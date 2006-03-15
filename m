Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752158AbWCOQrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbWCOQrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbWCOQrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:47:14 -0500
Received: from mail.macqel.be ([194.78.208.39]:44806 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S1752158AbWCOQrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:47:14 -0500
Message-Id: <200603151647.k2FGl7Y04736@mail.macqel.be>
Subject: PATCH m68knommu clear frame-pointer in start_thread
To: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Date: Wed, 15 Mar 2006 17:47:07 +0100 (CET)
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to print the calltrace of a user process on m68knommu targets
gdb follows the frame-pointer en falls on unreachable adresses, because
the frame pointer is not properly initialised by start_thread. This patch
initialises the frame pointer to NULL in start_thread.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

---

the only change is the initialisztion of a6, the rest is spacing fixes

Index: linux-2.6.x/include/asm-m68knommu/processor.h
===================================================================
RCS file: /newdev6/cvsrepos/uClinux-dist/linux-2.6.x/include/asm-m68knommu/processor.h,v
retrieving revision 1.1.1.1
diff -r1.1.1.1 processor.h
92,99c92,100
< #define start_thread(_regs, _pc, _usp)           \
< do {                                             \
< 	set_fs(USER_DS); /* reads from user space */ \
< 	(_regs)->pc = (_pc);                         \
< 	if (current->mm)                             \
< 		(_regs)->d5 = current->mm->start_data;   \
< 	(_regs)->sr &= ~0x2000;                      \
< 	wrusp(_usp);                                 \
---
> #define start_thread(_regs, _pc, _usp)			\
> do {							\
> 	set_fs(USER_DS); /* reads from user space */	\
> 	(_regs)->pc = (_pc);				\
> 	((struct switch_stack *)(_regs))[-1].a6 = 0;	\
> 	if (current->mm)				\
> 		(_regs)->d5 = current->mm->start_data;	\
> 	(_regs)->sr &= ~0x2000;				\
> 	wrusp(_usp);					\
