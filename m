Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWCKPLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWCKPLA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWCKPK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:10:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15113 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751184AbWCKPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:10:56 -0500
Date: Sat, 11 Mar 2006 16:10:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Corey Minyard <minyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/ipmi/ipmi_msghandler.c: fix a memory leak
Message-ID: <20060311151056.GO21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found this memory leak.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/ipmi/ipmi_msghandler.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.16-rc5-mm3-full/drivers/char/ipmi/ipmi_msghandler.c.old	2006-03-11 14:22:49.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/char/ipmi/ipmi_msghandler.c	2006-03-11 14:25:03.000000000 +0100
@@ -736,7 +736,8 @@ int ipmi_create_user(unsigned int       
 	intf = ipmi_interfaces[if_num];
 	if ((if_num >= MAX_IPMI_INTERFACES) || IPMI_INVALID_INTERFACE(intf)) {
 		spin_unlock_irqrestore(&interfaces_lock, flags);
-		return -EINVAL;
+		rv = -EINVAL;
+		goto out_kfree;
 	}
 
 	/* Note that each existing user holds a refcount to the interface. */
@@ -751,14 +752,14 @@ int ipmi_create_user(unsigned int       
 
 	if (!try_module_get(intf->handlers->owner)) {
 		rv = -ENODEV;
-		goto out_err;
+		goto out_kref;
 	}
 
 	if (intf->handlers->inc_usecount) {
 		rv = intf->handlers->inc_usecount(intf->send_info);
 		if (rv) {
 			module_put(intf->handlers->owner);
-			goto out_err;
+			goto out_kref;
 		}
 	}
 
@@ -769,9 +770,10 @@ int ipmi_create_user(unsigned int       
 	*user = new_user;
 	return 0;
 
- out_err:
-	kfree(new_user);
+out_kref:
 	kref_put(&intf->refcount, intf_free);
+out_kfree:
+	kfree(new_user);
 	return rv;
 }
 

