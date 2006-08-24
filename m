Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWHXPZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWHXPZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWHXPZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:25:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15533 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965054AbWHXPZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:25:32 -0400
Subject: [PATCH 1/4] Inconsistent extern declarations.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1156429585.3012.58.camel@pmac.infradead.org>
References: <1156429585.3012.58.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 16:25:18 +0100
Message-Id: <1156433118.3012.117.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you compile multiple files together with --combine, the compiler
starts to _notice_ when you do things like this in one file:

 extern int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
                                struct iovec *iov, int len, int noblock);

.. but the actual function looks like this:

 extern int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
                                struct iovec *iov, size_t len, int noblock);

This fixes a bunch of those, which are mostly just a missing 'const' on
the extern declaration.

This patch is a bug-fix which is fairly much independent of the
--combine/-fwhole-program stuff, so can be applied today.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
index e103503..f647ec3 100644
--- a/drivers/isdn/hisax/config.c
+++ b/drivers/isdn/hisax/config.c
@@ -369,11 +369,11 @@ #endif /* MODULE */
 
 int nrcards;
 
-extern char *l1_revision;
-extern char *l2_revision;
-extern char *l3_revision;
-extern char *lli_revision;
-extern char *tei_revision;
+extern const char *l1_revision;
+extern const char *l2_revision;
+extern const char *l3_revision;
+extern const char *lli_revision;
+extern const char *tei_revision;
 
 char *HiSax_getrev(const char *revision)
 {
diff --git a/drivers/net/skfp/smtinit.c b/drivers/net/skfp/smtinit.c
index 3c8964c..01bf76b 100644
--- a/drivers/net/skfp/smtinit.c
+++ b/drivers/net/skfp/smtinit.c
@@ -36,7 +36,7 @@ #endif
 
 #ifndef MULT_OEM
 #define OEMID(smc,i)	oem_id[i]
-	extern u_char	oem_id[] ;
+	extern const u_char	oem_id[] ;
 #else	/* MULT_OEM */
 #define OEMID(smc,i)	smc->hw.oem_id->oi_mark[i]
 	extern struct s_oem_ids	oem_ids[] ;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e8ae304..8a15f70 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -27,7 +27,7 @@ #include <linux/debugfs.h>
 #define DEBUGFS_MAGIC	0x64626720
 
 /* declared over in file.c */
-extern struct file_operations debugfs_file_operations;
+extern const struct file_operations debugfs_file_operations;
 
 static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 924ecde..99f3120 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -269,7 +269,7 @@ static int hfsplus_file_release(struct i
 }
 
 extern struct inode_operations hfsplus_dir_inode_operations;
-extern struct file_operations hfsplus_dir_operations;
+extern const struct file_operations hfsplus_dir_operations;
 
 static struct inode_operations hfsplus_file_inode_operations = {
 	.lookup		= hfsplus_file_lookup,
diff --git a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
index 9aabcc0..68ab9c0 100644
--- a/fs/reiserfs/dir.c
+++ b/fs/reiserfs/dir.c
@@ -11,7 +11,7 @@ #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
-extern struct reiserfs_key MIN_KEY;
+extern const struct reiserfs_key MIN_KEY;
 
 static int reiserfs_readdir(struct file *, void *, filldir_t);
 static int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry,
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 0253413..1316556 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -22,7 +22,7 @@ extern __u32 sysctl_rmem_max;
 extern int sysctl_core_destroy_delay;
 
 #ifdef CONFIG_NET_DIVERT
-extern char sysctl_divert_version[];
+extern const char sysctl_divert_version[];
 #endif /* CONFIG_NET_DIVERT */
 
 #ifdef CONFIG_XFRM
diff --git a/net/ipx/af_ipx.c b/net/ipx/af_ipx.c
index aa34ff4..94b3cb8 100644
--- a/net/ipx/af_ipx.c
+++ b/net/ipx/af_ipx.c
@@ -87,7 +87,7 @@ extern int ipxrtr_add_route(__u32 networ
 			    unsigned char *node);
 extern void ipxrtr_del_routes(struct ipx_interface *intrfc);
 extern int ipxrtr_route_packet(struct sock *sk, struct sockaddr_ipx *usipx,
-			       struct iovec *iov, int len, int noblock);
+			       struct iovec *iov, size_t len, int noblock);
 extern int ipxrtr_route_skb(struct sk_buff *skb);
 extern struct ipx_route *ipxrtr_lookup(__u32 net);
 extern int ipxrtr_ioctl(unsigned int cmd, void __user *arg);
diff --git a/net/irda/irsysctl.c b/net/irda/irsysctl.c
index 86805c3..7606ee7 100644
--- a/net/irda/irsysctl.c
+++ b/net/irda/irsysctl.c
@@ -44,9 +44,9 @@ extern int  sysctl_slot_timeout;
 extern int  sysctl_fast_poll_increase;
 extern char sysctl_devname[];
 extern int  sysctl_max_baud_rate;
-extern int  sysctl_min_tx_turn_time;
-extern int  sysctl_max_tx_data_size;
-extern int  sysctl_max_tx_window;
+extern unsigned  sysctl_min_tx_turn_time;
+extern unsigned  sysctl_max_tx_data_size;
+extern unsigned  sysctl_max_tx_window;
 extern int  sysctl_max_noreply_time;
 extern int  sysctl_warn_noreply_time;
 extern int  sysctl_lap_keepalive_time;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 1ab03a2..2a3657b 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -83,11 +83,11 @@ kmem_cache_t *sctp_chunk_cachep __read_m
 kmem_cache_t *sctp_bucket_cachep __read_mostly;
 
 extern int sctp_snmp_proc_init(void);
-extern int sctp_snmp_proc_exit(void);
+extern void sctp_snmp_proc_exit(void);
 extern int sctp_eps_proc_init(void);
-extern int sctp_eps_proc_exit(void);
+extern void sctp_eps_proc_exit(void);
 extern int sctp_assocs_proc_init(void);
-extern int sctp_assocs_proc_exit(void);
+extern void sctp_assocs_proc_exit(void);
 
 /* Return the address of the control sock. */
 struct sock *sctp_get_ctl_sock(void)


-- 
dwmw2

