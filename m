Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVAYFN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVAYFN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 00:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVAYFN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 00:13:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:59333 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261818AbVAYFNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 00:13:52 -0500
Date: Mon, 24 Jan 2005 21:12:44 -0800
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>, tj@home-tj.org
Cc: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Modules: Allow sysfs module paramaters to be written to.
Message-ID: <20050125051244.GA656@kroah.com>
References: <200501132234.30762.rathamahata@ehouse.ru> <20050114005948.GD4140@kroah.com> <1106463261.8118.13.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106463261.8118.13.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 07:54:21AM +0100, Marcel Holtmann wrote:
> Hi Greg,
> 
> > > It looks like module parameters are not setable via sysfs in 2.6.11-rc1
> > > 
> > > E.g.
> > > arise parameters # echo -en Y > /sys/module/usbcore/parameters/old_scheme_first
> > > -bash: /sys/module/usbcore/parameters/old_scheme_first: Permission denied
> > > arise parameters # id
> > > uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)
> > > arise parameters # 
> > > arise parameters # ls -la /sys/module/usbcore/parameters/old_scheme_first
> > > -rw-r--r--  1 root root 0 Jan 13 22:22 /sys/module/usbcore/parameters/old_scheme_first
> > > arise parameters # 
> > > 
> > > This is sad because it seems that my usb flash stick (transcebd jetflash)
> > > doesn't like new USB device initialization scheme introduced in 2.6.10.
> > 
> > I'm seeing the same problem here.  I'll dig into it later tonight.
> 
> any updates on this? It still results in a permission denied with a
> recent 2.6.11-rc2 kernel.

Here's a patch that fixes this for me.  It's as if the function was
never implemented at all for some reason.  Sorry for not catching this
when tj's patches went in that changed all of this logic.

Let me know if this fixes the problem for you or not.

thanks,

greg k-h

-----
Modules: Allow sysfs module paramaters to be written to.

Fixes a bug in the current tree preventing the sysfs module paramaters from being able
to be changed at all from userspace.  It's as if someone just forgot to write this function...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/kernel/params.c b/kernel/params.c
--- a/kernel/params.c	2005-01-24 21:07:40 -08:00
+++ b/kernel/params.c	2005-01-24 21:07:40 -08:00
@@ -640,9 +640,33 @@
 	return ret;
 }
 
+static ssize_t module_attr_store(struct kobject *kobj,
+				struct attribute *attr,
+				const char *buf, size_t len)
+{
+	struct module_attribute *attribute;
+	struct module_kobject *mk;
+	int ret;
+
+	attribute = to_module_attr(attr);
+	mk = to_module_kobject(kobj);
+
+	if (!attribute->store)
+		return -EPERM;
+
+	if (!try_module_get(mk->mod))
+		return -ENODEV;
+
+	ret = attribute->store(attribute, mk->mod, buf, len);
+
+	module_put(mk->mod);
+
+	return ret;
+}
+
 static struct sysfs_ops module_sysfs_ops = {
 	.show = module_attr_show,
-	.store = NULL,
+	.store = module_attr_store,
 };
 
 #else
