Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTIBRzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTIBRzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:55:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32409 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263915AbTIBRrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:47:51 -0400
Message-ID: <3F54D7B5.8060203@pobox.com>
Date: Tue, 02 Sep 2003 13:47:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Re: 2.4.23-pre2: 3c515.c doesn't compile non-modular
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva> <20030902164917.GM23729@fs.tum.de>
In-Reply-To: <20030902164917.GM23729@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------030603050304090709040909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030603050304090709040909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> On Sat, Aug 30, 2003 at 12:48:22PM -0300, Marcelo Tosatti wrote:
> 
>>...
>>Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
>>============================================
>>...
>>Jeff Garzik:
>>...
>>  o [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe
>>...
> 
> 
> This change broke non-modular compile of 3c515.c ("debug" is declared 
> inside an #ifdef MODULE):

I'm pretty impressed that it broke, actually.  "debug" is a weird 
pseudo-variable that's really another global variable underneath, 
corkscrew_debug...  but MODULE_PARM() uses "debug".  Sigh.

Further encouragement for me to convert net drivers over to Rusty's new 
module parameter stuff, I suppose.  His stuff is at least type-checked, 
and would have caught this problem -- a big advantage over the 2.4.x 
MODULE_PARM() stuff.

> ...
> gcc -D__KERNEL__ 
> -I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
> include -DKBUILD_BASENAME=3c515  -c -o 3c515.o 3c515.c
> 3c515.c: In function `netdev_get_msglevel':
> 3c515.c:1621: error: `debug' undeclared (first use in this function)
> 3c515.c:1621: error: (Each undeclared identifier is reported only once
> 3c515.c:1621: error: for each function it appears in.)
> 3c515.c: In function `netdev_set_msglevel':
> 3c515.c:1626: error: `debug' undeclared (first use in this function)


Fixed.  Linus, please apply.

	Jeff



--------------030603050304090709040909
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/3c515.c 1.22 vs edited =====
--- 1.22/drivers/net/3c515.c	Tue Aug 26 16:42:22 2003
+++ edited/drivers/net/3c515.c	Tue Sep  2 13:44:18 2003
@@ -1590,12 +1590,12 @@
 
 static u32 netdev_get_msglevel(struct net_device *dev)
 {
-	return debug;
+	return corkscrew_debug;
 }
 
 static void netdev_set_msglevel(struct net_device *dev, u32 level)
 {
-	debug = level;
+	corkscrew_debug = level;
 }
 
 static struct ethtool_ops netdev_ethtool_ops = {

--------------030603050304090709040909--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
This is a multi-part message in MIME format.
--------------030603050304090709040909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> On Sat, Aug 30, 2003 at 12:48:22PM -0300, Marcelo Tosatti wrote:
> 
>>...
>>Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
>>============================================
>>...
>>Jeff Garzik:
>>...
>>  o [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe
>>...
> 
> 
> This change broke non-modular compile of 3c515.c ("debug" is declared 
> inside an #ifdef MODULE):

I'm pretty impressed that it broke, actually.  "debug" is a weird 
pseudo-variable that's really another global variable underneath, 
corkscrew_debug...  but MODULE_PARM() uses "debug".  Sigh.

Further encouragement for me to convert net drivers over to Rusty's new 
module parameter stuff, I suppose.  His stuff is at least type-checked, 
and would have caught this problem -- a big advantage over the 2.4.x 
MODULE_PARM() stuff.

> ...
> gcc -D__KERNEL__ 
> -I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
> include -DKBUILD_BASENAME=3c515  -c -o 3c515.o 3c515.c
> 3c515.c: In function `netdev_get_msglevel':
> 3c515.c:1621: error: `debug' undeclared (first use in this function)
> 3c515.c:1621: error: (Each undeclared identifier is reported only once
> 3c515.c:1621: error: for each function it appears in.)
> 3c515.c: In function `netdev_set_msglevel':
> 3c515.c:1626: error: `debug' undeclared (first use in this function)


Fixed.  Linus, please apply.

	Jeff



--------------030603050304090709040909
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/3c515.c 1.22 vs edited =====
--- 1.22/drivers/net/3c515.c	Tue Aug 26 16:42:22 2003
+++ edited/drivers/net/3c515.c	Tue Sep  2 13:44:18 2003
@@ -1590,12 +1590,12 @@
 
 static u32 netdev_get_msglevel(struct net_device *dev)
 {
-	return debug;
+	return corkscrew_debug;
 }
 
 static void netdev_set_msglevel(struct net_device *dev, u32 level)
 {
-	debug = level;
+	corkscrew_debug = level;
 }
 
 static struct ethtool_ops netdev_ethtool_ops = {

--------------030603050304090709040909--

