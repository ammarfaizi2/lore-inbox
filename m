Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUJMFvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUJMFvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268421AbUJMFvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:51:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:10173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268404AbUJMFuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:50:25 -0400
Message-ID: <416CC156.8070201@osdl.org>
Date: Tue, 12 Oct 2004 22:47:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [PATCH] ds: reduce stack usage in ds_ioctl
Content-Type: multipart/mixed;
 boundary="------------070904000500060107010109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904000500060107010109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Russell,
Please consider for after 2.6.9.

-- 
~Randy


--------------070904000500060107010109
Content-Type: text/x-patch;
 name="ds_ioctl_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ds_ioctl_v2.patch"


Reduce stack usage from 696 (0x2b8) to 24 (0x18) (on x86-32).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 drivers/pcmcia/ds.c |   79 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 46 insertions(+), 33 deletions(-)

diff -Naurp ./drivers/pcmcia/ds.c~ds_ioctl ./drivers/pcmcia/ds.c
--- ./drivers/pcmcia/ds.c~ds_ioctl	2004-10-11 21:10:02.000000000 -0700
+++ ./drivers/pcmcia/ds.c	2004-10-12 22:37:17.176866912 -0700
@@ -892,7 +892,7 @@ static int ds_ioctl(struct inode * inode
     void __user *uarg = (char __user *)arg;
     u_int size;
     int ret, err;
-    ds_ioctl_arg_t buf;
+    ds_ioctl_arg_t *buf;
     user_info_t *user;
 
     ds_dbg(2, "ds_ioctl(socket %d, %#x, %#lx)\n", iminor(inode), cmd, arg);
@@ -926,46 +926,49 @@ static int ds_ioctl(struct inode * inode
 	    return err;
 	}
     }
+    buf = kmalloc(sizeof(ds_ioctl_arg_t), GFP_KERNEL);
+    if (!buf)
+	return -ENOMEM;
     
     err = ret = 0;
     
-    if (cmd & IOC_IN) __copy_from_user((char *)&buf, uarg, size);
+    if (cmd & IOC_IN) __copy_from_user((char *)buf, uarg, size);
     
     switch (cmd) {
     case DS_ADJUST_RESOURCE_INFO:
-	ret = pcmcia_adjust_resource_info(s->handle, &buf.adjust);
+	ret = pcmcia_adjust_resource_info(s->handle, &buf->adjust);
 	break;
     case DS_GET_CARD_SERVICES_INFO:
-	ret = pcmcia_get_card_services_info(&buf.servinfo);
+	ret = pcmcia_get_card_services_info(&buf->servinfo);
 	break;
     case DS_GET_CONFIGURATION_INFO:
-	ret = pcmcia_get_configuration_info(s->handle, &buf.config);
+	ret = pcmcia_get_configuration_info(s->handle, &buf->config);
 	break;
     case DS_GET_FIRST_TUPLE:
 	pcmcia_validate_mem(s->parent);
-	ret = pcmcia_get_first_tuple(s->handle, &buf.tuple);
+	ret = pcmcia_get_first_tuple(s->handle, &buf->tuple);
 	break;
     case DS_GET_NEXT_TUPLE:
-	ret = pcmcia_get_next_tuple(s->handle, &buf.tuple);
+	ret = pcmcia_get_next_tuple(s->handle, &buf->tuple);
 	break;
     case DS_GET_TUPLE_DATA:
-	buf.tuple.TupleData = buf.tuple_parse.data;
-	buf.tuple.TupleDataMax = sizeof(buf.tuple_parse.data);
-	ret = pcmcia_get_tuple_data(s->handle, &buf.tuple);
+	buf->tuple.TupleData = buf->tuple_parse.data;
+	buf->tuple.TupleDataMax = sizeof(buf->tuple_parse.data);
+	ret = pcmcia_get_tuple_data(s->handle, &buf->tuple);
 	break;
     case DS_PARSE_TUPLE:
-	buf.tuple.TupleData = buf.tuple_parse.data;
-	ret = pcmcia_parse_tuple(s->handle, &buf.tuple, &buf.tuple_parse.parse);
+	buf->tuple.TupleData = buf->tuple_parse.data;
+	ret = pcmcia_parse_tuple(s->handle, &buf->tuple, &buf->tuple_parse.parse);
 	break;
     case DS_RESET_CARD:
 	ret = pcmcia_reset_card(s->handle, NULL);
 	break;
     case DS_GET_STATUS:
-	ret = pcmcia_get_status(s->handle, &buf.status);
+	ret = pcmcia_get_status(s->handle, &buf->status);
 	break;
     case DS_VALIDATE_CIS:
 	pcmcia_validate_mem(s->parent);
-	ret = pcmcia_validate_cis(s->handle, &buf.cisinfo);
+	ret = pcmcia_validate_cis(s->handle, &buf->cisinfo);
 	break;
     case DS_SUSPEND_CARD:
 	ret = pcmcia_suspend_card(s->parent);
@@ -980,46 +983,54 @@ static int ds_ioctl(struct inode * inode
 	err = pcmcia_insert_card(s->parent);
 	break;
     case DS_ACCESS_CONFIGURATION_REGISTER:
-	if ((buf.conf_reg.Action == CS_WRITE) && !capable(CAP_SYS_ADMIN))
-	    return -EPERM;
-	ret = pcmcia_access_configuration_register(s->handle, &buf.conf_reg);
+	if ((buf->conf_reg.Action == CS_WRITE) && !capable(CAP_SYS_ADMIN)) {
+	    err = -EPERM;
+	    goto free_out;
+	}
+	ret = pcmcia_access_configuration_register(s->handle, &buf->conf_reg);
 	break;
     case DS_GET_FIRST_REGION:
-        ret = pcmcia_get_first_region(s->handle, &buf.region);
+        ret = pcmcia_get_first_region(s->handle, &buf->region);
 	break;
     case DS_GET_NEXT_REGION:
-	ret = pcmcia_get_next_region(s->handle, &buf.region);
+	ret = pcmcia_get_next_region(s->handle, &buf->region);
 	break;
     case DS_GET_FIRST_WINDOW:
-	buf.win_info.handle = (window_handle_t)s->handle;
-	ret = pcmcia_get_first_window(&buf.win_info.handle, &buf.win_info.window);
+	buf->win_info.handle = (window_handle_t)s->handle;
+	ret = pcmcia_get_first_window(&buf->win_info.handle, &buf->win_info.window);
 	break;
     case DS_GET_NEXT_WINDOW:
-	ret = pcmcia_get_next_window(&buf.win_info.handle, &buf.win_info.window);
+	ret = pcmcia_get_next_window(&buf->win_info.handle, &buf->win_info.window);
 	break;
     case DS_GET_MEM_PAGE:
-	ret = pcmcia_get_mem_page(buf.win_info.handle,
-			   &buf.win_info.map);
+	ret = pcmcia_get_mem_page(buf->win_info.handle,
+			   &buf->win_info.map);
 	break;
     case DS_REPLACE_CIS:
-	ret = pcmcia_replace_cis(s->handle, &buf.cisdump);
+	ret = pcmcia_replace_cis(s->handle, &buf->cisdump);
 	break;
     case DS_BIND_REQUEST:
-	if (!capable(CAP_SYS_ADMIN)) return -EPERM;
-	err = bind_request(s, &buf.bind_info);
+	if (!capable(CAP_SYS_ADMIN)) {
+	    err = -EPERM;
+	    goto free_out;
+	}
+	err = bind_request(s, &buf->bind_info);
 	break;
     case DS_GET_DEVICE_INFO:
-	err = get_device_info(s, &buf.bind_info, 1);
+	err = get_device_info(s, &buf->bind_info, 1);
 	break;
     case DS_GET_NEXT_DEVICE:
-	err = get_device_info(s, &buf.bind_info, 0);
+	err = get_device_info(s, &buf->bind_info, 0);
 	break;
     case DS_UNBIND_REQUEST:
-	err = unbind_request(s, &buf.bind_info);
+	err = unbind_request(s, &buf->bind_info);
 	break;
     case DS_BIND_MTD:
-	if (!capable(CAP_SYS_ADMIN)) return -EPERM;
-	err = bind_mtd(s, &buf.mtd_info);
+	if (!capable(CAP_SYS_ADMIN)) {
+	    err = -EPERM;
+	    goto free_out;
+	}
+	err = bind_mtd(s, &buf->mtd_info);
 	break;
     default:
 	err = -EINVAL;
@@ -1046,8 +1057,10 @@ static int ds_ioctl(struct inode * inode
 	}
     }
 
-    if (cmd & IOC_OUT) __copy_to_user(uarg, (char *)&buf, size);
+    if (cmd & IOC_OUT) __copy_to_user(uarg, (char *)buf, size);
 
+free_out:
+    kfree(buf);
     return err;
 } /* ds_ioctl */
 


--------------070904000500060107010109--
