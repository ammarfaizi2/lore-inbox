Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbUKTOsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbUKTOsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 09:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUKTOsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 09:48:21 -0500
Received: from umail.mtu.ru ([195.34.32.101]:62901 "EHLO umail.ru")
	by vger.kernel.org with ESMTP id S262973AbUKTOqn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 09:46:43 -0500
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PREEMPT x86 assembly question
Date: Sat, 20 Nov 2004 17:43:11 +0300
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411201746.44804@sercond.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello

Whily lazy-examining kernel code, I found the following interesting point.

In arch/i386/kernel/entry.S

...
ENTRY(resume_kernel)
 cmpl $0,TI_preempt_count(%ebp) # non-zero preempt_count ?
 jnz restore_all
need_resched:
 movl TI_flags(%ebp), %ecx # need_resched set ?
 testb $_TIF_NEED_RESCHED, %cl
 jz restore_all
 testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 jz restore_all
 movl $PREEMPT_ACTIVE,TI_preempt_count(%ebp)
 sti
 call schedule
 movl $0,TI_preempt_count(%ebp)
 cli
 jmp need_resched
#endif
...

Why, after return from schedule(), first 0 is written to 
TI_preempt_count(%ebp), and only then interrupts are disabled?
Wht not the reverse order?

As far as I understand, the idea of the preempt_count flag is to avoid 
nested preemts. The fact that flag is reset before interrupts are 
disabled, somewhat breaks this: interrupt may happen just after flag is 
reset, causing nested interrupt while preempt_count flag is already reset. 
In a very unprobable case this could happen unlimited number of times, 
causing kernel stack overflow.

Very unprobable? But couldn't this be the cause of kernel lockups I 
suffered several times while writing DVD on a probably broken media (which 
could cause interrupt storm)?..
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBn1jSv3x5OskTLdsRAu/lAKCCqeNbJSkhC4W3iWawjm4vctOzpwCeN7vX
Cjk39KRgRSnjN8ktKGCfoUA=
=XvKR
-----END PGP SIGNATURE-----
