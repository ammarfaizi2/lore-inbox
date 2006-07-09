Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWGIXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWGIXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWGIXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:33:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8977 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932330AbWGIXdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:33:06 -0400
Date: Mon, 10 Jul 2006 01:33:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Patrick McHardy <kaber@trash.net>
Cc: coreteam@netfilter.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] netfilter: fix SYSCTL=n compile
Message-ID: <20060709233304.GX13938@stusta.de>
References: <20060708202023.GE5020@stusta.de> <44B079FF.8060909@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B079FF.8060909@trash.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 05:37:35AM +0200, Patrick McHardy wrote:
> Adrian Bunk wrote:
> > This patch fixes the following compile error with CONFIG_SYSCTL=n 
> > introduced by commit 39a27a35c5c1b5be499a0576a35c45a011788bf8:
> 
> My fault I guess.
> 
> > <--  snip  -->
> > 
> > ...
> >   LD      .tmp_vmlinux1
> > net/built-in.o: In function `tcp_error':
> > ip_conntrack_proto_tcp.c:(.text+0x77af6): undefined reference to `ip_conntrack_checksum'
> > net/built-in.o: In function `udp_error':
> > ip_conntrack_proto_udp.c:(.text+0x78456): undefined reference to `ip_conntrack_checksum'
> > net/built-in.o: In function `icmp_error':
> > ip_conntrack_proto_icmp.c:(.text+0x7868f): undefined reference to `ip_conntrack_checksum'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> Thanks Adrian. Usually all bugs in ip_conntrack are duplicated in
> nf_conntrack, please update your patch to take care of that as well.

Correct, updated patch below.

cu
Adrian


<--  snip  -->


This patch fixes the following compile errors with CONFIG_SYSCTL=n 
introduced by commit 39a27a35c5c1b5be499a0576a35c45a011788bf8:

<--  snip  -->

...
  LD      .tmp_vmlinux1
net/built-in.o: In function `tcp_error':
ip_conntrack_proto_tcp.c:(.text+0x77af6): undefined reference to `ip_conntrack_checksum'
net/built-in.o: In function `udp_error':
ip_conntrack_proto_udp.c:(.text+0x78456): undefined reference to `ip_conntrack_checksum'
net/built-in.o: In function `icmp_error':
ip_conntrack_proto_icmp.c:(.text+0x7868f): undefined reference to `ip_conntrack_checksum'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

...
  LD      .tmp_vmlinux1
net/built-in.o: In function `tcp_error':
nf_conntrack_proto_tcp.c:(.text+0x46b44): undefined reference to `nf_conntrack_checksum'
net/built-in.o: In function `udp_error':
nf_conntrack_proto_udp.c:(.text+0x474f5): undefined reference to `nf_conntrack_checksum'
net/built-in.o: In function `icmp_error':
nf_conntrack_proto_icmp.c:(.text+0x8e5f4): undefined reference to `nf_conntrack_checksum'
net/built-in.o: In function `icmpv6_error':
nf_conntrack_proto_icmpv6.c:(.text+0xd3f54): undefined reference to `nf_conntrack_checksum'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv4/netfilter/ip_conntrack_standalone.c |    4 ++--
 net/netfilter/nf_conntrack_standalone.c      |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.17-mm6-full/net/ipv4/netfilter/ip_conntrack_standalone.c.old	2006-07-08 15:32:32.000000000 +0200
+++ linux-2.6.17-mm6-full/net/ipv4/netfilter/ip_conntrack_standalone.c	2006-07-08 15:33:30.000000000 +0200
@@ -534,6 +534,8 @@
 
 /* Sysctl support */
 
+int ip_conntrack_checksum = 1;
+
 #ifdef CONFIG_SYSCTL
 
 /* From ip_conntrack_core.c */
@@ -568,8 +570,6 @@
 static int log_invalid_proto_min = 0;
 static int log_invalid_proto_max = 255;
 
-int ip_conntrack_checksum = 1;
-
 static struct ctl_table_header *ip_ct_sysctl_header;
 
 static ctl_table ip_ct_sysctl_table[] = {

--- linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_standalone.c.old	2006-07-09 21:18:04.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_standalone.c	2006-07-09 21:18:27.000000000 +0200
@@ -428,6 +428,8 @@
 
 /* Sysctl support */
 
+int nf_conntrack_checksum = 1;
+
 #ifdef CONFIG_SYSCTL
 
 /* From nf_conntrack_core.c */
@@ -459,8 +461,6 @@
 static int log_invalid_proto_min = 0;
 static int log_invalid_proto_max = 255;
 
-int nf_conntrack_checksum = 1;
-
 static struct ctl_table_header *nf_ct_sysctl_header;
 
 static ctl_table nf_ct_sysctl_table[] = {

