Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279372AbRJWLVw>; Tue, 23 Oct 2001 07:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279374AbRJWLVm>; Tue, 23 Oct 2001 07:21:42 -0400
Received: from hermes.domdv.de ([193.102.202.1]:19460 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279376AbRJWLVa>;
	Tue, 23 Oct 2001 07:21:30 -0400
Message-ID: <XFMail.20011023132051.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.6-3.Linux:20011023131131:5243=_"
Date: Tue, 23 Oct 2001 13:20:51 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] BOOTP extension buffer size (2.4.13pre6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.6-3.Linux:20011023131131:5243=_
Content-Type: text/plain; charset=us-ascii

This patch adds the extension buffer size to the BOOTP request. If not given
the BOOTP server will assume a default of 64 bytes which is quite often too
short, resulting in missing BOOTP data and thus boot failure.

Example (ISC dhcpd):

subnet 10.4.1.0 netmask 255.255.255.0 {
 range dynamic-bootp 10.4.1.128 10.4.1.254;
 option routers 10.4.1.1;
 option broadcast-address 10.4.1.255;
 option domain-name-servers 10.4.1.1;
 option netbios-name-servers 10.4.1.1;
 option time-servers 10.4.1.1;
 option ntp-servers 10.4.1.1;
 option subnet-mask 255.255.255.0;
 option domain-name "lan.domdv.de";
 option netbios-dd-server 10.4.1.1;
 option netbios-node-type 8;
 option ip-forwarding off;
 max-lease-time 600;
 default-lease-time 120;
 dynamic-bootp-lease-length 3600;
 next-server 10.1.2.5;
 option root-path "/mnt/data4/nfsroot";
}

Stand-alone booted kernel from floppy without the patch does the following:

1. Kernel sends BOOTP request without DHCP MAX MESSAGE SIZE option, but a 128
   byte option buffer.
 
2. dhcpd thus allocates by default a 64 bytes options buffer for the reply,
   as this buffer is too small the boot path is not included in the reply
   (the domain name and other options already fill the buffer).
 
3. Kernel doesn't find boot path in BOOTP reply, tries default path and fails
   to boot.


Fix: Add the DHCP MAX MESSAGE SIZE option to the dhcp request. The size
in the fix below is 128 bytes linux vendor buffer plus the size dhcpd
subtracts from this size to calculate the vendor buffer size.

<rant>
Posted this patch for 2.2.14 on 08 May 2000. Maybe this time somebody does take
care and applies the patch.
</rant>


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--_=XFMail.1.4.6-3.Linux:20011023131131:5243=_
Content-Disposition: attachment; filename="ipconfig2.patch"
Content-Transfer-Encoding: 7bit
Content-Description: ipconfig2.patch
Content-Type: text/plain; charset=us-ascii; name=ipconfig2.patch; SizeOnDisk=375

--- linux/net/ipv4/ipconfig.c	Tue Oct 23 12:58:28 2001
+++ linux-fixed/net/ipv4/ipconfig.c	Tue Oct 23 13:09:53 2001
@@ -605,6 +605,12 @@
 	*e++ = 17;		/* Boot path */
 	*e++ = 40;
 	e += 40;
+
+	*e++ = 57;		/* set extension buffer size for reply */ 
+	*e++ = 2;
+	*e++ = 1;		/* 128+236+8+20+14, see dhcpd sources */ 
+	*e++ = 150;
+
 	*e++ = 255;		/* End of the list */
 }
 

--_=XFMail.1.4.6-3.Linux:20011023131131:5243=_--
End of MIME message
