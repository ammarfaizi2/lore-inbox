Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbSKXChi>; Sat, 23 Nov 2002 21:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267142AbSKXChi>; Sat, 23 Nov 2002 21:37:38 -0500
Received: from 5-005.ctame701-2.telepar.net.br ([200.181.169.5]:11015 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267137AbSKXCha>; Sat, 23 Nov 2002 21:37:30 -0500
Date: Sun, 24 Nov 2002 00:00:46 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tcpv4: convert /proc/net/tcp to seq_file
Message-ID: <20021124020046.GA29645@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Handle with care and please pull from:

master.kernel.org:/home/acme/BK/net-2.5

	Now there are two outstanding changesets :-)

- Arnaldo


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.859, 2002-11-23 23:49:24-02:00, acme@conectiva.com.br
  o tcpv4: convert /proc/net/tcp to seq_file


 af_inet.c  |    7 
 tcp_ipv4.c |  480 +++++++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 365 insertions(+), 122 deletions(-)


diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Sat Nov 23 23:56:58 2002
+++ b/net/ipv4/af_inet.c	Sat Nov 23 23:56:58 2002
@@ -1165,7 +1165,8 @@
 extern int  ip_misc_proc_init(void);
 extern int  raw_proc_init(void);
 extern void raw_proc_exit(void);
-extern int  tcp_get_info(char *buffer, char **start, off_t offset, int length);
+extern int  tcp_proc_init(void);
+extern void tcp_proc_exit(void);
 extern int  udp_proc_init(void);
 extern void udp_proc_exit(void);
 
@@ -1175,7 +1176,7 @@
 
 	if (raw_proc_init())
 		goto out_raw;
-	if (!proc_net_create("tcp", 0, tcp_get_info))
+	if (tcp_proc_init())
 		goto out_tcp;
 	if (udp_proc_init())
 		goto out_udp;
@@ -1190,7 +1191,7 @@
 out_fib:
 	udp_proc_exit();
 out_udp:
-	proc_net_remove("tcp");
+	tcp_proc_exit();
 out_tcp:
 	raw_proc_exit();
 out_raw:
diff -Nru a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c	Sat Nov 23 23:56:58 2002
+++ b/net/ipv4/tcp_ipv4.c	Sat Nov 23 23:56:58 2002
@@ -69,6 +69,8 @@
 #include <linux/inet.h>
 #include <linux/ipv6.h>
 #include <linux/stddef.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 extern int sysctl_ip_dynaddr;
 extern int sysctl_ip_default_ttl;
@@ -2131,7 +2133,295 @@
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
 /* Proc filesystem TCP sock list dumping. */
+
+enum tcp_seq_states {
+	TCP_SEQ_STATE_LISTENING,
+	TCP_SEQ_STATE_OPENREQ,
+	TCP_SEQ_STATE_ESTABLISHED,
+	TCP_SEQ_STATE_TIME_WAIT,
+};
+
+struct tcp_iter_state {
+	enum tcp_seq_states state;
+	struct sock	   *syn_wait_sk;
+	int		    bucket, sbucket, num, uid;
+};
+
+static void *listening_get_first(struct seq_file *seq)
+{
+	struct tcp_iter_state* st = seq->private;
+	void *rc = NULL;
+
+	for (st->bucket = 0; st->bucket < TCP_LHTABLE_SIZE; ++st->bucket) {
+		struct open_request *req;
+		struct tcp_opt *tp;
+		struct sock *sk = tcp_listening_hash[st->bucket];
+
+		if (!sk)
+			continue;
+		++st->num;
+		if (TCP_INET_FAMILY(sk->family)) {
+			rc = sk;
+			goto out;
+		}
+	       	tp = tcp_sk(sk);
+		read_lock_bh(&tp->syn_wait_lock);
+		if (tp->listen_opt && tp->listen_opt->qlen) {
+			st->uid		= sock_i_uid(sk);
+			st->syn_wait_sk = sk;
+			st->state	= TCP_SEQ_STATE_OPENREQ;
+			for (st->sbucket = 0; st->sbucket < TCP_SYNQ_HSIZE;
+			     ++st->sbucket) {
+				for (req = tp->listen_opt->syn_table[st->sbucket];
+				     req; req = req->dl_next, ++st->num) {
+					if (!TCP_INET_FAMILY(req->class->family))
+						continue;
+					rc = req;
+					goto out;
+				}
+			}
+			st->state = TCP_SEQ_STATE_LISTENING;
+		}
+		read_unlock_bh(&tp->syn_wait_lock);
+	}
+out:
+	return rc;
+}
+
+static void *listening_get_next(struct seq_file *seq, void *cur)
+{
+	struct tcp_opt *tp;
+	struct sock *sk = cur;
+	struct tcp_iter_state* st = seq->private;
+
+	if (st->state == TCP_SEQ_STATE_OPENREQ) {
+		struct open_request *req = cur;
+
+	       	tp = tcp_sk(st->syn_wait_sk);
+		req = req->dl_next;
+		while (1) {
+			while (req) {
+				++st->num;
+				if (TCP_INET_FAMILY(req->class->family)) {
+					cur = req;
+					goto out;
+				}
+				req = req->dl_next;
+			}
+			if (++st->sbucket >= TCP_SYNQ_HSIZE)
+				break;
+get_req:
+			req = tp->listen_opt->syn_table[st->sbucket];
+		}
+		sk	  = st->syn_wait_sk->next;
+		st->state = TCP_SEQ_STATE_LISTENING;
+		read_unlock_bh(&tp->syn_wait_lock);
+	} else
+		sk = sk->next;
+get_sk:
+	while (sk) {
+		if (TCP_INET_FAMILY(sk->family)) {
+			cur = sk;
+			goto out;
+		}
+	       	tp = tcp_sk(sk);
+		read_lock_bh(&tp->syn_wait_lock);
+		if (tp->listen_opt && tp->listen_opt->qlen) {
+			st->uid		= sock_i_uid(sk);
+			st->syn_wait_sk = sk;
+			st->state	= TCP_SEQ_STATE_OPENREQ;
+			st->sbucket	= 0;
+			goto get_req;
+		}
+		read_unlock_bh(&tp->syn_wait_lock);
+	}
+	if (++st->bucket < TCP_LHTABLE_SIZE) {
+		sk = tcp_listening_hash[st->bucket];
+		goto get_sk;
+	}
+	cur = NULL;
+out:
+	return cur;
+}
+
+static void *listening_get_idx(struct seq_file *seq, loff_t *pos)
+{
+	void *rc = listening_get_first(seq);
+
+	if (rc)
+		while (*pos && (rc = listening_get_next(seq, rc)))
+			--*pos;
+	return *pos ? NULL : rc;
+}
+
+static void *established_get_first(struct seq_file *seq)
+{
+	struct tcp_iter_state* st = seq->private;
+	void *rc = NULL;
+
+	for (st->bucket = 0; st->bucket < tcp_ehash_size; ++st->bucket) {
+		struct sock *sk;
+		struct tcp_tw_bucket *tw;
+	       
+		read_lock(&tcp_ehash[st->bucket].lock);
+		for (sk = tcp_ehash[st->bucket].chain; sk;
+		     sk = sk->next, ++st->num) {
+			if (!TCP_INET_FAMILY(sk->family))
+				continue;
+			rc = sk;
+			goto out;
+		}
+		st->state = TCP_SEQ_STATE_TIME_WAIT;
+		for (tw = (struct tcp_tw_bucket *)
+				tcp_ehash[st->bucket + tcp_ehash_size].chain;
+		     tw; tw = (struct tcp_tw_bucket *)tw->next, ++st->num) {
+			if (!TCP_INET_FAMILY(tw->family))
+				continue;
+			rc = tw;
+			goto out;
+		}
+		read_unlock(&tcp_ehash[st->bucket].lock);
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+	}
+out:
+	return rc;
+}
+
+static void *established_get_next(struct seq_file *seq, void *cur)
+{
+	struct sock *sk = cur;
+	struct tcp_tw_bucket *tw;
+	struct tcp_iter_state* st = seq->private;
+
+	if (st->state == TCP_SEQ_STATE_TIME_WAIT) {
+		tw = cur;
+		tw = (struct tcp_tw_bucket *)tw->next;
+get_tw:
+		while (tw && !TCP_INET_FAMILY(tw->family)) {
+			++st->num;
+			tw = (struct tcp_tw_bucket *)tw->next;
+		}
+		if (tw) {
+			cur = tw;
+			goto out;
+		}
+		read_unlock(&tcp_ehash[st->bucket].lock);
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		if (++st->bucket < tcp_ehash_size) {
+			read_lock(&tcp_ehash[st->bucket].lock);
+			sk = tcp_ehash[st->bucket].chain;
+		} else {
+			cur = NULL;
+			goto out;
+		}
+	} else
+		sk = sk->next;
+
+	while (sk && !TCP_INET_FAMILY(sk->family)) {
+		++st->num;
+		sk = sk->next;
+	}
+	if (!sk) {
+		st->state = TCP_SEQ_STATE_TIME_WAIT;
+		tw = (struct tcp_tw_bucket *)
+				tcp_ehash[st->bucket + tcp_ehash_size].chain;
+		goto get_tw;
+	}
+	cur = sk;
+out:
+	return cur;
+}
+
+static void *established_get_idx(struct seq_file *seq, loff_t pos)
+{
+	void *rc = established_get_first(seq);
+
+	if (rc)
+		while (pos && (rc = established_get_next(seq, rc)))
+			--pos;
+	return pos ? NULL : rc;
+}
+
+static void *tcp_get_idx(struct seq_file *seq, loff_t pos)
+{
+	void *rc;
+	struct tcp_iter_state* st = seq->private;
+
+	tcp_listen_lock();
+	st->state = TCP_SEQ_STATE_LISTENING;
+	rc	  = listening_get_idx(seq, &pos);
+
+	if (!rc) {
+		tcp_listen_unlock();
+		local_bh_disable();
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		rc	  = established_get_idx(seq, pos);
+	}
+
+	return rc;
+}
+
+static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	return *pos ? tcp_get_idx(seq, *pos - 1) : (void *)1;
+}
+
+static void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	void *rc = NULL;
+	struct tcp_iter_state* st;
+
+	if (v == (void *)1) {
+		rc = tcp_get_idx(seq, 0);
+		goto out;
+	}
+	st = seq->private;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_OPENREQ:
+	case TCP_SEQ_STATE_LISTENING:
+		rc = listening_get_next(seq, v);
+		if (!rc) {
+			tcp_listen_unlock();
+			local_bh_disable();
+			st->state = TCP_SEQ_STATE_ESTABLISHED;
+			rc	  = established_get_first(seq);
+		}
+		break;
+	case TCP_SEQ_STATE_ESTABLISHED:
+	case TCP_SEQ_STATE_TIME_WAIT:
+		rc = established_get_next(seq, v);
+		break;
+	}
+out:
+	++*pos;
+	return rc;
+}
+
+static void tcp_seq_stop(struct seq_file *seq, void *v)
+{
+	struct tcp_iter_state* st = seq->private;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_OPENREQ:
+		if (v) {
+			struct tcp_opt *tp = tcp_sk(st->syn_wait_sk);
+			read_unlock_bh(&tp->syn_wait_lock);
+		}
+	case TCP_SEQ_STATE_LISTENING:
+		tcp_listen_unlock();
+		break;
+	case TCP_SEQ_STATE_TIME_WAIT:
+	case TCP_SEQ_STATE_ESTABLISHED:
+		if (v)
+			read_unlock(&tcp_ehash[st->bucket].lock);
+		local_bh_enable();
+		break;
+	}
+}
+
 static void get_openreq(struct sock *sk, struct open_request *req,
 			char *tmpbuf, int i, int uid)
 {
@@ -2219,137 +2509,89 @@
 
 #define TMPSZ 150
 
-int tcp_get_info(char *buffer, char **start, off_t offset, int length)
+static int tcp_seq_show(struct seq_file *seq, void *v)
 {
-	int len = 0, num = 0, i;
-	off_t begin, pos = 0;
+	struct tcp_iter_state* st;
 	char tmpbuf[TMPSZ + 1];
 
-	if (offset < TMPSZ)
-		len += sprintf(buffer, "%-*s\n", TMPSZ - 1,
-			       "  sl  local_address rem_address   st tx_queue "
-			       "rx_queue tr tm->when retrnsmt   uid  timeout "
-			       "inode");
-
-	pos = TMPSZ;
-
-	/* First, walk listening socket table. */
-	tcp_listen_lock();
-	for (i = 0; i < TCP_LHTABLE_SIZE; i++) {
-		struct sock *sk;
-		struct tcp_listen_opt *lopt;
-		int k;
-
-		for (sk = tcp_listening_hash[i]; sk; sk = sk->next, num++) {
-			struct open_request *req;
-			int uid;
-			struct tcp_opt *tp = tcp_sk(sk);
-
-			if (!TCP_INET_FAMILY(sk->family))
-				goto skip_listen;
+	if (v == (void *)1) {
+		seq_printf(seq, "%-*s\n", TMPSZ - 1,
+			   "  sl  local_address rem_address   st tx_queue "
+			   "rx_queue tr tm->when retrnsmt   uid  timeout "
+			   "inode");
+		goto out;
+	}
+	st = seq->private;
 
-			pos += TMPSZ;
-			if (pos >= offset) {
-				get_tcp_sock(sk, tmpbuf, num);
-				len += sprintf(buffer + len, "%-*s\n",
-					       TMPSZ - 1, tmpbuf);
-				if (pos >= offset + length) {
-					tcp_listen_unlock();
-					goto out_no_bh;
-				}
-			}
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+	case TCP_SEQ_STATE_ESTABLISHED:
+		get_tcp_sock(v, tmpbuf, st->num);
+		break;
+	case TCP_SEQ_STATE_OPENREQ:
+		get_openreq(st->syn_wait_sk, v, tmpbuf, st->num, st->uid);
+		break;
+	case TCP_SEQ_STATE_TIME_WAIT:
+		get_timewait_sock(v, tmpbuf, st->num);
+		break;
+	}
+	seq_printf(seq, "%-*s\n", TMPSZ - 1, tmpbuf);
+out:
+	return 0;
+}
 
-skip_listen:
-			uid = sock_i_uid(sk);
-			read_lock_bh(&tp->syn_wait_lock);
-			lopt = tp->listen_opt;
-			if (lopt && lopt->qlen) {
-				for (k = 0; k < TCP_SYNQ_HSIZE; k++) {
-					for (req = lopt->syn_table[k];
-					     req; req = req->dl_next, num++) {
-						if (!TCP_INET_FAMILY(req->class->family))
-							continue;
-
-						pos += TMPSZ;
-						if (pos <= offset)
-							continue;
-						get_openreq(sk, req, tmpbuf,
-							    num, uid);
-						len += sprintf(buffer + len,
-							       "%-*s\n",
-							       TMPSZ - 1,
-							       tmpbuf);
-						if (pos >= offset + length) {
-							read_unlock_bh(&tp->syn_wait_lock);
-							tcp_listen_unlock();
-							goto out_no_bh;
-						}
-					}
-				}
-			}
-			read_unlock_bh(&tp->syn_wait_lock);
+static struct seq_operations tcp_seq_ops = {
+	.start  = tcp_seq_start,
+	.next   = tcp_seq_next,
+	.stop   = tcp_seq_stop,
+	.show   = tcp_seq_show,
+};
 
-			/* Completed requests are in normal socket hash table */
-		}
-	}
-	tcp_listen_unlock();
+static int tcp_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct tcp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
 
-	local_bh_disable();
+	if (!s)
+		goto out;
+	rc = seq_open(file, &tcp_seq_ops);
+	if (rc)
+		goto out_kfree;
+	seq	     = file->private_data;
+	seq->private = s;
+	memset(s, 0, sizeof(*s));
+out:
+	return rc;
+out_kfree:
+	kfree(s);
+	goto out;
+}
 
-	/* Next, walk established hash chain. */
-	for (i = 0; i < tcp_ehash_size; i++) {
-		struct tcp_ehash_bucket *head = &tcp_ehash[i];
-		struct sock *sk;
-		struct tcp_tw_bucket *tw;
+static struct file_operations tcp_seq_fops = {
+	.open           = tcp_seq_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release	= ip_seq_release,
+};
 
-		read_lock(&head->lock);
-		for (sk = head->chain; sk; sk = sk->next, num++) {
-			if (!TCP_INET_FAMILY(sk->family))
-				continue;
-			pos += TMPSZ;
-			if (pos <= offset)
-				continue;
-			get_tcp_sock(sk, tmpbuf, num);
-			len += sprintf(buffer + len, "%-*s\n",
-				       TMPSZ - 1, tmpbuf);
-			if (pos >= offset + length) {
-				read_unlock(&head->lock);
-				goto out;
-			}
-		}
-		for (tw = (struct tcp_tw_bucket *)tcp_ehash[i +
-							  tcp_ehash_size].chain;
-		     tw;
-		     tw = (struct tcp_tw_bucket *)tw->next, num++) {
-			if (!TCP_INET_FAMILY(tw->family))
-				continue;
-			pos += TMPSZ;
-			if (pos <= offset)
-				continue;
-			get_timewait_sock(tw, tmpbuf, num);
-			len += sprintf(buffer + len, "%-*s\n",
-				       TMPSZ - 1, tmpbuf);
-			if (pos >= offset + length) {
-				read_unlock(&head->lock);
-				goto out;
-			}
-		}
-		read_unlock(&head->lock);
-	}
+int __init tcp_proc_init(void)
+{
+	int rc = 0;
+	struct proc_dir_entry *p = create_proc_entry("tcp", S_IRUGO, proc_net);
 
-out:
-	local_bh_enable();
-out_no_bh:
+	if (p)
+		p->proc_fops = &tcp_seq_fops;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
 
-	begin = len - (pos - offset);
-	*start = buffer + begin;
-	len -= begin;
-	if (len > length)
-		len = length;
-	if (len < 0)
-		len = 0;
-	return len;
+void __init tcp_proc_exit(void)
+{
+	remove_proc_entry("tcp", proc_net);
 }
+#endif /* CONFIG_PROC_FS */
 
 struct proto tcp_prot = {
 	.name =		"TCP",

===================================================================


This BitKeeper patch contains the following changesets:
1.859
## Wrapped with gzip_uu ##


begin 664 bkpatch2986
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
:]9P]I?8L6"T&U+:UB6VWY?\`O0XPMI@G````
`
end
