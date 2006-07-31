Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWGaRGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWGaRGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWGaRGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:06:00 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:59612 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030256AbWGaRF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:05:59 -0400
Date: Mon, 31 Jul 2006 12:59:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: fix is_at_popf() for compat tasks
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Albert Cahalan <acahalan@gmail.com>
Message-ID: <200607311302_MC3-1-C69F-F0D8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200607311054.38585.ak@suse.de>

On Mon, 31 Jul 2006 10:54:38 +0200, Andi Kleen wrote:
>
> > When testing for the REX instruction prefix, first check
> > for a 32-bit task because in compat mode the REX prefix is an
> > increment instruction.
> 
> is_compat_task doesn't actually say that a task is in compat mode
> (it refers to the Linux compat layer, not x86-64 compat mode)
> 
> A better test would be regs->cs == __USER32_CS, but in theory
> there could be other code segments in LDT. I guess that can 
> be ignored though.

How about checking for regs->cs != __USER_CS instead?  In 64-bit mode
a program shouldn't have any other value there while in 32-bit mode
it could be using LDT segments.



From: Chuck Ebbert <76306.1226@compuserve.com>

When testing for the REX instruction prefix, first check
for 32-bit mode because in compat mode the REX prefix is an
increment instruction.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc2-64.orig/arch/x86_64/kernel/ptrace.c
+++ 2.6.18-rc2-64/arch/x86_64/kernel/ptrace.c
@@ -141,8 +141,11 @@ static int is_at_popf(struct task_struct
 		case 0xf0: case 0xf2: case 0xf3:
 			continue;
 
-		/* REX prefixes */
 		case 0x40 ... 0x4f:
+			if (regs->cs != __USER_CS)
+				/* 32-bit mode: register increment */
+				return 0;
+			/* 64-bit mode: REX prefix */
 			continue;
 
 			/* CHECKME: f0, f2, f3 */
-- 
Chuck
