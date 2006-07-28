Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752028AbWG1QPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbWG1QPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbWG1QPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:15:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:54659 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752028AbWG1QPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:15:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=YCx6uZQH3/n4463Aya+7piQJAnZ5ccSzxnsKYAG8TzmFw0UvFkxHn4LEf1jm1U6q9qaRgKjrryTdLjA6xS635y/jUNRXOqrBLqA3gpecaGTSHNdZ10U+2ZkcbpVwwSlhIuLTiGVJG5S1adCUjHCoAwGR92mcpZQa2v/vLEJDUzY=
Date: Fri, 28 Jul 2006 18:15:17 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, acme@mandriva.com, marcel@holtmann.org, jet@gyve.org
Subject: [01/04 mm-patch, rfc] Add lightweight rwlock (was Re: [mm-patch] bluetooth: use GFP_ATOMIC in *_sock_create's sk_alloc)
Message-ID: <20060728161515.GA1227@slug>
References: <20060728083532.GA311@slug> <20060728.181756.135980869.jet@gyve.org> <20060728123246.GB311@slug> <20060728.221252.265353941.jet@gyve.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20060728.221252.265353941.jet@gyve.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2006 at 10:12:52PM +0900, Masatake YAMATO wrote:
> Hi,
> > On Fri, Jul 28, 2006 at 06:17:56PM +0900, Masatake YAMATO wrote:
> > > > I think that the bluetooth-guard-bt_proto-with-rwlock.patch introduced the following
> > > > BUG:
> > > > [   43.232000] BUG: sleeping function called from invalid context at mm/slab.c:2903
> > > > [   43.232000] in_atomic():1, irqs_disabled():0
> > > > [   43.232000]  [<c0104114>] show_trace_log_lvl+0x197/0x1ba
> > > > [   43.232000]  [<c010415e>] show_trace+0x27/0x29
> > > > [   43.232000]  [<c010426e>] dump_stack+0x26/0x28
> > > > [   43.232000]  [<c011ad1c>] __might_sleep+0xa2/0xaa
> > > > [   43.232000]  [<c0173085>] __kmalloc+0x9c/0xb3
> > > > [   43.232000]  [<c02f9295>] sk_alloc+0x1bc/0x1de
> > > > [   43.232000]  [<c036d689>] hci_sock_create+0x42/0x8a
> > > > [   43.236000]  [<c0366f40>] bt_sock_create+0xb5/0x154
> > > > [   43.236000]  [<c02f69dc>] __sock_create+0x131/0x356
> > > > [   43.236000]  [<c02f6c2f>] sock_create+0x2e/0x30
> > > > [   43.236000]  [<c02f6c88>] sys_socket+0x27/0x53
> > > > [   43.240000]  [<c02f7db5>] sys_socketcall+0xa9/0x277
> > > > [   43.240000]  [<c0103131>] sysenter_past_esp+0x56/0x8d
> > > > [   43.240000]  [<b7f38410>] 0xb7f38410
> > > > 
> > > > 
> > > > This patch makes sk_alloc GFP_ATOMIC, because we are holding the bt_proto_rwlock, for
> > > > the following functions:
> > > > - bnep_sock_create
> > > > - cmtp_sock_create
> > > > - hci_sock_create
> > > > - hidp_sock_create
> > > > - l2cap_sock_create
> > > > - rfcomm_sock_create
> > > > - sco_sock_create
> > > 
> > > There is very similar code in i net/socket.c(I guess some part of
> > > bluetooth/af_bluetooth.c is derived from net/socket.c):
> > > 
> > [... skip net/socket.c code ...]
> > > 
> > > So there are two ways to avoid the bug:
> > > 1. As proposed by Frederik, use sk_alloc with GFP_ATOMIC or
> > > 2. use net_family_{read|writ}_{lock|unlock} in af_bluetooth.c.
> > > 
> > I'd say that using a net_family_* like function set is much better,
> > if only in terms of preemptibility. 
> > 
> > I'll write an implementation that allows to use the same code
> > in socket.c and in af_bluetooth.c
> > 
> I found one more similar code set at net/dccp/ccid.c for the same purpose:
OK, thanks, I modified it too.

The following set of patches adds a struct lw_rwlock (for lightweight
rwlock) which contains a spin_lock_t and an atomic_t. It is defined
in include/linux/lw_rwlock.h.

This lw_rwlock aims at protecting structures that are modified very rarely
and quickly. This assumptions allow the reader to merely increment the
atomic_t, allowing it to sleep why the lw_rwlock is help.

There were already two users of this kind of API: net/socket.c to protect
'net_families' and net/dccp/ccid.c to protect 'ccids'. As suggested
by Masatake YAMATO, this looked like good way to protect 'bt_proto'
in net/bluetooth/af_bluetooth.c as well. This patchset aims at having
only one implementation in the kernel.

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

 include/linux/lw_rwlock.h    |   71 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/af_bluetooth.c |   15 ++++-----
 net/dccp/ccid.c              |   63 +++++++-------------------------------
 net/socket.c                 |   58 ++++-------------------------------
 4 files changed, 100 insertions(+), 107 deletions(-)

--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="lw_rwlock-include-file.patch"

--- v2.6.18-rc2-mm1~ori/include/linux/lw_rwlock.h	1970-01-01 01:00:00.000000000 +0100
+++ v2.6.18-rc2-mm1/include/linux/lw_rwlock.h	2006-07-28 17:25:04.000000000 +0200
@@ -0,0 +1,71 @@
+#ifndef __LINUX_LW_RWLOCK_H
+#define __LINUX_LW_RWLOCK_H
+
+/*
+ * LightWeight readwriter lock.
+ * The strategy is: modifications while the lock is held are short, do not
+ * sleep and veeery rare, but read access should be free of any exclusive
+ * locks.
+ * The original implementation was written for net/socket.c
+ */
+
+#include <linux/spinlock.h>
+
+
+struct lw_rwlock {
+	/* tracks down the number of current readers */
+	atomic_t readers;
+	/* the actual lock, only held by writers */
+	spinlock_t lock;
+};
+
+#define __LW_RWLOCK_UNLOCKED(lockname) \
+		 { { 0 }, __SPIN_LOCK_UNLOCKED(lockname) }
+
+#define lw_rwlock_init(x) \
+		do { *(x) = (lw_rwlock_t) __LW_RWLOCK_UNLOCKED(x); } while (0)
+
+#define DEFINE_LW_RWLOCK(x) \
+		struct lw_rwlock x = __LW_RWLOCK_UNLOCKED(x)
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+
+static inline void lw_write_lock(struct lw_rwlock *l)
+{
+	spin_lock(&l->lock);
+	while (atomic_read(&l->readers) != 0) {
+		spin_unlock(&l->lock);
+
+		yield();
+
+		spin_lock(&l->lock);
+	}
+}	
+
+static inline void lw_write_unlock(struct lw_rwlock *l) 
+{
+	spin_unlock(&l->lock);
+}
+
+static inline void lw_read_lock(struct lw_rwlock *l)
+{
+	atomic_inc(&l->readers);
+	spin_unlock_wait(&l->lock);
+}
+
+static inline void lw_read_unlock(struct lw_rwlock *l)
+{
+	atomic_dec(&l->readers);
+}
+
+#else
+
+#define lw_write_lock(x) do { } while(0)
+#define lw_write_unlock(x) do { } while(0)
+#define lw_read_lock(x) do { } while(0)
+#define lw_read_unlock() do { } while(0)
+
+#endif /* CONFIG_SMP || CONFIG_PREEMPT */
+
+
+#endif /* __LINUX_LW_RWLOCK_H */

--DKU6Jbt7q3WqK7+M--
