Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbTGCVJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 17:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTGCVJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 17:09:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20178 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265359AbTGCVJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 17:09:07 -0400
Date: Thu, 3 Jul 2003 14:17:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: andyp@osdl.org, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org,
       akpm@digeo.com
Subject: Re: Linux 2.5.74: BUG at mm/slab.c:1537
Message-Id: <20030703141758.12ec3825.akpm@osdl.org>
In-Reply-To: <3F048E77.8080402@colorfullife.com>
References: <3F048E77.8080402@colorfullife.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> The problem is caused by changeset 1.1310.102.3, 2003/07/01 
> 02:01:51+10:00, yoshfuji@linux-ipv6.org:
> 
> http://linus.bkbits.net:8080/linux-2.5/diffs/net/ipv4/raw.c@3f005eebc5YsuvTFXhDo-QDhPEgh5Q?nav=index.html
> (Subject: [NET] fixed /proc/net/raw{,6} seq_file support)
> 
> raw_iter_state is just an integer. Without that patch, the integer is 
> stored directly in the seq->private pointer (note the & in the define of 
> raw_seq_private, around line 690 of net/ipv4/raw.c). The patch converts 
> part of the code to an pointer to an integer, but other parts still 
> consider seq->private as an integer. The oops is actually a BUG 
> statement in kmalloc: it complains (if CONFIG_DEBUG_SLAB is enabled) 
> about the invalid pointer.
> 

This is the patch out of bugzilla.  I'm not sure who wrote it, and
there is no description.

(Could people please not do that?  If you have a patch which fixes a
bug, please squirt it to the mailing list)


 25-akpm/net/ipv4/igmp.c          |    4 ++--
 25-akpm/net/ipv4/raw.c           |    2 +-
 25-akpm/net/ipv6/anycast.c       |    2 +-
 25-akpm/net/ipv6/ip6_flowlabel.c |    2 +-
 25-akpm/net/ipv6/mcast.c         |    4 ++--
 25-akpm/net/ipv6/raw.c           |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff -puN net/ipv4/igmp.c~netstat-oops-fix net/ipv4/igmp.c
--- 25/net/ipv4/igmp.c~netstat-oops-fix	Thu Jul  3 12:31:19 2003
+++ 25-akpm/net/ipv4/igmp.c	Thu Jul  3 12:31:19 2003
@@ -2099,7 +2099,7 @@ struct igmp_mc_iter_state {
 	struct in_device *in_dev;
 };
 
-#define	igmp_mc_seq_private(seq)	((struct igmp_mc_iter_state *)&seq->private)
+#define	igmp_mc_seq_private(seq)	((struct igmp_mc_iter_state *)(seq)->private)
 
 static inline struct ip_mc_list *igmp_mc_get_first(struct seq_file *seq)
 {
@@ -2254,7 +2254,7 @@ struct igmp_mcf_iter_state {
 	struct ip_mc_list *im;
 };
 
-#define igmp_mcf_seq_private(seq)	((struct igmp_mcf_iter_state *)&seq->private)
+#define igmp_mcf_seq_private(seq)	((struct igmp_mcf_iter_state *)(seq)->private)
 
 static inline struct ip_sf_list *igmp_mcf_get_first(struct seq_file *seq)
 {
diff -puN net/ipv4/raw.c~netstat-oops-fix net/ipv4/raw.c
--- 25/net/ipv4/raw.c~netstat-oops-fix	Thu Jul  3 12:31:19 2003
+++ 25-akpm/net/ipv4/raw.c	Thu Jul  3 12:31:19 2003
@@ -687,7 +687,7 @@ struct raw_iter_state {
 	int bucket;
 };
 
-#define raw_seq_private(seq) ((struct raw_iter_state *)&seq->private)
+#define raw_seq_private(seq) ((struct raw_iter_state *)(seq)->private)
 
 static struct sock *raw_get_first(struct seq_file *seq)
 {
diff -puN net/ipv6/anycast.c~netstat-oops-fix net/ipv6/anycast.c
--- 25/net/ipv6/anycast.c~netstat-oops-fix	Thu Jul  3 12:31:19 2003
+++ 25-akpm/net/ipv6/anycast.c	Thu Jul  3 12:31:19 2003
@@ -441,7 +441,7 @@ struct ac6_iter_state {
 	struct inet6_dev *idev;
 };
 
-#define ac6_seq_private(seq)	((struct ac6_iter_state *)&seq->private)
+#define ac6_seq_private(seq)	((struct ac6_iter_state *)(seq)->private)
 
 static inline struct ifacaddr6 *ac6_get_first(struct seq_file *seq)
 {
diff -puN net/ipv6/ip6_flowlabel.c~netstat-oops-fix net/ipv6/ip6_flowlabel.c
--- 25/net/ipv6/ip6_flowlabel.c~netstat-oops-fix	Thu Jul  3 12:31:19 2003
+++ 25-akpm/net/ipv6/ip6_flowlabel.c	Thu Jul  3 12:31:19 2003
@@ -559,7 +559,7 @@ struct ip6fl_iter_state {
 	int bucket;
 };
 
-#define ip6fl_seq_private(seq)	((struct ip6fl_iter_state *)&(seq)->private)
+#define ip6fl_seq_private(seq)	((struct ip6fl_iter_state *)(seq)->private)
 
 static struct ip6_flowlabel *ip6fl_get_first(struct seq_file *seq)
 {
diff -puN net/ipv6/mcast.c~netstat-oops-fix net/ipv6/mcast.c
--- 25/net/ipv6/mcast.c~netstat-oops-fix	Thu Jul  3 12:31:19 2003
+++ 25-akpm/net/ipv6/mcast.c	Thu Jul  3 12:31:19 2003
@@ -2045,7 +2045,7 @@ struct igmp6_mc_iter_state {
 	struct inet6_dev *idev;
 };
 
-#define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)&seq->private)
+#define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)(seq)->private)
 
 static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
 {
@@ -2185,7 +2185,7 @@ struct igmp6_mcf_iter_state {
 	struct ifmcaddr6 *im;
 };
 
-#define igmp6_mcf_seq_private(seq)	((struct igmp6_mcf_iter_state *)&seq->private)
+#define igmp6_mcf_seq_private(seq)	((struct igmp6_mcf_iter_state *)(seq)->private)
 
 static inline struct ip6_sf_list *igmp6_mcf_get_first(struct seq_file *seq)
 {
diff -puN net/ipv6/raw.c~netstat-oops-fix net/ipv6/raw.c
--- 25/net/ipv6/raw.c~netstat-oops-fix	Thu Jul  3 12:31:19 2003
+++ 25-akpm/net/ipv6/raw.c	Thu Jul  3 12:31:19 2003
@@ -913,7 +913,7 @@ struct raw6_iter_state {
 	int bucket;
 };
 
-#define raw6_seq_private(seq) ((struct raw6_iter_state *)&seq->private)
+#define raw6_seq_private(seq) ((struct raw6_iter_state *)(seq)->private)
 
 static struct sock *raw6_get_first(struct seq_file *seq)
 {

_

