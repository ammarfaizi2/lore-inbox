Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSKXUs3>; Sun, 24 Nov 2002 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSKXUs3>; Sun, 24 Nov 2002 15:48:29 -0500
Received: from 5-005.ctame701-2.telepar.net.br ([200.181.169.5]:55050 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261661AbSKXUsZ>; Sun, 24 Nov 2002 15:48:25 -0500
Date: Sun, 24 Nov 2002 18:55:36 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>, jt@hpl.hp.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] wireless: convert /proc/net/wireless to seq_file
Message-ID: <20021124205536.GN31074@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, jt@hpl.hp.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

	Now there are four outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.861, 2002-11-24 18:47:45-02:00, acme@conectiva.com.br
  o wireless: convert /proc/net/wireless to seq_file


 dev.c      |   22 +++++++---
 wireless.c |  133 +++++++++++++++++++++++++++++++------------------------------
 2 files changed, 84 insertions(+), 71 deletions(-)


diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Sun Nov 24 18:51:15 2002
+++ b/net/core/dev.c	Sun Nov 24 18:51:15 2002
@@ -1737,18 +1737,18 @@
 	return i == pos ? dev : NULL;
 }
 
-static void *dev_seq_start(struct seq_file *seq, loff_t *pos)
+void *dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&dev_base_lock);
 	return *pos ? dev_get_idx(seq, *pos) : (void *)1;
 }
 
-static void *dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+void *dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	return v == (void *)1 ? dev_base : ((struct net_device *)v)->next;
 }
 
-static void dev_seq_stop(struct seq_file *seq, void *v)
+void dev_seq_stop(struct seq_file *seq, void *v)
 {
 	read_unlock(&dev_base_lock);
 }
@@ -1856,6 +1856,14 @@
 	.release = seq_release,
 };
 
+#ifdef WIRELESS_EXT
+extern int wireless_proc_init(void);
+extern int wireless_proc_exit(void);
+#else
+#define wireless_proc_init() 0
+#define wireless_proc_exit()
+#endif
+
 static int __init dev_proc_init(void)
 {
 	struct proc_dir_entry *p;
@@ -1865,13 +1873,15 @@
 	if (!p)
 		goto out;
 	p->proc_fops = &dev_seq_fops;
+	if (wireless_proc_init())
+		goto out_dev;
 	create_proc_read_entry("net/softnet_stat", 0, 0, dev_proc_stats, NULL);
-#ifdef WIRELESS_EXT
-	proc_net_create("wireless", 0, dev_get_wireless_info);
-#endif
 	rc = 0;
 out:
 	return rc;
+out_dev:
+	remove_proc_entry("dev", proc_net);
+	goto out;
 }
 #else
 #define dev_proc_init() 0
diff -Nru a/net/core/wireless.c b/net/core/wireless.c
--- a/net/core/wireless.c	Sun Nov 24 18:51:15 2002
+++ b/net/core/wireless.c	Sun Nov 24 18:51:15 2002
@@ -47,15 +47,18 @@
 
 /***************************** INCLUDES *****************************/
 
-#include <asm/uaccess.h>		/* copy_to_user() */
 #include <linux/config.h>		/* Not needed ??? */
 #include <linux/types.h>		/* off_t */
 #include <linux/netdevice.h>		/* struct ifreq, dev_get_by_name() */
+#include <linux/proc_fs.h>
 #include <linux/rtnetlink.h>		/* rtnetlink stuff */
-
+#include <linux/seq_file.h>
 #include <linux/wireless.h>		/* Pretty obvious */
+
 #include <net/iw_handler.h>		/* New driver API */
 
+#include <asm/uaccess.h>		/* copy_to_user() */
+
 /**************************** CONSTANTS ****************************/
 
 /* Enough lenience, let's make sure things are proper... */
@@ -330,83 +333,83 @@
 /*
  * Print one entry (line) of /proc/net/wireless
  */
-static inline int sprintf_wireless_stats(char *buffer, struct net_device *dev)
+static __inline__ void wireless_seq_printf_stats(struct seq_file *seq,
+						 struct net_device *dev)
 {
 	/* Get stats from the driver */
-	struct iw_statistics *stats;
-	int size;
+	struct iw_statistics *stats = get_wireless_stats(dev);
 
-	stats = get_wireless_stats(dev);
-	if (stats != (struct iw_statistics *) NULL) {
-		size = sprintf(buffer,
-			       "%6s: %04x  %3d%c  %3d%c  %3d%c  %6d %6d %6d %6d %6d   %6d\n",
-			       dev->name,
-			       stats->status,
-			       stats->qual.qual,
-			       stats->qual.updated & 1 ? '.' : ' ',
-			       ((__u8) stats->qual.level),
-			       stats->qual.updated & 2 ? '.' : ' ',
-			       ((__u8) stats->qual.noise),
-			       stats->qual.updated & 4 ? '.' : ' ',
-			       stats->discard.nwid,
-			       stats->discard.code,
-			       stats->discard.fragment,
-			       stats->discard.retries,
-			       stats->discard.misc,
-			       stats->miss.beacon);
+	if (stats) {
+		seq_printf(seq, "%6s: %04x  %3d%c  %3d%c  %3d%c  %6d %6d %6d "
+				"%6d %6d   %6d\n",
+			   dev->name, stats->status, stats->qual.qual,
+			   stats->qual.updated & 1 ? '.' : ' ',
+			   ((__u8) stats->qual.level),
+			   stats->qual.updated & 2 ? '.' : ' ',
+			   ((__u8) stats->qual.noise),
+			   stats->qual.updated & 4 ? '.' : ' ',
+			   stats->discard.nwid, stats->discard.code,
+			   stats->discard.fragment, stats->discard.retries,
+			   stats->discard.misc, stats->miss.beacon);
 		stats->qual.updated = 0;
 	}
-	else
-		size = 0;
-
-	return size;
 }
 
 /* ---------------------------------------------------------------- */
 /*
  * Print info for /proc/net/wireless (print all entries)
  */
-int dev_get_wireless_info(char * buffer, char **start, off_t offset,
-			  int length)
+static int wireless_seq_show(struct seq_file *seq, void *v)
 {
-	int		len = 0;
-	off_t		begin = 0;
-	off_t		pos = 0;
-	int		size;
-	
-	struct net_device *	dev;
-
-	size = sprintf(buffer,
-		       "Inter-| sta-|   Quality        |   Discarded packets               | Missed\n"
-		       " face | tus | link level noise |  nwid  crypt   frag  retry   misc | beacon\n"
-			);
-	
-	pos += size;
-	len += size;
-
-	read_lock(&dev_base_lock);
-	for (dev = dev_base; dev != NULL; dev = dev->next) {
-		size = sprintf_wireless_stats(buffer + len, dev);
-		len += size;
-		pos = begin + len;
-
-		if (pos < offset) {
-			len = 0;
-			begin = pos;
-		}
-		if (pos > offset + length)
-			break;
-	}
-	read_unlock(&dev_base_lock);
+	if (v == (void *)1)
+		seq_printf(seq, "Inter-| sta-|   Quality        |   Discarded "
+				"packets               | Missed\n"
+				" face | tus | link level noise |  nwid  "
+				"crypt   frag  retry   misc | beacon\n");
+	else
+		wireless_seq_printf_stats(seq, v);
+	return 0;
+}
+
+extern void *dev_seq_start(struct seq_file *seq, loff_t *pos);
+extern void *dev_seq_next(struct seq_file *seq, void *v, loff_t *pos);
+extern void dev_seq_stop(struct seq_file *seq, void *v);
+
+static struct seq_operations wireless_seq_ops = {
+	.start = dev_seq_start,
+	.next  = dev_seq_next,
+	.stop  = dev_seq_stop,
+	.show  = wireless_seq_show,
+};
+
+static int wireless_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &wireless_seq_ops);
+}
 
-	*start = buffer + (offset - begin);	/* Start of wanted data */
-	len -= (offset - begin);		/* Start slop */
-	if (len > length)
-		len = length;			/* Ending slop */
-	if (len < 0)
-		len = 0;
+static struct file_operations wireless_seq_fops = {
+	.open    = wireless_seq_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
 
-	return len;
+int __init wireless_proc_init(void)
+{
+	struct proc_dir_entry *p;
+	int rc = 0;
+
+	p = create_proc_entry("wireless", S_IRUGO, proc_net);
+	if (p)
+		p->proc_fops = &wireless_seq_fops;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
+
+void __init wireless_proc_exit(void)
+{
+	remove_proc_entry("wireless", proc_net);
 }
 #endif	/* CONFIG_PROC_FS */
 

===================================================================


This BitKeeper patch contains the following changesets:
1.861
## Wrapped with gzip_uu ##


begin 664 bkpatch16624
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
:KPX^$ORVF(Q/\6O-,ZY=6_D;&%7YZT41````
`
end
