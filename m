Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264167AbVBDUEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264167AbVBDUEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266699AbVBDUEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:04:06 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:64421 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S266743AbVBDUBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:01:01 -0500
Message-ID: <4203D476.4040706@free.fr>
Date: Fri, 04 Feb 2005 21:00:54 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Adam Belay <ambx1@neo.rr.com>
Subject: [patch] ns558 bug
Content-Type: multipart/mixed;
 boundary="------------030606040402000602000603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030606040402000602000603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch is based on http://bugzilla.kernel.org/show_bug.cgi?id=2962 
patch from adam belay.

It solve a oops when pnp_register_driver(&ns558_pnp_driver) failed.

Please apply this patch.

Matthieu

--------------030606040402000602000603
Content-Type: text/x-patch;
 name="ns558.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ns558.patch"

Index: drivers/input/gameport/ns558.c
===================================================================
RCS file: /home/mat/dev/linux-cvs-rep/linux-cvs/drivers/input/gameport/ns558.c,v
retrieving revision 1.15
diff -u -u -r1.15 ns558.c
--- drivers/input/gameport/ns558.c	16 Sep 2004 14:04:04 -0000	1.15
+++ drivers/input/gameport/ns558.c	4 Feb 2005 19:53:20 -0000
@@ -261,6 +261,8 @@
 
 #endif
 
+static int registered = 0;
+
 int __init ns558_init(void)
 {
 	int i = 0;
@@ -272,8 +274,10 @@
 	while (ns558_isa_portlist[i])
 		ns558_isa_probe(ns558_isa_portlist[i++]);
 
-	pnp_register_driver(&ns558_pnp_driver);
-	return list_empty(&ns558_list) ? -ENODEV : 0;
+	if (pnp_register_driver(&ns558_pnp_driver) >= 0) 
+		registered = 1;
+
+	return (list_empty(&ns558_list) && !registered) ? -ENODEV : 0;
 }
 
 void __exit ns558_exit(void)
@@ -297,7 +301,8 @@
 				break;
 		}
 	}
-	pnp_unregister_driver(&ns558_pnp_driver);
+	if (registered)
+		pnp_unregister_driver(&ns558_pnp_driver);
 }
 
 module_init(ns558_init);

--------------030606040402000602000603--
