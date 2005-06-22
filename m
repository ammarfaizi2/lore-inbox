Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVFVJWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVFVJWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVFVHo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:44:59 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:32494 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262814AbVFVFvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:51:24 -0400
Date: Wed, 22 Jun 2005 01:48:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: cutaway@bellsouth.net, Coywolf Qi Hunt <coywolf@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200506220150_MC3-1-A23C-875A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2005 10:43:03 +0300, Denis Vlasenko wrote:

> On Tuesday 14 June 2005 07:26, cutaway@bellsouth.net wrote:
> > The problem with that approach is GCC would still just relocate the push/pop
> > block to the bottom of the function.  This means you won't be likely to pick
> > up anything useful in L1 or L2 as the function exits normally - in fact
> > you'd typically be guaranteed to be picking up a partial line of gorp that
> > is completely worthless later on.
> > 
> > This is one of my issues with the notion of unlikely() being smoothed on
> > everywhere like Bondo<g> - it also makes it "unlikely" that you'll get any
> > serendipitous L1/L2 advantages that could be had by locating related
> > functions next to each other.
> > 
> > When you take the unlikely stuff completely out of line in a seperate
> > functions located elsewhere, the mainline code can make better use of the
> > caches.  The Intel parts thrive on L1 hits and die if they're not getting
> > them.
> 
> That's exactly what compiler can do by itself. The fact that currently
> it isn't smart enough to od it means that it has to be improved.
> You propose that people have to do compiler's job.

  Not just the compiler -- the linker would need to be a lot smarter too:


/* foo.c */

extern int bar1(void), bar2(void), bar3(void);

main() {
        if (likely(bar1()))
                bar2();
        else
                bar3();
}


/* bar.c */

int bar1(void) { return 1; }
int bar2(void) { whatever; }
int bar3(void) { whatever; }


  When you compile bar.c the compiler has _no_ idea which functions are likely
to be called.

  And doing this manually is trivial:

        1. Add two sections to vmlinux.lds.S: .fast.text and .slow.text
        2. Define __fast __attribute__(__section__(".fast.text"))
        3. Define __slow similarly
        4. Start tagging functions with __fast and __slow as needed

  Very little work for much potential gain, AFAICS.


--
Chuck
