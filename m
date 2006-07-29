Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWG2U1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWG2U1U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWG2U1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 16:27:20 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:27152 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932186AbWG2U1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 16:27:19 -0400
Date: Sat, 29 Jul 2006 16:20:24 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, marcel@holtman.org,
       fpavlic@de.ibm.com, paulus@au.ibm.com, bcollins@debian.org,
       tony.luck@intel.com
Subject: Re: [KJ] (re) audit return code handling for kernel_thread [3/3]
Message-ID: <20060729202024.GD8574@localhost.localdomain>
References: <20060729201139.GA8574@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729201139.GA8574@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to audit return codes for kernel_thread.  This patch corrects callers who
have differing assumptions about the meaning of a zero return code.  I've
normalized all the callers to consider a zero return code a successful return.

Thanks & Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 arch/ia64/sn/kernel/xpc_main.c |    2 +-
 init/do_mounts_initrd.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


--- a/arch/ia64/sn/kernel/xpc_main.c
+++ b/arch/ia64/sn/kernel/xpc_main.c
@@ -583,7 +583,7 @@ xpc_activate_partition(struct xpc_partit
 
 	pid = kernel_thread(xpc_activating, (void *) ((u64) partid), 0);
 
-	if (unlikely(pid <= 0)) {
+	if (unlikely(pid < 0)) {
 		spin_lock_irqsave(&part->act_lock, irq_flags);
 		part->act_state = XPC_P_INACTIVE;
 		XPC_SET_REASON(part, xpcCloneKThreadFailed, __LINE__);
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -57,7 +57,7 @@ static void __init handle_initrd(void)
 
 	current->flags |= PF_NOFREEZE;
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
-	if (pid > 0) {
+	if (pid >= 0) {
 		while (pid != sys_wait4(-1, NULL, 0, NULL))
 			yield();
 	}
