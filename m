Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265585AbUEULIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbUEULIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265593AbUEULIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:08:37 -0400
Received: from gprs214-188.eurotel.cz ([160.218.214.188]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265585AbUEULIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:08:24 -0400
Date: Fri, 21 May 2004 13:05:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: fix devfs breakage introduced in 2.6.6
Message-ID: <20040521110459.GA2529@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes bad interaction between devfs and swsusp.

 Check whether the swap device is the specified resume
 device, irrespective of whether they are specified by
 identical names.

 (Thus, device inode aliasing is allowed.  You can say
 /dev/hda4 instead of /dev/ide/host0/bus0/target0/lun0/part4
 [if using devfs] and they'll be considered the same device.
 This is *necessary* for devfs, since the resume code can
 only recognize the form /dev/hda4, but the suspend code
 would like the long name [as shown in 'cat /proc/mounts'].)

[Thanks to devfs hero whose name I forgot.]
								Pavel

--- clean/kernel/power/swsusp.c	2004-05-20 23:08:36.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-05-21 12:26:43.000000000 +0200
@@ -222,10 +224,30 @@
 	__free_page(page);
 }
 
+
+/*
+ * Check whether the swap device is the specified resume
+ * device, irrespective of whether they are specified by
+ * identical names.
+ *
+ * (Thus, device inode aliasing is allowed.  You can say /dev/hda4
+ * instead of /dev/ide/host0/bus0/target0/lun0/part4 [if using devfs]
+ * and they'll be considered the same device.  This is *necessary* for
+ * devfs, since the resume code can only recognize the form /dev/hda4,
+ * but the suspend code would see the long name.)
+ */
+static int is_resume_device(const struct swap_info_struct *swap_info)
+{
+	struct file *file = swap_info->swap_file;
+	struct inode *inode = file->f_dentry->d_inode;
+
+	return S_ISBLK(inode->i_mode) &&
+		resume_device == MKDEV(imajor(inode), iminor(inode));
+}
+
 static void read_swapfiles(void) /* This is called before saving image */
 {
 	int i, len;
-	static char buff[sizeof(resume_file)], *sname;
 	
 	len=strlen(resume_file);
 	root_swap = 0xFFFF;
@@ -244,17 +266,10 @@
 					swapfile_used[i] = SWAPFILE_IGNORED;				  
 			} else {
 	  			/* we ignore all swap devices that are not the resume_file */
-				sname = d_path(swap_info[i].swap_file->f_dentry,
-					       swap_info[i].swap_file->f_vfsmnt,
-					       buff,
-					       sizeof(buff));
-				if (!strcmp(sname, resume_file)) {
+				if (is_resume_device(&swap_info[i])) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
 				} else {
-#if 0
-					printk( "Resume: device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
-#endif
 				  	swapfile_used[i] = SWAPFILE_IGNORED;
 				}
 			}

-- 
934a471f20d6580d5aad759bf0d97ddc
