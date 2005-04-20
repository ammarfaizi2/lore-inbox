Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVDTMID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVDTMID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVDTMIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:08:02 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:13721 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261542AbVDTMHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:07:20 -0400
Message-ID: <42664734.4060901@jp.fujitsu.com>
Date: Wed, 20 Apr 2005 21:12:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Subject: [RFC][PATCH] nameing reserved pages [3/3]
Content-Type: multipart/mixed;
 boundary="------------080005060300080807010300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080005060300080807010300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

showing state of memmap by /dev/memstate.
-- Kame

--------------080005060300080807010300
Content-Type: text/plain;
 name="show_memstate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="show_memstate.patch"


/dev/memstate shows status of memmap.
A user can read state of a page as a byte.
This feature is useful for Memory-hotplug and other stuffs,
where we have to investigate for what a page is.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



---

 linux-2.6.12-rc2-kamezawa/drivers/char/mem.c |   63 +++++++++++++++++++++++++++
 1 files changed, 63 insertions(+)

diff -puN drivers/char/mem.c~show_memstate drivers/char/mem.c
--- linux-2.6.12-rc2/drivers/char/mem.c~show_memstate	2005-04-20 10:39:40.000000000 +0900
+++ linux-2.6.12-rc2-kamezawa/drivers/char/mem.c	2005-04-20 16:51:45.000000000 +0900
@@ -715,6 +715,59 @@ static int open_port(struct inode * inod
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
+static inline unsigned char get_page_type(struct page *page)
+{
+	if ( !PageReserved(page) )
+		return Page_Common;
+	return reserved_page_type(page);
+}
+
+static ssize_t read_memstate(struct file *file, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	unsigned long pfn = *ppos;
+	unsigned long left, written;
+	ssize_t ret;
+	int len, i;
+	struct page *page;
+	char *kbuf;
+
+	if (!count)
+		return 0;
+
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
+
+	left = count;
+	written = 0;
+	kbuf = (char *)__get_free_page(GFP_KERNEL);
+
+	if (!kbuf)
+		return -ENOMEM;
+	ret = -EFAULT;
+	/* copy data */
+	while (left) {
+		len = (left < PAGE_SIZE) ? left : PAGE_SIZE;
+		for (i = 0; i < len; i++, pfn++) {
+			if ( !pfn_valid(pfn) ) {
+				kbuf[i] = Page_Invalid;
+				continue;
+			}
+			page = pfn_to_page(pfn);
+			kbuf[i] = get_page_type(page);
+		}
+		if (copy_to_user(buf, kbuf, len))
+			goto err_out;
+		written += len;
+		left -= len;
+	}
+	*ppos = pfn;
+	ret = written;
+ err_out:
+	free_page((unsigned long)kbuf);
+	return ret;
+}
+
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
 #define write_zero	write_null
@@ -770,6 +823,11 @@ static struct file_operations full_fops 
 	.write		= write_full,
 };
 
+static struct file_operations memstate_fops = {
+	.llseek		= memory_lseek,
+	.read		= read_memstate,
+};
+
 static ssize_t kmsg_write(struct file * file, const char __user * buf,
 			  size_t count, loff_t *ppos)
 {
@@ -825,6 +883,9 @@ static int memory_open(struct inode * in
 		case 11:
 			filp->f_op = &kmsg_fops;
 			break;
+		case 12:
+			filp->f_op = &memstate_fops;
+			break;
 		default:
 			return -ENXIO;
 	}
@@ -854,6 +915,7 @@ static const struct {
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
 	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
+	{12,"memstate", S_IRUSR | S_IRGRP,          &memstate_fops},
 };
 
 static struct class_simple *mem_class;
@@ -870,6 +932,7 @@ static int __init chr_dev_init(void)
 		class_simple_device_add(mem_class,
 					MKDEV(MEM_MAJOR, devlist[i].minor),
 					NULL, devlist[i].name);
+		printk("creating mem device %d %d\n",i,devlist[i].minor);
 		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
 				S_IFCHR | devlist[i].mode, devlist[i].name);
 	}

_

--------------080005060300080807010300--

