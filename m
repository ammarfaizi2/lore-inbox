Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVL3Voa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVL3Voa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 16:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVL3Voa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 16:44:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:7948 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932104AbVL3Vo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 16:44:29 -0500
Date: Fri, 30 Dec 2005 22:44:02 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Al Boldi <a1426z@gawab.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Message-ID: <20051230214402.GA28683@w.ods.org>
References: <200512302306.28667.a1426z@gawab.com> <986ed62e0512301218v30dd5d67m699bf7c29375a1fe@mail.gmail.com> <200512302351.58650.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512302351.58650.a1426z@gawab.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 11:51:58PM +0300, Al Boldi wrote:
> Barry K. Nathan wrote:
> > On 12/30/05, Al Boldi <a1426z@gawab.com> wrote:
> > > Thanks a lot!
> > >
> > > > +3 - (NEW) paranoid overcommit The total address space commit
> > > > +      for the system is not permitted to exceed swap. The machine
> > > > +      will never kill a process accessing pages it has mapped
> > > > +      except due to a bug (ie report it!)
> > >
> > > This one isn't in 2.6, which is critical for a stable system.
> >
> > I think you can get paranoid overcommit with either my patch or 2.6 by
> > setting /proc/sys/vm/overcommit_mode to 2 *and*
> > /proc/sys/vm/overcommit_ratio to 0, however.
> 
> Not really in 2.6.
> And even if this were made to work, what would it imply to a system running 
> w/o swap?

I can clearly reply on this one :

root@pcw:vm# swapoff -a
root@pcw:vm# free
             total       used       free     shared    buffers     cached
Mem:       1031752      84992     946760          0       3144      38564
-/+ buffers/cache:      43284     988468
Swap:            0          0          0
root@pcw:vm# echo 2 > overcommit_memory
root@pcw:vm# echo 0 > overcommit_ratio
root@pcw:vm# uname -a
bash: fork: Cannot allocate memory
root@pcw:vm# echo 10 > overcommit_ratio
root@pcw:vm# uname -a
Linux pcw 2.4.33-pre1 #1 SMP Fri Dec 30 21:52:06 CET 2005 i686 unknown
root@pcw:vm#

So as one could expect, if you're limited to allocation of
(swap_size)+0% of RAM, then you have a limit of 0 kB, so that
malloc() always fails. I'll do some crash tests with mmap, shm
and 100 ratio to see how it behaves, but at the moment it's
clearly good. Multi-process malloc cannot allocate more than
specified and that's good.

> Thanks!
> 
> --
> Al

Regards,
Willy

