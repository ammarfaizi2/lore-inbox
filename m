Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWAHDCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWAHDCE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 22:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbWAHDCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 22:02:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64384 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161156AbWAHDCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 22:02:03 -0500
Date: Sat, 7 Jan 2006 19:05:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.14.6
Message-ID: <20060108030518.GB3335@sorel.sous-sol.org>
References: <20060108030412.GA3335@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108030412.GA3335@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index ea6f2f9..8c6fcb0 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 14
-EXTRAVERSION = .5
+EXTRAVERSION = .6
 NAME=Affluent Albatross
 
 # *DOCUMENTATION*
diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
index de39956..da8c31d 100644
--- a/drivers/net/sungem.c
+++ b/drivers/net/sungem.c
@@ -2905,7 +2905,7 @@ static int __devinit gem_get_device_addr
 	return 0;
 }
 
-static void __devexit gem_remove_one(struct pci_dev *pdev)
+static void gem_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -3179,7 +3179,7 @@ static struct pci_driver gem_driver = {
 	.name		= GEM_MODULE_NAME,
 	.id_table	= gem_pci_tbl,
 	.probe		= gem_init_one,
-	.remove		= __devexit_p(gem_remove_one),
+	.remove		= gem_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= gem_suspend,
 	.resume		= gem_resume,
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 037fe9d..efbd63c 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -404,7 +404,7 @@ static struct {
 	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 235, 83, 63, ATI_CHIP_264XL | M64F_SDRAM_MAGIC_PLL },
 	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP_264XL },
 
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 8a8c344..89f64c1 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -54,6 +54,18 @@ proc_file_read(struct file *file, char _
 	ssize_t	n, count;
 	char	*start;
 	struct proc_dir_entry * dp;
+	unsigned long long pos;
+
+	/*
+	 * Gaah, please just use "seq_file" instead. The legacy /proc
+	 * interfaces cut loff_t down to off_t for reads, and ignore
+	 * the offset entirely for writes..
+	 */
+	pos = *ppos;
+	if (pos > MAX_NON_LFS)
+		return 0;
+	if (nbytes > MAX_NON_LFS - pos)
+		nbytes = MAX_NON_LFS - pos;
 
 	dp = PDE(inode);
 	if (!(page = (char*) __get_free_page(GFP_KERNEL)))
@@ -202,30 +214,17 @@ proc_file_write(struct file *file, const
 static loff_t
 proc_file_lseek(struct file *file, loff_t offset, int orig)
 {
-    lock_kernel();
-
-    switch (orig) {
-    case 0:
-	if (offset < 0)
-	    goto out;
-	file->f_pos = offset;
-	unlock_kernel();
-	return(file->f_pos);
-    case 1:
-	if (offset + file->f_pos < 0)
-	    goto out;
-	file->f_pos += offset;
-	unlock_kernel();
-	return(file->f_pos);
-    case 2:
-	goto out;
-    default:
-	goto out;
-    }
-
-out:
-    unlock_kernel();
-    return -EINVAL;
+	loff_t retval = -EINVAL;
+	switch (orig) {
+	case 1:
+		offset += file->f_pos;
+	/* fallthrough */
+	case 0:
+		if (offset < 0 || offset > MAX_NON_LFS)
+			break;
+		file->f_pos = retval = offset;
+	}
+	return retval;
 }
 
 static int proc_notify_change(struct dentry *dentry, struct iattr *iattr)
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index f036d69..b466265 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1294,8 +1294,10 @@ static ssize_t ufs_quota_write(struct su
 		blk++;
 	}
 out:
-	if (len == towrite)
+	if (len == towrite) {
+		up(&inode->i_sem);
 		return err;
+	}
 	if (inode->i_size < off+len-towrite)
 		i_size_write(inode, off+len-towrite);
 	inode->i_version++;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b90dba7..eebedca 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2191,29 +2191,32 @@ int sysctl_string(ctl_table *table, int 
 		  void __user *oldval, size_t __user *oldlenp,
 		  void __user *newval, size_t newlen, void **context)
 {
-	size_t l, len;
-	
 	if (!table->data || !table->maxlen) 
 		return -ENOTDIR;
 	
 	if (oldval && oldlenp) {
-		if (get_user(len, oldlenp))
+		size_t bufsize;
+		if (get_user(bufsize, oldlenp))
 			return -EFAULT;
-		if (len) {
-			l = strlen(table->data);
-			if (len > l) len = l;
-			if (len >= table->maxlen)
+		if (bufsize) {
+			size_t len = strlen(table->data), copied;
+
+			/* This shouldn't trigger for a well-formed sysctl */
+			if (len > table->maxlen)
 				len = table->maxlen;
-			if(copy_to_user(oldval, table->data, len))
-				return -EFAULT;
-			if(put_user(0, ((char __user *) oldval) + len))
+
+			/* Copy up to a max of bufsize-1 bytes of the string */
+			copied = (len >= bufsize) ? bufsize - 1 : len;
+
+			if (copy_to_user(oldval, table->data, copied) ||
+			    put_user(0, (char __user *)(oldval + copied)))
 				return -EFAULT;
-			if(put_user(len, oldlenp))
+			if (put_user(len, oldlenp))
 				return -EFAULT;
 		}
 	}
 	if (newval && newlen) {
-		len = newlen;
+		size_t len = newlen;
 		if (len > table->maxlen)
 			len = table->maxlen;
 		if(copy_from_user(table->data, newval, len))
@@ -2222,7 +2225,7 @@ int sysctl_string(ctl_table *table, int 
 			len--;
 		((char *) table->data)[len] = 0;
 	}
-	return 0;
+	return 1;
 }
 
 /*
diff --git a/net/ieee80211/Kconfig b/net/ieee80211/Kconfig
index 91b16fb..d18ccba 100644
--- a/net/ieee80211/Kconfig
+++ b/net/ieee80211/Kconfig
@@ -55,7 +55,7 @@ config IEEE80211_CRYPT_CCMP
 
 config IEEE80211_CRYPT_TKIP
 	tristate "IEEE 802.11i TKIP encryption"
-	depends on IEEE80211
+	depends on IEEE80211 && NET_RADIO
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
 	---help---
