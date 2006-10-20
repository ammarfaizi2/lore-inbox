Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946765AbWJTA6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946765AbWJTA6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946767AbWJTA6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:58:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55997 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1946765AbWJTA6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:58:40 -0400
Date: Fri, 20 Oct 2006 01:58:37 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061020005837.GX29920@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org> <20061020005337.GV29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020005337.GV29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More interesting: skbuff -> highmem.  That's a preliminary patch, needs
testing on more targets.

---
 drivers/infiniband/ulp/iser/iser_memory.c |    1 +
 drivers/net/sun3lance.c                   |    1 +
 fs/compat.c                               |    1 +
 include/linux/skbuff.h                    |   19 -------------------
 kernel/auditsc.c                          |    1 +
 net/appletalk/ddp.c                       |    1 +
 net/core/kmap_skb.h                       |   19 +++++++++++++++++++
 net/core/skbuff.c                         |    3 ++-
 net/core/sock.c                           |    1 +
 net/ipv4/ip_output.c                      |    1 +
 net/packet/af_packet.c                    |    1 +
 11 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 0606744..5e12250 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -35,6 +35,7 @@ #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <asm/io.h>
 #include <asm/scatterlist.h>
 #include <linux/scatterlist.h>
diff --git a/drivers/net/sun3lance.c b/drivers/net/sun3lance.c
index d353ddc..c62e85d 100644
--- a/drivers/net/sun3lance.c
+++ b/drivers/net/sun3lance.c
@@ -38,6 +38,7 @@ #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
 
+#include <asm/cacheflush.h>
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff --git a/fs/compat.c b/fs/compat.c
index 50624d4..0f06acb 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -45,6 +45,7 @@ #include <linux/nfsd/syscall.h>
 #include <linux/personality.h>
 #include <linux/rwsem.h>
 #include <linux/tsacct_kern.h>
+#include <linux/highmem.h>
 #include <linux/mm.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 85577a4..c9c83ae 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -23,7 +23,6 @@ #include <asm/atomic.h>
 #include <asm/types.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
-#include <linux/highmem.h>
 #include <linux/poll.h>
 #include <linux/net.h>
 #include <linux/textsearch.h>
@@ -1293,24 +1292,6 @@ static inline int pskb_trim_rcsum(struct
 	return __pskb_trim(skb, len);
 }
 
-static inline void *kmap_skb_frag(const skb_frag_t *frag)
-{
-#ifdef CONFIG_HIGHMEM
-	BUG_ON(in_irq());
-
-	local_bh_disable();
-#endif
-	return kmap_atomic(frag->page, KM_SKB_DATA_SOFTIRQ);
-}
-
-static inline void kunmap_skb_frag(void *vaddr)
-{
-	kunmap_atomic(vaddr, KM_SKB_DATA_SOFTIRQ);
-#ifdef CONFIG_HIGHMEM
-	local_bh_enable();
-#endif
-}
-
 #define skb_queue_walk(queue, skb) \
 		for (skb = (queue)->next;					\
 		     prefetch(skb->next), (skb != (struct sk_buff *)(queue));	\
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 42f2f11..ab97e51 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -64,6 +64,7 @@ #include <linux/list.h>
 #include <linux/tty.h>
 #include <linux/selinux.h>
 #include <linux/binfmts.h>
+#include <linux/highmem.h>
 #include <linux/syscalls.h>
 
 #include "audit.h"
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 708e2e0..a5b0f1a 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -61,6 +61,7 @@ #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <net/route.h>
 #include <linux/atalk.h>
+#include "../core/kmap_skb.h"
 
 struct datalink_proto *ddp_dl, *aarp_dl;
 static const struct proto_ops atalk_dgram_ops;
diff --git a/net/core/kmap_skb.h b/net/core/kmap_skb.h
new file mode 100644
index 0000000..283c2b9
--- /dev/null
+++ b/net/core/kmap_skb.h
@@ -0,0 +1,19 @@
+#include <linux/highmem.h>
+
+static inline void *kmap_skb_frag(const skb_frag_t *frag)
+{
+#ifdef CONFIG_HIGHMEM
+	BUG_ON(in_irq());
+
+	local_bh_disable();
+#endif
+	return kmap_atomic(frag->page, KM_SKB_DATA_SOFTIRQ);
+}
+
+static inline void kunmap_skb_frag(void *vaddr)
+{
+	kunmap_atomic(vaddr, KM_SKB_DATA_SOFTIRQ);
+#ifdef CONFIG_HIGHMEM
+	local_bh_enable();
+#endif
+}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3c23760..12e0c04 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -56,7 +56,6 @@ #include <linux/skbuff.h>
 #include <linux/cache.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
-#include <linux/highmem.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
@@ -67,6 +66,8 @@ #include <net/xfrm.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+#include "kmap_skb.h"
+
 static kmem_cache_t *skbuff_head_cache __read_mostly;
 static kmem_cache_t *skbuff_fclone_cache __read_mostly;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index b77e155..591c252 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -111,6 +111,7 @@ #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/tcp.h>
 #include <linux/init.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index fc195a4..fb1b21f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -53,6 +53,7 @@ #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/highmem.h>
 
 #include <linux/socket.h>
 #include <linux/sockios.h>
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f4ccb90..6c2313c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -71,6 +71,7 @@ #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 #include <asm/page.h>
+#include <asm/cacheflush.h>
 #include <asm/io.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-- 
1.4.2.GIT

