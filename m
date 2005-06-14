Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVFNPNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVFNPNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVFNPMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:12:03 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:22593 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261153AbVFNPCo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:02:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AhAE752X1ZSnhgADx72QTpLyTEwgrAxUkVUwB3vwl9VDO4yJAFo816YlDMUW6F85dBS1CB9NZYJ2nB8SkafnQgjSFA0xEsyywH+OXCn8JAdLYvJHE0oIvtnua3dKztfd2nrUhd9NTBtVi39s/497prnlSphNs2dBDwwMAeRWJ9c=
Message-ID: <9e473391050614080230ae359d@mail.gmail.com>
Date: Tue, 14 Jun 2005 11:02:43 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: Input sysbsystema and hotplug
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050614063851.GA19620@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506131607.51736.dtor_core@ameritech.net>
	 <20050613221657.GB15381@suse.de>
	 <9e473391050613232170f57ea3@mail.gmail.com>
	 <20050614063851.GA19620@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, Greg KH <gregkh@suse.de> wrote:
> Heh, yes, sorry, you did.
> 
> Hm, I don't even remember why I didn't like it anymore, last I remember,
> I think you got the parent reference counting correct, right?  Care to
> dig out the patch and send it again?

I brought this forward from a kernel a couple of months old so it may
need some checking.

diff --git a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -406,8 +406,9 @@ int class_device_add(struct class_device
 
 	/* first, register with generic layer. */
 	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
-	if (parent)
+	if (parent && !class_dev->kobj.parent)
 		class_dev->kobj.parent = &parent->subsys.kset.kobj;
+	class_dev->kobj.parent = kobject_get(class_dev->kobj.parent);
 
 	if ((error = kobject_add(&class_dev->kobj)))
 		goto register_done;
@@ -438,6 +439,12 @@ int class_device_add(struct class_device
 	return error;
 }
 
+int class_device_add_child(struct class_device *class_dev, struct
class_device *parent)
+{
+	class_dev->kobj.parent = &class_dev->kobj;
+	return class_device_add(class_dev);
+}
+
 int class_device_register(struct class_device *class_dev)
 {
 	class_device_initialize(class_dev);
@@ -463,6 +470,7 @@ void class_device_del(struct class_devic
 	class_device_remove_attrs(class_dev);
 
 	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
+	kobject_put(class_dev->kobj.parent);
 	kobject_del(&class_dev->kobj);
 
 	if (parent)
@@ -581,6 +589,7 @@ EXPORT_SYMBOL_GPL(class_device_register)
 EXPORT_SYMBOL_GPL(class_device_unregister);
 EXPORT_SYMBOL_GPL(class_device_initialize);
 EXPORT_SYMBOL_GPL(class_device_add);
+EXPORT_SYMBOL_GPL(class_device_add_child);
 EXPORT_SYMBOL_GPL(class_device_del);
 EXPORT_SYMBOL_GPL(class_device_get);
 EXPORT_SYMBOL_GPL(class_device_put);
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -208,6 +208,7 @@ extern int class_device_register(struct 
 extern void class_device_unregister(struct class_device *);
 extern void class_device_initialize(struct class_device *);
 extern int class_device_add(struct class_device *);
+extern int class_device_add_child(struct class_device *, struct
class_device *);
 extern void class_device_del(struct class_device *);
 
 extern int class_device_rename(struct class_device *, char *);



-- 
Jon Smirl
jonsmirl@gmail.com
