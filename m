Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUEJQYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUEJQYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264859AbUEJQYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:24:30 -0400
Received: from se2.ruf.uni-freiburg.de ([132.230.2.222]:7811 "EHLO
	se2.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264857AbUEJQXO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:23:14 -0400
X-Scanned: Mon, 10 May 2004 18:22:41 +0200 Nokia Message Protector V1.3.30 2004040916 - RELEASE
To: Pavel Machek <pavel@suse.cz>, Gabor Kuti <seasons@fornax.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.6 swsusp.c: allow device aliasing
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 10 May 2004 18:22:39 +0200
Message-ID: <xb73c68s14g.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


swsusp has  been working on my  notebook on 2.6.2 and  2.6.5, but does
not work on 2.6.6.  It  panics.  Here are the 'dmesg' after activating
swsusp: (The number of "=" and  "." aren't correct, and I have retyped
them from the console message.)

        ACPI: (supports S0 S1 S3 S4 S5)
        Stopping tasks: =================================|
        Freeing memory: .............|
        /critical section: counting pages to copy.[no save pfn 0x338].....
         (pages needed: 12532+512=13044 free: 28407)
        Alloc pagedir
        .[nosave pfn 0x338]......................
        critical section/: done (12532 pages copied)
        Writing data to swap (12532 pages): . <0>Kernel panic:
        Not enough swapspace when writing data
         <3>swap_free: Unused swap file entry 0000003d

Here is another trial:


        ACPI: (supports S0 S1 S3 S4 S5)
        Stopping tasks: =================================|
        Freeing memory: .............|
        /critical section: counting pages to copy.
              [nosave pfn 0x338].................. 
              (pages needed: 12191+512=12703 free: 28748)
        Alloc pagedir
        .[nosave pfn 0x338].....................critical section/:
              done 912191 pages copied)
        Writing data to swap (12191 pages): .<0>Kernel panic:
        Not enough swapspace when writing data
        swap_free: Unused swap file entry 00000026


Cause:


I'm  using  devfs.   (I'm   using  /dev/hda7  for  swsusp.)   So,  cat
/proc/swaps shows my swap device as:

    Filename                                Type      Size  Used Priority
    /dev/ide/host0/bus0/target0/lun0/part7  partition 498920  0   -1

whereas  I  specify  "resume=/dev/hda7"  as a  boot  parameter.   Upon
suspend, swsusp can't find a swap device exactly named "/dev/hda7" and
hence thinks there is no swapspace.


The problem is that:

1) Upon suspend, kernel/power/swsusp.c compares the devices names
   "/dev/hda7" and "/dev/ide/.../part7" and they don't match.  So
   swsusp refuses to suspend to the swap partition.  Changing the
   boot parameter to "resume=/dev/ide/host0/bus0/target0/lun0/part7"
   solves this problem, BUT:

2) Upon resume, kernel/power/swsusp.c doesn't understand what a device
   "/dev/ide/host0/bus0/target0/lun0/part7" is.  It only knows what
   "/dev/hda7".  So, I have to set "resume=/dev/hda7" for resume to
   work.  But this would create problem (1).

So, I can't get both suspend and resume to work!  :(

Why did it  work in pre-2.6.6?  Because that check  in swsusp.c in pre
2.6.6 didn't really check if  the device is correct upon suspend.  The
suspend code  only writes  the suspend/resume data  to the  FIRST swap
device.  2.6.6 has corrected this bug, but can't equate "/dev/hda7" to
"/dev/ide/host0/bus0/target0/lun0/part7",  although the  two  refer to
the same device.


The following patch (against 2.6.6)  fixes this problem in the suspend
code.  It  will check whether both  the swap device  and the "resume="
parameter refer to a block  device with the same (major,minor) number.
If so, the swap device is taken  to be the one specified for swsusp to
use.   So, aliasing  of devices  is support.   This means  I  must say
"resume=/dev/hda7"                       and                       not
"resume=/dev/ide/host0/bus0/target0/lun0/part7".    If,  however,  the
specified swap devices are (swap)  files rather block devices, it only
does a filename comparison.  (Does  swsusp support swap files?  If so,
should we also support file aliasing?  How?)


--- linux-2.6.6-official/kernel/power/swsusp.c	2004/05/10 14:11:17	1.1
+++ linux-2.6.6-swsusp-dev-aliasing/kernel/power/swsusp.c	2004/05/10 16:11:41	1.3
@@ -215,47 +215,67 @@
 		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
 			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
 		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
 		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
 		/* link.next lies *no more* in last 4/8 bytes of magic */
 	}
 	rw_swap_page_sync(WRITE, entry, page);
 	__free_page(page);
 }
 
+static int is_resume_file(const struct swap_info_struct *swap_info) {
+	/* check whether the swap device is the specified resume file */
+
+	static char buff[sizeof(resume_file)], *sname;
+	struct file *file = swap_info->swap_file;
+	struct inode *inode = file->f_dentry->d_inode;
+
+	/* now, see if it is a swap (block) device.  If so, we compare
+	   the device (MAJOR,MINOR), so as to support device inode
+	   aliasing.
+	*/
+	if (S_ISBLK(inode->i_mode)) {
+		if (resume_device == MKDEV(imajor(inode), iminor(inode)))
+			return 1; /* true */
+	}
+
+	/* otherwise, we compare filenames */
+	sname = d_path(swap_info->swap_file->f_dentry,
+		       swap_info->swap_file->f_vfsmnt,
+		       buff,
+		       sizeof(buff));
+
+	return !strcmp(sname, resume_file);
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

