Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTICHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbTICHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:07:25 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:34066 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261393AbTICHHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:07:20 -0400
Date: Wed, 03 Sep 2003 16:07:33 +0900 (JST)
Message-Id: <20030903.160733.06230402.yoshfuji@linux-ipv6.org>
To: Ricky Beam <jfbeam@bluetronic.net>, jfbeam@bluetronic.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, yoshfuji@linux-ipv6.org,
       davem@redhat.com
Subject: Re: /proc/net/* read drops data
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.GSO.4.33.0308271935550.7750-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0308271658370.7750-100000@sweetums.bluetronic.net>
	<Pine.GSO.4.33.0308271935550.7750-100000@sweetums.bluetronic.net>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <Pine.GSO.4.33.0308271935550.7750-100000@sweetums.bluetronic.net> (at Wed, 27 Aug 2003 19:58:17 -0400 (EDT)), Ricky Beam <jfbeam@bluetronic.net> says:

> On Wed, 27 Aug 2003, Ricky Beam wrote:
> >This smells like a simple "off by one" bug, but I've been too busy to go
> >look at the code.
> 
> Ah hah!  it's a block size problem... netstat reads 1024 at a time.
> 
> Using dd...
> 
> [root:pts/5{9}]gir:~/[7:55pm]:dd if=/proc/net/udp bs=1024 | wc
> 2+1 records in
> 2+1 records out
>      18     216    2304
> [root:pts/5{9}]gir:~/[7:56pm]:dd if=/proc/net/udp bs=2048 | wc
> 1+1 records in
> 1+1 records out
>      19     228    2432
:

Please try this patch.

D: Fixing a bug that reading /proc/net/{udp,udp6} may drop some data

Index: linux-2.6/net/ipv4/udp.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/udp.c,v
retrieving revision 1.38
diff -u -r1.38 udp.c
--- linux-2.6/net/ipv4/udp.c	14 Aug 2003 06:00:04 -0000	1.38
+++ linux-2.6/net/ipv4/udp.c	3 Sep 2003 05:30:52 -0000
@@ -1349,64 +1349,65 @@
 /* ------------------------------------------------------------------------ */
 #ifdef CONFIG_PROC_FS
 
-static __inline__ struct sock *udp_get_bucket(struct seq_file *seq, loff_t *pos)
+static struct sock *udp_get_first(struct seq_file *seq)
 {
-	int i;
 	struct sock *sk;
-	struct hlist_node *node;
-	loff_t l = *pos;
 	struct udp_iter_state *state = seq->private;
 
-	for (; state->bucket < UDP_HTABLE_SIZE; ++state->bucket) {
-		i = 0;
+	for (state->bucket = 0; state->bucket < UDP_HTABLE_SIZE; ++state->bucket) {
+		struct hlist_node *node;
 		sk_for_each(sk, node, &udp_hash[state->bucket]) {
-			if (sk->sk_family != state->family) {
-				++i;
-				continue;
-			}
-			if (l--) {
-				++i;
-				continue;
-			}
-			*pos = i;
-			goto out;
+			if (sk->sk_family == state->family)
+				goto found;
 		}
 	}
 	sk = NULL;
-out:
+found:
 	return sk;
 }
 
+static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
+{
+	struct udp_iter_state *state = seq->private;
+
+	do {
+		sk = sk_next(sk);
+try_again:
+		;
+	} while (sk && sk->sk_family != state->family);
+
+	if (!sk && ++state->bucket < UDP_HTABLE_SIZE) {
+		sk = sk_head(&udp_hash[state->bucket]);
+		goto try_again;
+	}
+	return sk;
+}
+
+static struct sock *udp_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct sock *sk = udp_get_first(seq);
+
+	if (sk)
+		while(pos && (sk = udp_get_next(seq, sk)) != NULL)
+			--pos;
+	return pos ? NULL : sk;
+}
+
 static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&udp_hash_lock);
-	return *pos ? udp_get_bucket(seq, pos) : (void *)1;
+	return *pos ? udp_get_idx(seq, *pos-1) : (void *)1;
 }
 
 static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct sock *sk;
-	struct hlist_node *node;
-	struct udp_iter_state *state;
-
-	if (v == (void *)1) {
-		sk = udp_get_bucket(seq, pos);
-		goto out;
-	}
 
-	state = seq->private;
+	if (v == (void *)1)
+		sk = udp_get_idx(seq, 0);
+	else
+		sk = udp_get_next(seq, v);
 
-	sk = v;
-	sk_for_each_continue(sk, node)
-		if (sk->sk_family == state->family)
-			goto out;
-
-	if (++state->bucket >= UDP_HTABLE_SIZE) 
-		goto out;
-
-	*pos = 0;
-	sk = udp_get_bucket(seq, pos);
-out:
 	++*pos;
 	return sk;
 }

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
