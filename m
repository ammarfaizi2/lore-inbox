Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWDZJ4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWDZJ4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWDZJ4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:56:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:20913 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932071AbWDZJ4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:56:19 -0400
X-IronPort-AV: i="4.04,157,1144047600"; 
   d="scan'208"; a="28740610:sNHT24343193"
X-IronPort-AV: i="4.04,157,1144047600"; 
   d="scan'208"; a="28740604:sNHT21699097"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,157,1144047600"; 
   d="scan'208"; a="28740597:sNHT22676108"
Subject: [PATCH] kprobe cleanup for VM_MASK judgement
From: "mao, bibo" <bibo.mao@intel.com>
To: Andrew Morton <akpm@osdl.org>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Jim Keniston <jkenisto@us.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       prasanna <prasanna@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "systemtap@sources.redhat.com" <systemtap@sources.redhat.com>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 17:56:26 +0800
Message-Id: <1146045386.29367.8.camel@maobb.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2006 09:56:17.0725 (UTC) FILETIME=[A99A16D0:01C66917]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
When trap happens in user space, kprobe_exceptions_notify() funtion will skip it. 
This patch deletes some unnecessary code for VM_MASK judgement in eflags.

Signed-off-by: bibo, mao <bibo.mao@intel.com>
 
Thanks
bibo,mao

diff -Nruap 2.6.17-rc1-mm3.org/arch/i386/kernel/kprobes.c 2.6.17-rc1-mm3.new/arch/i386/kernel/kprobes.c
--- 2.6.17-rc1-mm3.org/arch/i386/kernel/kprobes.c	2006-04-26 15:52:24.000000000 +0800
+++ 2.6.17-rc1-mm3.new/arch/i386/kernel/kprobes.c	2006-04-26 16:25:38.000000000 +0800
@@ -242,10 +242,6 @@ static int __kprobes kprobe_handler(stru
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
 		} else {
-			if (regs->eflags & VM_MASK) {
-			/* We are in virtual-8086 mode. Return 0 */
-				goto no_kprobe;
-			}
 			if (*addr != BREAKPOINT_INSTRUCTION) {
 			/* The breakpoint instruction was removed by
 			 * another cpu right after we hit, no further
@@ -265,11 +261,6 @@ static int __kprobes kprobe_handler(stru
 
 	p = get_kprobe(addr);
 	if (!p) {
-		if (regs->eflags & VM_MASK) {
-			/* We are in virtual-8086 mode. Return 0 */
-			goto no_kprobe;
-		}
-
 		if (*addr != BREAKPOINT_INSTRUCTION) {
 			/*
 			 * The breakpoint instruction was removed right
