Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVLVED0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVLVED0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLVEDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:03:25 -0500
Received: from stinky.trash.net ([213.144.137.162]:62618 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751205AbVLVEDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:03:25 -0500
Message-ID: <43AA257B.4060105@trash.net>
Date: Thu, 22 Dec 2005 05:03:07 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikukkon@iki.fi
CC: coreteam@netfilter.org, netfilter@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] [PATCH] NETFILTER: Fix handling of module param
 dcc_timeout in ip_conntrack_irc.c
References: <20051221210621.GD24213@localhost.localdomain>
In-Reply-To: <20051221210621.GD24213@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------050303030006000306060805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050303030006000306060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mika Kukkonen wrote:
> Variable dcc_timeout is unsigned, so change the module_param() to
> reflect that, and also remove the now unneeded check in init().

We seem to be having lots of patches with module_param fixes lately,
so I went through the entire netfilter stuff and hopefully fixed up
all of them.

--------------050303030006000306060805
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: Fix module_param types and permissions

Fix netfilter module_param types and permissions. Also fix an off-by-one in
the ipt_ULOG nlbufsiz < 128k check.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit cc4da712876514a63e670370f64f63e585f784fc
tree 610b74bc9fa1dca55dba011b898314a13c9733cd
parent 1c49374279d9639b9d2980770cdcf47ea491af4f
author Patrick McHardy <kaber@trash.net> Thu, 22 Dec 2005 04:57:39 +0100
committer Patrick McHardy <kaber@trash.net> Thu, 22 Dec 2005 04:57:39 +0100

 net/ipv4/netfilter/ip_conntrack_amanda.c     |    2 +-
 net/ipv4/netfilter/ip_conntrack_ftp.c        |    2 +-
 net/ipv4/netfilter/ip_conntrack_irc.c        |   10 +++-------
 net/ipv4/netfilter/ip_conntrack_netbios_ns.c |    2 +-
 net/ipv4/netfilter/ipt_ULOG.c                |   10 +++++-----
 net/ipv4/netfilter/ipt_recent.c              |   20 ++++++++++----------
 net/netfilter/nf_conntrack_ftp.c             |    2 +-
 7 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/net/ipv4/netfilter/ip_conntrack_amanda.c b/net/ipv4/netfilter/ip_conntrack_amanda.c
index e52847f..f3bde90 100644
--- a/net/ipv4/netfilter/ip_conntrack_amanda.c
+++ b/net/ipv4/netfilter/ip_conntrack_amanda.c
@@ -34,7 +34,7 @@ static unsigned int master_timeout = 300
 MODULE_AUTHOR("Brian J. Murrell <netfilter@interlinx.bc.ca>");
 MODULE_DESCRIPTION("Amanda connection tracking module");
 MODULE_LICENSE("GPL");
-module_param(master_timeout, int, 0600);
+module_param(master_timeout, uint, 0600);
 MODULE_PARM_DESC(master_timeout, "timeout for the master connection");
 
 static const char *conns[] = { "DATA ", "MESG ", "INDEX " };
diff --git a/net/ipv4/netfilter/ip_conntrack_ftp.c b/net/ipv4/netfilter/ip_conntrack_ftp.c
index 68b173b..e627e58 100644
--- a/net/ipv4/netfilter/ip_conntrack_ftp.c
+++ b/net/ipv4/netfilter/ip_conntrack_ftp.c
@@ -34,7 +34,7 @@ static int ports_c;
 module_param_array(ports, ushort, &ports_c, 0400);
 
 static int loose;
-module_param(loose, int, 0600);
+module_param(loose, bool, 0600);
 
 unsigned int (*ip_nat_ftp_hook)(struct sk_buff **pskb,
 				enum ip_conntrack_info ctinfo,
diff --git a/net/ipv4/netfilter/ip_conntrack_irc.c b/net/ipv4/netfilter/ip_conntrack_irc.c
index d7c4042..c51a2cf 100644
--- a/net/ipv4/netfilter/ip_conntrack_irc.c
+++ b/net/ipv4/netfilter/ip_conntrack_irc.c
@@ -36,7 +36,7 @@
 #define MAX_PORTS 8
 static unsigned short ports[MAX_PORTS];
 static int ports_c;
-static int max_dcc_channels = 8;
+static unsigned int max_dcc_channels = 8;
 static unsigned int dcc_timeout = 300;
 /* This is slow, but it's simple. --RR */
 static char *irc_buffer;
@@ -54,9 +54,9 @@ MODULE_DESCRIPTION("IRC (DCC) connection
 MODULE_LICENSE("GPL");
 module_param_array(ports, ushort, &ports_c, 0400);
 MODULE_PARM_DESC(ports, "port numbers of IRC servers");
-module_param(max_dcc_channels, int, 0400);
+module_param(max_dcc_channels, uint, 0400);
 MODULE_PARM_DESC(max_dcc_channels, "max number of expected DCC channels per IRC session");
-module_param(dcc_timeout, int, 0400);
+module_param(dcc_timeout, uint, 0400);
 MODULE_PARM_DESC(dcc_timeout, "timeout on for unestablished DCC channels");
 
 static const char *dccprotos[] = { "SEND ", "CHAT ", "MOVE ", "TSEND ", "SCHAT " };
@@ -254,10 +254,6 @@ static int __init init(void)
 		printk("ip_conntrack_irc: max_dcc_channels must be a positive integer\n");
 		return -EBUSY;
 	}
-	if (dcc_timeout < 0) {
-		printk("ip_conntrack_irc: dcc_timeout must be a positive integer\n");
-		return -EBUSY;
-	}
 
 	irc_buffer = kmalloc(65536, GFP_KERNEL);
 	if (!irc_buffer)
diff --git a/net/ipv4/netfilter/ip_conntrack_netbios_ns.c b/net/ipv4/netfilter/ip_conntrack_netbios_ns.c
index 186646e..4e68e16 100644
--- a/net/ipv4/netfilter/ip_conntrack_netbios_ns.c
+++ b/net/ipv4/netfilter/ip_conntrack_netbios_ns.c
@@ -37,7 +37,7 @@ MODULE_DESCRIPTION("NetBIOS name service
 MODULE_LICENSE("GPL");
 
 static unsigned int timeout = 3;
-module_param(timeout, int, 0600);
+module_param(timeout, uint, 0400);
 MODULE_PARM_DESC(timeout, "timeout for master connection/replies in seconds");
 
 static int help(struct sk_buff **pskb,
diff --git a/net/ipv4/netfilter/ipt_ULOG.c b/net/ipv4/netfilter/ipt_ULOG.c
index 2883ccd..3fdf147 100644
--- a/net/ipv4/netfilter/ipt_ULOG.c
+++ b/net/ipv4/netfilter/ipt_ULOG.c
@@ -77,15 +77,15 @@ MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NE
 #define PRINTR(format, args...) do { if (net_ratelimit()) printk(format , ## args); } while (0)
 
 static unsigned int nlbufsiz = 4096;
-module_param(nlbufsiz, uint, 0600); /* FIXME: Check size < 128k --RR */
+module_param(nlbufsiz, uint, 0600);
 MODULE_PARM_DESC(nlbufsiz, "netlink buffer size");
 
 static unsigned int flushtimeout = 10;
-module_param(flushtimeout, int, 0600);
+module_param(flushtimeout, uint, 0600);
 MODULE_PARM_DESC(flushtimeout, "buffer flush timeout (hundredths of a second)");
 
-static unsigned int nflog = 1;
-module_param(nflog, int, 0400);
+static int nflog = 1;
+module_param(nflog, bool, 0400);
 MODULE_PARM_DESC(nflog, "register as internal netfilter logging module");
 
 /* global data structures */
@@ -376,7 +376,7 @@ static int __init init(void)
 
 	DEBUGP("ipt_ULOG: init module\n");
 
-	if (nlbufsiz >= 128*1024) {
+	if (nlbufsiz > 128*1024) {
 		printk("Netlink buffer has to be <= 128kB\n");
 		return -EINVAL;
 	}
diff --git a/net/ipv4/netfilter/ipt_recent.c b/net/ipv4/netfilter/ipt_recent.c
index 261cbb4..5ddccb1 100644
--- a/net/ipv4/netfilter/ipt_recent.c
+++ b/net/ipv4/netfilter/ipt_recent.c
@@ -24,10 +24,10 @@
 #define HASH_LOG 9
 
 /* Defaults, these can be overridden on the module command-line. */
-static int ip_list_tot = 100;
-static int ip_pkt_list_tot = 20;
-static int ip_list_hash_size = 0;
-static int ip_list_perms = 0644;
+static unsigned int ip_list_tot = 100;
+static unsigned int ip_pkt_list_tot = 20;
+static unsigned int ip_list_hash_size = 0;
+static unsigned int ip_list_perms = 0644;
 #ifdef DEBUG
 static int debug = 1;
 #endif
@@ -38,13 +38,13 @@ KERN_INFO RECENT_NAME " " RECENT_VER ": 
 MODULE_AUTHOR("Stephen Frost <sfrost@snowman.net>");
 MODULE_DESCRIPTION("IP tables recently seen matching module " RECENT_VER);
 MODULE_LICENSE("GPL");
-module_param(ip_list_tot, int, 0400);
-module_param(ip_pkt_list_tot, int, 0400);
-module_param(ip_list_hash_size, int, 0400);
-module_param(ip_list_perms, int, 0400);
+module_param(ip_list_tot, uint, 0400);
+module_param(ip_pkt_list_tot, uint, 0400);
+module_param(ip_list_hash_size, uint, 0400);
+module_param(ip_list_perms, uint, 0400);
 #ifdef DEBUG
-module_param(debug, int, 0600);
-MODULE_PARM_DESC(debug,"debugging level, defaults to 1");
+module_param(debug, bool, 0600);
+MODULE_PARM_DESC(debug,"enable debugging output");
 #endif
 MODULE_PARM_DESC(ip_list_tot,"number of IPs to remember per list");
 MODULE_PARM_DESC(ip_pkt_list_tot,"number of packets per IP to remember");
diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index 65080e2..d5a6eaf 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -44,7 +44,7 @@ static unsigned int ports_c;
 module_param_array(ports, ushort, &ports_c, 0400);
 
 static int loose;
-module_param(loose, int, 0600);
+module_param(loose, bool, 0600);
 
 unsigned int (*nf_nat_ftp_hook)(struct sk_buff **pskb,
 				enum ip_conntrack_info ctinfo,

--------------050303030006000306060805--
