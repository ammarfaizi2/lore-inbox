Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262953AbTC0Ona>; Thu, 27 Mar 2003 09:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262991AbTC0On3>; Thu, 27 Mar 2003 09:43:29 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:1292 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262952AbTC0On1>; Thu, 27 Mar 2003 09:43:27 -0500
Date: Thu, 27 Mar 2003 14:54:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Ford <david+cert@blue-labs.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66 buglet
Message-ID: <20030327145440.A900@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Ford <david+cert@blue-labs.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3E827CDA.8030904@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E827CDA.8030904@blue-labs.org>; from david+cert@blue-labs.org on Wed, Mar 26, 2003 at 11:23:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 11:23:54PM -0500, David Ford wrote:
> <boot dmesg snip>
> devfs_register(cpu/microcode): illegal mode: 8180
> </snip>
> 
> # ls /dev/cpu
> # grep -i microcode /boot/2.5.66/.config
> CONFIG_MICROCODE=y
> 
> Not sure how it breaks between .64 where it worked and .66 where it 
> doesn't.  The code where it's registered doesn't appear to have changed. 
> arch/i386/kernel/microcode.c, line 137.

Please try the appended patch.


--- 1.17/arch/i386/kernel/microcode.c	Tue Mar 11 09:16:36 2003
+++ edited/arch/i386/kernel/microcode.c	Thu Mar 27 10:24:37 2003
@@ -107,7 +107,6 @@
 static char *mc_applied;            /* array of applied microcode blocks */
 static unsigned int mc_fsize;       /* file size of /dev/cpu/microcode */
 
-/* we share file_operations between misc and devfs mechanisms */
 static struct file_operations microcode_fops = {
 	.owner		= THIS_MODULE,
 	.read		= microcode_read,
@@ -122,41 +121,33 @@
 	.fops	= &microcode_fops,
 };
 
-static devfs_handle_t devfs_handle;
-
 static int __init microcode_init(void)
 {
 	int error;
 
 	error = misc_register(&microcode_dev);
 	if (error)
-		printk(KERN_WARNING 
-			"microcode: can't misc_register on minor=%d\n",
-			MICROCODE_MINOR);
-
-	devfs_handle = devfs_register(NULL, "cpu/microcode",
-			DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR | S_IWUSR, 
-			&microcode_fops, NULL);
-	if (devfs_handle == NULL && error) {
-		printk(KERN_ERR "microcode: failed to devfs_register()\n");
-		misc_deregister(&microcode_dev);
-		goto out;
-	}
-	error = 0;
+		goto fail;
+	error = devfs_mk_symlink("cpu/microcode", "../misc/microcode");
+	if (error)
+		goto fail_deregister;
+
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
 		MICROCODE_VERSION);
+	return 0;
 
-out:
+fail_deregister:
+	misc_deregister(&microcode_dev);
+fail:
 	return error;
 }
 
 static void __exit microcode_exit(void)
 {
 	misc_deregister(&microcode_dev);
-	devfs_unregister(devfs_handle);
-	if (mc_applied)
-		kfree(mc_applied);
+	devfs_remove("cpu/microcode");
+	kfree(mc_applied);
 	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n", 
 			MICROCODE_VERSION);
 }
