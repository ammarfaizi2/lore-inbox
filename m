Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbTHaWYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbTHaWYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:24:19 -0400
Received: from codepoet.org ([166.70.99.138]:46469 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262857AbTHaWYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:24:14 -0400
Date: Sun, 31 Aug 2003 16:24:14 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, jun.nakajima@intel.com
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Message-ID: <20030831222414.GA29923@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, jun.nakajima@intel.com
References: <20030829210335.GA3150@codepoet.org> <Pine.LNX.4.44.0308311404430.1581-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308311404430.1581-100000@home.osdl.org>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 31, 2003 at 02:05:25PM -0700, Linus Torvalds wrote:
> 
> On Fri, 29 Aug 2003, Erik Andersen wrote:
> > 
> > gcc then generates code calling __udivdi3 and __umoddi3.  Since
> > the kernel does not provide these, people keep reinventing them.
> > Perhaps it is time to kill off do_div and all its little friends
> > and simply copy __udivdi3 and __umoddi3 from libgcc.....
> 
> No. do_div() does _nothing_ like __udivdi3/__umoddi3.
> 
> Read the documentation.

Been there done that, got the scars to prove it.  do_div() is a
macro that acts sortof like the ISO C99 lldiv(3) function.
Except it does unexpected things like modify its arguments... 

Most places in the kernel using do_div() not because it is the
right thing to do, but because they tried to do something
seemingly simple such as:

    u64 foo, bar, baz;
    ...
    baz = foo / bar;

and then got an error that __udivdi3 was undefined.  So the
authors then go hunting for a way to do a 64 bit division and
find do_div()...

See mm/vmscan.c, mm/shmem.c, fs/proc/proc_misc.c,
drivers/ide/ide-disk.c, etc, etc, etc, for plenty of examples of
_exactly_ this sort of thing.  Every one of them is using
do_div() to perform 64 bit division.  Not becase that is the
right thing to do, but because __udivdi3 is missing.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
