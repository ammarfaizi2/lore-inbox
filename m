Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWC0AmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWC0AmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWC0AmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:42:24 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:20072 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932273AbWC0AmX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:42:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rpzg2vfdVrwddwQdn+TMZXdOqiO+tXxa294RRR0lU3cFc7l2zIYutDVvFcpUnXGiQSnHxkhYc1FHKLIup7ZVhfjNmaPH7S4phsC2uRatuYo8sCSZi69maUWmhuB67VIfBjrOaBDG90rBB1uNEBDFqN42IksxvP9B94VvzPC3DJY=
Message-ID: <2c0942db0603261642k1554be2al3f3b0fe49d2f5ff@mail.gmail.com>
Date: Sun, 26 Mar 2006 16:42:22 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: [patch] fix delay_tsc (was Re: delay_tsc(): inefficient delay loop (2.6.16-mm1))
Cc: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Dominik Brodowski" <linux@brodo.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andi Kleen" <ak@suse.de>
In-Reply-To: <200603261647_MC3-1-BB98-CB09@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603261647_MC3-1-BB98-CB09@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> On Fri, 24 Mar 2006 09:22:51 -0800, Ray Lee wrote:
> > On 3/24/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> > > +       loops += bclock;
> > [...]
> > > -       } while ((now-bclock) < loops);
> > > +       } while (now < loops);
> >
> > Erm, aren't you introducing an overflow problem here?
> >
> > if loops is 2^32-1, bclock is 1, the old version would execute the
> > proper number of times, the new one will blow out in one tick.
>
> Yes, but the old version has a bug too.
[...]
> If (loops == 100000) and (bclock == 2^32-1) the loop will terminate
> immediately when the low part of the TSC overflows because (now-bclock)
> is a large number.

Er, no, it won't, because (now-bclock) won't be large.

I know thinking about math on a modulo number line such as u8/16/32 is
odd, but it's best if you just always think of "subtraction" to mean
"distance between." (Which is always true in any space or coordinate
system, even with wrap arounds.) This is the same trick used by
Andrew's ring buffers, where you let head and tail wrap around freely,
and only perform the modulo operation at dereferencing.

A simple test program will give you a better feel for what's going on
(I write a lot of these...):

#include <stdio.h>
int main() {
  unsigned int a,b,c;
  a=-1-1;
  b=1000;
  c=b-a;
  printf("%u - %u = %u\n", b, a, c);
}

ray@issola:~/work/test/overflow$ gcc -o test test.c
ray@issola:~/work/test/overflow$ ./test
1000 - 4294967294 = 1002

So, it wraps appropriately, as odd as that may seem at first blush.

Ray
