Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVJFI3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVJFI3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVJFI3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:29:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29857 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750740AbVJFI3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:29:54 -0400
Date: Thu, 6 Oct 2005 04:29:44 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051006081055.GA20491@elte.hu>
Message-ID: <Pine.LNX.4.58.0510060425561.28535@localhost.localdomain>
References: <20051004130009.GB31466@elte.hu>
 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
 <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
 <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Found the problem.  You're using a 64 bit machine and flags in the
> > acpi code is defined as u32 and not unsigned long.  Ingo's tests put
> > some checks in the flags at the MSBs and these are being truncated.
>
> ahh ... I would not be surprised if this caused actual problems on x64
> in the upstream kernel too: using save_flags() over u32 will corrupt a
> word on the stack ...
>
> Andi?
>

So I guess these patches need to go upstream too?

Here's the rest of the u32 coversions. Not all the u32 flags were used for
spinlocks. Most were for the flags instance in the structure.

Note, this patch does _NOT_ include the previous patch that I sent.  If
this needs to go upstream, I'll send the two together as one patch.

-- Steve

--- linux-2.6.14-rc3-rt9/drivers/acpi/events/evgpe.c.orig	2005-10-06 04:15:40.000000000 -0400
+++ linux-2.6.14-rc3-rt9/drivers/acpi/events/evgpe.c	2005-10-06 04:15:46.000000000 -0400
@@ -377,7 +377,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 	struct acpi_gpe_register_info *gpe_register_info;
 	u32 status_reg;
 	u32 enable_reg;
-	u32 flags;
+	unsigned long flags;
 	acpi_status status;
 	struct acpi_gpe_block_info *gpe_block;
 	acpi_native_uint i;
--- linux-2.6.14-rc3-rt9/drivers/acpi/events/evgpeblk.c.orig	2005-10-06 04:00:34.000000000 -0400
+++ linux-2.6.14-rc3-rt9/drivers/acpi/events/evgpeblk.c	2005-10-06 04:00:58.000000000 -0400
@@ -136,7 +136,7 @@ acpi_status acpi_ev_walk_gpe_list(ACPI_G
 	struct acpi_gpe_block_info *gpe_block;
 	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
 	acpi_status status = AE_OK;
-	u32 flags;
+	unsigned long flags;

 	ACPI_FUNCTION_TRACE("ev_walk_gpe_list");

@@ -479,7 +479,7 @@ static struct acpi_gpe_xrupt_info *acpi_
 	struct acpi_gpe_xrupt_info *next_gpe_xrupt;
 	struct acpi_gpe_xrupt_info *gpe_xrupt;
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;

 	ACPI_FUNCTION_TRACE("ev_get_gpe_xrupt_block");

@@ -553,7 +553,7 @@ static acpi_status
 acpi_ev_delete_gpe_xrupt(struct acpi_gpe_xrupt_info *gpe_xrupt)
 {
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;

 	ACPI_FUNCTION_TRACE("ev_delete_gpe_xrupt");

@@ -610,7 +610,7 @@ acpi_ev_install_gpe_block(struct acpi_gp
 	struct acpi_gpe_block_info *next_gpe_block;
 	struct acpi_gpe_xrupt_info *gpe_xrupt_block;
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;

 	ACPI_FUNCTION_TRACE("ev_install_gpe_block");

@@ -663,7 +663,7 @@ acpi_ev_install_gpe_block(struct acpi_gp
 acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 {
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;

 	ACPI_FUNCTION_TRACE("ev_install_gpe_block");

--- linux-2.6.14-rc3-rt9/drivers/acpi/events/evxface.c.orig	2005-10-06 04:16:27.000000000 -0400
+++ linux-2.6.14-rc3-rt9/drivers/acpi/events/evxface.c	2005-10-06 04:16:43.000000000 -0400
@@ -562,7 +562,7 @@ acpi_install_gpe_handler(acpi_handle gpe
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_handler_info *handler;
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;

 	ACPI_FUNCTION_TRACE("acpi_install_gpe_handler");

@@ -653,7 +653,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_handler_info *handler;
 	acpi_status status;
-	u32 flags;
+	unsigned long flags;

 	ACPI_FUNCTION_TRACE("acpi_remove_gpe_handler");

