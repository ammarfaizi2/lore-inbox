Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264963AbUD2UeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUD2UeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbUD2Ud6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:33:58 -0400
Received: from [213.133.118.2] ([213.133.118.2]:21649 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264963AbUD2U16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:27:58 -0400
Message-ID: <40916621.50509@shadowconnect.com>
Date: Thu, 29 Apr 2004 22:31:29 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] I2O subsystem fixing and cleanup for 2.6 - i2o-passthru.patch
Content-Type: multipart/mixed;
 boundary="------------030204090406060902040807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030204090406060902040807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------030204090406060902040807
Content-Type: text/plain;
 name="i2o-passthru.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-passthru.patch"

--- a/drivers/message/i2o/i2o_config.c  2004-02-18 04:59:26.000000000 +0100
+++ b/drivers/message/i2o/i2o_config.c  2004-03-03 17:14:38.035056342 +0100
@@ -21,6 +21,8 @@
  *		Added event managmenet support
  *	Alan Cox <alan@redhat.com>:
  *		2.4 rewrite ported to 2.5
+ *	Markus Lidel <Markus.Lidel@shadowconnect.com>:
+ *		Added pass-thru support for Adaptec's raidutils
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -50,6 +52,11 @@
 
 #define MODINC(x,y) ((x) = ((x) + 1) % (y))
 
+struct sg_simple_element {
+	u32  flag_count;
+	u32 addr_bus;
+};
+
 struct i2o_cfg_info
 {
 	struct file* fp;
@@ -76,6 +83,7 @@
 static int ioctl_validate(unsigned long); 
 static int ioctl_evt_reg(unsigned long, struct file *);
 static int ioctl_evt_get(unsigned long, struct file *);
+static int ioctl_passthru(unsigned long);
 static int cfg_fasync(int, struct file*, int);
 
 /*
@@ -257,6 +265,10 @@
 			ret = ioctl_evt_get(arg, fp);
 			break;
 
+		case I2OPASSTHRU:
+			ret = ioctl_passthru(arg);
+			break;
+
 		default:
 			ret = -EINVAL;
 	}
@@ -828,6 +840,157 @@
 	return 0;
 }
 
+static int ioctl_passthru(unsigned long arg)
+{
+	struct i2o_cmd_passthru *cmd = (struct i2o_cmd_passthru *) arg;
+	struct i2o_controller *c;
+	u32 msg[MSG_FRAME_SIZE];
+	u32 *user_msg = (u32*)cmd->msg;
+	u32 *reply = NULL;
+	u32 *user_reply = NULL;
+	u32 size = 0;
+	u32 reply_size = 0;
+	u32 rcode = 0;
+	ulong sg_list[SG_TABLESIZE];
+	u32 sg_offset = 0;
+	u32 sg_count = 0;
+	int sg_index = 0;
+	u32 i = 0;
+	ulong p = 0;
+
+	c = i2o_find_controller(cmd->iop);
+	if(!c)
+                return -ENXIO;
+
+	memset(&msg, 0, MSG_FRAME_SIZE*4);
+	if(get_user(size, &user_msg[0]))
+		return -EFAULT;
+	size = size>>16;
+
+	user_reply = &user_msg[size];
+	if(size > MSG_FRAME_SIZE)
+		return -EFAULT;
+	size *= 4; // Convert to bytes
+                                              
+	/* Copy in the user's I2O command */
+	if(copy_from_user((void*)msg, (void*)user_msg, size))
+		return -EFAULT;
+	get_user(reply_size, &user_reply[0]);
+	reply_size = reply_size>>16;
+	reply = kmalloc(REPLY_FRAME_SIZE*4, GFP_KERNEL);
+	if(!reply) {
+		printk(KERN_WARNING"%s: Could not allocate reply buffer\n",c->name);
+		return -ENOMEM;
+	}
+	memset(reply, 0, REPLY_FRAME_SIZE*4);
+	sg_offset = (msg[0]>>4)&0x0f;
+	msg[2] = (u32)i2o_cfg_context;
+	msg[3] = (u32)reply;
+
+	memset(sg_list,0, sizeof(sg_list[0])*SG_TABLESIZE);
+	if(sg_offset) {
+		// TODO 64bit fix
+		struct sg_simple_element *sg = (struct sg_simple_element*) (msg+sg_offset);
+		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
+		if (sg_count > SG_TABLESIZE) {
+			printk(KERN_DEBUG"%s:IOCTL SG List too large (%u)\n", c->name,sg_count);
+			kfree (reply);
+			return -EINVAL;
+		}
+
+		for(i = 0; i < sg_count; i++) {
+			int sg_size;
+
+			if (!(sg[i].flag_count & 0x10000000 /*I2O_SGL_FLAGS_SIMPLE_ADDRESS_ELEMENT*/)) {
+				printk(KERN_DEBUG"%s:Bad SG element %d - not simple (%x)\n",c->name,i,  sg[i].flag_count);
+				rcode = -EINVAL;
+				goto cleanup;
+			}
+			sg_size = sg[i].flag_count & 0xffffff;
+			/* Allocate memory for the transfer */
+			p = (ulong)kmalloc(sg_size, GFP_KERNEL);
+			if (!p) {
+				printk(KERN_DEBUG"%s: Could not allocate SG buffer - size = %d buffer number %d of %d\n", c->name,sg_size,i,sg_count);
+				rcode = -ENOMEM;
+				goto cleanup;
+			}
+			sg_list[sg_index++] = p; // sglist indexed with input frame, not our internal frame.
+			/* Copy in the user's SG buffer if necessary */
+			if(sg[i].flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR*/) {
+				// TODO 64bit fix
+			        if (copy_from_user((void*)p,(void*)sg[i].addr_bus, sg_size)) {
+					printk(KERN_DEBUG"%s: Could not copy SG buf %d FROM user\n",c->name,i);
+					rcode = -EFAULT;
+					goto cleanup;
+				}
+			}
+			//TODO 64bit fix
+			sg[i].addr_bus = (u32)virt_to_bus((void*)p);
+		}
+	}
+
+	rcode = i2o_post_wait(c, msg, size, 60);
+	if(rcode)
+		goto cleanup;
+
+	if(sg_offset) {
+		/* Copy back the Scatter Gather buffers back to user space */
+		u32 j;
+		// TODO 64bit fix
+		struct sg_simple_element* sg;
+		int sg_size;
+										                                                                                
+		// re-acquire the original message to handle correctly the sg copy operation
+		memset(&msg, 0, MSG_FRAME_SIZE*4);
+		// get user msg size in u32s
+		if (get_user(size, &user_msg[0])) {
+			rcode = -EFAULT;
+			goto cleanup;
+		}
+		size = size>>16;
+		size *= 4;
+		/* Copy in the user's I2O command */
+		if (copy_from_user ((void*)msg, (void*)user_msg, size)) {
+			rcode = -EFAULT;
+			goto cleanup;
+		}
+		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
+
+		 // TODO 64bit fix
+		sg = (struct sg_simple_element*)(msg + sg_offset);
+		for (j = 0; j < sg_count; j++) {
+			/* Copy out the SG list to user's buffer if necessary */
+			if (!(sg[j].flag_count & 0x4000000 /*I2O_SGL_FLAGS_DIR*/)) {
+				sg_size = sg[j].flag_count & 0xffffff;
+				// TODO 64bit fix
+				if (copy_to_user((void*)sg[j].addr_bus,(void*)sg_list[j], sg_size)) {
+					printk(KERN_WARNING"%s: Could not copy %lx TO user %x\n",c->name, sg_list[j], sg[j].addr_bus);
+					rcode = -EFAULT;
+					goto cleanup;
+				}
+			}
+		}
+	}
+	
+	/* Copy back the reply to user space */
+        if (reply_size) {
+		// we wrote our own values for context - now restore the user supplied ones
+		if(copy_from_user(reply+2, user_msg+2, sizeof(u32)*2)) {
+			printk(KERN_WARNING"%s: Could not copy message context FROM user\n",c->name);
+			rcode = -EFAULT;
+		}
+		if(copy_to_user(user_reply, reply, reply_size)) {
+			printk(KERN_WARNING"%s: Could not copy reply TO user\n",c->name);
+			rcode = -EFAULT;
+		}
+	}
+
+cleanup:
+	kfree(reply);
+	i2o_unlock_controller(c);
+	return rcode;
+}		
+
 static int cfg_open(struct inode *inode, struct file *file)
 {
 	struct i2o_cfg_info *tmp = 
--- a/include/linux/i2o.h   2004-03-01 23:18:47.000000000 +0100
+++ b/include/linux/i2o.h   2004-03-03 17:36:20.129361237 +0100
@@ -621,6 +640,8 @@
 #define HOST_TID		1
 
 #define MSG_FRAME_SIZE		64	/* i2o_scsi assumes >= 32 */
+#define REPLY_FRAME_SIZE	17
+#define SG_TABLESIZE		30
 #define NMBR_MSG_FRAMES		128
 
 #define MSG_POOL_SIZE		(MSG_FRAME_SIZE*NMBR_MSG_FRAMES*sizeof(u32))
--- a/include/linux/i2o-dev.h   2004-03-01 23:18:47.000000000 +0100
+++ b/include/linux/i2o-dev.h   2004-03-03 17:36:20.129361237 +0100
@@ -41,7 +41,15 @@
 #define I2OHTML 		_IOWR(I2O_MAGIC_NUMBER,9,struct i2o_html)
 #define I2OEVTREG		_IOW(I2O_MAGIC_NUMBER,10,struct i2o_evt_id)
 #define I2OEVTGET		_IOR(I2O_MAGIC_NUMBER,11,struct i2o_evt_info)
+#define I2OPASSTHRU		_IOR(I2O_MAGIC_NUMBER,12,struct i2o_cmd_passthru)
 
+struct i2o_cmd_passthru
+{
+	void *msg;		/* message */
+	int iop;		/* number of the I2O controller, to which the
+				   message should go to */
+};
+
 struct i2o_cmd_hrtlct
 {
 	unsigned int iop;	/* IOP unit number */

--------------030204090406060902040807--
