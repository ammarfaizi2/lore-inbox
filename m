Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTLBUGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTLBUGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:06:44 -0500
Received: from jimknopf.rz.uni-frankfurt.de ([141.2.22.56]:42400 "EHLO
	jimknopf.rz.uni-frankfurt.de") by vger.kernel.org with ESMTP
	id S264342AbTLBUGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:06:37 -0500
Message-ID: <3FCCF0C8.6090809@slit.de>
Date: Tue, 02 Dec 2003 21:06:32 +0100
From: Alexander Achenbach <xela@slit.de>
Reply-To: xela@slit.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-1.backports.org.1
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>, andre@linuxdiskcert.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE modules + cmd640 (2.4.22)
Content-Type: multipart/mixed;
 boundary="------------030705070607020002010504"
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705070607020002010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi again.

This should fix IDE module dependency problems with CMD640 support.

I have sent this same patch before (on September 22nd) for kernel
2.4.22, to the same recipients. While it bounced for one recipient
('andre@linux-ide.org'), it reached the mailing list, but I never got
any answers.

Anyway, as I'm right back in the middle of kernel compilation (do_brk,
*sigh*), I've just noticed that the IDE modules and CMD640 problem
/still/ persists. So please read on (reading '2.4.22' as '2.4.23'):

-----------------------------------------------------------------------

This patch intends to fix an unresolved symbol 'init_cmd640_vlb' error
when compiling kernel 2.4.22 using

     CONFIG_IDE=m
     CONFIG_BLK_DEV_IDE=m

and an enabled 'CONFIG_BLK_DEV_CMD640' option. The problem would show up
on the first attempt to run 'depmod' or otherwise deal with IDE modules.

I've not seen any fix for this in any recent prerelease.

The problem is caused by the way 'cmd640' is made part of the kernel. If

     CONFIG_BLK_DEV_CMD640=y

(which is the only answer offered besides 'n' for a stock 2.4.22), the
'cmd640' code will be put into the kernel statically. As 'ide-core.o'
will be a module and it will contain a reference to the (unexported)
function 'init_cmd640_vlb' of 'cmd640.c', symbol resolution will fail.

The following patch assumes that 'cmd640' is meant to be an independent
module now (as all other IDE drivers in 'drivers/ide/pci') if IDE core is
modular. The patch only adds the required configuration option changes to
allow an additional answer 'm' for 'CONFIG_BLK_DEV_CMD640' (and disabling
'y' completely if IDE is modular). Boolean 'CONFIG_BLK_DEV_CMD640_ENHANCED'
may now be set to 'y' if 'CONFIG_BLK_DEV_CMD640' is either 'y' or 'm'.

With

     CONFIG_BLK_DEV_CMD640=m'

the reference to 'init_cmd640_vlb' from 'ide.c' will be omitted, leaving
VLB handling to the respective module parameter of 'cmd640.o', so there's
no longer any unresolved symbol.

NB: While I have verified that symbols resolve cleanly and 'cmd640.o' loads
     without problems, I currently have no hardware to actually test any
     CMD640 chipsets on (I only added the driver to my configuration for
     completeness), so I cannot tell whether the modular driver actually
     works as it should. At least it doesn't break IDE module loading now.

Best regards,
Alex

[ Please send answers to my From address.
   I'm not subscribed to the kernel mailing list. ]

--------------030705070607020002010504
Content-Type: text/plain;
 name="cmd640fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmd640fix.diff"

diff -ur linux-2.4.22/drivers/ide/Config.in linux-2.4.22-cmd640fix/drivers/ide/Config.in
--- linux-2.4.22/drivers/ide/Config.in	Mon Aug 25 13:44:41 2003
+++ linux-2.4.22-cmd640fix/drivers/ide/Config.in	Sun Sep 21 17:03:19 2003
@@ -27,8 +27,8 @@
 
    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
-      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
+      dep_tristate '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86 $CONFIG_BLK_DEV_IDE
+      dep_mbool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
       dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
       if [ "$CONFIG_PCI" = "y" ]; then
 	 bool '  PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI


--------------030705070607020002010504--

