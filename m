Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266265AbUAVMI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 07:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266267AbUAVMI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 07:08:56 -0500
Received: from hell.org.pl ([212.244.218.42]:52239 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S266265AbUAVMIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 07:08:54 -0500
Date: Thu, 22 Jan 2004 13:08:54 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: "Georg C. F. Greve" <greve@gnu.org>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
Message-ID: <20040122120854.GB3534@hell.org.pl>
Mail-Followup-To: "Georg C. F. Greve" <greve@gnu.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Martin Loschwitz <madkiss@madkiss.org>,
	linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
	acpi-devel@lists.sourceforge.net
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com> <m3u12pgfpr.fsf@reason.gnu-hamburg> <m3ptddgckg.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <m3ptddgckg.fsf@reason.gnu-hamburg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Georg C. F. Greve:
> So the problem we've been seeing seems to be related to the
> interaction between local APIC support and ACPI.

We've definitely had those problems before (with ASUS L3800C), there's 
even a patch fixing this issue (attached below) you might try.
I guess that's another of those lost and forgotten bugzilla bugs :)

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl


diff -Bru linux-2.6.0-test8/arch/i386/kernel/apic.c patched/arch/i386/kernel/apic.c
--- linux-2.6.0-test8/arch/i386/kernel/apic.c	2003-10-18 05:43:36.000000000 +0800
+++ patched/arch/i386/kernel/apic.c	2003-10-30 23:17:50.000000000 +0800
@@ -836,8 +836,8 @@
 {
 	unsigned int lvtt1_value, tmp_value;
 
-	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
-			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+	lvtt1_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+
 	apic_write_around(APIC_LVTT, lvtt1_value);
 
 	/*
diff -Bru linux-2.6.0-test8/drivers/acpi/bus.c patched/drivers/acpi/bus.c
--- linux-2.6.0-test8/drivers/acpi/bus.c	2003-10-18 05:43:19.000000000 +0800
+++ patched/drivers/acpi/bus.c	2003-10-30 23:20:32.000000000 +0800
@@ -589,6 +589,7 @@
 
 	ACPI_FUNCTION_TRACE("acpi_bus_init");
 
+	disable_APIC_timer();
 	status = acpi_initialize_subsystem();
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to initialize the ACPI Interpreter\n");
@@ -643,6 +644,7 @@
 		goto error1;
 	}
 
+	enable_APIC_timer();
 	printk(KERN_INFO PREFIX "Interpreter enabled\n");
 
 	/*
@@ -672,6 +674,7 @@
 error1:
 	acpi_terminate();
 error0:
+	enable_APIC_timer();
 	return_VALUE(-ENODEV);
 }
 
