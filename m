Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVAGJxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVAGJxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVAGJxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:53:36 -0500
Received: from gprs215-114.eurotel.cz ([160.218.215.114]:36746 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261335AbVAGJxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:53:31 -0500
Date: Fri, 7 Jan 2005 10:53:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [hugang@soulinfo.com: [PATH]software suspend for ppc.]
Message-ID: <20050107095316.GB1300@elf.ucw.cz>
References: <20050103122653.GB8827@hugang.soulinfo.com> <20050103221718.GC25250@elf.ucw.cz> <20050106160306.GA20127@hugang.soulinfo.com> <20050106223132.GD25913@elf.ucw.cz> <20050107014023.GA29740@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107014023.GA29740@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > adding a option to freeze/thaw_processes, first freeze all user
> > > processess, from now only kernel processess running, Now we can shrink
> > > more memory than current version, after that freeze all processes.
> > > that's mean if your swap space enough, swsusp will not fail. 
> > 
> > Thanks for the port... ...what is the test case this fixes?
> > 
> > Patch is pretty pretty simple, that's good...
> 
> # free
> ....
> Mem:        256368     198148
> ...
> Swap:       524280     140108
> 
> # ./eatmem 256
> 
> now do swsusp, the current swsusp will fail, with the patch it works.

It worked here:

pavel@amd:~/misc$ gcc eatmem.c -o eatmem
eatmem.c: In function `do_malloc':
eatmem.c:10: warning: assignment makes pointer from integer without a
cast
pavel@amd:~/misc$ cat /proc/swaps
Filename                                Type            Size    Used
Priority
/dev/hda1                               partition       1953464 0
-2
pavel@amd:~/misc$ free
             total       used       free     shared    buffers
cached
Mem:       1031568     989672      41896          0      34340
788156
-/+ buffers/cache:     167176     864392
Swap:      1953464          0    1953464
pavel@amd:~/misc$ ./eatmem 1024
1023

(When it was printing around 900, I switched to another console and
tried swsusp (worked ok), then tried again when it printed 1023).

I'm using patched kernel, however, and this patch might be
relevant. Can you try to apply it and see if problem goes away? [This
patch is ugly hack, but if it helps, we'll simply ask akpm to fix
free_some_memory :-)].

								Pavel

--- clean/kernel/power/disk.c	2004-12-25 13:35:03.000000000 +0100
+++ linux/kernel/power/disk.c	2004-12-25 13:05:45.000000000 +0100
@@ -86,23 +86,25 @@
 
 static void free_some_memory(void)
 {
-	unsigned int i = 0;
-	unsigned int tmp;
-	unsigned long pages = 0;
-	char *p = "-\\|/";
-
-	printk("Freeing memory...  ");
-	while ((tmp = shrink_all_memory(10000))) {
-		pages += tmp;
-		printk("\b%c", p[i]);
-		i++;
-		if (i > 3)
-			i = 0;
+	int i;
+	for (i=0; i<5; i++) {
+		int i = 0, tmp;
+		long pages = 0;
+		char *p = "-\\|/";
+
+		printk("Freeing memory...  ");
+		while ((tmp = shrink_all_memory(10000))) {
+			pages += tmp;
+			printk("\b%c", p[i]);
+			i++;
+			if (i > 3)
+				i = 0;
+		}
+		printk("\bdone (%li pages freed)\n", pages);
+		msleep_interruptible(200);
 	}
-	printk("\bdone (%li pages freed)\n", pages);
 }
 
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
