Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbSJMHFR>; Sun, 13 Oct 2002 03:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbSJMHFR>; Sun, 13 Oct 2002 03:05:17 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:30725 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261452AbSJMHFM>; Sun, 13 Oct 2002 03:05:12 -0400
Date: Sun, 13 Oct 2002 05:10:59 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: convert /proc/net/arp to seq_file
Message-ID: <20021013071059.GD7898@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021013065656.GC7898@conectiva.com.br> <20021012.235756.130619930.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012.235756.130619930.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 12, 2002 at 11:57:56PM -0700, David S. Miller escreveu:
>    PS.: Any feedback from the pppoe maintainer about seq_file patch?
> 
> None that I've seen :(
> 
> We should just put the changes in, if the maintainer really
> cares he can revert them later after making his case.
> 
> Can you repost the changes in question?

Sure, here it is, and it is available for pulling at:

master.kernel.org:/home/acme/BK/llc-2.5

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.637, 2002-10-09 02:03:34-03:00, acme@conectiva.com.br
  o pppoe: use seq_file for proc stuff
  
  Also make it conditional on CONFIG_PROC_FS


 pppoe.c |  156 +++++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 106 insertions(+), 50 deletions(-)


diff -Nru a/drivers/net/pppoe.c b/drivers/net/pppoe.c
--- a/drivers/net/pppoe.c	Sun Oct 13 05:09:55 2002
+++ b/drivers/net/pppoe.c	Sun Oct 13 05:09:55 2002
@@ -5,7 +5,7 @@
  * PPPoE --- PPP over Ethernet (RFC 2516)
  *
  *
- * Version:    0.6.10
+ * Version:    0.6.11
  *
  * 220102 :	Fix module use count on failure in pppoe_create, pppox_sk -acme
  * 030700 :     Fixed connect logic to allow for disconnect.
@@ -35,6 +35,7 @@
  * 121301 :     New ppp channels interface; cannot unregister a channel
  *              from interrupts.  Thus, we mark the socket as a ZOMBIE
  *              and do the unregistration later.
+ * 081002 :	seq_file support for proc stuff -acme
  *
  * Author:	Michal Ostrowski <mostrows@speakeasy.net>
  * Contributors:
@@ -75,6 +76,7 @@
 #include <linux/notifier.h>
 #include <linux/file.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 
 
@@ -974,63 +976,102 @@
 	return error;
 }
 
-int pppoe_proc_info(char *buffer, char **start, off_t offset, int length)
+#ifdef CONFIG_PROC_FS
+static int pppoe_seq_show(struct seq_file *seq, void *v)
 {
 	struct pppox_opt *po;
-	int len = 0;
-	off_t pos = 0;
-	off_t begin = 0;
-	int size;
-	int i;
+	char *dev_name;
 
-	len += sprintf(buffer,
-		       "Id       Address              Device\n");
-	pos = len;
+	if (v == (void *)1) {
+		seq_puts(seq, "Id       Address              Device\n");
+		goto out;
+	}
 
-	write_lock_bh(&pppoe_hash_lock);
+	po = v;
+	dev_name = po->pppoe_pa.dev;
+
+	seq_printf(seq, "%08X %02X:%02X:%02X:%02X:%02X:%02X %8s\n",
+		   po->pppoe_pa.sid,
+		   po->pppoe_pa.remote[0], po->pppoe_pa.remote[1],
+		   po->pppoe_pa.remote[2], po->pppoe_pa.remote[3],
+		   po->pppoe_pa.remote[4], po->pppoe_pa.remote[5], dev_name);
+out:
+  	return 0;
+}
 
-	for (i = 0; i < PPPOE_HASH_SIZE; i++) {
+static __inline__ struct pppox_opt *pppoe_get_idx(loff_t pos)
+{
+	struct pppox_opt *po = NULL;
+	int i = 0;
+
+	for (; i < PPPOE_HASH_SIZE; i++) {
 		po = item_hash_table[i];
 		while (po) {
-			char *dev = po->pppoe_pa.dev;
+			if (!pos--)
+				goto out;
+			po = po->next;
+		}
+	}
+out:
+	return po;
+}
 
-			size = sprintf(buffer + len,
-				       "%08X %02X:%02X:%02X:%02X:%02X:%02X %8s\n",
-				       po->pppoe_pa.sid,
-				       po->pppoe_pa.remote[0],
-				       po->pppoe_pa.remote[1],
-				       po->pppoe_pa.remote[2],
-				       po->pppoe_pa.remote[3],
-				       po->pppoe_pa.remote[4],
-				       po->pppoe_pa.remote[5],
-				       dev);
-			len += size;
-			pos += size;
-			if (pos < offset) {
-				len = 0;
-				begin = pos;
-			}
+static void *pppoe_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t l = *pos;
 
-			if (pos > offset + length)
-				break;
+	read_lock_bh(&pppoe_hash_lock);
+	return l ? pppoe_get_idx(--l) : (void *)1;
+}
 
-			po = po->next;
+static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct pppox_opt *po;
+
+	++*pos;
+	if (v == (void *)1) {
+		po = pppoe_get_idx(0);
+		goto out;
+	}
+	po = v;
+	po = po->next;
+	if (!po) {
+		int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
+
+		while (++hash < PPPOE_HASH_SIZE) {
+			po = item_hash_table[hash];
+			if (po)
+				break;
 		}
+	}
+out:
+	return po;
+}
 
-		if (po)
-			break;
-  	}
-	write_unlock_bh(&pppoe_hash_lock);
+static void pppoe_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock_bh(&pppoe_hash_lock);
+}
+
+struct seq_operations pppoe_seq_ops = {
+	.start		= pppoe_seq_start,
+	.next		= pppoe_seq_next,
+	.stop		= pppoe_seq_stop,
+	.show		= pppoe_seq_show,
+};
 
-  	*start = buffer + (offset - begin);
-  	len -= (offset - begin);
-  	if (len > length)
-  		len = length;
-	if (len < 0)
-		len = 0;
-  	return len;
+static int pppoe_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &pppoe_seq_ops);
 }
 
+static struct file_operations pppoe_seq_fops = {
+	.open           = pppoe_seq_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+#endif /* CONFIG_PROC_FS */
 
 struct proto_ops pppoe_ops = {
     .family		= AF_PPPOX,
@@ -1061,13 +1102,28 @@
 {
  	int err = register_pppox_proto(PX_PROTO_OE, &pppoe_proto);
 
-	if (err == 0) {
-		dev_add_pack(&pppoes_ptype);
-		dev_add_pack(&pppoed_ptype);
-		register_netdevice_notifier(&pppoe_notifier);
-		proc_net_create("pppoe", 0, pppoe_proc_info);
-	}
+	if (err)
+		goto out;
+#ifdef CONFIG_PROC_FS
+{
+	struct proc_dir_entry *p = create_proc_entry("pppoe", S_IRUGO,
+						     proc_net);
+	err = -ENOMEM;
+	if (!p)
+		goto out_unregister;
+	
+	p->proc_fops = &pppoe_seq_fops;
+	err = 0;
+}
+#endif /* CONFIG_PROC_FS */
+	dev_add_pack(&pppoes_ptype);
+	dev_add_pack(&pppoed_ptype);
+	register_netdevice_notifier(&pppoe_notifier);
+out:
 	return err;
+out_unregister:
+	unregister_pppox_proto(PX_PROTO_OE);
+	goto out;
 }
 
 void __exit pppoe_exit(void)
@@ -1076,7 +1132,7 @@
 	dev_remove_pack(&pppoes_ptype);
 	dev_remove_pack(&pppoed_ptype);
 	unregister_netdevice_notifier(&pppoe_notifier);
-	proc_net_remove("pppoe");
+	remove_proc_entry("pppoe", proc_net);
 }
 
 module_init(pppoe_init);

===================================================================


This BitKeeper patch contains the following changesets:
1.637
## Wrapped with gzip_uu ##


begin 664 bkpatch3941
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
1!YV.[X1C3?T'+AM][3$/````
`
end
