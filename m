Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTDIABM (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTDIABM (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:01:12 -0400
Received: from dp.samba.org ([66.70.73.150]:28894 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262600AbTDIABJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 20:01:09 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, hch@infradead.org,
       Kai Germaschewski <kai.germaschewski@gmx.de>, sfr@canb.auug.org.au,
       "Nemosoft Unv." <nemosoft@smcc.demon.nl>, davem@redhat.com
Subject: Re: SET_MODULE_OWNER? 
In-reply-to: Your message of "Tue, 08 Apr 2003 00:34:35 -0400."
             <3E92515B.6030807@pobox.com> 
Date: Tue, 08 Apr 2003 22:25:39 +1000
Message-Id: <20030409001247.E02A12C482@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E92515B.6030807@pobox.com> you write:
> Rusty Russell wrote:
> > Unlike that, substituting dev->owner = THIS_MODULE; has no backwards
> > compatibility loss, and it removes a confusing and pointless macro
> > which *never* had a point.
> 
> 
> Substituting dev->owner=THIS_MODULE has _obvious_ backwards compat loss, 
> because 'owner' member did not exist in struct net_device.

Oh, so SET_MODULE_OWNER is a struct net_device only thing?  Certain
authors (myself included) obviously don't know that.

> If you had bothered to even do a trivial grep, you would have seen the 
> use to which SET_MODULE_OWNER is being put.  Christoph's try* changes 
> are annoying but work-around-able.  Removal of SET_MODULE_OWNER is not.

If *you* had bothered to do a grep, you would have seen non-netdevice
uses to which it is really being put, as it's managed to thoroughly
confuse coders.

APM, isdn, USB, hell, you even fooled the USAGI guys!

Seriously, adding an owner arg to init_etherdev and friends, or
creating a set of SET_NET_DEVICE_OWNER etc macros would have been
defensible for backwards compatibility.

Rusty.
PS.  I didn't fix up ISDN.  Kai, want me to do that?
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Move SET_MODULE_OWNER to netdevice.h 
Author: Rusty Russell
Status: Completely Untested

D: Jeff points out that SET_MODULE_OWNER is really only for struct
D: net_device, so move it from module.h to netdevice.h and fix up
D: areas which were confused about it (renaming would be nice, but
D: too invasive).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/arch/i386/kernel/apm.c working-2.5.67-set_owner/arch/i386/kernel/apm.c
--- linux-2.5.67/arch/i386/kernel/apm.c	2003-04-08 11:13:40.000000000 +1000
+++ working-2.5.67-set_owner/arch/i386/kernel/apm.c	2003-04-08 22:03:56.000000000 +1000
@@ -2038,7 +2038,7 @@ static int __init apm_init(void)
 
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
 	if (apm_proc)
-		SET_MODULE_OWNER(apm_proc);
+		apm_proc->owner = THIS_MODULE;
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/drivers/char/i8k.c working-2.5.67-set_owner/drivers/char/i8k.c
--- linux-2.5.67/drivers/char/i8k.c	2003-02-07 19:22:26.000000000 +1100
+++ working-2.5.67-set_owner/drivers/char/i8k.c	2003-04-08 22:04:33.000000000 +1000
@@ -757,7 +757,7 @@ int __init i8k_init(void)
 	return -ENOENT;
     }
     proc_i8k->proc_fops = &i8k_fops;
-    SET_MODULE_OWNER(proc_i8k);
+    proc_i8k->owner = THIS_MODULE;
 
     printk(KERN_INFO
 	   "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/drivers/usb/media/pwc-if.c working-2.5.67-set_owner/drivers/usb/media/pwc-if.c
--- linux-2.5.67/drivers/usb/media/pwc-if.c	2003-03-18 12:21:38.000000000 +1100
+++ working-2.5.67-set_owner/drivers/usb/media/pwc-if.c	2003-04-08 22:21:30.000000000 +1000
@@ -1805,7 +1805,7 @@ static int usb_pwc_probe(struct usb_inte
 	}
 	memcpy(vdev, &pwc_template, sizeof(pwc_template));
 	strcpy(vdev->name, name);
-	SET_MODULE_OWNER(vdev);
+	vdev->owner = THIS_MODULE;
 	pdev->vdev = vdev;
 	vdev->priv = pdev;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/include/linux/module.h working-2.5.67-set_owner/include/linux/module.h
--- linux-2.5.67/include/linux/module.h	2003-04-08 11:15:01.000000000 +1000
+++ working-2.5.67-set_owner/include/linux/module.h	2003-04-08 22:13:05.000000000 +1000
@@ -408,7 +408,6 @@ __attribute__((section(".gnu.linkonce.th
 #endif /* MODULE */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
-#define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/include/linux/netdevice.h working-2.5.67-set_owner/include/linux/netdevice.h
--- linux-2.5.67/include/linux/netdevice.h	2003-04-08 11:15:01.000000000 +1000
+++ working-2.5.67-set_owner/include/linux/netdevice.h	2003-04-08 22:16:01.000000000 +1000
@@ -835,6 +835,11 @@ extern int		netdev_fastroute_obstacles;
 extern void		dev_clear_fastroute(struct net_device *dev);
 #endif
 
+/* For use with struct netdevice, which didn't have an owner field in
+   2.2 and before: this provides backwards compatibility if you care.
+   Don't use on other structs (unless you know the owner field was
+   added at the same time as struct netdevice's was). */
+#define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
 #endif /* __KERNEL__ */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/net/ipv4/ah.c working-2.5.67-set_owner/net/ipv4/ah.c
--- linux-2.5.67/net/ipv4/ah.c	2003-04-08 11:15:06.000000000 +1000
+++ working-2.5.67-set_owner/net/ipv4/ah.c	2003-04-08 22:20:05.000000000 +1000
@@ -320,6 +320,7 @@ static void ah_destroy(struct xfrm_state
 static struct xfrm_type ah_type =
 {
 	.description	= "AH4",
+	.owner		= THIS_MODULE,
 	.proto	     	= IPPROTO_AH,
 	.init_state	= ah_init_state,
 	.destructor	= ah_destroy,
@@ -335,7 +336,6 @@ static struct inet_protocol ah4_protocol
 
 static int __init ah4_init(void)
 {
-	SET_MODULE_OWNER(&ah_type);
 	if (xfrm_register_type(&ah_type, AF_INET) < 0) {
 		printk(KERN_INFO "ip ah init: can't add xfrm type\n");
 		return -EAGAIN;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/net/ipv4/esp.c working-2.5.67-set_owner/net/ipv4/esp.c
--- linux-2.5.67/net/ipv4/esp.c	2003-04-08 11:15:06.000000000 +1000
+++ working-2.5.67-set_owner/net/ipv4/esp.c	2003-04-08 22:20:18.000000000 +1000
@@ -552,6 +552,7 @@ error:
 static struct xfrm_type esp_type =
 {
 	.description	= "ESP4",
+	.owner		= THIS_MODULE,
 	.proto	     	= IPPROTO_ESP,
 	.init_state	= esp_init_state,
 	.destructor	= esp_destroy,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/net/ipv6/ah6.c working-2.5.67-set_owner/net/ipv6/ah6.c
--- linux-2.5.67/net/ipv6/ah6.c	2003-04-08 11:15:09.000000000 +1000
+++ working-2.5.67-set_owner/net/ipv6/ah6.c	2003-04-08 22:20:27.000000000 +1000
@@ -318,6 +318,7 @@ static void ah6_destroy(struct xfrm_stat
 static struct xfrm_type ah6_type =
 {
 	.description	= "AH6",
+	.owner		= THIS_MODULE,
 	.proto	     	= IPPROTO_AH,
 	.init_state	= ah6_init_state,
 	.destructor	= ah6_destroy,
@@ -333,8 +334,6 @@ static struct inet6_protocol ah6_protoco
 
 int __init ah6_init(void)
 {
-	SET_MODULE_OWNER(&ah6_type);
-
 	if (xfrm_register_type(&ah6_type, AF_INET6) < 0) {
 		printk(KERN_INFO "ipv6 ah init: can't add xfrm type\n");
 		return -EAGAIN;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.67/net/ipv6/esp6.c working-2.5.67-set_owner/net/ipv6/esp6.c
--- linux-2.5.67/net/ipv6/esp6.c	2003-04-08 11:15:09.000000000 +1000
+++ working-2.5.67-set_owner/net/ipv6/esp6.c	2003-04-08 22:20:42.000000000 +1000
@@ -488,6 +488,7 @@ error:
 static struct xfrm_type esp6_type =
 {
 	.description	= "ESP6",
+	.owner	     	= THIS_MODULE,
 	.proto	     	= IPPROTO_ESP,
 	.init_state	= esp6_init_state,
 	.destructor	= esp6_destroy,
@@ -504,7 +505,6 @@ static struct inet6_protocol esp6_protoc
 
 int __init esp6_init(void)
 {
-	SET_MODULE_OWNER(&esp6_type);
 	if (xfrm_register_type(&esp6_type, AF_INET6) < 0) {
 		printk(KERN_INFO "ipv6 esp init: can't add xfrm type\n");
 		return -EAGAIN;
