Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272002AbTHHWY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272121AbTHHWY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:24:26 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:57860 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272002AbTHHWYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:24:03 -0400
Date: Sat, 9 Aug 2003 00:15:42 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 6/8] 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm (arp)
Message-ID: <20030809001541.G2699@electric-eye.fr.zoreil.com>
References: <20030809000303.A2699@electric-eye.fr.zoreil.com> <20030809000633.B2699@electric-eye.fr.zoreil.com> <20030809000841.C2699@electric-eye.fr.zoreil.com> <20030809001013.D2699@electric-eye.fr.zoreil.com> <20030809001139.E2699@electric-eye.fr.zoreil.com> <20030809001321.F2699@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030809001321.F2699@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Aug 09, 2003 at 12:13:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file support for /proc/net/atm/arp:
- svc_addr/atmarp_info(): seq_printf/seq_putc replace sprintf and friends;
- atm_arp_getidx/atm_arp_vc_walk() take care of the usual seq_file cursor
  positionning: they both return NULL until the cursor has reached its
  position. struct atm_arp_state is updated accordingly;
- atm_arp_seq_{stop/start} are responsible for clip_tbl_hook (un)locking;
- module refcounting is done in atm_arp_seq_open()/atm_arp_seq_release();


 net/atm/proc.c |  269 +++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 185 insertions(+), 84 deletions(-)

diff -puN net/atm/proc.c~atm-proc-seq-arp-conversion net/atm/proc.c
--- linux-2.6.0-test2-bk8/net/atm/proc.c~atm-proc-seq-arp-conversion	Fri Aug  8 20:29:30 2003
+++ linux-2.6.0-test2-bk8-fr/net/atm/proc.c	Fri Aug  8 20:29:30 2003
@@ -91,75 +91,67 @@ static void atm_dev_info(struct seq_file
 
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 
-
-static int svc_addr(char *buf,struct sockaddr_atmsvc *addr)
+static void svc_addr(struct seq_file *seq, struct sockaddr_atmsvc *addr)
 {
 	static int code[] = { 1,2,10,6,1,0 };
 	static int e164[] = { 1,8,4,6,1,0 };
-	int *fields;
-	int len,i,j,pos;
 
-	len = 0;
 	if (*addr->sas_addr.pub) {
-		strcpy(buf,addr->sas_addr.pub);
-		len = strlen(addr->sas_addr.pub);
-		buf += len;
-		if (*addr->sas_addr.prv) {
-			*buf++ = '+';
-			len++;
-		}
+		seq_printf(seq, "%s", addr->sas_addr.pub);
+		if (*addr->sas_addr.prv)
+			seq_putc(seq, '+');
+	} else if (!*addr->sas_addr.prv) {
+		seq_printf(seq, "%s", "(none)");
+		return;
 	}
-	else if (!*addr->sas_addr.prv) {
-			strcpy(buf,"(none)");
-			return strlen(buf);
-		}
 	if (*addr->sas_addr.prv) {
-		len += 44;
-		pos = 0;
-		fields = *addr->sas_addr.prv == ATM_AFI_E164 ? e164 : code;
+		unsigned char *prv = addr->sas_addr.prv;
+		int *fields;
+		int i, j;
+
+		fields = *prv == ATM_AFI_E164 ? e164 : code;
 		for (i = 0; fields[i]; i++) {
-			for (j = fields[i]; j; j--) {
-				sprintf(buf,"%02X",addr->sas_addr.prv[pos++]);
-				buf += 2;
-			}
-			if (fields[i+1]) *buf++ = '.';
+			for (j = fields[i]; j; j--)
+				seq_printf(seq, "%02X", *prv++);
+			if (fields[i+1])
+				seq_putc(seq, '.');
 		}
 	}
-	return len;
 }
 
-
-static void atmarp_info(struct net_device *dev,struct atmarp_entry *entry,
-    struct clip_vcc *clip_vcc,char *buf)
+static void atmarp_info(struct seq_file *seq, struct net_device *dev,
+			struct atmarp_entry *entry, struct clip_vcc *clip_vcc)
 {
-	unsigned char *ip;
-	int svc,off,ip_len;
+	char buf[17];
+	int svc, off;
 
 	svc = !clip_vcc || clip_vcc->vcc->sk->sk_family == AF_ATMSVC;
-	off = sprintf(buf,"%-6s%-4s%-4s%5ld ",dev->name,svc ? "SVC" : "PVC",
+	seq_printf(seq, "%-6s%-4s%-4s%5ld ", dev->name, svc ? "SVC" : "PVC",
 	    !clip_vcc || clip_vcc->encap ? "LLC" : "NULL",
-	    (jiffies-(clip_vcc ? clip_vcc->last_use : entry->neigh->used))/
-	    HZ);
-	ip = (unsigned char *) &entry->ip;
-	ip_len = sprintf(buf+off,"%d.%d.%d.%d",ip[0],ip[1],ip[2],ip[3]);
-	off += ip_len;
-	while (ip_len++ < 16) buf[off++] = ' ';
-	if (!clip_vcc)
+	    (jiffies-(clip_vcc ? clip_vcc->last_use : entry->neigh->used))/HZ);
+
+	off = snprintf(buf, sizeof(buf) - 1, "%d.%d.%d.%d", NIPQUAD(entry->ip));
+	while (off < 16)
+		buf[off++] = ' ';
+	buf[off] = '\0';
+	seq_printf(seq, "%s", buf);
+
+	if (!clip_vcc) {
 		if (time_before(jiffies, entry->expires))
-			strcpy(buf+off,"(resolving)\n");
-		else sprintf(buf+off,"(expired, ref %d)\n",
-			    atomic_read(&entry->neigh->refcnt));
-	else if (!svc)
-			sprintf(buf+off,"%d.%d.%d\n",clip_vcc->vcc->dev->number,
-			    clip_vcc->vcc->vpi,clip_vcc->vcc->vci);
-		else {
-			off += svc_addr(buf+off,&clip_vcc->vcc->remote);
-			strcpy(buf+off,"\n");
-		}
+			seq_printf(seq, "(resolving)\n");
+		else
+			seq_printf(seq, "(expired, ref %d)\n",
+				   atomic_read(&entry->neigh->refcnt));
+	} else if (!svc) {
+		seq_printf(seq, "%d.%d.%d\n", clip_vcc->vcc->dev->number,
+			   clip_vcc->vcc->vpi, clip_vcc->vcc->vci);
+	} else {
+		svc_addr(seq, &clip_vcc->vcc->remote);
+		seq_putc(seq, '\n');
+	}
 }
 
-
-#endif
+#endif /* CONFIG_ATM_CLIP */
 
 struct atm_vc_state {
 	struct sock *sk;
@@ -561,45 +553,154 @@ static struct file_operations atm_seq_sv
 };
 
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-static int atm_arp_info(loff_t pos,char *buf)
+
+struct atm_arp_state {
+	int bucket;
+  	struct neighbour *n;
+	struct clip_vcc *vcc;
+};
+  
+static void *atm_arp_vc_walk(struct atm_arp_state *state,
+			     struct atmarp_entry *e, loff_t *l)
+{
+	struct clip_vcc *vcc = state->vcc;
+
+	if (!vcc)
+		vcc = e->vccs;
+	if (vcc == (void *)1) {
+		vcc = e->vccs;
+		--*l;
+  	}
+	for (; vcc; vcc = vcc->next) {
+		if (--*l < 0)
+			break;
+	}
+	state->vcc = vcc;
+	return (*l < 0) ? state : NULL;
+}
+  
+static void *atm_arp_get_idx(struct atm_arp_state *state, loff_t l)
 {
-	struct neighbour *n;
-	int i,count;
+	void *v = NULL;
 
-	if (!pos) {
-		return sprintf(buf,"IPitf TypeEncp Idle IP address      "
-		    "ATM address\n");
+	for (; state->bucket <= NEIGH_HASHMASK; state->bucket++) {
+		for (; state->n; state->n = state->n->next) {
+			v = atm_arp_vc_walk(state, NEIGH2ENTRY(state->n), &l);
+			if (v)
+				goto done;
+  		}
+		state->n = clip_tbl_hook->hash_buckets[state->bucket + 1];
 	}
-	if (!try_atm_clip_ops())
-		return 0;
-	count = pos;
+done:
+	return v;
+}
+
+static void *atm_arp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct atm_arp_state *state = seq->private;
+	void *ret = (void *)1;
+
+	if (!clip_tbl_hook) {
+		state->bucket = -1;
+		goto out;
+	}
+
 	read_lock_bh(&clip_tbl_hook->lock);
-	for (i = 0; i <= NEIGH_HASHMASK; i++)
-		for (n = clip_tbl_hook->hash_buckets[i]; n; n = n->next) {
-			struct atmarp_entry *entry = NEIGH2ENTRY(n);
-			struct clip_vcc *vcc;
-
-			if (!entry->vccs) {
-				if (--count) continue;
-				atmarp_info(n->dev,entry,NULL,buf);
-				read_unlock_bh(&clip_tbl_hook->lock);
-				module_put(atm_clip_ops->owner);
-				return strlen(buf);
-			}
-			for (vcc = entry->vccs; vcc;
-			    vcc = vcc->next) {
-				if (--count) continue;
-				atmarp_info(n->dev,entry,vcc,buf);
-				read_unlock_bh(&clip_tbl_hook->lock);
-				module_put(atm_clip_ops->owner);
-				return strlen(buf);
-			}
-		}
-	read_unlock_bh(&clip_tbl_hook->lock);
+	state->bucket = 0;
+	state->n = clip_tbl_hook->hash_buckets[0];
+	state->vcc = (void *)1;
+	if (*pos)
+		ret = atm_arp_get_idx(state, *pos);
+out:
+	return ret;
+}
+
+static void atm_arp_seq_stop(struct seq_file *seq, void *v)
+{
+	struct atm_arp_state *state = seq->private;
+
+	if (state->bucket != -1)
+		read_unlock_bh(&clip_tbl_hook->lock);
+}
+
+static void *atm_arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct atm_arp_state *state = seq->private;
+
+	v = atm_arp_get_idx(state, 1);
+	*pos += !!PTR_ERR(v);
+	return v;
+}
+
+static int atm_arp_seq_show(struct seq_file *seq, void *v)
+{
+	static char atm_arp_banner[] = 
+		"IPitf TypeEncp Idle IP address      ATM address\n";
+
+	if (v == (void *)1)
+		seq_puts(seq, atm_arp_banner);
+	else {
+		struct atm_arp_state *state = seq->private;
+		struct neighbour *n = state->n;	
+		struct clip_vcc *vcc = state->vcc;
+
+		atmarp_info(seq, n->dev, NEIGH2ENTRY(n), vcc);
+	}
+  	return 0;
+}
+
+static struct seq_operations atm_arp_seq_ops = {
+	.start	= atm_arp_seq_start,
+	.next	= atm_arp_seq_next,
+	.stop	= atm_arp_seq_stop,
+	.show	= atm_arp_seq_show,
+};
+
+static int atm_arp_seq_open(struct inode *inode, struct file *file)
+{
+	struct atm_arp_state *state;
+	struct seq_file *seq;
+	int rc = -EAGAIN;
+
+	if (!try_atm_clip_ops())
+		goto out;
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state) {
+		rc = -ENOMEM;
+		goto out_put;
+	}
+
+	rc = seq_open(file, &atm_arp_seq_ops);
+	if (rc)
+		goto out_kfree;
+
+	seq = file->private_data;
+	seq->private = state;
+out:
+	return rc;
+
+out_put:
 	module_put(atm_clip_ops->owner);
-	return 0;
+out_kfree:
+	kfree(state);
+	goto out;
 }
-#endif
+
+static int atm_arp_seq_release(struct inode *inode, struct file *file)
+{
+	module_put(atm_clip_ops->owner);
+	return seq_release_private(inode, file);
+}
+
+static struct file_operations atm_seq_arp_fops = {
+	.open		= atm_arp_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= atm_arp_seq_release,
+};
+
+#endif /* CONFIG_ATM_CLIP */
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 static int atm_lec_info(loff_t pos,char *buf)
@@ -808,7 +909,7 @@ int __init atm_proc_init(void)
 	CREATE_SEQ_ENTRY(svc);
 	CREATE_SEQ_ENTRY(vc);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-	CREATE_ENTRY(arp);
+	CREATE_SEQ_ENTRY(arp);
 #endif
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 	CREATE_ENTRY(lec);

_
