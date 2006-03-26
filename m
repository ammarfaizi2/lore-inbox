Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWCZMZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWCZMZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWCZMZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:25:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60932 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751306AbWCZMZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:25:16 -0500
Date: Sun, 26 Mar 2006 14:25:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix nfs PROC_FS=n compile error
Message-ID: <20060326122515.GJ4053@stusta.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
>...
> Boilerplate:
>...
> Changes since 2.6.16-rc6-mm2:
>...
>  git-nfs.patch
>...
>  git trees.
>...


This patch fixes the following compile error with CONFIG_PROC_FS=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
fs/built-in.o: In function `nfs_show_stats':inode.c:(.text+0x15481a): undefined reference to `rpc_print_iostats'
net/built-in.o: In function `rpc_destroy_client': undefined reference to `rpc_free_iostats'
net/built-in.o: In function `rpc_clone_client': undefined reference to `rpc_alloc_iostats'
net/built-in.o: In function `rpc_new_client': undefined reference to `rpc_alloc_iostats'
net/built-in.o: In function `xprt_release': undefined reference to `rpc_count_iostats'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/sunrpc/metrics.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- linux-2.6.16-mm1-full/include/linux/sunrpc/metrics.h.old	2006-03-26 00:05:50.000000000 +0100
+++ linux-2.6.16-mm1-full/include/linux/sunrpc/metrics.h	2006-03-26 00:13:46.000000000 +0100
@@ -69,9 +69,21 @@
 /*
  * EXPORTed functions for managing rpc_iostats structures
  */
+
+#ifdef CONFIG_PROC_FS
+
 struct rpc_iostats *	rpc_alloc_iostats(struct rpc_clnt *);
 void			rpc_count_iostats(struct rpc_task *);
 void			rpc_print_iostats(struct seq_file *, struct rpc_clnt *);
 void			rpc_free_iostats(struct rpc_iostats *);
 
+#else  /*  CONFIG_PROC_FS  */
+
+static inline struct rpc_iostats *rpc_alloc_iostats(struct rpc_clnt *clnt) { return NULL; }
+static inline void rpc_count_iostats(struct rpc_task *task) {}
+static inline void rpc_print_iostats(struct seq_file *seq, struct rpc_clnt *clnt) {}
+static inline void rpc_free_iostats(struct rpc_iostats *stats) {}
+
+#endif  /*  CONFIG_PROC_FS  */
+
 #endif /* _LINUX_SUNRPC_METRICS_H */

