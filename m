Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUEKIuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUEKIuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUEKIuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:50:00 -0400
Received: from se2.ruf.uni-freiburg.de ([132.230.2.222]:36740 "EHLO
	se2.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262453AbUEKIsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:48:25 -0400
X-Scanned: Tue, 11 May 2004 10:44:49 +0200 Nokia Message Protector V1.3.30 2004040916 - RELEASE
To: Pavel Machek <pavel@suse.cz>, Gabor Kuti <seasons@fornax.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 swsusp.c: allow device aliasing
References: <xb73c68s14g.fsf@savona.informatik.uni-freiburg.de>
	<20040510170936.GG27008@atrey.karlin.mff.cuni.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 11 May 2004 10:44:03 +0200
In-Reply-To: <20040510170936.GG27008@atrey.karlin.mff.cuni.cz>
Message-ID: <xb7y8nzqros.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is an updated patch.  I thank Pavel for his suggestions.

    >> (Does swsusp support swap files?  If so, should we also support
    >> file aliasing?  How?)

    Pavel> No, swsusp only supports swap devices. That means that you
    Pavel> probably should kill d_path and name handling; that will
    Pavel> slean the code up as well.



--- linux-2.6.6/kernel/power/swsusp.c	2004/05/10 14:11:17	1.1
+++ linux-2.6.6-swsusp-dev-aliasing/kernel/power/swsusp.c	2004/05/11 08:14:40	1.4
@@ -215,47 +215,69 @@
 		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
 			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
 		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
 		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
 		/* link.next lies *no more* in last 4/8 bytes of magic */
 	}
 	rw_swap_page_sync(WRITE, entry, page);
 	__free_page(page);
 }
 
+static int is_resume_file(const struct swap_info_struct *swap_info)
+{
+	/*
+	  Check whether the swap device is the specified resume
+	  device, irrespective of whether they are specified by
+	  identical names.
+
+	  (Thus, device inode aliasing is allowed.  You can say
+	   /dev/hda4 instead of /dev/ide/host0/bus0/target0/lun0/part4
+	   [if using devfs] and they'll be considered the same device.
+	   This is *necessary* for devfs, since the resume code can
+	   only recognize the form /dev/hda4, but the suspend code
+	   would like the long name [as shown in 'cat /proc/mounts'].)
+	 */
+
+	struct file *file = swap_info->swap_file;
+	struct inode *inode = file->f_dentry->d_inode;
+
+	/* See if it is a swap (block) device.  If so, we compare
+	   the device (MAJOR,MINOR).
+
+	   Note: Swap files are not supported by swsusp.
+	*/
+	return S_ISBLK(inode->i_mode) &&
+	  resume_device == MKDEV(imajor(inode), iminor(inode));
+}
+
 static void read_swapfiles(void) /* This is called before saving image */
 {
 	int i, len;
-	static char buff[sizeof(resume_file)], *sname;
 	
 	len=strlen(resume_file);
 	root_swap = 0xFFFF;
 	
 	swap_list_lock();
 	for(i=0; i<MAX_SWAPFILES; i++) {
 		if (swap_info[i].flags == 0) {
 			swapfile_used[i]=SWAPFILE_UNUSED;
 		} else {
 			if(!len) {
 	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
 				if(root_swap == 0xFFFF) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
 				} else
 					swapfile_used[i] = SWAPFILE_IGNORED;				  
 			} else {
 	  			/* we ignore all swap devices that are not the resume_file */
-				sname = d_path(swap_info[i].swap_file->f_dentry,
-					       swap_info[i].swap_file->f_vfsmnt,
-					       buff,
-					       sizeof(buff));
-				if (!strcmp(sname, resume_file)) {
+				if (is_resume_file(&swap_info[i])) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
 				} else {
 #if 0
 					printk( "Resume: device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
 #endif
 				  	swapfile_used[i] = SWAPFILE_IGNORED;
 				}
 			}
 		}



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

