Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267151AbUBMSaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267157AbUBMSaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:30:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:13027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267151AbUBMS2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:28:12 -0500
Date: Fri, 13 Feb 2004 10:27:55 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Tommi Virtanen <tv@tv.debian.net>, Greg KH <greg@kroah.com>
Cc: Leann Ogasawara <ogasawara@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] don't allow / in class device names
Message-Id: <20040213102755.27cf4fcd.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [0 tv@tao /sys/class/misc]$ uname -a
> Linux tao 2.6.2-rc2 #6 Mon Jan 26 10:54:50 EET 2004 i686 GNU/Linux
> [0 tv@tao /sys/class/misc]$ echo *
> intermezzo net/tun psaux rtc uinput
> [0 tv@tao /sys/class/misc]$
>
> Seems like that's all because of this:
>
> static struct miscdevice tun_miscdev = {
>         .minor = TUN_MINOR,
>         .name = "net/tun",
>         .fops = &tun_fops
> };
>
> Name is apparently meant to be a filename, not a path.
> Don't know what should be done to it; maybe
>
> static struct miscdevice tun_miscdev = {
>         .minor = TUN_MINOR,
>         .name = "tun",
>         .fops = &tun_fops,
>         .devfs_name = "misc/net/tun",
> };
>
> But I havent tried that out.
>
> I'd suggest this, to flush out all the problems. Later,
> it can be changed to return -EINVAL or BUG_ON.
>
> --- 1.26/drivers/char/misc.c    Thu Jan 15 13:05:56 2004
> +++ edited/misc.c       Fri Feb 13 19:35:45 2004
> @@ -212,6 +212,9 @@
>  int misc_register(struct miscdevice * misc)
>  {
>         struct miscdevice *c;
> +
> +       if (misc->name && strchr(misc->name, '/'))
> +         printk("%s: name contains slash when registering %s.\n", __func__, misc->name);
>
>         down(&misc_sem);
>         list_for_each_entry(c, &misc_list, list) {
>
Don't fix it just for misc_register, the fix needs to go into class_device.

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Fri Feb 13 10:23:36 2004
+++ b/drivers/base/class.c	Fri Feb 13 10:23:36 2004
@@ -281,7 +281,8 @@
 	int error;
 
 	class_dev = class_device_get(class_dev);
-	if (!class_dev || !strlen(class_dev->class_id))
+	if (!class_dev || !strlen(class_dev->class_id) 
+	    || strchr(class_dev->class_id, '/'))
 		return -EINVAL;
 
 	parent = class_get(class_dev->class);

