Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269785AbUJMUCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269785AbUJMUCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269788AbUJMUCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:02:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:39866 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269785AbUJMUCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:02:13 -0400
Message-ID: <416D87CC.70605@osdl.org>
Date: Wed, 13 Oct 2004 12:53:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] ds: reduce stack usage in ds_ioctl
References: <416CC156.8070201@osdl.org>
In-Reply-To: <416CC156.8070201@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000307050108060304070308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000307050108060304070308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've updated this patch to apply after all other changes to
drivers/pcmcia/ds.c that are in current PCMCIA patchsets at
   http://pcmcia.arm.linux.org.uk/

It can be applied after patchset 16, as part of patchset
17 or 18.

-- 
~Randy

--------------000307050108060304070308
Content-Type: text/x-patch;
 name="ds_ioctl_v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ds_ioctl_v3.patch"


Reduce stack usage from 696 (0x2b8) to 24 (0x18) (on x86-32).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 drivers/pcmcia/ds.c |   93 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 55 insertions(+), 38 deletions(-)

diff -Naurp ./drivers/pcmcia/ds.c~ds_ioctl ./drivers/pcmcia/ds.c
--- ./drivers/pcmcia/ds.c~ds_ioctl	2004-10-13 11:29:46.223010248 -0700
+++ ./drivers/pcmcia/ds.c	2004-10-13 12:46:55.719219848 -0700
@@ -895,7 +895,7 @@ static int ds_ioctl(struct inode * inode
     void __user *uarg = (char __user *)arg;
     u_int size;
     int ret, err;
-    ds_ioctl_arg_t buf;
+    ds_ioctl_arg_t *buf;
     user_info_t *user;
 
     ds_dbg(2, "ds_ioctl(socket %d, %#x, %#lx)\n", iminor(inode), cmd, arg);
@@ -929,54 +929,58 @@ static int ds_ioctl(struct inode * inode
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
-	ret = pcmcia_adjust_resource_info(&buf.adjust);
+	ret = pcmcia_adjust_resource_info(&buf->adjust);
 	break;
     case DS_GET_CARD_SERVICES_INFO:
-	ret = pcmcia_get_card_services_info(&buf.servinfo);
+	ret = pcmcia_get_card_services_info(&buf->servinfo);
 	break;
     case DS_GET_CONFIGURATION_INFO:
-	if (buf.config.Function && 
-	   (buf.config.Function >= s->parent->functions))
+	if (buf->config.Function && 
+	   (buf->config.Function >= s->parent->functions))
 	    ret = CS_BAD_ARGS;
 	else
-	    ret = pccard_get_configuration_info(s->parent, buf.config.Function, &buf.config);
+	    ret = pccard_get_configuration_info(s->parent,
+			buf->config.Function, &buf->config);
 	break;
     case DS_GET_FIRST_TUPLE:
 	pcmcia_validate_mem(s->parent);
-	ret = pccard_get_first_tuple(s->parent, BIND_FN_ALL, &buf.tuple);
+	ret = pccard_get_first_tuple(s->parent, BIND_FN_ALL, &buf->tuple);
 	break;
     case DS_GET_NEXT_TUPLE:
-	ret = pccard_get_next_tuple(s->parent, BIND_FN_ALL, &buf.tuple);
+	ret = pccard_get_next_tuple(s->parent, BIND_FN_ALL, &buf->tuple);
 	break;
     case DS_GET_TUPLE_DATA:
-	buf.tuple.TupleData = buf.tuple_parse.data;
-	buf.tuple.TupleDataMax = sizeof(buf.tuple_parse.data);
-	ret = pccard_get_tuple_data(s->parent, &buf.tuple);
+	buf->tuple.TupleData = buf->tuple_parse.data;
+	buf->tuple.TupleDataMax = sizeof(buf->tuple_parse.data);
+	ret = pccard_get_tuple_data(s->parent, &buf->tuple);
 	break;
     case DS_PARSE_TUPLE:
-	buf.tuple.TupleData = buf.tuple_parse.data;
-	ret = pccard_parse_tuple(&buf.tuple, &buf.tuple_parse.parse);
+	buf->tuple.TupleData = buf->tuple_parse.data;
+	ret = pccard_parse_tuple(&buf->tuple, &buf->tuple_parse.parse);
 	break;
     case DS_RESET_CARD:
 	ret = pccard_reset_card(s->parent);
 	break;
     case DS_GET_STATUS:
-	if (buf.status.Function && 
-	   (buf.status.Function >= s->parent->functions))
+	if (buf->status.Function && 
+	   (buf->status.Function >= s->parent->functions))
 	    ret = CS_BAD_ARGS;
 	else
-	ret = pccard_get_status(s->parent, buf.status.Function, &buf.status);
+	ret = pccard_get_status(s->parent, buf->status.Function, &buf->status);
 	break;
     case DS_VALIDATE_CIS:
 	pcmcia_validate_mem(s->parent);
-	ret = pccard_validate_cis(s->parent, BIND_FN_ALL, &buf.cisinfo);
+	ret = pccard_validate_cis(s->parent, BIND_FN_ALL, &buf->cisinfo);
 	break;
     case DS_SUSPEND_CARD:
 	ret = pcmcia_suspend_card(s->parent);
@@ -991,49 +995,60 @@ static int ds_ioctl(struct inode * inode
 	err = pcmcia_insert_card(s->parent);
 	break;
     case DS_ACCESS_CONFIGURATION_REGISTER:
-	if ((buf.conf_reg.Action == CS_WRITE) && !capable(CAP_SYS_ADMIN))
-	    return -EPERM;
-	if (buf.conf_reg.Function && 
-	   (buf.conf_reg.Function >= s->parent->functions))
+	if ((buf->conf_reg.Action == CS_WRITE) && !capable(CAP_SYS_ADMIN)) {
+	    err = -EPERM;
+	    goto free_out;
+	}
+	if (buf->conf_reg.Function && 
+	   (buf->conf_reg.Function >= s->parent->functions))
 	    ret = CS_BAD_ARGS;
 	else
-	    ret = pccard_access_configuration_register(s->parent, buf.conf_reg.Function, &buf.conf_reg);
+	    ret = pccard_access_configuration_register(s->parent,
+			buf->conf_reg.Function, &buf->conf_reg);
 	break;
     case DS_GET_FIRST_REGION:
-        ret = pccard_get_first_region(s->parent, &buf.region);
+	ret = pccard_get_first_region(s->parent, &buf->region);
 	break;
     case DS_GET_NEXT_REGION:
-	ret = pccard_get_next_region(s->parent, &buf.region);
+	ret = pccard_get_next_region(s->parent, &buf->region);
 	break;
     case DS_GET_FIRST_WINDOW:
-	ret = pcmcia_get_window(s->parent, &buf.win_info.handle, 0, &buf.win_info.window);
+	ret = pcmcia_get_window(s->parent, &buf->win_info.handle, 0,
+			&buf->win_info.window);
 	break;
     case DS_GET_NEXT_WINDOW:
-	ret = pcmcia_get_window(s->parent, &buf.win_info.handle, buf.win_info.handle->index + 1, &buf.win_info.window);
+	ret = pcmcia_get_window(s->parent, &buf->win_info.handle,
+		buf->win_info.handle->index + 1, &buf->win_info.window);
 	break;
     case DS_GET_MEM_PAGE:
-	ret = pcmcia_get_mem_page(buf.win_info.handle,
-			   &buf.win_info.map);
+	ret = pcmcia_get_mem_page(buf->win_info.handle,
+			   &buf->win_info.map);
 	break;
     case DS_REPLACE_CIS:
-	ret = pcmcia_replace_cis(s->parent, &buf.cisdump);
+	ret = pcmcia_replace_cis(s->parent, &buf->cisdump);
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
@@ -1060,8 +1075,10 @@ static int ds_ioctl(struct inode * inode
 	}
     }
 
-    if (cmd & IOC_OUT) __copy_to_user(uarg, (char *)&buf, size);
+    if (cmd & IOC_OUT) __copy_to_user(uarg, (char *)buf, size);
 
+free_out:
+    kfree(buf);
     return err;
 } /* ds_ioctl */
 

--------------000307050108060304070308--
