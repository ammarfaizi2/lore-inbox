Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUJGVVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUJGVVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUJGVRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:17:37 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:8117 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S268088AbUJGU6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:58:20 -0400
Message-ID: <4165AEB9.8040608@shadowconnect.com>
Date: Thu, 07 Oct 2004 23:01:45 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add missing checks of __copy_to_user return value in
 i2o_config.c
References: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost> <20041006114154.A29243@infradead.org> <Pine.LNX.4.61.0410062159590.2975@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0410062159590.2975@dragon.hygekrogen.localhost>
Content-Type: multipart/mixed;
 boundary="------------000303010503030402050301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000303010503030402050301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

thanks for fixing i2o_config. In the meantime i've also made a patch, 
which tries to reduce the many return's too.

Note: i've not touched the passthru stuff yet.

Please let me know, which you think of it.


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

--------------000303010503030402050301
Content-Type: text/x-patch;
 name="i2o_config-copy_user-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_config-copy_user-fix.patch"

--- a/drivers/message/i2o/i2o_config.c	2004-09-24 11:05:12.044972000 +0200
+++ b/drivers/message/i2o/i2o_config.c	2004-10-07 22:49:59.786543596 +0200
@@ -178,18 +178,17 @@
 	struct i2o_controller *c;
 	u8 __user *user_iop_table = (void __user *)arg;
 	u8 tmp[MAX_I2O_CONTROLLERS];
+	int rc = 0;
 
 	memset(tmp, 0, MAX_I2O_CONTROLLERS);
 
-	if (!access_ok(VERIFY_WRITE, user_iop_table, MAX_I2O_CONTROLLERS))
-		return -EFAULT;
-
 	list_for_each_entry(c, &i2o_controllers, list)
 	    tmp[c->unit] = 1;
 
-	__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS);
+	if(copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS))
+		rc = -EFAULT;
 
-	return 0;
+	return rc;
 };
 
 static int i2o_cfg_gethrt(unsigned long arg)
@@ -200,20 +199,28 @@
 	i2o_hrt *hrt;
 	int len;
 	u32 reslen;
-	int ret = 0;
+	int rc = 0;
 
-	if (copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_hrtlct)))
-		return -EFAULT;
+	if (copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_hrtlct))) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(reslen, kcmd.reslen) < 0)
-		return -EFAULT;
+	if (get_user(reslen, kcmd.reslen) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (kcmd.resbuf == NULL)
-		return -EFAULT;
+	if (kcmd.resbuf == NULL) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	c = i2o_find_iop(kcmd.iop);
-	if (!c)
-		return -ENXIO;
+	if (!c) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	hrt = (i2o_hrt *) c->hrt.virt;
 
@@ -221,12 +228,16 @@
 
 	/* We did a get user...so assuming mem is ok...is this bad? */
 	put_user(len, kcmd.reslen);
-	if (len > reslen)
-		ret = -ENOBUFS;
+	if (len > reslen) {
+		rc = -ENOBUFS;
+		goto exit;
+	}
+
 	if (copy_to_user(kcmd.resbuf, (void *)hrt, len))
-		ret = -EFAULT;
+		rc = -EFAULT;
 
-	return ret;
+exit:
+	return rc;
 };
 
 static int i2o_cfg_getlct(unsigned long arg)
@@ -236,37 +247,48 @@
 	struct i2o_cmd_hrtlct kcmd;
 	i2o_lct *lct;
 	int len;
-	int ret = 0;
+	int rc = 0;
 	u32 reslen;
 
-	if (copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_hrtlct)))
-		return -EFAULT;
+	if (copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_hrtlct))) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(reslen, kcmd.reslen) < 0)
-		return -EFAULT;
+	if (get_user(reslen, kcmd.reslen) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (kcmd.resbuf == NULL)
-		return -EFAULT;
+	if (kcmd.resbuf == NULL) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	c = i2o_find_iop(kcmd.iop);
-	if (!c)
-		return -ENXIO;
+	if (!c) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	lct = (i2o_lct *) c->lct;
 
 	len = (unsigned int)lct->table_size << 2;
 	put_user(len, kcmd.reslen);
-	if (len > reslen)
-		ret = -ENOBUFS;
-	else if (copy_to_user(kcmd.resbuf, lct, len))
-		ret = -EFAULT;
+	if (len > reslen) {
+		rc = -ENOBUFS;
+		goto exit;
+	}
 
-	return ret;
+	if (copy_to_user(kcmd.resbuf, lct, len))
+		rc = -EFAULT;
+
+exit:
+	return rc;
 };
 
 static int i2o_cfg_parms(unsigned long arg, unsigned int type)
 {
-	int ret = 0;
 	struct i2o_controller *c;
 	struct i2o_device *dev;
 	struct i2o_cmd_psetget __user *cmd =
@@ -276,31 +298,42 @@
 	u8 *ops;
 	u8 *res;
 	int len = 0;
+	int rc = 0;
 
 	u32 i2o_cmd = (type == I2OPARMGET ?
 		       I2O_CMD_UTIL_PARAMS_GET : I2O_CMD_UTIL_PARAMS_SET);
 
-	if (copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_psetget)))
-		return -EFAULT;
+	if (copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_psetget))) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(reslen, kcmd.reslen))
-		return -EFAULT;
+	if (get_user(reslen, kcmd.reslen)) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	c = i2o_find_iop(kcmd.iop);
-	if (!c)
-		return -ENXIO;
+	if (!c) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	dev = i2o_iop_find_device(c, kcmd.tid);
-	if (!dev)
-		return -ENXIO;
+	if (!dev) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	ops = (u8 *) kmalloc(kcmd.oplen, GFP_KERNEL);
-	if (!ops)
-		return -ENOMEM;
+	if (!ops) {
+		rc = -ENOMEM;
+		goto exit;
+	}
 
 	if (copy_from_user(ops, kcmd.opbuf, kcmd.oplen)) {
-		kfree(ops);
-		return -EFAULT;
+		rc = -EFAULT;
+		goto cleanup_ops;
 	}
 
 	/*
@@ -309,27 +342,33 @@
 	 */
 	res = (u8 *) kmalloc(65536, GFP_KERNEL);
 	if (!res) {
-		kfree(ops);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto cleanup_ops;
 	}
 
 	len = i2o_parm_issue(dev, i2o_cmd, ops, kcmd.oplen, res, 65536);
-	kfree(ops);
-
 	if (len < 0) {
-		kfree(res);
-		return -EAGAIN;
+		rc = -EAGAIN;
+		goto cleanup_res;
 	}
 
 	put_user(len, kcmd.reslen);
-	if (len > reslen)
-		ret = -ENOBUFS;
-	else if (copy_to_user(kcmd.resbuf, res, len))
-		ret = -EFAULT;
+	if (len > reslen) {
+		rc = -ENOBUFS;
+		goto cleanup_res;
+	}
+
+	if (copy_to_user(kcmd.resbuf, res, len))
+		rc = -EFAULT;
 
+cleanup_res:
 	kfree(res);
 
-	return ret;
+cleanup_ops:
+	kfree(ops);
+
+exit:
+	return rc;
 };
 
 static int i2o_cfg_swdl(unsigned long arg)
@@ -342,39 +381,57 @@
 	u32 m;
 	unsigned int status = 0, swlen = 0, fragsize = 8192;
 	struct i2o_controller *c;
+	int rc = 0;
 
-	if (copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer)))
-		return -EFAULT;
+	if (copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer))) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(swlen, kxfer.swlen) < 0)
-		return -EFAULT;
+	if (get_user(swlen, kxfer.swlen) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(maxfrag, kxfer.maxfrag) < 0)
-		return -EFAULT;
+	if (get_user(maxfrag, kxfer.maxfrag) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(curfrag, kxfer.curfrag) < 0)
-		return -EFAULT;
+	if (get_user(curfrag, kxfer.curfrag) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	if (curfrag == maxfrag)
 		fragsize = swlen - (maxfrag - 1) * 8192;
 
-	if (!kxfer.buf || !access_ok(VERIFY_READ, kxfer.buf, fragsize))
-		return -EFAULT;
+	if (!kxfer.buf) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	c = i2o_find_iop(kxfer.iop);
-	if (!c)
-		return -ENXIO;
+	if (!c) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	m = i2o_msg_get_wait(c, &msg, I2O_TIMEOUT_MESSAGE_GET);
-	if (m == I2O_QUEUE_EMPTY)
-		return -EBUSY;
+	if (m == I2O_QUEUE_EMPTY) {
+		rc = -EBUSY;
+		goto exit;
+	}
 
 	if (i2o_dma_alloc(&c->pdev->dev, &buffer, fragsize, GFP_KERNEL)) {
-		i2o_msg_nop(c, m);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto nop_msg;
 	}
 
-	__copy_from_user(buffer.virt, kxfer.buf, fragsize);
+	if(copy_from_user(buffer.virt, kxfer.buf, fragsize)) {
+		rc = -EFAULT;
+		goto cleanup_buffer;
+	}
 
 	writel(NINE_WORD_MSG_SIZE | SGL_OFFSET_7, &msg->u.head[0]);
 	writel(I2O_CMD_SW_DOWNLOAD << 24 | HOST_TID << 12 | ADAPTER_TID,
@@ -400,10 +457,19 @@
 		printk(KERN_INFO
 		       "i2o_config: swdl failed, DetailedStatus = %d\n",
 		       status);
-		return status;
+		rc = status;
 	}
 
-	return 0;
+exit:
+	return rc;
+
+cleanup_buffer:
+	i2o_dma_free(&c->pdev->dev, &buffer);
+	
+nop_msg:
+	i2o_msg_nop(c, m);
+
+	return rc;
 };
 
 static int i2o_cfg_swul(unsigned long arg)
@@ -416,36 +482,51 @@
 	u32 m;
 	unsigned int status = 0, swlen = 0, fragsize = 8192;
 	struct i2o_controller *c;
+	int rc = 0;
 
-	if (copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer)))
-		return -EFAULT;
+	if (copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer))) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(swlen, kxfer.swlen) < 0)
-		return -EFAULT;
+	if (get_user(swlen, kxfer.swlen) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(maxfrag, kxfer.maxfrag) < 0)
-		return -EFAULT;
+	if (get_user(maxfrag, kxfer.maxfrag) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(curfrag, kxfer.curfrag) < 0)
-		return -EFAULT;
+	if (get_user(curfrag, kxfer.curfrag) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	if (curfrag == maxfrag)
 		fragsize = swlen - (maxfrag - 1) * 8192;
 
-	if (!kxfer.buf || !access_ok(VERIFY_WRITE, kxfer.buf, fragsize))
-		return -EFAULT;
+	if (!kxfer.buf) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	c = i2o_find_iop(kxfer.iop);
-	if (!c)
-		return -ENXIO;
+	if (!c) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	m = i2o_msg_get_wait(c, &msg, I2O_TIMEOUT_MESSAGE_GET);
-	if (m == I2O_QUEUE_EMPTY)
-		return -EBUSY;
+	if (m == I2O_QUEUE_EMPTY) {
+		rc = -EBUSY;
+		goto exit;
+	}
 
 	if (i2o_dma_alloc(&c->pdev->dev, &buffer, fragsize, GFP_KERNEL)) {
-		i2o_msg_nop(c, m);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto nop_msg;
 	}
 
 	writel(NINE_WORD_MSG_SIZE | SGL_OFFSET_7, &msg->u.head[0]);
@@ -471,13 +552,22 @@
 		printk(KERN_INFO
 		       "i2o_config: swul failed, DetailedStatus = %d\n",
 		       status);
-		return status;
+		rc = status;
+		goto exit;
 	}
 
-	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
+	if(copy_to_user(kxfer.buf, buffer.virt, fragsize))
+		rc = -EFAULT;
+
 	i2o_dma_free(&c->pdev->dev, &buffer);
 
-	return 0;
+exit:
+	return rc;
+
+nop_msg:
+	i2o_msg_nop(c, m);
+
+	return rc;
 };
 
 static int i2o_cfg_swdel(unsigned long arg)
@@ -489,20 +579,29 @@
 	u32 m;
 	unsigned int swlen;
 	int token;
+	int rc = 0;
 
-	if (copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer)))
-		return -EFAULT;
+	if (copy_from_user(&kxfer, pxfer, sizeof(struct i2o_sw_xfer))) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
-	if (get_user(swlen, kxfer.swlen) < 0)
-		return -EFAULT;
+	if (get_user(swlen, kxfer.swlen) < 0) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	c = i2o_find_iop(kxfer.iop);
-	if (!c)
-		return -ENXIO;
+	if (!c) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	m = i2o_msg_get_wait(c, &msg, I2O_TIMEOUT_MESSAGE_GET);
-	if (m == I2O_QUEUE_EMPTY)
-		return -EBUSY;
+	if (m == I2O_QUEUE_EMPTY) {
+		rc = -EBUSY;
+		goto exit;
+	}
 
 	writel(SEVEN_WORD_MSG_SIZE | SGL_OFFSET_0, &msg->u.head[0]);
 	writel(I2O_CMD_SW_REMOVE << 24 | HOST_TID << 12 | ADAPTER_TID,
@@ -520,10 +619,11 @@
 		printk(KERN_INFO
 		       "i2o_config: swdel failed, DetailedStatus = %d\n",
 		       token);
-		return -ETIMEDOUT;
+		rc = -ETIMEDOUT;
 	}
 
-	return 0;
+exit:
+	return rc;
 };
 
 static int i2o_cfg_validate(unsigned long arg)
@@ -533,14 +633,19 @@
 	struct i2o_message *msg;
 	u32 m;
 	struct i2o_controller *c;
+	int rc = 0;
 
 	c = i2o_find_iop(iop);
-	if (!c)
-		return -ENXIO;
+	if (!c) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	m = i2o_msg_get_wait(c, &msg, I2O_TIMEOUT_MESSAGE_GET);
-	if (m == I2O_QUEUE_EMPTY)
-		return -EBUSY;
+	if (m == I2O_QUEUE_EMPTY) {
+		rc = -EBUSY;
+		goto exit;
+	}
 
 	writel(FOUR_WORD_MSG_SIZE | SGL_OFFSET_0, &msg->u.head[0]);
 	writel(I2O_CMD_CONFIG_VALIDATE << 24 | HOST_TID << 12 | iop,
@@ -553,10 +658,11 @@
 	if (token != I2O_POST_WAIT_OK) {
 		printk(KERN_INFO "Can't validate configuration, ErrorStatus = "
 		       "%d\n", token);
-		return -ETIMEDOUT;
+		rc = -ETIMEDOUT;
 	}
 
-	return 0;
+exit:
+	return rc;
 };
 
 static int i2o_cfg_evt_reg(unsigned long arg, struct file *fp)
@@ -567,23 +673,32 @@
 	struct i2o_evt_id kdesc;
 	struct i2o_controller *c;
 	struct i2o_device *d;
+	int rc = 0;
 
-	if (copy_from_user(&kdesc, pdesc, sizeof(struct i2o_evt_id)))
-		return -EFAULT;
+	if (copy_from_user(&kdesc, pdesc, sizeof(struct i2o_evt_id))) {
+		rc = -EFAULT;
+		goto exit;
+	}
 
 	/* IOP exists? */
 	c = i2o_find_iop(kdesc.iop);
-	if (!c)
-		return -ENXIO;
+	if (!c) {
+		rc = -ENXIO;
+		goto exit;
+	}
 
 	/* Device exists? */
 	d = i2o_iop_find_device(c, kdesc.tid);
-	if (!d)
-		return -ENODEV;
+	if (!d) {
+		rc = -ENODEV;
+		goto exit;
+	}
 
 	m = i2o_msg_get_wait(c, &msg, I2O_TIMEOUT_MESSAGE_GET);
-	if (m == I2O_QUEUE_EMPTY)
-		return -EBUSY;
+	if (m == I2O_QUEUE_EMPTY) {
+		rc = -EBUSY;
+		goto exit;
+	}
 
 	writel(FOUR_WORD_MSG_SIZE | SGL_OFFSET_0, &msg->u.head[0]);
 	writel(I2O_CMD_UTIL_EVT_REGISTER << 24 | HOST_TID << 12 | kdesc.tid,
@@ -594,7 +709,8 @@
 
 	i2o_msg_post(c, m);
 
-	return 0;
+exit:
+	return rc;
 }
 
 static int i2o_cfg_evt_get(unsigned long arg, struct file *fp)
@@ -603,13 +719,16 @@
 	struct i2o_evt_get __user *uget = (struct i2o_evt_get __user *)arg;
 	struct i2o_evt_get kget;
 	unsigned long flags;
+	int rc = 0;
 
 	for (p = open_files; p; p = p->next)
 		if (p->q_id == (ulong) fp->private_data)
 			break;
 
-	if (!p->q_len)
-		return -ENOENT;
+	if (!p->q_len) {
+		rc = -ENOENT;
+		goto exit;
+	}
 
 	memcpy(&kget.info, &p->event_q[p->q_out], sizeof(struct i2o_evt_info));
 	MODINC(p->q_out, I2O_EVT_Q_LEN);
@@ -620,8 +739,10 @@
 	spin_unlock_irqrestore(&i2o_config_lock, flags);
 
 	if (copy_to_user(uget, &kget, sizeof(struct i2o_evt_get)))
-		return -EFAULT;
-	return 0;
+		rc = -EFAULT;
+
+exit:
+	return rc;
 }
 
 #if BITS_PER_LONG == 64

--------------000303010503030402050301--
