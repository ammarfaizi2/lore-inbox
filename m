Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293380AbSCOV4Y>; Fri, 15 Mar 2002 16:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293373AbSCOV4O>; Fri, 15 Mar 2002 16:56:14 -0500
Received: from zero.tech9.net ([209.61.188.187]:41478 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293362AbSCOVz7>;
	Fri, 15 Mar 2002 16:55:59 -0500
Subject: Re: [OOPS] Kernel powerdown
From: Robert Love <rml@tech9.net>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3C926B56.FC147170@delusion.de>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7D01@orsmsx111.jf.intel.com> 
	<3C926B56.FC147170@delusion.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 15 Mar 2002 16:55:49 -0500
Message-Id: <1016229350.1148.63.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-15 at 16:44, Udo A. Steinberg wrote:

> > Does the machine power off successfully using ACPI when the NMI watchdog is
> > not enabled?
> 
> No, it never managed to power off with ACPI. It works with APM though.

Ah, that is the problem, then.

> > APM doesn't turn off the NMI afaik so why should ACPI have to?
> 
> Imho the problem will most likely go away when poweroff works properly
> on my board. I can supply whatever info you need to make it work, too ;)
> 
> The board is an Asus A7V.

See if the attached patch fixes it ...

	Robert Love

diff -urN linux-2.4.19/drivers/acpi/hardware/hwsleep.c linux/drivers/acpi/hardware/hwsleep.c
--- linux-2.4.19/drivers/acpi/hardware/hwsleep.c	Fri Mar 15 00:28:10 2002
+++ linux/drivers/acpi/hardware/hwsleep.c	Fri Mar 15 16:54:57 2002
@@ -152,6 +152,15 @@
 		return status;
 	}
 
+	/*
+	 * Broken ACPI table on ASUS A7V:
+	 * it reports type 7, but poweroff is type 2
+	 */
+	if (type_a == 7 && type_b == 7 && sleep_state == ACPI_STATE_S5
+			&& !memcmp(acpi_gbl_DSDT->oem_id, "ASUS\0\0", 6)
+			&& !memcmp(acpi_gbl_DSDT->oem_table_id, "A7V", 3)) {
+		type_a = type_b = 2;
+	}
 	/* run the _PTS and _GTS methods */
 
 	MEMSET(&arg_list, 0, sizeof(arg_list));

