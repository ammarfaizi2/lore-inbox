Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbTAHBuM>; Tue, 7 Jan 2003 20:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267654AbTAHBuM>; Tue, 7 Jan 2003 20:50:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19209 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267650AbTAHBtz>;
	Tue, 7 Jan 2003 20:49:55 -0500
Date: Tue, 7 Jan 2003 17:58:19 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.54
Message-ID: <20030108015819.GD30924@kroah.com>
References: <20030108015500.GA30924@kroah.com> <20030108015551.GB30924@kroah.com> <20030108015714.GC30924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108015714.GC30924@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.896, 2003/01/07 16:41:22-08:00, greg@kroah.com

PCI hotplug: clean up the try_module_get() logic a bit.


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Tue Jan  7 16:44:10 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Tue Jan  7 16:44:10 2003
@@ -561,7 +561,7 @@
 	up(&parent->d_inode->i_sem);
 }
 
-/* yuck, WFT is this? */
+/* Weee, fun with macros... */
 #define GET_STATUS(name,type)	\
 static int get_##name (struct hotplug_slot *slot, type *value)		\
 {									\
@@ -661,29 +661,26 @@
 	power = (u8)(lpower & 0xff);
 	dbg ("power = %d\n", power);
 
+	if (!try_module_get(slot->ops->owner)) {
+		retval = -ENODEV;
+		goto exit;
+	}
 	switch (power) {
 		case 0:
-			if (!slot->ops->disable_slot)
-				break;
-			if (try_module_get(slot->ops->owner)) {
+			if (slot->ops->disable_slot)
 				retval = slot->ops->disable_slot(slot);
-				module_put(slot->ops->owner);
-			}
 			break;
 
 		case 1:
-			if (!slot->ops->enable_slot)
-				break;
-			if (try_module_get(slot->ops->owner)) {
+			if (slot->ops->enable_slot)
 				retval = slot->ops->enable_slot(slot);
-				module_put(slot->ops->owner);
-			}
 			break;
 
 		default:
 			err ("Illegal value specified for power\n");
 			retval = -EINVAL;
 	}
+	module_put(slot->ops->owner);
 
 exit:	
 	kfree (buff);
@@ -770,12 +767,13 @@
 	attention = (u8)(lattention & 0xff);
 	dbg (" - attention = %d\n", attention);
 
-	if (slot->ops->set_attention_status) {
-		if (try_module_get(slot->ops->owner)) {
-			retval = slot->ops->set_attention_status(slot, attention);
-			module_put(slot->ops->owner);
-		}
+	if (!try_module_get(slot->ops->owner)) {
+		retval = -ENODEV;
+		goto exit;
 	}
+	if (slot->ops->set_attention_status)
+		retval = slot->ops->set_attention_status(slot, attention);
+	module_put(slot->ops->owner);
 
 exit:	
 	kfree (buff);
@@ -1007,12 +1005,13 @@
 	test = (u32)(ltest & 0xffffffff);
 	dbg ("test = %d\n", test);
 
-	if (slot->ops->hardware_test) {
-		if (try_module_get(slot->ops->owner)) {
-			retval = slot->ops->hardware_test(slot, test);
-			module_put(slot->ops->owner);
-		}
+	if (!try_module_get(slot->ops->owner)) {
+		retval = -ENODEV;
+		goto exit;
 	}
+	if (slot->ops->hardware_test)
+		retval = slot->ops->hardware_test(slot, test);
+	module_put(slot->ops->owner);
 
 exit:	
 	kfree (buff);
