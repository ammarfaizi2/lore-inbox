Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281691AbRLWWBA>; Sun, 23 Dec 2001 17:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281863AbRLWWAv>; Sun, 23 Dec 2001 17:00:51 -0500
Received: from d-dialin-2748.addcom.de ([213.61.81.108]:15600 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S281691AbRLWWAo>; Sun, 23 Dec 2001 17:00:44 -0500
Date: Sun, 23 Dec 2001 23:00:39 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to fix false positives on references to discarded text/data?
In-Reply-To: <23259.1009099071@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0112232255500.1676-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Keith Owens wrote:

> As an example, net/ipv4/netfilter/ip_nat_snmp_basic.c
> static void __exit fini(void)
> {
>         ip_nat_helper_unregister(&snmp);
>         ip_nat_helper_unregister(&snmp_trap);
>         br_write_lock_bh(BR_NETPROTO_LOCK);
>         br_write_unlock_bh(BR_NETPROTO_LOCK);
> }
> 
> The lock operations generate a branch to out of line code in section
> .text.lock which then branches back to fini.  When ip_nat_snmp_basic is
> built into vmlinux, the fini section is discarded but the .text.lock
> code is kept.  That has two problems, unused code in .text.lock (minor)
> and an unresolved reference from .text.lock to .text.exit which makes
> binutils complain (major).

The logical fix would be to have the out-of-line code put into 
.text.exit.lock in this case, and then discard .text.exit.lock during the 
final link. Now, the problem is to have the spinlock code automatically 
chose the right section.

But I think, I found a solution: Don't use .text.lock for the out-of-line 
code, use .text 1 (subsection 1) instead. This will put the out-of-line 
code out of line, but into the same section - case solved ;-)

I'll patch my kernel now - since I don't have the new binutils yet, it'll 
be a bit hard to verify it really works, though.

--Kai



