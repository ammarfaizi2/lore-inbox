Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbULCBu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbULCBu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 20:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbULCBu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 20:50:57 -0500
Received: from tantale.fifi.org ([216.27.190.146]:13201 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261840AbULCBuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 20:50:50 -0500
To: "Brown, Len" <len.brown@intel.com>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>
Subject: Re: APM suspend/resume ceased to work with 2.4.28
References: <F7DC2337C7631D4386A2DF6E8FB22B300225E3FC@hdsmsx401.amr.corp.intel.com>
	<87d5xsjly5.fsf@ceramic.fifi.org> <871xeia26p.fsf@ceramic.fifi.org> <87zn1amuov.fsf@ceramic.fifi.org>
	<20041122173654.GA31848@logos.cnet> <87mzx94ekm.fsf@ceramic.fifi.org>
	<20041123070252.GA2712@logos.cnet>
From: Philippe Troin <phil@fifi.org>
Date: 02 Dec 2004 17:50:48 -0800
Message-ID: <87wtw0i1zb.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Philippe Troin <phil@fifi.org> writes:

> Where do we go from here?

I just diffed out the boot log between 2.4.27 and 2.4.28.  And I found
this new message appearing in 2.4.28:

        ACPI: IRQ9 SCI: Edge set to Level Trigger.

Weird since IRQ 9 is not in use in this system.  IRQ9 is typically
used by ACPI.

After some digging in the sources, I found that the newly introduced
(2.4.28-rc2) function acpi_early_init() runs wether or not acpi=off
was specified on the command line.

This trivial patch makes my laptop suspend-happy.  Len, please confirm
that this is ok.  Marcelo, please include in 29-pre.

Phil.

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.28-8-acpi.patch

diff -ruN linux-2.4.28.orig/drivers/acpi/bus.c linux-2.4.28/drivers/acpi/bus.c
--- linux-2.4.28.orig/drivers/acpi/bus.c	Wed Nov 17 03:54:21 2004
+++ linux-2.4.28/drivers/acpi/bus.c	Thu Dec  2 16:49:54 2004
@@ -1850,6 +1850,9 @@
 	acpi_status		status = AE_OK;
 	struct acpi_buffer	buffer = {sizeof(acpi_fadt), &acpi_fadt};
 
+	if (acpi_disabled)
+		return;
+
 	ACPI_FUNCTION_TRACE("acpi_bus_init");
 
 	status = acpi_initialize_subsystem();

--=-=-=--
