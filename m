Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTIUVT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTIUVT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 17:19:58 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:53940 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262574AbTIUVT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 17:19:56 -0400
Date: Mon, 22 Sep 2003 01:19:52 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: [PATCH] [2.4] Fix possible memleaks in Ethtool ioctl handler
Message-ID: <20030921211952.GA5903@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There are trivial memleaks in Ethtool ioctl handler, while not all that
   dangerous since only root can cause them (I presume), still
   trivial patch below is needed at least for the correctness sake.
   Please apply.

   Found with help of smatch.

===== net/core/ethtool.c 1.4 vs edited =====
--- 1.4/net/core/ethtool.c	Tue Sep  2 04:26:28 2003
+++ edited/net/core/ethtool.c	Mon Sep 22 01:17:14 2003
@@ -247,8 +247,10 @@
 	if (!data)
 		return -ENOMEM;
 
-	if (copy_from_user(data, useraddr + sizeof(eeprom), len))
-		return -EFAULT;
+	if (copy_from_user(data, useraddr + sizeof(eeprom), len)) {
+		ret = -EFAULT;
+		goto out;
+	}
 
 	ret = dev->ethtool_ops->get_eeprom(dev, &eeprom, data);
 	if (!ret)
@@ -287,8 +289,10 @@
 	if (!data)
 		return -ENOMEM;
 
-	if (copy_from_user(data, useraddr + sizeof(eeprom), len))
-		return -EFAULT;
+	if (copy_from_user(data, useraddr + sizeof(eeprom), len)) {
+		ret = -EFAULT;
+		goto out;
+	}
 
 	ret = dev->ethtool_ops->set_eeprom(dev, &eeprom, data);
 	if (ret)
