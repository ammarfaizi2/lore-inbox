Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTGCG3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 02:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTGCG3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 02:29:15 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:58126 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265182AbTGCG3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 02:29:05 -0400
Date: Thu, 03 Jul 2003 15:44:29 +0900 (JST)
Message-Id: <20030703.154429.06241047.yoshfuji@linux-ipv6.org>
To: davem@redhat.com, jmorris@intercode.com.au, acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, mbligh@aracnet.com
Subject: [PATCH] NET: fix SEGV/OOPS with /proc/net/{raw,igmp,...} (is Re:
 [Bug 863] New: cat /proc/buddyinfo + netstat -a kills machine)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <25670000.1057163262@[10.10.2.4]>
References: <25670000.1057163262@[10.10.2.4]>
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

I'm not so sure if this is ralated to BUG#863, but anyway;

Following patch fixes segv/oops with /proc/net/{raw,igmp,mfilter,
raw6,igmp6,mfilter6,anycast,ip6_flowlabel}.

I should be more careful about cast...; sorry...

Thanks.

Index: linux-2.5/net/ipv4/igmp.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/igmp.c,v
retrieving revision 1.29
diff -u -r1.29 igmp.c
--- linux-2.5/net/ipv4/igmp.c	1 Jul 2003 16:42:06 -0000	1.29
+++ linux-2.5/net/ipv4/igmp.c	3 Jul 2003 05:06:18 -0000
@@ -2099,7 +2099,7 @@
 	struct in_device *in_dev;
 };
 
-#define	igmp_mc_seq_private(seq)	((struct igmp_mc_iter_state *)&seq->private)
+#define	igmp_mc_seq_private(seq)	((struct igmp_mc_iter_state *)(seq)->private)
 
 static inline struct ip_mc_list *igmp_mc_get_first(struct seq_file *seq)
 {
@@ -2254,7 +2254,7 @@
 	struct ip_mc_list *im;
 };
 
-#define igmp_mcf_seq_private(seq)	((struct igmp_mcf_iter_state *)&seq->private)
+#define igmp_mcf_seq_private(seq)	((struct igmp_mcf_iter_state *)(seq)->private)
 
 static inline struct ip_sf_list *igmp_mcf_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv4/raw.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/raw.c,v
retrieving revision 1.32
diff -u -r1.32 raw.c
--- linux-2.5/net/ipv4/raw.c	1 Jul 2003 16:42:06 -0000	1.32
+++ linux-2.5/net/ipv4/raw.c	3 Jul 2003 05:06:18 -0000
@@ -687,7 +687,7 @@
 	int bucket;
 };
 
-#define raw_seq_private(seq) ((struct raw_iter_state *)&seq->private)
+#define raw_seq_private(seq) ((struct raw_iter_state *)(seq)->private)
 
 static struct sock *raw_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv6/anycast.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/anycast.c,v
retrieving revision 1.4
diff -u -r1.4 anycast.c
--- linux-2.5/net/ipv6/anycast.c	1 Jul 2003 16:42:06 -0000	1.4
+++ linux-2.5/net/ipv6/anycast.c	3 Jul 2003 05:06:18 -0000
@@ -441,7 +441,7 @@
 	struct inet6_dev *idev;
 };
 
-#define ac6_seq_private(seq)	((struct ac6_iter_state *)&seq->private)
+#define ac6_seq_private(seq)	((struct ac6_iter_state *)(seq)->private)
 
 static inline struct ifacaddr6 *ac6_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv6/ip6_flowlabel.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/ip6_flowlabel.c,v
retrieving revision 1.5
diff -u -r1.5 ip6_flowlabel.c
--- linux-2.5/net/ipv6/ip6_flowlabel.c	1 Jul 2003 16:42:06 -0000	1.5
+++ linux-2.5/net/ipv6/ip6_flowlabel.c	3 Jul 2003 05:06:18 -0000
@@ -559,7 +559,7 @@
 	int bucket;
 };
 
-#define ip6fl_seq_private(seq)	((struct ip6fl_iter_state *)&(seq)->private)
+#define ip6fl_seq_private(seq)	((struct ip6fl_iter_state *)(seq)->private)
 
 static struct ip6_flowlabel *ip6fl_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv6/mcast.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/mcast.c,v
retrieving revision 1.25
diff -u -r1.25 mcast.c
--- linux-2.5/net/ipv6/mcast.c	1 Jul 2003 16:42:06 -0000	1.25
+++ linux-2.5/net/ipv6/mcast.c	3 Jul 2003 05:06:18 -0000
@@ -2045,7 +2045,7 @@
 	struct inet6_dev *idev;
 };
 
-#define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)&seq->private)
+#define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)(seq)->private)
 
 static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
 {
@@ -2185,7 +2185,7 @@
 	struct ifmcaddr6 *im;
 };
 
-#define igmp6_mcf_seq_private(seq)	((struct igmp6_mcf_iter_state *)&seq->private)
+#define igmp6_mcf_seq_private(seq)	((struct igmp6_mcf_iter_state *)(seq)->private)
 
 static inline struct ip6_sf_list *igmp6_mcf_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv6/raw.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/raw.c,v
retrieving revision 1.31
diff -u -r1.31 raw.c
--- linux-2.5/net/ipv6/raw.c	1 Jul 2003 16:42:06 -0000	1.31
+++ linux-2.5/net/ipv6/raw.c	3 Jul 2003 05:06:18 -0000
@@ -913,7 +913,7 @@
 	int bucket;
 };
 
-#define raw6_seq_private(seq) ((struct raw6_iter_state *)&seq->private)
+#define raw6_seq_private(seq) ((struct raw6_iter_state *)(seq)->private)
 
 static struct sock *raw6_get_first(struct seq_file *seq)
 {

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
