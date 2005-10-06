Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVJFLI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVJFLI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 07:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVJFLI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 07:08:57 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:1759 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750828AbVJFLI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 07:08:56 -0400
Date: Thu, 6 Oct 2005 07:08:14 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       acpi-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] cleanup u32 flags in acpi spin_lock calls.
In-Reply-To: <200510061204.33045.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0510060656490.28535@localhost.localdomain>
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
 <20051006084920.GB22397@elte.hu> <Pine.LNX.4.58.0510060544390.28535@localhost.localdomain>
 <200510061204.33045.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is not an urgent issue, but was noticed in Ingo's RT kernel. There
are some places in ACPI that save flags as a u32 instead of a unsigned
long.  This is done indirectly by calling acpi_os_acquire_lock, which uses
unsigned long, but the flags returned are saved in the acpi code as a u32.

Since todays archs that use acpi, only care about the LS 32 bits of the
word, this is not really an issue.  But if there is an arch in the future
that changes that assumption, or (as RT does) some internal change in the
kernel that looks at the MSB of flags on a restore, this will be broken
for 64 bit machines.

This patch is just to make the ACPI code "clean".  That is, to use the
proper type for flags.

-- Steve

Note: You may notice that this patch has an -rt in the names, it does
      apply cleanly to 2.6.14-rc3.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


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

