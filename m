Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268296AbTAMTB2>; Mon, 13 Jan 2003 14:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268294AbTAMTB1>; Mon, 13 Jan 2003 14:01:27 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:30592 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S268293AbTAMTBX>;
	Mon, 13 Jan 2003 14:01:23 -0500
Date: Mon, 13 Jan 2003 20:10:07 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: schlicht@uni-mannheim.de, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Re: patch for errno-issue (with soundcore)
Message-ID: <20030113191007.GA2814@vana>
References: <D206AA476EB@vcnet.vc.cvut.cz> <200301131810.53089.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301131810.53089.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Now, at least, I understood the real problem...
> 'errno' is only needed because open(), close(), llseek() and read() are used, 
> which do a syscall and the return code is written to a variable called 
> 'errno'. This is NOT the 'errno' variable defined in lib/errno.c... OK.
> 
> And so the real problem is using these functions and as we ARE in the kernel 
> mode we do not really need the kernel traps...

Hi, 
  can someone with sound card requiring firmware download (OSS's trix,
sb_common, msnd_pinnacle, sscape, maui or pss) verify that code below
works? I know that it compiles without warnings, and looks obviously
correct (to me), but...

  I think that I do not need any locking around reading i_size, as
nothing bad should happen if size changes, you'll get damaged firmware
upload at worst, and if you are updating firmware file while kernel 
reads it, you deserve it (besides that vfs_read is one who will do final 
check). And sys_stat (getattr) does not take any lock too, unless I 
missed something.

  Patch is for 2.5.57.

  BTW, should I convert it to goto? It was really annoying that I had to
fix 3 error paths instead of one ;-)
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz	

diff -urdN linux/sound/sound_firmware.c linux/sound/sound_firmware.c
--- linux/sound/sound_firmware.c	2003-01-13 18:24:36.000000000 +0000
+++ linux/sound/sound_firmware.c	2003-01-13 18:45:12.000000000 +0000
@@ -9,39 +9,40 @@
 
 static int do_mod_firmware_load(const char *fn, char **fp)
 {
-	int fd;
+	struct file* filp;
 	long l;
 	char *dp;
+	loff_t pos;
 
-	fd = open(fn, 0, 0);
-	if (fd == -1)
+	filp = filp_open(fn, 0, 0);
+	if (IS_ERR(filp))
 	{
 		printk(KERN_INFO "Unable to load '%s'.\n", fn);
 		return 0;
 	}
-	l = lseek(fd, 0L, 2);
+	l = filp->f_dentry->d_inode->i_size;
 	if (l <= 0 || l > 131072)
 	{
 		printk(KERN_INFO "Invalid firmware '%s'\n", fn);
-		sys_close(fd);
+		filp_close(filp, current->files);
 		return 0;
 	}
-	lseek(fd, 0L, 0);
 	dp = vmalloc(l);
 	if (dp == NULL)
 	{
 		printk(KERN_INFO "Out of memory loading '%s'.\n", fn);
-		sys_close(fd);
+		filp_close(filp, current->files);
 		return 0;
 	}
-	if (read(fd, dp, l) != l)
+	pos = 0;
+	if (vfs_read(filp, dp, l, &pos) != l)
 	{
 		printk(KERN_INFO "Failed to read '%s'.\n", fn);
 		vfree(dp);
-		sys_close(fd);
+		filp_close(filp, current->files);
 		return 0;
 	}
-	close(fd);
+	filp_close(filp, current->files);
 	*fp = dp;
 	return (int) l;
 }
