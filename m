Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSJXXYb>; Thu, 24 Oct 2002 19:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265610AbSJXXYb>; Thu, 24 Oct 2002 19:24:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:45979 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265516AbSJXXY1>;
	Thu, 24 Oct 2002 19:24:27 -0400
Message-ID: <3DB88298.735FD044@digeo.com>
Date: Thu, 24 Oct 2002 16:30:32 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: cmm@us.ibm.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]updated ipc lock patch
References: <3DB87458.F5C7DABA@digeo.com> <Pine.LNX.4.44.0210242342460.1169-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 23:30:32.0563 (UTC) FILETIME=[589AC430:01C27BB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> ...
> Manfred and I have both reviewed the patch (or the 2.5.44 version)
> and we both recommend it highly (well, let Manfred speak for himself).
> 

OK, thanks.

So I took a look.  Wish I hadn't :(  The locking rules in there
are outrageously uncommented.  You must be brave people.

What about this code?

void ipc_rcu_free(void* ptr, int size)
{
        struct rcu_ipc_free* arg;

        arg = (struct rcu_ipc_free *) kmalloc(sizeof(*arg), GFP_KERNEL);
        if (arg == NULL)
                return;
        arg->ptr = ptr;
        arg->size = size;
        call_rcu(&arg->rcu_head, ipc_free_callback, arg);
}

Are we sure that it's never called under locks?

And it seems that if the kmalloc fails, we decide to leak some
memory, yes?

If so it would be better to use GFP_ATOMIC there.  Avoids any
locking problems and also increases the chance of the allocation
succeeding.  (With an explanatory comment, naturally :)).

Even better: is it possible to embed the rcu_ipc_free inside the
object-to-be-freed?  Perhaps not?


Stylistically, it is best to not typecast the return value
from kmalloc, btw.  You should never typecast the return
value of anything which returns a void *, because it weakens
your compile-time checking.  Example:

	foo *bar = (foo *)zot();

The compiler will swallow that, regardless of what zot() returns.
Someone could go and change zot() to return a reiserfs_inode *
and you would never know about it.  Whereas:

	foo *bar = zot();

Says to the compiler "zot() must return a bar * or a void *",
which is much tighter checking, yes?
	

There is an insane amount of inlining in the ipc code.  I
couldn't keep my paws off it.

Before:
mnm:/usr/src/25> size ipc/*.o
   text    data     bss     dec     hex filename
  28346     224     192   28762    705a ipc/built-in.o
   7390      20      64    7474    1d32 ipc/msg.o
  11236      16      64   11316    2c34 ipc/sem.o
   8136     160      64    8360    20a8 ipc/shm.o
   1584       0       0    1584     630 ipc/util.o

After:
mnm:/usr/src/25> size ipc/*.o
   text    data     bss     dec     hex filename
  19274     224     192   19690    4cea ipc/built-in.o
   4846      20      64    4930    1342 ipc/msg.o
   7636      16      64    7716    1e24 ipc/sem.o
   4808     160      64    5032    13a8 ipc/shm.o
   1984       0       0    1984     7c0 ipc/util.o



--- 25/ipc/util.h~ipc-akpm	Thu Oct 24 16:03:32 2002
+++ 25-akpm/ipc/util.h	Thu Oct 24 16:08:25 2002
@@ -54,63 +54,11 @@ void* ipc_alloc(int size);
 void ipc_free(void* ptr, int size);
 void ipc_rcu_free(void* arg, int size);
 
-extern inline struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
-{
-	struct kern_ipc_perm* out;
-	int lid = id % SEQ_MULTIPLIER;
-	if(lid >= ids->size)
-		return NULL;
-	rmb();
-	out = ids->entries[lid].p;
-	return out;
-}
-
-extern inline struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
-{
-	struct kern_ipc_perm* out;
-	int lid = id % SEQ_MULTIPLIER;
-
-	rcu_read_lock();
-	if(lid >= ids->size) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	rmb();
-	out = ids->entries[lid].p;
-	if(out == NULL) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	spin_lock(&out->lock);
-	
-	/* ipc_rmid() may have already freed the ID while ipc_lock
-	 * was spinning: here verify that the structure is still valid
-	 */
-	if (out->deleted) {
-		spin_unlock(&out->lock);
-		rcu_read_unlock();
-		return NULL;
-	}
-	return out;
-}
-
-extern inline void ipc_unlock(struct kern_ipc_perm* perm)
-{
-	spin_unlock(&perm->lock);
-	rcu_read_unlock();
-}
-
-extern inline int ipc_buildid(struct ipc_ids* ids, int id, int seq)
-{
-	return SEQ_MULTIPLIER*seq + id;
-}
-
-extern inline int ipc_checkid(struct ipc_ids* ids, struct kern_ipc_perm* ipcp, int uid)
-{
-	if(uid/SEQ_MULTIPLIER != ipcp->seq)
-		return 1;
-	return 0;
-}
+struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id);
+struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id);
+void ipc_unlock(struct kern_ipc_perm* perm);
+int ipc_buildid(struct ipc_ids* ids, int id, int seq);
+int ipc_checkid(struct ipc_ids* ids, struct kern_ipc_perm* ipcp, int uid);
 
 void kernel_to_ipc64_perm(struct kern_ipc_perm *in, struct ipc64_perm *out);
 void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out);
--- 25/ipc/util.c~ipc-akpm	Thu Oct 24 16:07:07 2002
+++ 25-akpm/ipc/util.c	Thu Oct 24 16:07:51 2002
@@ -359,6 +359,61 @@ void ipc64_perm_to_ipc_perm (struct ipc6
 	out->seq	= in->seq;
 }
 
+struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
+{
+	struct kern_ipc_perm* out;
+	int lid = id % SEQ_MULTIPLIER;
+	if(lid >= ids->size)
+		return NULL;
+	rmb();
+	out = ids->entries[lid].p;
+	return out;
+}
+
+struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
+{
+	struct kern_ipc_perm* out;
+	int lid = id % SEQ_MULTIPLIER;
+
+	rcu_read_lock();
+	if(lid >= ids->size)
+		goto fail;
+	rmb();
+	out = ids->entries[lid].p;
+	if (out == NULL)
+		goto fail;
+	spin_lock(&out->lock);
+	
+	/* ipc_rmid() may have already freed the ID while ipc_lock
+	 * was spinning: here verify that the structure is still valid
+	 */
+	if (!out->deleted)
+		return out;
+
+	spin_unlock(&out->lock);
+fail:
+	rcu_read_unlock();
+	return NULL;
+}
+
+void ipc_unlock(struct kern_ipc_perm* perm)
+{
+	spin_unlock(&perm->lock);
+	rcu_read_unlock();
+}
+
+int ipc_buildid(struct ipc_ids* ids, int id, int seq)
+{
+	return SEQ_MULTIPLIER*seq + id;
+}
+
+int ipc_checkid(struct ipc_ids* ids, struct kern_ipc_perm* ipcp, int uid)
+{
+	if(uid/SEQ_MULTIPLIER != ipcp->seq)
+		return 1;
+	return 0;
+}
+
 #ifndef __ia64__
 
 /**

.
