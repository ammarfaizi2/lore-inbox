Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTFHKIz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 06:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTFHKIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 06:08:55 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:65029 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261328AbTFHKIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 06:08:47 -0400
Date: Sun, 8 Jun 2003 11:43:14 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Sam Ravnborg <sam@ravnborg.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
In-Reply-To: <20030607155826.GA20118@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0306081118100.1643-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jun 2003, Sam Ravnborg wrote:

> On Sat, Jun 07, 2003 at 05:24:34PM +0200, Adrian Bunk wrote:
> > I got the following compile error with !CONFIG_PROC_FS:
> >   CC      drivers/net/irda/vlsi_ir.o
> > drivers/net/irda/vlsi_ir.c:2047: `PROC_DIR' undeclared (first use in this function)
> > The following patch fixes it:
> 
> I prefer the following patch:
> Get rid of one ifdef/endif pair.
> 
> -#ifdef CONFIG_PROC_FS
>  #define PROC_DIR ("driver/" DRIVER_NAME)
> -#endif

Yes, Thanks. In fact walking over the proc-stuff in vlsi_ir, there are 
some more places which need cleanup and fixing.

Jean, please apply the patch below - ChangeLog:

* make it compile without CONFIG_PROC_FS (problem reported by Adrian Bunk, 
  original patch by Sam Ravnborg)
* get rid of a number of unneeded ifdef/endif CONFIG_PROC_FS (also 
  removing an "unused label" warning)
* use proc entry's owner field to protect against module removal racing
  with proc entry access.

Martin

------------------------

--- linux-2.5.70/include/net/irda/vlsi_ir.h	Mon Apr  7 19:31:51 2003
+++ v2.5.70/include/net/irda/vlsi_ir.h	Sun Jun  8 11:33:40 2003
@@ -730,9 +730,7 @@ typedef struct vlsi_irda_dev {
 
 	u32			cfg_space[64/sizeof(u32)];
 	u8			resume_ok;	
-#ifdef CONFIG_PROC_FS
 	struct proc_dir_entry	*proc_entry;
-#endif
 
 } vlsi_irda_dev_t;
 
--- linux-2.5.70/drivers/net/irda/vlsi_ir.c	Wed May  7 09:13:39 2003
+++ v2.5.70/drivers/net/irda/vlsi_ir.c	Sun Jun  8 11:33:34 2003
@@ -149,6 +149,9 @@ static void vlsi_ring_debug(struct vlsi_
 
 /********************************************************/
 
+/* needed regardless of CONFIG_PROC_FS */
+static struct proc_dir_entry *vlsi_proc_root = NULL;
+
 #ifdef CONFIG_PROC_FS
 
 static int vlsi_proc_pdev(struct pci_dev *pdev, char *buf, int len)
@@ -394,8 +397,6 @@ static int vlsi_proc_print(struct net_de
 	return out - buf;
 }
 
-static struct proc_dir_entry *vlsi_proc_root = NULL;
-
 struct vlsi_proc_data {
 	int size;
 	char *data;
@@ -499,6 +500,11 @@ static struct file_operations vlsi_proc_
 	.read		= vlsi_proc_read,
 	.release	= vlsi_proc_release,
 };
+
+#define VLSI_PROC_FOPS		(&vlsi_proc_fops)
+
+#else	/* CONFIG_PROC_FS */
+#define VLSI_PROC_FOPS		NULL
 #endif
 
 /********************************************************/
@@ -1800,8 +1806,7 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 		goto out_freedev;
 	}
 
-#ifdef CONFIG_PROC_FS
-	{
+	if (vlsi_proc_root != NULL) {
 		struct proc_dir_entry *ent;
 
 		ent = create_proc_entry(ndev->name, S_IFREG|S_IRUGO, vlsi_proc_root);
@@ -1810,11 +1815,11 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 			goto out_unregister;
 		}
 		ent->data = ndev;
-		ent->proc_fops = &vlsi_proc_fops;
+		ent->proc_fops = VLSI_PROC_FOPS;
 		ent->size = 0;
 		idev->proc_entry = ent;
-	}
-#endif
+	} else
+		idev->proc_entry = NULL;
 
 	printk(KERN_INFO "%s: registered device %s\n", drivername, ndev->name);
 
@@ -1851,12 +1856,10 @@ static void __devexit vlsi_irda_remove(s
 	down(&idev->sem);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-#ifdef CONFIG_PROC_FS
 	if (idev->proc_entry) {
 		remove_proc_entry(ndev->name, vlsi_proc_root);
 		idev->proc_entry = NULL;
 	}
-#endif
 	up(&idev->sem);
 
 	unregister_netdev(ndev);
@@ -1993,9 +1996,7 @@ static struct pci_driver vlsi_irda_drive
 #endif
 };
 
-#ifdef CONFIG_PROC_FS
 #define PROC_DIR ("driver/" DRIVER_NAME)
-#endif
 
 static int __init vlsi_mod_init(void)
 {
@@ -2025,18 +2026,16 @@ static int __init vlsi_mod_init(void)
 
 	sirpulse = !!sirpulse;
 
-#ifdef CONFIG_PROC_FS
 	vlsi_proc_root = create_proc_entry(PROC_DIR, S_IFDIR, 0);
 	if (!vlsi_proc_root)
 		return -ENOMEM;
-#endif
+	/* protect registered procdir against module removal */
+	vlsi_proc_root->owner = THIS_MODULE;
 
 	ret = pci_module_init(&vlsi_irda_driver);
 
-#ifdef CONFIG_PROC_FS
 	if (ret)
 		remove_proc_entry(PROC_DIR, 0);
-#endif
 	return ret;
 
 }



