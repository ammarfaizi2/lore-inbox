Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292733AbSCJSFz>; Sun, 10 Mar 2002 13:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292842AbSCJSFq>; Sun, 10 Mar 2002 13:05:46 -0500
Received: from pD952A2D2.dip.t-dialin.net ([217.82.162.210]:11904 "EHLO
	darkside.22.kls.lan") by vger.kernel.org with ESMTP
	id <S292733AbSCJSFd>; Sun, 10 Mar 2002 13:05:33 -0500
Date: Sun, 10 Mar 2002 19:05:26 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Subject: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
Message-ID: <20020310180526.GA1135@darkside.ddts.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

since I didn't notice any change about the fact, that since 2.4.14
kernel, after issuing 'halt', the Keyboard Power-ON and Wake-On-LAN
don't work anymore on my ASUS P3B-F, which I reported Thu, 15 Nov 2001
18:43:22 +0100 here on this list, I wrote a small patch to fix
this myself.

The patch does nothing else than suppressing the clearing of the
General Purpose Events (GPEs).

Thanks to Patrick Mochel, who explained me, what was changed
between 2.4.13 and 2.4.14 regarding my problem.

The patch applies to 2.4.14 up to 2.4.18 at least.

With this patch applied and CONFIG_ACPI_NO_GPE_DISABLE #define'd,
Keyboard-Power-ON as well as Wake-On-LAN are working for me,
without this patch or with CONFIG_ACPI_NO_GPE_DISABLE #undef'ined,
both don't work.

Of course, there would be better ways to dynamically change this
behaviour (via some kernel option for example), but the way the
patch goes, was the least invasive one for me.

I have no idea about possible side-effects of suppressing the
execution of acpi_hw_disable_non_wakeup_gpes(), but i'd like
to hear about them, if there are any.

If there are no (relevant) side-effects, I'd be happy, if you'd
consider applying it to 2.4.19 or something like that.

And yes, I did notice, that acpi_hw_disable_non_wakeup_gpes()
should disable *non-wakeup* GPEs, but however - at least for
me it disables more than them :)


PS: I'm not member on the linux-kernel@ list, so please CC me in
    replies, thanks.


regards,
   Mario
-- 
[mod_nessus for iauth]
<delta> "scanning your system...found depreciated OS...found
        hole...installing new OS...please reboot and reconnect now"

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-source-2.4.14.ACPI-SoftWake.patch"

diff -ur kernel-source-2.4.14.orig/Documentation/Configure.help kernel-source-2.4.14/Documentation/Configure.help
--- kernel-source-2.4.14.orig/Documentation/Configure.help	Thu Nov  8 09:32:56 2001
+++ kernel-source-2.4.14/Documentation/Configure.help	Sun Mar 10 16:54:02 2002
@@ -14727,6 +14727,12 @@
   This driver handles overheating conditions on laptops. It is HIGHLY
   recommended, as your laptop CPU may be damaged without it.
 
+ACPI Dont disable GPE events
+CONFIG_ACPI_NO_GPE_DISABLE
+  Normally we disable all GPE events when we enter a system sleep state.
+  If you experience, that your Keyboard-Power-ON or other Wakeup
+  methods don't work anymore, try setting this to Y. Otherwise, say N.
+  
 Advanced Power Management BIOS support
 CONFIG_APM
   APM is a BIOS specification for saving power using several different
diff -ur kernel-source-2.4.14.orig/drivers/acpi/Config.in kernel-source-2.4.14/drivers/acpi/Config.in
--- kernel-source-2.4.14.orig/drivers/acpi/Config.in	Thu Jun 21 02:47:39 2001
+++ kernel-source-2.4.14/drivers/acpi/Config.in	Sun Mar 10 16:52:58 2002
@@ -14,4 +14,5 @@
 dep_tristate '      Embedded Controller' CONFIG_ACPI_EC $CONFIG_ACPI_BUSMGR $CONFIG_ACPI
 dep_tristate '      Control Method Battery' CONFIG_ACPI_CMBATT $CONFIG_ACPI_BUSMGR $CONFIG_ACPI $CONFIG_ACPI_EC
 dep_tristate '      Thermal' CONFIG_ACPI_THERMAL $CONFIG_ACPI_BUSMGR $CONFIG_ACPI  $CONFIG_ACPI_EC
+dep_bool     '      Dont disable GPE events' CONFIG_ACPI_NO_GPE_DISABLE $CONFIG_ACPI
 #endmenu
diff -ur kernel-source-2.4.14.orig/drivers/acpi/hardware/hwsleep.c kernel-source-2.4.14/drivers/acpi/hardware/hwsleep.c
--- kernel-source-2.4.14.orig/drivers/acpi/hardware/hwsleep.c	Wed Oct 24 23:06:22 2001
+++ kernel-source-2.4.14/drivers/acpi/hardware/hwsleep.c	Sun Mar 10 16:47:45 2002
@@ -171,7 +171,9 @@
 
 	disable ();
 
+#ifndef CONFIG_ACPI_NO_GPE_DISABLE
 	acpi_hw_disable_non_wakeup_gpes();
+#endif /* CONFIG_ACPI_NO_GPE_DISABLE */
 
 	PM1Acontrol = (u16) acpi_hw_register_read (ACPI_MTX_LOCK, PM1_CONTROL);
 

--u3/rZRmxL6MmkK24--
