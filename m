Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVANXoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVANXoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVANXoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:44:22 -0500
Received: from [81.2.110.250] ([81.2.110.250]:18921 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262024AbVANXoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:44:16 -0500
Subject: Re: aacraid fails when RAID1 array is in anything but Optimal state
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aaron Gowatch <aarong@divinia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0501141156580.28993-100000@nuevo.divinia.com>
References: <Pine.LNX.4.44.0501141156580.28993-100000@nuevo.divinia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105742350.9838.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 14 Jan 2005 22:39:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 20:10, Aaron Gowatch wrote:
> We're using Dell PowerEdge 750s with a Dell rebranded Adaptec CERC 1.5/6ch 
> SATA adapter.  The systems have 2 disks configured as RAID1.  If the array 
> is in any other state than 'Optimal' (ie. 'Degraded' or 'Rebuilding') the 
> following error is displayed and the box subsequently panics because its 
> unable to mount the root filesystem.

Known bug in the 2.6 aacraid driver. It's fixed in current Fedora Core 3
kernels, 2.6.10-ac or in 2.6.11rc1. I've attached the needed patch below

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/scsi/aacraid/commsup.c linux-2.6.10/drivers/scsi/aacraid/commsup.c
--- linux.vanilla-2.6.10/drivers/scsi/aacraid/commsup.c	2004-12-25 21:14:35.000000000 +0000
+++ linux-2.6.10/drivers/scsi/aacraid/commsup.c	2005-01-13 17:29:50.077160240 +0000
@@ -768,28 +768,6 @@
 	memset(cp, 0,  256);
 }
 
-
-/**
- *	aac_handle_aif		-	Handle a message from the firmware
- *	@dev: Which adapter this fib is from
- *	@fibptr: Pointer to fibptr from adapter
- *
- *	This routine handles a driver notify fib from the adapter and
- *	dispatches it to the appropriate routine for handling.
- */
-
-static void aac_handle_aif(struct aac_dev * dev, struct fib * fibptr)
-{
-	struct hw_fib * hw_fib = fibptr->hw_fib;
-	/*
-	 * Set the status of this FIB to be Invalid parameter.
-	 *
-	 *	*(u32 *)fib->data = ST_INVAL;
-	 */
-	*(u32 *)hw_fib->data = cpu_to_le32(ST_OK);
-	fib_adapter_complete(fibptr, sizeof(u32));
-}
-
 /**
  *	aac_command_thread	-	command processing thread
  *	@dev: Adapter to monitor
@@ -859,7 +837,6 @@
 			aifcmd = (struct aac_aifcmd *) hw_fib->data;
 			if (aifcmd->command == cpu_to_le32(AifCmdDriverNotify)) {
 				/* Handle Driver Notify Events */
-				aac_handle_aif(dev, fib);
 				*(u32 *)hw_fib->data = cpu_to_le32(ST_OK);
 				fib_adapter_complete(fib, sizeof(u32));
 			} else {
@@ -870,10 +847,6 @@
 				u32 time_now, time_last;
 				unsigned long flagv;
 				
-				/* Sniff events */
-				if (aifcmd->command == cpu_to_le32(AifCmdEventNotify))
-					aac_handle_aif(dev, fib);
-				
 				time_now = jiffies/HZ;
 
 				spin_lock_irqsave(&dev->fib_lock, flagv);

