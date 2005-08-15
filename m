Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVHOGnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVHOGnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 02:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVHOGnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 02:43:11 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:61875 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932095AbVHOGnK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 02:43:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tPRrFoGry5Q3VRDdzsVzbNs4cffmZ21z/Z+IIBOnraIGFkXyri3NHUBnTCse4oiDL7+S+0Dh4RStg1mr0kp6fn4cIEl0n8k/O+xZQeuPtDhyOCiej3Izi0UqSyubhruqY2h/sNEyFHVhchBh8H+ZrVI+o56iVYJdxHNCQ3yUoyE=
Message-ID: <98df96d30508142343407b4d61@mail.gmail.com>
Date: Mon, 15 Aug 2005 15:43:05 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: linux-kernel@vger.kernel.org, Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <1124015743.3222.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98df96d305081402164ce52f8@mail.gmail.com>
	 <1124012489.3222.13.camel@laptopd505.fenrus.org>
	 <98df96d305081403222e75b232@mail.gmail.com>
	 <1124015743.3222.17.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Date: Sun, 14 Aug 2005 12:35:43 +0200
Message-ID: <1124015743.3222.17.camel@laptopd505.fenrus.org>

> On Sun, 2005-08-14 at 19:22 +0900, Hiro Yoshioka wrote:
> > Thanks for your comments.
> > 
> > On 8/14/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Sun, 2005-08-14 at 18:16 +0900, Hiro Yoshioka wrote:
> > > > Hi,
> > > >
> > > > The following is a patch to reduce a cache pollution
> > > > of __copy_from_user_ll().
> > > >
> > > > When I run simple iozone benchmark to find a performance bottleneck of
> > > > the linux kernel, I found that __copy_from_user_ll() spent CPU cycle
> > > > most and it did many cache misses.
> > > 
> > > 
> > > however... you copy something from userspace... aren't you going to USE
> > > it? The non-termoral versions actually throw the data out of the
> > > cache... so while this part might be nice, you pay BIG elsewhere....
> > 
> > The oprofile data does not give an evidence that we pay BIG elsewhere.
> 
> 
> the problem is that the pay elsewhere is far more spread out, but not
> less. At least generally....
> 
> I can see the point of a copy_from_user_nocache() or something, for
> those cases where we *know* we are not going to use the copied data in
> the cpu (but say, only do DMA).
> But that should be explicit, not implicit, since the general case will
> be that the kernel WILL use the data. And if that's the case your change
> is a loss.... (just harder to see because the cost is spread out)

I understand the iozone is not good benchmark nor reprsents any useful
application so I did a kernel build as a simple benchmark.

What I did is
    cd /test/f1
    tar xjf ${baseDir}/src/linux-2.6.12.4.tar.bz2
    cd linux-2.6.12.4
    cp -p ${baseDir}/src/config .config
    make oldconfig
    time make -j $CPUS

The following is Top 5 of CPU cycle
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 10
0000
samples  %        app name                 symbol name
7347544  72.8296  cc1                      (no symbols)
532307    5.2763  libbz2.so.1.0.2          (no symbols)
241853    2.3973  vmlinux                  buffered_rmqueue
128552    1.2742  libc-2.3.4.so            _int_malloc
107784    1.0684  vmlinux                  page_fault
...
10749     0.1065  vmlinux                  __copy_from_user_ll
pattern12-0-cpu4-0-08150920/summary.out

Since __copy_from_user_ll is not hot spot, so we didn't see any big
performance difference. (the number is time (sec) of 5 runs)

original 2.6.12.4               real    user    system
No profiling                    532.27	1797.02	194.9
BSQ 0x200+0x3f                  620.15	2094.21	212.38
GLOBAL_POWER_EVENTS:100000:	586.01	1984.92	215.97

cache aware 2.6.12.4            real    user    system
No profiling                    526.65	1792.22	190.05
BSQ 0x200+0x3f                  615.51	2090.74	206.58
GLOBAL_POWER_EVENTS:100000:     587.69	1978.66	209.18

Now Top 5 of Memory Access (2.6.12.4)
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x3f (multiple flags) count 3000
Counted BSQ_CACHE_REFERENCE events (cache references seen by the bus
unit) with a unit mask of 0x200 (read 3rd level cache miss) count 3000
samples  %        samples  %        app name             symbol name
11439689 82.2135  33906    27.9328  cc1                  (no symbols)
277177    1.9920  347       0.2859  libc-2.3.4.so        _int_malloc
229593    1.6500  12946    10.6653  libbz2.so.1.0.2      (no symbols)
84348     0.6062  116       0.0956  libc-2.3.4.so        _int_free
83653     0.6012  438       0.3608  libc-2.3.4.so        calloc
...
8527      0.0613  1648      1.3577  vmlinux              __copy_from_user_ll

Top 5 of Cache miss
33906   27.9328 cc1                     (no symbols)
30849   25.4144 vmlinux                 buffered_rmqueue
12946   10.6653 libbz2.so.1.0.2         (no symbols)
9178    7.5611  vmlinux                 __copy_to_user_ll
2934    2.4171  oprofiled               (no symbols)
...
1648    1.3577  vmlinux                 __copy_from_user_ll
pattern12-0-cpu4-0-08150917

Cache aware 2.6.12.4, Top 5 of Memory Access
samples  %        samples  %        app name             symbol name
11448487 82.8100  32786    28.1051  cc1                  (no symbols)
276812    2.0023  256       0.2195  libc-2.3.4.so        _int_malloc
230177    1.6649  12371    10.6048  libbz2.so.1.0.2      (no symbols)
84485     0.6111  120       0.1029  libc-2.3.4.so        _int_free
84043     0.6079  473       0.4055  libc-2.3.4.so        calloc
...
18282     0.1322  9060      7.7665  vmlinux              __copy_from_user_ll

Top 5 of Cache miss
32786   28.1051 cc1                     (no symbols)
31175   26.7241 vmlinux                 buffered_rmqueue
12371   10.6048 libbz2.so.1.0.2         (no symbols)
9060    7.7665  vmlinux                 __copy_from_user_ll
2801    2.4011  oprofiled               (no symbols)
...
0            0  vmlinux                 __copy_to_user_ll
pattern12-0-cpu4-0-08151048

Cache miss of __copy_from_user_ll has been increased but
__copy_to_user_ll has been decreased to 0. (oprofile could not get a
sample.)

I don't know the reason why __copy_to_user_ll has been decreased.

Anyway we could not find the cache aware version of __copy_from_user_ll
has a big regression yet.

What do you think?
  Hiro
