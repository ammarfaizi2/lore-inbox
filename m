Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131392AbRCUM4o>; Wed, 21 Mar 2001 07:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131400AbRCUM43>; Wed, 21 Mar 2001 07:56:29 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:734 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131392AbRCUM4F>;
	Wed, 21 Mar 2001 07:56:05 -0500
Message-ID: <3AB8A49B.372063D7@mandrakesoft.com>
Date: Wed, 21 Mar 2001 07:54:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: netdev@oss.sgi.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhinds@sonic.net
Subject: [PATCH] RFC: Network driver info to userspace
Content-Type: multipart/mixed;
 boundary="------------F91653DF53532B4243FBCC90"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F91653DF53532B4243FBCC90
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In various scenarios where userland needs to interact with hardware,
userland often needs to know exactly what driver (and driver version) is
currently running on a given interface.  Hotplugging and other
applications could -really- use the ability to find out bus information
for a given interface.  Firmware

So I propose the attached addition to the ethtool interface.  It adds a
new structure with several ASCII text fields, which are filled in at the
driver's discretion.  Userland then interprets these fields for their
own evil designs.

Currently (AFAIK) for all kernel interfaces, userland has no reliable
way to associate a hardware device with a kernel interface, or a driver
with a kernel interface[1].  Since we have no generic register_driver()
interface, solving this problem means implementing a domain-specific
solution like I have done here...

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
--------------F91653DF53532B4243FBCC90
Content-Type: text/plain; charset=us-ascii;
 name="ethtool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ethtool.patch"

Index: include/linux/ethtool.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/Attic/ethtool.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 ethtool.h
--- include/linux/ethtool.h	2000/11/14 22:01:49	1.1.1.2
+++ include/linux/ethtool.h	2001/03/21 12:42:15
@@ -24,10 +24,21 @@
 	u32	reserved[4];
 };
 
+/* these strings are set to whatever the driver author decides... */
+struct ethtool_drvinfo {
+	char	driver[32];	/* driver short name, "tulip", "eepro100" */
+	char	version[32];	/* driver version string */
+	char	fw_version[32];	/* firmware version string, if applicable */
+	char	bus_info[32];	/* Bus info for this interface.  For PCI
+				 * devices, use pci_dev->slot_name. */
+	char	reserved1[32];
+	char	reserved2[32];
+};
 
 /* CMDs currently supported */
-#define ETHTOOL_GSET		0x00000001 /* Get settings, non-privileged. */
+#define ETHTOOL_GSET		0x00000001 /* Get settings. */
 #define ETHTOOL_SSET		0x00000002 /* Set settings, privileged. */
+#define ETHTOOL_GDRVINFO	0x00000003 /* Get driver info. */
 
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET

--------------F91653DF53532B4243FBCC90--

