Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266873AbTGGIWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266843AbTGGIWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:22:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266873AbTGGIVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:21:52 -0400
Date: Mon, 7 Jul 2003 01:36:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduler merged
Message-Id: <20030707013620.5dbae291.akpm@osdl.org>
In-Reply-To: <m3fzli4udq.fsf@lugabout.jhcloos.org>
References: <20030705133334.4cc7e11b.akpm@osdl.org>
	<m3fzli4udq.fsf@lugabout.jhcloos.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James H. Cloos Jr." <cloos@jhcloos.com> wrote:
>
> ...
> Looks like I got hit by such a bug.

No, these aren't due to the IO scheduler.

> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> 00000000
> *pde = 00000000
> Oops: 0000 [#2]
> CPU:    0
> EIP:    0060:[<00000000>]    Not tainted
> EFLAGS: 00010286
> EIP is at 0x0
> eax: c04b0d20   ebx: fffffff4   ecx: d87bcd3c   edx: d87bcd3c
> esi: ca6466c4   edi: d0f55e00   ebp: c9b51f70   esp: c9b51f08
> ds: 007b   es: 007b   ss: 0068
> Process strip (pid: 18461, threadinfo=c9b50000 task=c40a32a0)
> Stack: c01675f6 ca6466c4 d0f55e00 c9b51f70 ffffffd8 d87bcd20 00000242 c9b51f70 
>        c0167f24 c9b51f78 d87bcd20 c9b51f70 c9b50000 c9b51f78 00000001 00000002 
>        cad39d60 00000241 00000002 c520e000 c9b50000 c015734b c520e000 00000242 
> Call Trace:
>  [<c01675f6>] __lookup_hash+0xc6/0xe0
>  [<c0167f24>] open_namei+0x334/0x460
>  [<c015734b>] filp_open+0x3b/0x70
>  [<c015786b>] sys_open+0x5b/0xa0
>  [<c010b379>] sysenter_past_esp+0x52/0x71

This one is a null inode->i_op->lookup() pointer.  Several people have
reported this.

What filesystem was in use at the time?


> >>eax; c04b0d20 <ext3_file_inode_operations+0/60>

eh?  We did a lookup in a regular file?

> Call Trace:
>  [<c0178635>] seq_release_private+0x25/0x48
>  [<c0178610>] seq_release_private+0x0/0x48
>  [<c015951a>] __fput+0x12a/0x170
>  [<c015792d>] filp_close+0x4d/0x90
>  [<c01579cb>] sys_close+0x5b/0x90
>  [<c010b379>] sysenter_past_esp+0x52/0x71

This one's fixed.  Here's the patch:



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

