Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVESXjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVESXjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVESXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:36:56 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15796 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261318AbVESXdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:33:23 -0400
Message-ID: <428D2241.5070005@acm.org>
Date: Thu, 19 May 2005 18:33:21 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Jordan Hargave <jordan_hargrave@dell.com>
Subject: [PATCH] Add 32-bit ioctl translations for 64-bit platforms
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020202000503070607030401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020202000503070607030401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------020202000503070607030401
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
 
@@ -500,10 +501,184 @@
 	return rv;
 }
 
+#ifdef CONFIG_COMPAT
+/* 
+ * The following code contains code for supporting 32-bit compatible
+ * ioctls on 64-bit kernels.  This allows running 32-bit apps on the
+ * 64-bit kernel
+ */
+#define IPMICTL_SEND_COMMAND32	       _IOR(IPMI_IOC_MAGIC, 13,	 struct ipmi_req32)
+#define IPMICTL_SEND_COMMAND_SETTIME32 _IOR(IPMI_IOC_MAGIC, 21,	 struct ipmi_req_settime32)
+#define IPMICTL_RECEIVE_MSG32	       _IOWR(IPMI_IOC_MAGIC, 12, struct ipmi_recv32)
+#define IPMICTL_RECEIVE_MSG_TRUNC32    _IOWR(IPMI_IOC_MAGIC, 11, struct ipmi_recv32)
+
+struct ipmi_msg32
+{
+	uint8_t	      netfn;
+	uint8_t	      cmd;
+	uint16_t      data_len;
+	compat_uptr_t data;
+};
+
+struct ipmi_req32
+{
+	compat_uptr_t addr;
+	uint32_t      addr_len;
+	int32_t	      msgid;
+
+	struct ipmi_msg32 msg;
+};
+
+struct ipmi_recv32
+{
+	int32_t	      recv_type;
+	compat_uptr_t addr;
+	uint32_t      addr_len;
+	uint32_t      msgid;
+
+	struct ipmi_msg32 msg;
+};
+
+struct ipmi_req_settime32
+{
+	struct ipmi_req32  req;
+	int32_t		   retries;
+	uint32_t	   retry_time_ms;
+};
+
+/*
+ * Define some helper functions for copying IPMI data
+ */
+static void ipmi_copymsg64(struct ipmi_msg *p64, struct ipmi_msg32 *p32)
+{
+	p64->netfn    = p32->netfn;
+	p64->cmd      = p32->cmd;
+	p64->data_len = p32->data_len;
+	p64->data     = (char __user *)(u64)p32->data;
+}
+static void ipmi_copymsg32(struct ipmi_msg32 *p32, struct ipmi_msg *p64)
+{
+	p32->netfn    = p64->netfn;
+	p32->cmd      = p64->cmd;
+	p32->data_len = p64->data_len;
+}
+static void ipmi_copyreq64(struct ipmi_req *p64, struct ipmi_req32 *p32)
+{
+	p64->addr     = (char __user *)(u64)p32->addr;
+	p64->addr_len = p32->addr_len;
+	p64->msgid    = p32->msgid;
+	ipmi_copymsg64(&p64->msg, &p32->msg);
+}
+static void ipmi_copyrecv64(struct ipmi_recv *p64, struct ipmi_recv32 *p32)
+{
+	p64->recv_type = p32->recv_type;
+	p64->addr      = (char __user *)(u64)p32->addr;
+	p64->addr_len  = p32->addr_len;
+	p64->msgid     = p32->msgid;
+	ipmi_copymsg64(&p64->msg, &p32->msg);
+}
+static void ipmi_copyrecv32(struct ipmi_recv32 *p32, struct ipmi_recv *p64)
+{
+	p32->recv_type = p64->recv_type;
+	p32->addr_len  = p64->addr_len;
+	p32->msgid     = p64->msgid;
+	ipmi_copymsg32(&p32->msg, &p64->msg);
+}
+
+/*
+ * Handle 32-bit ioctls on 64-bit kernel
+ */
+static long ipmi_ioctl32(struct file *filep, unsigned int cmd,
+			 unsigned long arg)
+{
+	int rc;
+
+	switch(cmd) {
+	case IPMICTL_SEND_COMMAND32:
+	{
+		struct ipmi_req	  *preq64, req64;
+		struct ipmi_req32  req32;
+      
+		/*
+		 * Copy in the 32-bit ioctl structure from userspace,
+		 * move fields to 64-bit ioctl structure, copy back to
+		 * userspace and issue 64-bit ioctl
+		 */
+		if (copy_from_user(&req32, compat_ptr(arg), sizeof(req32)))
+			return -EFAULT;
+
+		ipmi_copyreq64(&req64, &req32);
+
+		preq64 = compat_alloc_user_space(sizeof(req64));
+		if (copy_to_user(preq64, &req64, sizeof(req64)))
+			return -EFAULT;
+
+		return ipmi_ioctl(filep->f_dentry->d_inode, filep,
+				  IPMICTL_SEND_COMMAND, (long) preq64);
+	}
+	case IPMICTL_SEND_COMMAND_SETTIME32:
+	{
+		struct ipmi_req_settime	 *preq64, req64;
+		struct ipmi_req_settime32 req32;
+
+		if (copy_from_user(&req32, compat_ptr(arg), sizeof(req32)))
+			return -EFAULT;
+
+		ipmi_copyreq64(&req64.req, &req32.req); 
+		req64.retries = req32.retries;
+		req64.retry_time_ms = req32.retry_time_ms;
+
+		preq64 = compat_alloc_user_space(sizeof(req64));
+		if (copy_to_user(preq64, &req64, sizeof(req64)))
+			return -EFAULT;
+
+		return ipmi_ioctl(filep->f_dentry->d_inode, filep,
+				  IPMICTL_SEND_COMMAND_SETTIME, (long) preq64);
+	}
+	case IPMICTL_RECEIVE_MSG32:
+	case IPMICTL_RECEIVE_MSG_TRUNC32:
+	{
+		struct ipmi_recv   *precv64, recv64;
+		struct ipmi_recv32  recv32;
+
+		if (copy_from_user(&recv32, compat_ptr(arg), sizeof(recv32)))
+			return -EFAULT;
+
+		ipmi_copyrecv64(&recv64, &recv32);
+
+		precv64 = compat_alloc_user_space(sizeof(recv64));
+		if (copy_to_user(precv64, &recv64, sizeof(recv64)))
+			return -EFAULT;
+
+		rc = ipmi_ioctl(filep->f_dentry->d_inode, filep, 
+				((cmd == IPMICTL_RECEIVE_MSG32)
+				 ? IPMICTL_RECEIVE_MSG
+				 : IPMICTL_RECEIVE_MSG_TRUNC),
+				(long) precv64);
+		if (rc != 0)
+			return rc;
+
+		if (copy_from_user(&recv64, precv64, sizeof(recv64))) 
+			return -EFAULT;
+
+		ipmi_copyrecv32(&recv32, &recv64);
+		if (copy_to_user(compat_ptr(arg), &recv32, sizeof(recv32)))
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
+	.compat_ioctl   = ipmi_ioctl32,
+#endif
 	.open		= ipmi_open,
 	.release	= ipmi_release,
 	.fasync		= ipmi_fasync,

--------------020202000503070607030401--
