Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbTAXCGU>; Thu, 23 Jan 2003 21:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTAXCGT>; Thu, 23 Jan 2003 21:06:19 -0500
Received: from [195.78.204.43] ([195.78.204.43]:11406 "EHLO mail.rhx.it")
	by vger.kernel.org with ESMTP id <S267495AbTAXCGL>;
	Thu, 23 Jan 2003 21:06:11 -0500
Date: Fri, 24 Jan 2003 03:22:22 +0100
From: Sergio Visinoni <piffio@arklinux.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: [TRIVIAL] Re: [PATCH] ACPI update (20030122)
Message-ID: <20030124032222.A9061@piffio.homelinux.org>
References: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>; from andrew.grover@intel.com on gio, gen 23, 2003 at 02:44:55 -0800
X-Operating-System: Linux maniac 2.4.9-21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Grover, Andrew (andrew.grover@intel.com) wrote:
> (2.4) S4BIOS support (Ducrot Bruno)

Attached is the missing s4bios portion (the
acpi_enter_sleep_state_s4bios function ) + fixes to make it
build correctly on a 2.4.20 tree.

It should apply correctly on 2.4.21-pre3 as well (not tested).

Greetings,
Sergio Visinoni

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi-20030122-missing-s4bios.patch"

--- linux-2.4.20/include/acpi/acpixf.h.s4bios~	2003-01-24 02:34:04.000000000 +0100
+++ linux-2.4.20/include/acpi/acpixf.h	2003-01-24 02:37:01.000000000 +0100
@@ -380,6 +380,10 @@
 	u8                              sleep_state);
 
 acpi_status
+acpi_enter_sleep_state_s4bios (
+	void);
+
+acpi_status
 acpi_leave_sleep_state (
 	u8                              sleep_state);
 
--- linux-2.4.20/drivers/acpi/hardware/hwsleep.c.s4bios~	2003-01-24 02:35:41.000000000 +0100
+++ linux-2.4.20/drivers/acpi/hardware/hwsleep.c	2003-01-24 02:35:53.000000000 +0100
@@ -316,6 +316,54 @@
 	return_ACPI_STATUS (AE_OK);
 }
 
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_enter_sleep_state_s4bios
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Perform a s4 bios request.
+ *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_enter_sleep_state_s4bios (
+	void)
+{
+	u32                     in_value;
+	acpi_status             status;
+
+
+	ACPI_FUNCTION_TRACE ("Acpi_enter_sleep_state_s4bios");
+
+
+	acpi_set_register (ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_LOCK);
+	acpi_hw_clear_acpi_status();
+
+	acpi_hw_disable_non_wakeup_gpes();
+
+	ACPI_FLUSH_CPU_CACHE();
+
+	status = acpi_os_write_port (acpi_gbl_FADT->smi_cmd, (acpi_integer) acpi_gbl_FADT->S4bios_req, 8);
+
+	do {
+		acpi_os_stall(1000);
+		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
+	} while (!in_value);
+
+	printk(KERN_DEBUG "acpi: s4bios coming to live\n");
+
+	return_ACPI_STATUS (AE_OK);
+}
+
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_leave_sleep_state
@@ -339,6 +387,8 @@
 
 	ACPI_FUNCTION_TRACE ("acpi_leave_sleep_state");
 
+	/* Be sure to have BM arbitration */
+	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	/* Ensure enter_sleep_state_prep -> enter_sleep_state ordering */
 
@@ -371,8 +421,5 @@
 		return_ACPI_STATUS (status);
 	}
 
-	/* Disable BM arbitration */
-	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
-
 	return_ACPI_STATUS (status);
 }
--- linux-2.4.20/drivers/acpi/include/acpixf.h.s4bios~	2001-10-24 23:06:22.000000000 +0200
+++ linux-2.4.20/drivers/acpi/include/acpixf.h	2003-01-24 02:38:17.000000000 +0100
@@ -320,6 +320,10 @@
 	u8 sleep_state);
 
 acpi_status
+acpi_enter_sleep_state_s4bios (
+	void);
+
+acpi_status
 acpi_leave_sleep_state (
 	u8 sleep_state);
 

--huq684BweRXVnRxX--
