Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272012AbTHHW0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272121AbTHHWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:25:33 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:59652 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272118AbTHHWYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:24:08 -0400
Date: Sat, 9 Aug 2003 00:19:03 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 7/8] 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm (lec)
Message-ID: <20030809001903.H2699@electric-eye.fr.zoreil.com>
References: <20030809000303.A2699@electric-eye.fr.zoreil.com> <20030809000633.B2699@electric-eye.fr.zoreil.com> <20030809000841.C2699@electric-eye.fr.zoreil.com> <20030809001013.D2699@electric-eye.fr.zoreil.com> <20030809001139.E2699@electric-eye.fr.zoreil.com> <20030809001321.F2699@electric-eye.fr.zoreil.com> <20030809001541.G2699@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030809001541.G2699@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Aug 09, 2003 at 12:15:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file support for /proc/net/atm/lec:
- lec_info(): seq_printf/seq_putc replaces sprintf;
- traversal of the lec structure needs to walk:
  -> the lec interfaces
     -> the tables of arp tables(lec_arp_tables);
        -> the arp tables themselves
     -> the misc tables (lec_arp_empty_ones/lec_no_forward/mcast_fwds)

  Sum up of the call tree:
  atm_lec_seq_start()/atm_lec_seq_next()
  -> atm_lec_get_idx()
     -> atm_lec_itf_walk() (responsible for dev_lec/dev_put handling)
        -> atm_lec_priv_walk() (responsible for lec_priv locking)
           -> atm_lec_arp_walk()
              -> atm_lec_tbl_walk()
           -> atm_lec_misc_walk()   (<- this one needed fixing)
              -> atm_lec_tbl_walk() (<- this one needed fixing)

  Each of the dedicated functions follows the same convention: return NULL
  as long as the seq_file cursor hasn't been digested (i.e. until < 0).
  Locking is only done when an entry (i.e. a lec_arp_table) is referenced.
  atm_lec_seq_stop()/atm_lec_itf_walk()/atm_lec_priv_walk() are responsible
  for getting this point right.
- module refcounting is done in atm_lec_seq_open()/atm_lec_seq_release();
- atm_lec_info() is removed.


 net/atm/proc.c |  338 +++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 232 insertions(+), 106 deletions(-)

diff -puN net/atm/proc.c~atm-proc-seq-lec-conversion net/atm/proc.c
--- linux-2.6.0-test2-bk8/net/atm/proc.c~atm-proc-seq-lec-conversion	Fri Aug  8 20:29:31 2003
+++ linux-2.6.0-test2-bk8-fr/net/atm/proc.c	Fri Aug  8 20:29:31 2003
@@ -335,54 +335,45 @@ static void svc_info(struct seq_file *se
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 
-static char*
-lec_arp_get_status_string(unsigned char status)
+static char* lec_arp_get_status_string(unsigned char status)
 {
-  switch(status) {
-  case ESI_UNKNOWN:
-    return "ESI_UNKNOWN       ";
-  case ESI_ARP_PENDING:
-    return "ESI_ARP_PENDING   ";
-  case ESI_VC_PENDING:
-    return "ESI_VC_PENDING    ";
-  case ESI_FLUSH_PENDING:
-    return "ESI_FLUSH_PENDING ";
-  case ESI_FORWARD_DIRECT:
-    return "ESI_FORWARD_DIRECT";
-  default:
-    return "<Unknown>         ";
-  }
-}
-
-static void 
-lec_info(struct lec_arp_table *entry, char *buf)
-{
-        int j, offset=0;
-
-        for(j=0;j<ETH_ALEN;j++) {
-                offset+=sprintf(buf+offset,"%2.2x",0xff&entry->mac_addr[j]);
+	static char *lec_arp_status_string[] = {
+		"ESI_UNKNOWN       ",
+		"ESI_ARP_PENDING   ",
+		"ESI_VC_PENDING    ",
+		"ESI_FLUSH_PENDING ",
+		"ESI_FORWARD_DIRECT",
+		"<Unknown>         "
+	};
+
+	if (status > ESI_FORWARD_DIRECT - 1)
+		status = ESI_FORWARD_DIRECT;
+	return lec_arp_status_string[status - ESI_UNKNOWN];
+}
+
+static void lec_info(struct seq_file *seq, struct lec_arp_table *entry)
+{
+	int i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		seq_printf(seq, "%2.2x", entry->mac_addr[i] & 0xff);
+	seq_printf(seq, " ");
+	for (i = 0; i < ATM_ESA_LEN; i++)
+		seq_printf(seq, "%2.2x", entry->atm_addr[i] & 0xff);
+	seq_printf(seq, " %s %4.4x", lec_arp_get_status_string(entry->status),
+		   entry->flags & 0xffff);
+	if (entry->vcc)
+		seq_printf(seq, "%3d %3d ", entry->vcc->vpi, entry->vcc->vci);
+	else
+	        seq_printf(seq, "        ");
+	if (entry->recv_vcc) {
+		seq_printf(seq, "     %3d %3d", entry->recv_vcc->vpi,
+			   entry->recv_vcc->vci);
         }
-        offset+=sprintf(buf+offset, " ");
-        for(j=0;j<ATM_ESA_LEN;j++) {
-                offset+=sprintf(buf+offset,"%2.2x",0xff&entry->atm_addr[j]);
-        }
-        offset+=sprintf(buf+offset, " %s %4.4x",
-                        lec_arp_get_status_string(entry->status),
-                        entry->flags&0xffff);
-        if (entry->vcc) {
-                offset+=sprintf(buf+offset, "%3d %3d ", entry->vcc->vpi, 
-                                entry->vcc->vci);                
-        } else
-                offset+=sprintf(buf+offset, "        ");
-        if (entry->recv_vcc) {
-                offset+=sprintf(buf+offset, "     %3d %3d", 
-                                entry->recv_vcc->vpi, entry->recv_vcc->vci);
-        }
-
-        sprintf(buf+offset,"\n");
+        seq_putc(seq, '\n');
 }
 
-#endif
+#endif /* CONFIG_ATM_LANE */
 
 static __inline__ void *dev_get_idx(struct seq_file *seq, loff_t left)
 {
@@ -703,78 +694,213 @@ static struct file_operations atm_seq_ar
 #endif /* CONFIG_ATM_CLIP */
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
-static int atm_lec_info(loff_t pos,char *buf)
-{
+
+struct atm_lec_state {
 	unsigned long flags;
-	struct lec_priv *priv;
+	struct lec_priv *locked;
 	struct lec_arp_table *entry;
-	int i, count, d, e;
 	struct net_device *dev;
+	int itf;
+	int arp_table;
+	int misc_table;
+};
 
-	if (!pos) {
-		return sprintf(buf,"Itf  MAC          ATM destination"
-		    "                          Status            Flags "
-		    "VPI/VCI Recv VPI/VCI\n");
+static void *atm_lec_tbl_walk(struct atm_lec_state *state,
+			      struct lec_arp_table *tbl, loff_t *l)
+{
+	struct lec_arp_table *e = state->entry;
+
+	if (!e)
+		e = tbl;
+	if (e == (void *)1) {
+		e = tbl;
+		--*l;
 	}
-	if (!try_atm_lane_ops())
-		return 0; /* the lane module is not there yet */
+	for (; e; e = e->next) {
+		if (--*l < 0)
+			break;
+	}
+	state->entry = e;
+	return (*l < 0) ? state : NULL;
+}
+
+static void *atm_lec_arp_walk(struct atm_lec_state *state, loff_t *l,
+			      struct lec_priv *priv)
+{
+	void *v = NULL;
+	int p;
 
-	count = pos;
-	for(d = 0; d < MAX_LEC_ITF; d++) {
-		dev = atm_lane_ops->get_lec(d);
-		if (!dev || !(priv = (struct lec_priv *) dev->priv))
-			continue;
-		spin_lock_irqsave(&priv->lec_arp_lock, flags);
-		for(i = 0; i < LEC_ARP_TABLE_SIZE; i++) {
-			for(entry = priv->lec_arp_tables[i]; entry; entry = entry->next) {
-				if (--count)
-					continue;
-				e = sprintf(buf,"%s ", dev->name);
-				lec_info(entry, buf+e);
-				spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
-				dev_put(dev);
-				module_put(atm_lane_ops->owner);
-				return strlen(buf);
-			}
-		}
-		for(entry = priv->lec_arp_empty_ones; entry; entry = entry->next) {
-			if (--count)
-				continue;
-			e = sprintf(buf,"%s ", dev->name);
-			lec_info(entry, buf+e);
-			spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
-			dev_put(dev);
-			module_put(atm_lane_ops->owner);
-			return strlen(buf);
-		}
-		for(entry = priv->lec_no_forward; entry; entry=entry->next) {
-			if (--count)
-				continue;
-			e = sprintf(buf,"%s ", dev->name);
-			lec_info(entry, buf+e);
-			spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
-			dev_put(dev);
-			module_put(atm_lane_ops->owner);
-			return strlen(buf);
-		}
-		for(entry = priv->mcast_fwds; entry; entry = entry->next) {
-			if (--count)
-				continue;
-			e = sprintf(buf,"%s ", dev->name);
-			lec_info(entry, buf+e);
-			spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
-			dev_put(dev);
-			module_put(atm_lane_ops->owner);
-			return strlen(buf);
-		}
-		spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
+	for (p = state->arp_table; p < LEC_ARP_TABLE_SIZE; p++) {
+		v = atm_lec_tbl_walk(state, priv->lec_arp_tables[p], l);
+		if (v)
+			break;
+	}
+	state->arp_table = p;
+	return v;
+}
+
+static void *atm_lec_misc_walk(struct atm_lec_state *state, loff_t *l,
+			       struct lec_priv *priv)
+{
+	struct lec_arp_table *lec_misc_tables[] = {
+		priv->lec_arp_empty_ones,
+		priv->lec_no_forward,
+		priv->mcast_fwds
+	};
+	void *v = NULL;
+	int q;
+
+	for (q = state->misc_table; q < ARRAY_SIZE(lec_misc_tables); q++) {
+		v = atm_lec_tbl_walk(state, lec_misc_tables[q], l);
+		if (v)
+			break;
+	}
+	state->misc_table = q;
+	return v;
+}
+
+static void *atm_lec_priv_walk(struct atm_lec_state *state, loff_t *l,
+			       struct lec_priv *priv)
+{
+	if (!state->locked) {
+		state->locked = priv;
+		spin_lock_irqsave(&priv->lec_arp_lock, state->flags);
+	}
+	if (!atm_lec_arp_walk(state, l, priv) &&
+	    !atm_lec_misc_walk(state, l, priv)) {
+		spin_unlock_irqrestore(&priv->lec_arp_lock, state->flags);
+		state->locked = NULL;
+	}
+	return state->locked;
+}
+
+static void *atm_lec_itf_walk(struct atm_lec_state *state, loff_t *l)
+{
+	struct net_device *dev;
+	void *v;
+
+	dev = state->dev ? state->dev : atm_lane_ops->get_lec(state->itf);
+	v = (dev && dev->priv) ? atm_lec_priv_walk(state, l, dev->priv) : NULL;
+	if (!v && dev) {
 		dev_put(dev);
+		dev = NULL;
+	}
+	state->dev = dev;
+	return v;
+}
+
+static void *atm_lec_get_idx(struct atm_lec_state *state, loff_t l)
+{
+	void *v = NULL;
+
+	for (; state->itf < MAX_LEC_ITF; state->itf++) {
+		v = atm_lec_itf_walk(state, &l);
+		if (v)
+			break;
+	}
+	return v; 
+}
+
+static void *atm_lec_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct atm_lec_state *state = seq->private;
+
+	state->itf = 0;
+	state->dev = NULL;
+	state->locked = NULL;
+	state->arp_table = 0;
+	state->misc_table = 0;
+	state->entry = (void *)1;
+
+	return *pos ? atm_lec_get_idx(state, *pos) : (void*)1;
+}
+
+static void atm_lec_seq_stop(struct seq_file *seq, void *v)
+{
+	struct atm_lec_state *state = seq->private;
+
+	if (state->dev) {
+		spin_unlock_irqrestore(&state->locked->lec_arp_lock,
+				       state->flags);
+		dev_put(state->dev);
+	}
+}
+
+static void *atm_lec_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct atm_lec_state *state = seq->private;
+
+	v = atm_lec_get_idx(state, 1);
+	*pos += !!PTR_ERR(v);
+	return v;
+}
+
+static int atm_lec_seq_show(struct seq_file *seq, void *v)
+{
+	static char atm_lec_banner[] = "Itf  MAC          ATM destination" 
+		"                          Status            Flags "
+		"VPI/VCI Recv VPI/VCI\n";
+
+	if (v == (void *)1)
+		seq_puts(seq, atm_lec_banner);
+	else {
+		struct atm_lec_state *state = seq->private;
+		struct net_device *dev = state->dev; 
+
+		seq_printf(seq, "%s ", dev->name);
+		lec_info(seq, state->entry);
 	}
-	module_put(atm_lane_ops->owner);
 	return 0;
 }
-#endif
 
+static struct seq_operations atm_lec_seq_ops = {
+	.start	= atm_lec_seq_start,
+	.next	= atm_lec_seq_next,
+	.stop	= atm_lec_seq_stop,
+	.show	= atm_lec_seq_show,
+};
+
+static int atm_lec_seq_open(struct inode *inode, struct file *file)
+{
+	struct atm_lec_state *state;
+	struct seq_file *seq;
+	int rc = -EAGAIN;
+
+	if (!try_atm_lane_ops())
+		goto out;
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = seq_open(file, &atm_lec_seq_ops);
+	if (rc)
+		goto out_kfree;
+	seq = file->private_data;
+	seq->private = state;
+out:
+	return rc;
+out_kfree:
+	kfree(state);
+	goto out;
+}
+
+static int atm_lec_seq_release(struct inode *inode, struct file *file)
+{
+	module_put(atm_lane_ops->owner);
+	return seq_release_private(inode, file);
+}
+
+static struct file_operations atm_seq_lec_fops = {
+	.open		= atm_lec_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= atm_lec_seq_release,
+};
+
+#endif /* CONFIG_ATM_LANE */
 
 static ssize_t proc_dev_atm_read(struct file *file,char *buf,size_t count,
     loff_t *pos)
@@ -912,7 +1038,7 @@ int __init atm_proc_init(void)
 	CREATE_SEQ_ENTRY(arp);
 #endif
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
-	CREATE_ENTRY(lec);
+	CREATE_SEQ_ENTRY(lec);
 #endif
 	return 0;
 

_
