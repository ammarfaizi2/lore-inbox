Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272127AbTHHWPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272134AbTHHWPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:15:40 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45572 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272127AbTHHWPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:15:00 -0400
Date: Sat, 9 Aug 2003 00:06:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 1/8] 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm (devices)
Message-ID: <20030809000633.B2699@electric-eye.fr.zoreil.com>
References: <20030809000303.A2699@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030809000303.A2699@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Aug 09, 2003 at 12:03:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file conversion for proc/atm/devices:
- code inspired from seq_file use in net/core/dev.c;
- atm_dev_lock taken/released in atm_devices_seq_{start/stop};
- add a helper CREATE_SEQ_ENTRY() similar to CREATE_ENTRY() (both are removed
  once conversion is done).


 net/atm/proc.c |  111 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 79 insertions(+), 32 deletions(-)

diff -puN net/atm/proc.c~atm-proc-seq-devices net/atm/proc.c
--- linux-2.6.0-test2-bk8/net/atm/proc.c~atm-proc-seq-devices	Fri Aug  8 20:28:48 2003
+++ linux-2.6.0-test2-bk8-fr/net/atm/proc.c	Fri Aug  8 20:28:48 2003
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/errno.h>
 #include <linux/atm.h>
 #include <linux/atmdev.h>
@@ -64,32 +65,30 @@ static struct file_operations proc_spec_
 	.read =		proc_spec_atm_read,
 };
 
-static void add_stats(char *buf,const char *aal,
+static void add_stats(struct seq_file *seq, const char *aal,
   const struct k_atm_aal_stats *stats)
 {
-	sprintf(strchr(buf,0),"%s ( %d %d %d %d %d )",aal,
+	seq_printf(seq, "%s ( %d %d %d %d %d )", aal,
 	    atomic_read(&stats->tx),atomic_read(&stats->tx_err),
 	    atomic_read(&stats->rx),atomic_read(&stats->rx_err),
 	    atomic_read(&stats->rx_drop));
 }
 
-
-static void atm_dev_info(const struct atm_dev *dev,char *buf)
+static void atm_dev_info(struct seq_file *seq, const struct atm_dev *dev)
 {
-	int off,i;
+	int i;
 
-	off = sprintf(buf,"%3d %-8s",dev->number,dev->type);
+	seq_printf(seq, "%3d %-8s", dev->number, dev->type);
 	for (i = 0; i < ESI_LEN; i++)
-		off += sprintf(buf+off,"%02x",dev->esi[i]);
-	strcat(buf,"  ");
-	add_stats(buf,"0",&dev->stats.aal0);
-	strcat(buf,"  ");
-	add_stats(buf,"5",&dev->stats.aal5);
-	sprintf(strchr(buf,0), "\t[%d]", atomic_read(&dev->refcnt));
-	strcat(buf,"\n");
+		seq_printf(seq, "%02x", dev->esi[i]);
+	seq_puts(seq, "  ");
+	add_stats(seq, "0", &dev->stats.aal0);
+	seq_puts(seq, "  ");
+	add_stats(seq, "5", &dev->stats.aal5);
+	seq_printf(seq, "\t[%d]", atomic_read(&dev->refcnt));
+	seq_putc(seq, '\n');
 }
 
-
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 
 
@@ -303,30 +302,70 @@ lec_info(struct lec_arp_table *entry, ch
 
 #endif
 
-static int atm_devices_info(loff_t pos,char *buf)
+static __inline__ void *dev_get_idx(struct seq_file *seq, loff_t left)
 {
-	struct atm_dev *dev;
 	struct list_head *p;
-	int left;
 
-	if (!pos) {
-		return sprintf(buf,"Itf Type    ESI/\"MAC\"addr "
-		    "AAL(TX,err,RX,err,drop) ...               [refcnt]\n");
-	}
-	left = pos-1;
-	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
-		dev = list_entry(p, struct atm_dev, dev_list);
-		if (left-- == 0) {
-			atm_dev_info(dev,buf);
-			spin_unlock(&atm_dev_lock);
-			return strlen(buf);
-		}
+		if (!--left)
+			break;
 	}
-	spin_unlock(&atm_dev_lock);
-	return 0;
+	return (p != &atm_devs) ? p : NULL;
+}
+
+static void *atm_devices_seq_start(struct seq_file *seq, loff_t *pos)
+{
+ 	spin_lock(&atm_dev_lock);
+	return *pos ? dev_get_idx(seq, *pos) : (void *) 1;
 }
 
+static void atm_devices_seq_stop(struct seq_file *seq, void *v)
+{
+ 	spin_unlock(&atm_dev_lock);
+}
+ 
+static void *atm_devices_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	v = (v == (void *)1) ? atm_devs.next : ((struct list_head *)v)->next;
+	return (v == &atm_devs) ? NULL : v;
+}
+ 
+static int atm_devices_seq_show(struct seq_file *seq, void *v)
+{
+	static char atm_devices_banner[] =
+		"Itf Type    ESI/\"MAC\"addr "
+		"AAL(TX,err,RX,err,drop) ...               [refcnt]\n";
+ 
+	if (v == (void *)1)
+		seq_puts(seq, atm_devices_banner);
+	else {
+		struct atm_dev *dev = list_entry(v, struct atm_dev, dev_list);
+
+		atm_dev_info(seq, dev);
+	}
+ 	return 0;
+}
+ 
+static struct seq_operations atm_devices_seq_ops = {
+	.start	= atm_devices_seq_start,
+	.next	= atm_devices_seq_next,
+	.stop	= atm_devices_seq_stop,
+	.show	= atm_devices_seq_show,
+};
+ 
+static int atm_devices_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &atm_devices_seq_ops);
+}
+ 
+static struct file_operations atm_seq_devices_fops = {
+	.open		= atm_devices_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 /*
  * FIXME: it isn't safe to walk the VCC list without turning off interrupts.
  * What is really needed is some lock on the devices. Ditto for ATMARP.
@@ -623,6 +662,14 @@ void atm_proc_dev_deregister(struct atm_
 	kfree(dev->proc_name);
 }
 
+#define CREATE_SEQ_ENTRY(name) \
+	do { \
+		name = create_proc_entry(#name, S_IRUGO, atm_proc_root); \
+		if (!name) \
+			goto cleanup; \
+		name->proc_fops = &atm_seq_##name##_fops; \
+		name->owner = THIS_MODULE; \
+	} while (0)
 
 #define CREATE_ENTRY(name) \
     name = create_proc_entry(#name,0,atm_proc_root); \
@@ -656,7 +703,7 @@ int __init atm_proc_init(void)
 	atm_proc_root = proc_mkdir("net/atm",NULL);
 	if (!atm_proc_root)
 		return -ENOMEM;
-	CREATE_ENTRY(devices);
+	CREATE_SEQ_ENTRY(devices);
 	CREATE_ENTRY(pvc);
 	CREATE_ENTRY(svc);
 	CREATE_ENTRY(vc);

_
