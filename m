Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbSLSXIl>; Thu, 19 Dec 2002 18:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267644AbSLSXIl>; Thu, 19 Dec 2002 18:08:41 -0500
Received: from dhcp024-210-222-139.woh.rr.com ([24.210.222.139]:18221 "EHLO
	mail.tacomeat.net") by vger.kernel.org with ESMTP
	id <S267639AbSLSXI2>; Thu, 19 Dec 2002 18:08:28 -0500
Date: Thu, 19 Dec 2002 18:19:21 -0500 (EST)
Message-Id: <20021219.181921.41185800.hoho@tacomeat.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.5.52-bk4
From: Colin Slater <hoho@tacomeat.net>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If I try to open (to view) /proc/net/tcp in midnight commander then
> the midnight commander freezes in kernel (cannot be killed) with 99%
> CPU usage.

> I do not see any disk_io line in /proc/stat although I have /dev/hda
> as primary disk. Maybe because I'm using boot_off first and
> ide=reverse. So real /dev/hda does not exist and /dev/hde is as
> /dev/hda.

I've been having a bit of trouble with /proc/net/tcp too. This patch
seemed to work for me. If this works then it's time to bug Arnaldo
some more.

 Colin


===== af_inet.c 1.36 vs edited =====
--- 1.36/net/ipv4/af_inet.c	Sun Nov 24 20:15:49 2002
+++ edited/af_inet.c	Thu Dec 19 18:09:38 2002
@@ -1163,8 +1163,7 @@
 extern int  ip_misc_proc_init(void);
 extern int  raw_proc_init(void);
 extern void raw_proc_exit(void);
-extern int  tcp_proc_init(void);
-extern void tcp_proc_exit(void);
+extern int  tcp_get_info(char *buffer, char **start, off_t offset, int length);
 extern int  udp_proc_init(void);
 extern void udp_proc_exit(void);
 
@@ -1174,7 +1173,7 @@
 
 	if (raw_proc_init())
 		goto out_raw;
-	if (tcp_proc_init())
+	if (!proc_net_create("tcp", 0, tcp_get_info))
 		goto out_tcp;
 	if (udp_proc_init())
 		goto out_udp;
@@ -1189,7 +1188,7 @@
 out_fib:
 	udp_proc_exit();
 out_udp:
-	tcp_proc_exit();
+	proc_net_remove("tcp");
 out_tcp:
 	raw_proc_exit();
 out_raw:
===== tcp_ipv4.c 1.37 vs edited =====
--- 1.37/net/ipv4/tcp_ipv4.c	Sat Nov 23 20:49:20 2002
+++ edited/tcp_ipv4.c	Thu Dec 19 18:09:40 2002
@@ -69,8 +69,6 @@
 #include <linux/inet.h>
 #include <linux/ipv6.h>
 #include <linux/stddef.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 
 extern int sysctl_ip_dynaddr;
 extern int sysctl_ip_default_ttl;
@@ -2133,295 +2131,7 @@
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
 /* Proc filesystem TCP sock list dumping. */
-
-enum tcp_seq_states {
-	TCP_SEQ_STATE_LISTENING,
-	TCP_SEQ_STATE_OPENREQ,
-	TCP_SEQ_STATE_ESTABLISHED,
-	TCP_SEQ_STATE_TIME_WAIT,
-};
-
-struct tcp_iter_state {
-	enum tcp_seq_states state;
-	struct sock	   *syn_wait_sk;
-	int		    bucket, sbucket, num, uid;
-};
-
-static void *listening_get_first(struct seq_file *seq)
-{
-	struct tcp_iter_state* st = seq->private;
-	void *rc = NULL;
-
-	for (st->bucket = 0; st->bucket < TCP_LHTABLE_SIZE; ++st->bucket) {
-		struct open_request *req;
-		struct tcp_opt *tp;
-		struct sock *sk = tcp_listening_hash[st->bucket];
-
-		if (!sk)
-			continue;
-		++st->num;
-		if (TCP_INET_FAMILY(sk->family)) {
-			rc = sk;
-			goto out;
-		}
-	       	tp = tcp_sk(sk);
-		read_lock_bh(&tp->syn_wait_lock);
-		if (tp->listen_opt && tp->listen_opt->qlen) {
-			st->uid		= sock_i_uid(sk);
-			st->syn_wait_sk = sk;
-			st->state	= TCP_SEQ_STATE_OPENREQ;
-			for (st->sbucket = 0; st->sbucket < TCP_SYNQ_HSIZE;
-			     ++st->sbucket) {
-				for (req = tp->listen_opt->syn_table[st->sbucket];
-				     req; req = req->dl_next, ++st->num) {
-					if (!TCP_INET_FAMILY(req->class->family))
-						continue;
-					rc = req;
-					goto out;
-				}
-			}
-			st->state = TCP_SEQ_STATE_LISTENING;
-		}
-		read_unlock_bh(&tp->syn_wait_lock);
-	}
-out:
-	return rc;
-}
-
-static void *listening_get_next(struct seq_file *seq, void *cur)
-{
-	struct tcp_opt *tp;
-	struct sock *sk = cur;
-	struct tcp_iter_state* st = seq->private;
-
-	if (st->state == TCP_SEQ_STATE_OPENREQ) {
-		struct open_request *req = cur;
-
-	       	tp = tcp_sk(st->syn_wait_sk);
-		req = req->dl_next;
-		while (1) {
-			while (req) {
-				++st->num;
-				if (TCP_INET_FAMILY(req->class->family)) {
-					cur = req;
-					goto out;
-				}
-				req = req->dl_next;
-			}
-			if (++st->sbucket >= TCP_SYNQ_HSIZE)
-				break;
-get_req:
-			req = tp->listen_opt->syn_table[st->sbucket];
-		}
-		sk	  = st->syn_wait_sk->next;
-		st->state = TCP_SEQ_STATE_LISTENING;
-		read_unlock_bh(&tp->syn_wait_lock);
-	} else
-		sk = sk->next;
-get_sk:
-	while (sk) {
-		if (TCP_INET_FAMILY(sk->family)) {
-			cur = sk;
-			goto out;
-		}
-	       	tp = tcp_sk(sk);
-		read_lock_bh(&tp->syn_wait_lock);
-		if (tp->listen_opt && tp->listen_opt->qlen) {
-			st->uid		= sock_i_uid(sk);
-			st->syn_wait_sk = sk;
-			st->state	= TCP_SEQ_STATE_OPENREQ;
-			st->sbucket	= 0;
-			goto get_req;
-		}
-		read_unlock_bh(&tp->syn_wait_lock);
-	}
-	if (++st->bucket < TCP_LHTABLE_SIZE) {
-		sk = tcp_listening_hash[st->bucket];
-		goto get_sk;
-	}
-	cur = NULL;
-out:
-	return cur;
-}
-
-static void *listening_get_idx(struct seq_file *seq, loff_t *pos)
-{
-	void *rc = listening_get_first(seq);
-
-	if (rc)
-		while (*pos && (rc = listening_get_next(seq, rc)))
-			--*pos;
-	return *pos ? NULL : rc;
-}
-
-static void *established_get_first(struct seq_file *seq)
-{
-	struct tcp_iter_state* st = seq->private;
-	void *rc = NULL;
-
-	for (st->bucket = 0; st->bucket < tcp_ehash_size; ++st->bucket) {
-		struct sock *sk;
-		struct tcp_tw_bucket *tw;
-	       
-		read_lock(&tcp_ehash[st->bucket].lock);
-		for (sk = tcp_ehash[st->bucket].chain; sk;
-		     sk = sk->next, ++st->num) {
-			if (!TCP_INET_FAMILY(sk->family))
-				continue;
-			rc = sk;
-			goto out;
-		}
-		st->state = TCP_SEQ_STATE_TIME_WAIT;
-		for (tw = (struct tcp_tw_bucket *)
-				tcp_ehash[st->bucket + tcp_ehash_size].chain;
-		     tw; tw = (struct tcp_tw_bucket *)tw->next, ++st->num) {
-			if (!TCP_INET_FAMILY(tw->family))
-				continue;
-			rc = tw;
-			goto out;
-		}
-		read_unlock(&tcp_ehash[st->bucket].lock);
-		st->state = TCP_SEQ_STATE_ESTABLISHED;
-	}
-out:
-	return rc;
-}
-
-static void *established_get_next(struct seq_file *seq, void *cur)
-{
-	struct sock *sk = cur;
-	struct tcp_tw_bucket *tw;
-	struct tcp_iter_state* st = seq->private;
-
-	if (st->state == TCP_SEQ_STATE_TIME_WAIT) {
-		tw = cur;
-		tw = (struct tcp_tw_bucket *)tw->next;
-get_tw:
-		while (tw && !TCP_INET_FAMILY(tw->family)) {
-			++st->num;
-			tw = (struct tcp_tw_bucket *)tw->next;
-		}
-		if (tw) {
-			cur = tw;
-			goto out;
-		}
-		read_unlock(&tcp_ehash[st->bucket].lock);
-		st->state = TCP_SEQ_STATE_ESTABLISHED;
-		if (++st->bucket < tcp_ehash_size) {
-			read_lock(&tcp_ehash[st->bucket].lock);
-			sk = tcp_ehash[st->bucket].chain;
-		} else {
-			cur = NULL;
-			goto out;
-		}
-	} else
-		sk = sk->next;
-
-	while (sk && !TCP_INET_FAMILY(sk->family)) {
-		++st->num;
-		sk = sk->next;
-	}
-	if (!sk) {
-		st->state = TCP_SEQ_STATE_TIME_WAIT;
-		tw = (struct tcp_tw_bucket *)
-				tcp_ehash[st->bucket + tcp_ehash_size].chain;
-		goto get_tw;
-	}
-	cur = sk;
-out:
-	return cur;
-}
-
-static void *established_get_idx(struct seq_file *seq, loff_t pos)
-{
-	void *rc = established_get_first(seq);
-
-	if (rc)
-		while (pos && (rc = established_get_next(seq, rc)))
-			--pos;
-	return pos ? NULL : rc;
-}
-
-static void *tcp_get_idx(struct seq_file *seq, loff_t pos)
-{
-	void *rc;
-	struct tcp_iter_state* st = seq->private;
-
-	tcp_listen_lock();
-	st->state = TCP_SEQ_STATE_LISTENING;
-	rc	  = listening_get_idx(seq, &pos);
-
-	if (!rc) {
-		tcp_listen_unlock();
-		local_bh_disable();
-		st->state = TCP_SEQ_STATE_ESTABLISHED;
-		rc	  = established_get_idx(seq, pos);
-	}
-
-	return rc;
-}
-
-static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	return *pos ? tcp_get_idx(seq, *pos - 1) : (void *)1;
-}
-
-static void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	void *rc = NULL;
-	struct tcp_iter_state* st;
-
-	if (v == (void *)1) {
-		rc = tcp_get_idx(seq, 0);
-		goto out;
-	}
-	st = seq->private;
-
-	switch (st->state) {
-	case TCP_SEQ_STATE_OPENREQ:
-	case TCP_SEQ_STATE_LISTENING:
-		rc = listening_get_next(seq, v);
-		if (!rc) {
-			tcp_listen_unlock();
-			local_bh_disable();
-			st->state = TCP_SEQ_STATE_ESTABLISHED;
-			rc	  = established_get_first(seq);
-		}
-		break;
-	case TCP_SEQ_STATE_ESTABLISHED:
-	case TCP_SEQ_STATE_TIME_WAIT:
-		rc = established_get_next(seq, v);
-		break;
-	}
-out:
-	++*pos;
-	return rc;
-}
-
-static void tcp_seq_stop(struct seq_file *seq, void *v)
-{
-	struct tcp_iter_state* st = seq->private;
-
-	switch (st->state) {
-	case TCP_SEQ_STATE_OPENREQ:
-		if (v) {
-			struct tcp_opt *tp = tcp_sk(st->syn_wait_sk);
-			read_unlock_bh(&tp->syn_wait_lock);
-		}
-	case TCP_SEQ_STATE_LISTENING:
-		tcp_listen_unlock();
-		break;
-	case TCP_SEQ_STATE_TIME_WAIT:
-	case TCP_SEQ_STATE_ESTABLISHED:
-		if (v)
-			read_unlock(&tcp_ehash[st->bucket].lock);
-		local_bh_enable();
-		break;
-	}
-}
-
 static void get_openreq(struct sock *sk, struct open_request *req,
 			char *tmpbuf, int i, int uid)
 {
@@ -2509,89 +2219,137 @@
 
 #define TMPSZ 150
 
-static int tcp_seq_show(struct seq_file *seq, void *v)
+int tcp_get_info(char *buffer, char **start, off_t offset, int length)
 {
-	struct tcp_iter_state* st;
+	int len = 0, num = 0, i;
+	off_t begin, pos = 0;
 	char tmpbuf[TMPSZ + 1];
 
-	if (v == (void *)1) {
-		seq_printf(seq, "%-*s\n", TMPSZ - 1,
-			   "  sl  local_address rem_address   st tx_queue "
-			   "rx_queue tr tm->when retrnsmt   uid  timeout "
-			   "inode");
-		goto out;
-	}
-	st = seq->private;
+	if (offset < TMPSZ)
+		len += sprintf(buffer, "%-*s\n", TMPSZ - 1,
+			       "  sl  local_address rem_address   st tx_queue "
+			       "rx_queue tr tm->when retrnsmt   uid  timeout "
+			       "inode");
 
-	switch (st->state) {
-	case TCP_SEQ_STATE_LISTENING:
-	case TCP_SEQ_STATE_ESTABLISHED:
-		get_tcp_sock(v, tmpbuf, st->num);
-		break;
-	case TCP_SEQ_STATE_OPENREQ:
-		get_openreq(st->syn_wait_sk, v, tmpbuf, st->num, st->uid);
-		break;
-	case TCP_SEQ_STATE_TIME_WAIT:
-		get_timewait_sock(v, tmpbuf, st->num);
-		break;
-	}
-	seq_printf(seq, "%-*s\n", TMPSZ - 1, tmpbuf);
-out:
-	return 0;
-}
+	pos = TMPSZ;
 
-static struct seq_operations tcp_seq_ops = {
-	.start  = tcp_seq_start,
-	.next   = tcp_seq_next,
-	.stop   = tcp_seq_stop,
-	.show   = tcp_seq_show,
-};
+	/* First, walk listening socket table. */
+	tcp_listen_lock();
+	for (i = 0; i < TCP_LHTABLE_SIZE; i++) {
+		struct sock *sk;
+		struct tcp_listen_opt *lopt;
+		int k;
 
-static int tcp_seq_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int rc = -ENOMEM;
-	struct tcp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+		for (sk = tcp_listening_hash[i]; sk; sk = sk->next, num++) {
+			struct open_request *req;
+			int uid;
+			struct tcp_opt *tp = tcp_sk(sk);
 
-	if (!s)
-		goto out;
-	rc = seq_open(file, &tcp_seq_ops);
-	if (rc)
-		goto out_kfree;
-	seq	     = file->private_data;
-	seq->private = s;
-	memset(s, 0, sizeof(*s));
-out:
-	return rc;
-out_kfree:
-	kfree(s);
-	goto out;
-}
+			if (!TCP_INET_FAMILY(sk->family))
+				goto skip_listen;
 
-static struct file_operations tcp_seq_fops = {
-	.open           = tcp_seq_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release	= ip_seq_release,
-};
+			pos += TMPSZ;
+			if (pos >= offset) {
+				get_tcp_sock(sk, tmpbuf, num);
+				len += sprintf(buffer + len, "%-*s\n",
+					       TMPSZ - 1, tmpbuf);
+				if (pos >= offset + length) {
+					tcp_listen_unlock();
+					goto out_no_bh;
+				}
+			}
 
-int __init tcp_proc_init(void)
-{
-	int rc = 0;
-	struct proc_dir_entry *p = create_proc_entry("tcp", S_IRUGO, proc_net);
+skip_listen:
+			uid = sock_i_uid(sk);
+			read_lock_bh(&tp->syn_wait_lock);
+			lopt = tp->listen_opt;
+			if (lopt && lopt->qlen) {
+				for (k = 0; k < TCP_SYNQ_HSIZE; k++) {
+					for (req = lopt->syn_table[k];
+					     req; req = req->dl_next, num++) {
+						if (!TCP_INET_FAMILY(req->class->family))
+							continue;
+
+						pos += TMPSZ;
+						if (pos <= offset)
+							continue;
+						get_openreq(sk, req, tmpbuf,
+							    num, uid);
+						len += sprintf(buffer + len,
+							       "%-*s\n",
+							       TMPSZ - 1,
+							       tmpbuf);
+						if (pos >= offset + length) {
+							read_unlock_bh(&tp->syn_wait_lock);
+							tcp_listen_unlock();
+							goto out_no_bh;
+						}
+					}
+				}
+			}
+			read_unlock_bh(&tp->syn_wait_lock);
 
-	if (p)
-		p->proc_fops = &tcp_seq_fops;
-	else
-		rc = -ENOMEM;
-	return rc;
-}
+			/* Completed requests are in normal socket hash table */
+		}
+	}
+	tcp_listen_unlock();
 
-void __init tcp_proc_exit(void)
-{
-	remove_proc_entry("tcp", proc_net);
+	local_bh_disable();
+
+	/* Next, walk established hash chain. */
+	for (i = 0; i < tcp_ehash_size; i++) {
+		struct tcp_ehash_bucket *head = &tcp_ehash[i];
+		struct sock *sk;
+		struct tcp_tw_bucket *tw;
+
+		read_lock(&head->lock);
+		for (sk = head->chain; sk; sk = sk->next, num++) {
+			if (!TCP_INET_FAMILY(sk->family))
+				continue;
+			pos += TMPSZ;
+			if (pos <= offset)
+				continue;
+			get_tcp_sock(sk, tmpbuf, num);
+			len += sprintf(buffer + len, "%-*s\n",
+				       TMPSZ - 1, tmpbuf);
+			if (pos >= offset + length) {
+				read_unlock(&head->lock);
+				goto out;
+			}
+		}
+		for (tw = (struct tcp_tw_bucket *)tcp_ehash[i +
+							  tcp_ehash_size].chain;
+		     tw;
+		     tw = (struct tcp_tw_bucket *)tw->next, num++) {
+			if (!TCP_INET_FAMILY(tw->family))
+				continue;
+			pos += TMPSZ;
+			if (pos <= offset)
+				continue;
+			get_timewait_sock(tw, tmpbuf, num);
+			len += sprintf(buffer + len, "%-*s\n",
+				       TMPSZ - 1, tmpbuf);
+			if (pos >= offset + length) {
+				read_unlock(&head->lock);
+				goto out;
+			}
+		}
+		read_unlock(&head->lock);
+	}
+
+out:
+	local_bh_enable();
+out_no_bh:
+
+	begin = len - (pos - offset);
+	*start = buffer + begin;
+	len -= begin;
+	if (len > length)
+		len = length;
+	if (len < 0)
+		len = 0;
+	return len;
 }
-#endif /* CONFIG_PROC_FS */
 
 struct proto tcp_prot = {
 	.name =		"TCP",

