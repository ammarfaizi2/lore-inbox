Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTJNSP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTJNSP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:15:56 -0400
Received: from ginger.lcs.mit.edu ([18.26.0.82]:47876 "EHLO ginger.lcs.mit.edu")
	by vger.kernel.org with ESMTP id S262694AbTJNSP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:15:28 -0400
Message-Id: <200310141814.h9EIErWB014091@ginger.lcs.mit.edu>
From: Tim Shepard <shep@alum.mit.edu>
To: "David S. Miller" <davem@redhat.com>
cc: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, jmorris@redhat.com,
       netdev@oss.sgi.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix numbering of lines in /proc/net/tcp (linux-2.6.0-test7) 
In-reply-to: Your message of Tue, 14 Oct 2003 10:45:03 -0700.
             <20031014104503.12ca907e.davem@redhat.com> 
Date: Tue, 14 Oct 2003 14:14:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I am not sure what the behavior is supposed to be.  Is there a spec
> > > anywhere for the interface with /proc/net/tcp?
> > 
> > Yes, I think the original is okay because the bucket is shared between
> > tcp6 and tcp4, and I don't want to change this behavior in 2.6 from 2.4.x.
> > (so, we need to fix 2.6.x.)
> 
> In the meantime I've applied Tim's patch because it is definitely
> a step in the right direction and the current 2.6.x behavior makes
> no sense at all :-)

Ok, that makes good sense to me.

> We can add a fix on top to make 2.6.x behave more closely to 2.4.x
> (by sharing numbers between v4 and v6).  If that proves to be very
> difficult to do, it's not absolutely critical to preserve this behavior
> I think.

Whoever dives in and fixes this (i.e. makes the linux-2.6 behavior
exactly match linux-2.4 behavior) may want to start with a copy of
net/ipv4/tcp_ipv4.c from 2.6.0-test7 without that patch applied
because that patch rips out bits of code that was trying to increment
st->num whenever sk->sk_family does not match st->family.  Some of
those bits of code will need to reappear to make linux-2.6 match
linux-2.4 behavior.  (Note, the patch below might contain some clues.)

When testing this stuff, you need to make sure that there is no
dependence upon the buffer size that the user mode program is using to
read from /proc/net/tcp and /proc/net/tcp6.  (Use dd with different
bs= arguments.)


I just quickly tried to make the linux-2.6 numbering behave
identically to linux-2.4 (see patch below) but it did not work
properly, and I have not figured out yet where I goofed.




Note: THIS PATCH IS WRONG.  Do not apply this patch unless you want
to help figure out why it does not work correctly.  I was trying to
make linux-2.6 number the lines the same way linux-2.4 did, but the
numbers come out wrong.

This patch is against linux-2.6.0-test7 without my previous
patch to fix the numbering.

			-Tim Shepard
			 shep@alum.mit.edu


--- ../pristine/linux-2.6.0-test7/net/ipv4/tcp_ipv4.c	2003-10-08 15:24:03.000000000 -0400
+++ net/ipv4/tcp_ipv4.c	2003-10-14 13:23:58.000000000 -0400
@@ -2136,29 +2136,29 @@
 static void *listening_get_first(struct seq_file *seq)
 {
 	struct tcp_iter_state* st = seq->private;
 	void *rc = NULL;
 
 	for (st->bucket = 0; st->bucket < TCP_LHTABLE_SIZE; ++st->bucket) {
 		struct open_request *req;
 		struct tcp_opt *tp;
 		struct sock *sk = sk_head(&tcp_listening_hash[st->bucket]);
 
 		if (!sk)
 			continue;
-		++st->num;
 		if (sk->sk_family == st->family) {
 			rc = sk;
 			goto out;
 		}
+		++st->num;
 	       	tp = tcp_sk(sk);
 		read_lock_bh(&tp->syn_wait_lock);
 		if (tp->listen_opt && tp->listen_opt->qlen) {
 			st->uid		= sock_i_uid(sk);
 			st->syn_wait_sk = sk;
 			st->state	= TCP_SEQ_STATE_OPENREQ;
 			for (st->sbucket = 0; st->sbucket < TCP_SYNQ_HSIZE;
 			     ++st->sbucket) {
 				for (req = tp->listen_opt->syn_table[st->sbucket];
 				     req; req = req->dl_next, ++st->num) {
 					if (req->class->family != st->family)
 						continue;
@@ -2172,54 +2172,57 @@
 	}
 out:
 	return rc;
 }
 
 static void *listening_get_next(struct seq_file *seq, void *cur)
 {
 	struct tcp_opt *tp;
 	struct hlist_node *node;
 	struct sock *sk = cur;
 	struct tcp_iter_state* st = seq->private;
 
+	++st->num;
+
 	if (st->state == TCP_SEQ_STATE_OPENREQ) {
 		struct open_request *req = cur;
 
 	       	tp = tcp_sk(st->syn_wait_sk);
 		req = req->dl_next;
 		while (1) {
 			while (req) {
-				++st->num;
 				if (req->class->family == st->family) {
 					cur = req;
 					goto out;
 				}
+				++st->num;
 				req = req->dl_next;
 			}
 			if (++st->sbucket >= TCP_SYNQ_HSIZE)
 				break;
 get_req:
 			req = tp->listen_opt->syn_table[st->sbucket];
 		}
 		sk	  = sk_next(st->syn_wait_sk);
 		st->state = TCP_SEQ_STATE_LISTENING;
 		read_unlock_bh(&tp->syn_wait_lock);
 	} else
 		sk = sk_next(sk);
 get_sk:
 	sk_for_each_from(sk, node) {
 		if (sk->sk_family == st->family) {
 			cur = sk;
 			goto out;
 		}
+		++st->num;
 	       	tp = tcp_sk(sk);
 		read_lock_bh(&tp->syn_wait_lock);
 		if (tp->listen_opt && tp->listen_opt->qlen) {
 			st->uid		= sock_i_uid(sk);
 			st->syn_wait_sk = sk;
 			st->state	= TCP_SEQ_STATE_OPENREQ;
 			st->sbucket	= 0;
 			goto get_req;
 		}
 		read_unlock_bh(&tp->syn_wait_lock);
 	}
 	if (++st->bucket < TCP_LHTABLE_SIZE) {
@@ -2275,24 +2278,26 @@
 	}
 out:
 	return rc;
 }
 
 static void *established_get_next(struct seq_file *seq, void *cur)
 {
 	struct sock *sk = cur;
 	struct tcp_tw_bucket *tw;
 	struct hlist_node *node;
 	struct tcp_iter_state* st = seq->private;
 
+	++st->num;
+
 	if (st->state == TCP_SEQ_STATE_TIME_WAIT) {
 		tw = cur;
 		tw = tw_next(tw);
 get_tw:
 		while (tw && tw->tw_family != st->family) {
 			++st->num;
 			tw = tw_next(tw);
 		}
 		if (tw) {
 			cur = tw;
 			goto out;
 		}
@@ -2345,24 +2350,26 @@
 	if (!rc) {
 		tcp_listen_unlock();
 		local_bh_disable();
 		st->state = TCP_SEQ_STATE_ESTABLISHED;
 		rc	  = established_get_idx(seq, pos);
 	}
 
 	return rc;
 }
 
 static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 {
+	struct tcp_iter_state* st = seq->private;
+	st->num = 0;
 	return *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
 static void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	void *rc = NULL;
 	struct tcp_iter_state* st;
 
 	if (v == SEQ_START_TOKEN) {
 		rc = tcp_get_idx(seq, 0);
 		goto out;
 	}
