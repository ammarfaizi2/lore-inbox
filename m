Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVETVXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVETVXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVETVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 17:23:40 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:35582 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261589AbVETVWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 17:22:33 -0400
Message-ID: <428E5515.8080004@acm.org>
Date: Fri, 20 May 2005 16:22:29 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jordan_hargrave@dell.com
Subject: Re: [PATCH] Add 32-bit ioctl translations for 64-bit platforms
References: <428D2241.5070005@acm.org> <20050520143337.38b6b5a6.sfr@canb.auug.org.au>
In-Reply-To: <20050520143337.38b6b5a6.sfr@canb.auug.org.au>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010603060204020007070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603060204020007070107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen suggested a lot of other changes, and I have tested the attached 
patch.  It seems to work fine.

-Corey

Stephen Rothwell wrote:

>Hi Cory,
>
>On Thu, 19 May 2005 18:33:21 -0500 Corey Minyard <minyard@acm.org> wrote:
>  
>
>>+struct ipmi_msg32
>>+{
>>+	uint8_t	      netfn;
>>+	uint8_t	      cmd;
>>+	uint16_t      data_len;
>>+	compat_uptr_t data;
>>+};
>>    
>>
>
>Why are you using unint8_t etc when we have perfectly good kernel types u8
>etc?
>
>  
>


--------------010603060204020007070107
Content-Type: text/x-patch;
 name="ipmi-32-bit-compat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-32-bit-compat.patch"

This contains the patch for supporting 32-bit compatible
ioctls on x86_64 systems. The current x86_64 driver
will not work with 32-bit applications.

Signed-off-by: Jordan Hargave <jordan_hargrave@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc4/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.12-rc4/drivers/char/ipmi/ipmi_devintf.c
@@ -45,6 +45,7 @@
 #include <asm/semaphore.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/compat.h>
 
 #define IPMI_DEVINTF_VERSION "v33"
 
@@ -500,10 +501,205 @@
 	return rv;
 }
 
+#ifdef CONFIG_COMPAT
+
+/*
+ * The following code contains code for supporting 32-bit compatible
+ * ioctls on 64-bit kernels.  This allows running 32-bit apps on the
+ * 64-bit kernel
+ */
+#define COMPAT_IPMICTL_SEND_COMMAND	\
+	_IOR(IPMI_IOC_MAGIC, 13, struct compat_ipmi_req)
+#define COMPAT_IPMICTL_SEND_COMMAND_SETTIME	\
+	_IOR(IPMI_IOC_MAGIC, 21, struct compat_ipmi_req_settime)
+#define COMPAT_IPMICTL_RECEIVE_MSG	\
+	_IOWR(IPMI_IOC_MAGIC, 12, struct compat_ipmi_recv)
+#define COMPAT_IPMICTL_RECEIVE_MSG_TRUNC	\
+	_IOWR(IPMI_IOC_MAGIC, 11, struct compat_ipmi_recv)
+
+struct compat_ipmi_msg {
+	u8		netfn;
+	u8		cmd;
+	u16		data_len;
+	compat_uptr_t	data;
+};
+
+struct compat_ipmi_req {
+	compat_uptr_t		addr;
+	compat_uint_t		addr_len;
+	compat_long_t		msgid;
+	struct compat_ipmi_msg	msg;
+};
+
+struct compat_ipmi_recv {
+	compat_int_t		recv_type;
+	compat_uptr_t		addr;
+	compat_uint_t		addr_len;
+	compat_long_t		msgid;
+	struct compat_ipmi_msg	msg;
+};
+
+struct compat_ipmi_req_settime {
+	struct compat_ipmi_req	req;
+	compat_int_t		retries;
+	compat_uint_t		retry_time_ms;
+};
+
+/*
+ * Define some helper functions for copying IPMI data
+ */
+static long get_compat_ipmi_msg(struct ipmi_msg *p64,
+				struct compat_ipmi_msg __user *p32)
+{
+	compat_uptr_t tmp;
+
+	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
+			__get_user(p64->netfn, &p32->netfn) ||
+			__get_user(p64->cmd, &p32->cmd) ||
+			__get_user(p64->data_len, &p32->data_len) ||
+			__get_user(tmp, &p32->data))
+		return -EFAULT;
+	p64->data = compat_ptr(tmp);
+	return 0;
+}
+
+static long put_compat_ipmi_msg(struct ipmi_msg *p64,
+				struct compat_ipmi_msg __user *p32)
+{
+	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
+			__put_user(p64->netfn, &p32->netfn) ||
+			__put_user(p64->cmd, &p32->cmd) ||
+			__put_user(p64->data_len, &p32->data_len))
+		return -EFAULT;
+	return 0;
+}
+
+static long get_compat_ipmi_req(struct ipmi_req *p64,
+				struct compat_ipmi_req __user *p32)
+{
+
+	compat_uptr_t	tmp;
+
+	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
+			__get_user(tmp, &p32->addr) ||
+			__get_user(p64->addr_len, &p32->addr_len) ||
+			__get_user(p64->msgid, &p32->msgid) ||
+			get_compat_ipmi_msg(&p64->msg, &p32->msg))
+		return -EFAULT;
+	p64->addr = compat_ptr(tmp);
+	return 0;
+}
+
+static long get_compat_ipmi_req_settime(struct ipmi_req_settime *p64,
+		struct compat_ipmi_req_settime __user *p32)
+{
+	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
+			get_compat_ipmi_req(&p64->req, &p32->req) ||
+			__get_user(p64->retries, &p32->retries) ||
+			__get_user(p64->retry_time_ms, &p32->retry_time_ms))
+		return -EFAULT;
+	return 0;
+}
+
+static long get_compat_ipmi_recv(struct ipmi_recv *p64,
+				 struct compat_ipmi_recv __user *p32)
+{
+	compat_uptr_t tmp;
+
+	if (!access_ok(VERIFY_READ, p32, sizeof(*p32)) ||
+			__get_user(p64->recv_type, &p32->recv_type) ||
+			__get_user(tmp, &p32->addr) ||
+			__get_user(p64->addr_len, &p32->addr_len) ||
+			__get_user(p64->msgid, &p32->msgid) ||
+			get_compat_ipmi_msg(&p64->msg, &p32->msg))
+		return -EFAULT;
+	p64->addr = compat_ptr(tmp);
+	return 0;
+}
+
+static long put_compat_ipmi_recv(struct ipmi_recv *p64,
+				 struct compat_ipmi_recv __user *p32)
+{
+	if (!access_ok(VERIFY_WRITE, p32, sizeof(*p32)) ||
+			__put_user(p64->recv_type, &p32->recv_type) ||
+			__put_user(p64->addr_len, &p32->addr_len) ||
+			__put_user(p64->msgid, &p32->msgid) ||
+			put_compat_ipmi_msg(&p64->msg, &p32->msg))
+		return -EFAULT;
+	return 0;
+}
+
+/*
+ * Handle compatibility ioctls
+ */
+static long compat_ipmi_ioctl(struct file *filep, unsigned int cmd,
+			      unsigned long arg)
+{
+	int rc;
+	struct ipmi_file_private *priv = filep->private_data;
+
+	switch(cmd) {
+	case COMPAT_IPMICTL_SEND_COMMAND:
+	{
+		struct ipmi_req	rp;
+
+		if (get_compat_ipmi_req(&rp, compat_ptr(arg)))
+			return -EFAULT;
+
+		return handle_send_req(priv->user, &rp,
+				priv->default_retries,
+				priv->default_retry_time_ms);
+	}
+	case COMPAT_IPMICTL_SEND_COMMAND_SETTIME:
+	{
+		struct ipmi_req_settime	sp;
+
+		if (get_compat_ipmi_req_settime(&sp, compat_ptr(arg)))
+			return -EFAULT;
+
+		return handle_send_req(priv->user, &sp.req,
+				sp.retries, sp.retry_time_ms);
+	}
+	case COMPAT_IPMICTL_RECEIVE_MSG:
+	case COMPAT_IPMICTL_RECEIVE_MSG_TRUNC:
+	{
+		struct ipmi_recv   *precv64, recv64;
+
+		if (get_compat_ipmi_recv(&recv64, compat_ptr(arg)))
+			return -EFAULT;
+
+		precv64 = compat_alloc_user_space(sizeof(recv64));
+		if (copy_to_user(precv64, &recv64, sizeof(recv64)))
+			return -EFAULT;
+
+		rc = ipmi_ioctl(filep->f_dentry->d_inode, filep,
+				((cmd == COMPAT_IPMICTL_RECEIVE_MSG)
+				 ? IPMICTL_RECEIVE_MSG
+				 : IPMICTL_RECEIVE_MSG_TRUNC),
+				(long) precv64);
+		if (rc != 0)
+			return rc;
+
+		if (copy_from_user(&recv64, precv64, sizeof(recv64)))
+			return -EFAULT;
+
+		if (put_compat_ipmi_recv(&recv64, compat_ptr(arg)))
+			return -EFAULT;
+
+		return rc;
+	}
+	default:
+		return ipmi_ioctl(filep->f_dentry->d_inode, filep, cmd, arg);
+	}
+}
+#endif
 
 static struct file_operations ipmi_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= ipmi_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = compat_ipmi_ioctl,
+#endif
 	.open		= ipmi_open,
 	.release	= ipmi_release,
 	.fasync		= ipmi_fasync,

--------------010603060204020007070107--
