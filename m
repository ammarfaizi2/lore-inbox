Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWCIG0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWCIG0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWCIG0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:26:31 -0500
Received: from smtp-out.google.com ([216.239.45.12]:15953 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751435AbWCIG0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:26:30 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=aIm7yC81PVCOPg6u5Sf+wkhYQsrWALHKFTK7jf5WEjVtPtMFM4rK97y47IvsExwSy
	dKn0Rlb32Zj3J7TQDU6QA==
Message-ID: <440FCA81.7090608@google.com>
Date: Wed, 08 Mar 2006 22:26:09 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
References: <4408C2E8.4010600@google.com>	<20060303233617.51718c8e.akpm@osdl.org>	<440B9035.1070404@google.com>	<20060306025800.GA27280@ca-server1.us.oracle.com>	<440BC1C6.1000606@google.com>	<20060306195135.GB27280@ca-server1.us.oracle.com>	<p733bhvgc7f.fsf@verdi.suse.de> <20060307045835.GF27280@ca-server1.us.oracle.com>
In-Reply-To: <20060307045835.GF27280@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:
> On Tue, Mar 07, 2006 at 04:34:12AM +0100, Andi Kleen wrote:
>>Did you actually do some statistics how long the hash chains are? 
>>Just increasing hash tables blindly has other bad side effects, like
>>increasing cache misses.
> 
> Yep, the gory details are at:
> 
> http://oss.oracle.com/~mfasheh/lock_distribution.csv

Hi Mark,

I don't know how you got your statistics, but I went to the bother of
writing a proc interface to dump the bucket counts.  Mostly to try out the
seq_file interface, though it turned into something more of a tour through
the slimy unberbelly of seq_read.  (This patch includes surgery for one of
the several bunions I found there - seq_read failed to distinguish between
"buffer full" and "buffer overrun", expanding the buffer unnecessarily in
the former case).  This also includes my simple-minded big hash table
code, with a 256K table size this time.

This proc interface always names itself /proc/ocfs2hash (a bug if you
create more than one lockspace).  It gives the chain length as a uint32_t
per bucket.

Dump the buckets like this:

    cat /proc/ocfs2hash | hexdump -e'32 " %1.1X" "\n"'

To total the buckets:

    cat /proc/ocfs2hash | hexdump -v -e'"%1.1d\n"' | awk '{sum += $1} END {print "Total: ", sum;}'

After untarring four kernel trees, number of locks hits a peak of 128K.
With 64K buckets the hash, a typical region of the table looks like:

  3 0 3 6 1 2 2 1 2 6 1 0 1 2 1 0 0 3 1 2 2 3 1 2 5 3 2 2 1 0 3 1
  1 1 3 5 2 2 1 0 2 3 3 1 3 0 5 2 2 3 0 2 1 3 1 2 4 2 0 2 5 1 4 3
  5 3 3 3 3 1 4 1 2 1 2 6 2 1 3 0 2 2 2 8 1 2 2 2 3 1 0 1 3 2 1 1
  1 2 2 2 2 3 2 0 2 2 2 5 2 3 2 1 1 2 6 6 1 2 2 4 2 0 3 0 3 3 3 0
  2 2 1 1 2 3 2 0 2 3 3 1 3 3 3 1 4 2 8 3 2 2 2 4 3 0 1 2 3 4 2 0
  3 1 0 1 2 2 3 1 4 2 1 1 3 3 4 3 3 3 4 2 1 4 2 1 5 2 1 3 1 2 3 2
  1 0 1 5 3 2 1 2 3 0 1 1 2 3 4 4 4 1 3 1 4 3 2 2 4 4 1 3 1 0 0 1
  3 1 1 3 0 3 0 1 1 1 1 1 3 4 4 2 4 3 4 2 3 3 0 3 4 2 1 5 4 1 3 1
  1 0 1 0 1 4 1 2 1 4 2 0 2 2 5 2 1 1 1 2 3 6 4 5 5 1 1 2 3 1 5 1
  3 0 1 0 3 3 2 0 2 1 2 1 0 4 3 2 1 0 1 0 2 7 1 3 2 1 1 2 4 1 3 1
  2 2 3 1 3 3 1 2 0 2 1 3 1 2 0 4 4 1 2 1 2 3 3 6 0 5 2 1 1 0 3 0
  1 0 2 0 4 3 2 1 0 0 2 0 1 4 2 4 5 1 0 1 3 2 2 1 1 3 2 3 0 2 1 1
  3 0 0 0 2 5 3 1 0 2 0 1 0 0 2 0 4 2 1 2 4 3 0 1 2 4 1 3 0 0 1 4

A poor distribution as you already noticed[1].  Even if it was a great
distribution, we would still average a little over two nodes per bucket
twice as many as we should allow unless you believe that people running
cluster filesystems have too much time on their hands and need to waste
some of it waiting for the computer to chew its way through millions
of cold cache lines.

So if we improve the hash function, 128K buckets (512K table size) is
the right number, given a steady-state number of hash resources around
128K.  This is pretty much independent of load: if you run light loads
long enough, you will eventually fill up the hash table.  Of course, if
we take a critical look at your locking strategy we might find some fat
to cut there too.  Could I possibly interest you in writing up a tech
note on your global locking strategy?

[1] And this is our all-important dentry hash function.  Oops.

Regards,

Daniel

diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmcommon.h 2.6.16/fs/ocfs2/dlm/dlmcommon.h
--- 2.6.16.clean/fs/ocfs2/dlm/dlmcommon.h	2006-03-02 19:05:13.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmcommon.h	2006-03-08 15:47:53.000000000 -0800
@@ -36,8 +36,8 @@
  #define DLM_LOCK_RES_OWNER_UNKNOWN     O2NM_MAX_NODES
  #define DLM_THREAD_SHUFFLE_INTERVAL    5     // flush everything every 5 passes
  #define DLM_THREAD_MS                  200   // flush at least every 200 ms
-
-#define DLM_HASH_BUCKETS     (PAGE_SIZE / sizeof(struct hlist_head))
+#define DLM_HASH_SIZE		(1 << 18)
+#define DLM_HASH_BUCKETS	(DLM_HASH_SIZE / sizeof(struct hlist_head))

  enum dlm_ast_type {
  	DLM_AST = 0,
diff -urp 2.6.16.clean/fs/ocfs2/dlm/dlmdomain.c 2.6.16/fs/ocfs2/dlm/dlmdomain.c
--- 2.6.16.clean/fs/ocfs2/dlm/dlmdomain.c	2006-03-02 16:47:47.000000000 -0800
+++ 2.6.16/fs/ocfs2/dlm/dlmdomain.c	2006-03-08 20:26:47.000000000 -0800
@@ -33,6 +33,7 @@
  #include <linux/spinlock.h>
  #include <linux/delay.h>
  #include <linux/err.h>
+#include <linux/vmalloc.h>

  #include "cluster/heartbeat.h"
  #include "cluster/nodemanager.h"
@@ -49,6 +50,80 @@
  #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_DOMAIN)
  #include "cluster/masklog.h"

+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+
+static void hashdump_stop(struct seq_file *seq, void *v)
+{
+};
+
+static void *hashdump_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return *pos < DLM_HASH_SIZE ? (++*pos, pos) : NULL;
+};
+
+static void *hashdump_start(struct seq_file *seq, loff_t *pos)
+{
+	return *pos < DLM_HASH_SIZE ? pos : NULL;
+};
+
+int hashdump_show(struct seq_file *seq, void *v)
+{
+	loff_t *ppos = v, pos = *ppos;
+	int len = seq->size - seq->count, tail = DLM_HASH_SIZE - pos;
+
+	if (len > tail)
+		len = tail;
+	memcpy(seq->buf + seq->count, seq->private + pos, len);
+	seq->count += len;
+	*ppos += len - 1;
+	return 0;
+}
+
+static struct seq_operations hashdump_ops = {
+	.start = hashdump_start,
+	.next = hashdump_next,
+	.stop = hashdump_stop,
+	.show = hashdump_show
+};
+
+static int hashdump_open(struct inode *inode, struct file *file)
+{
+	int err = seq_open(file, &hashdump_ops);
+	if (!err) {
+		struct seq_file *seq = file->private_data;
+		int size = DLM_HASH_BUCKETS * sizeof(int), *vec = vmalloc(size);
+		if (vec) {
+			struct dlm_ctxt *dlm = PDE(inode)->data;
+			struct hlist_head *heads = dlm->lockres_hash;
+			struct hlist_node *node;
+			struct dlm_lock_resource *res;
+			int i;
+
+			memset(vec, 0, size);
+			for (i = 0; i < DLM_HASH_BUCKETS; i++)
+				hlist_for_each_entry(res, node, heads + i, hash_node)
+					vec[i]++;
+			seq->private = vec;
+		}
+	}
+	return err;
+};
+
+int hashdump_release(struct inode *inode, struct file *file)
+{
+	vfree(((struct seq_file *)file->private_data)->private);
+	return seq_release(inode, file);
+}
+
+static struct file_operations hashdump_file_ops = {
+	.owner   = THIS_MODULE,
+	.open    = hashdump_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = hashdump_release
+};
+
  /*
   *
   * spinlock lock ordering: if multiple locks are needed, obey this ordering:
@@ -194,7 +269,7 @@ static int dlm_wait_on_domain_helper(con
  static void dlm_free_ctxt_mem(struct dlm_ctxt *dlm)
  {
  	if (dlm->lockres_hash)
-		free_page((unsigned long) dlm->lockres_hash);
+		vfree(dlm->lockres_hash);

  	if (dlm->name)
  		kfree(dlm->name);
@@ -223,6 +298,7 @@ static void dlm_ctxt_release(struct kref

  	wake_up(&dlm_domain_events);

+	remove_proc_entry("ocfs2hash", NULL);
  	dlm_free_ctxt_mem(dlm);

  	spin_lock(&dlm_domain_lock);
@@ -1191,7 +1267,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
  		goto leave;
  	}

-	dlm->lockres_hash = (struct hlist_head *) __get_free_page(GFP_KERNEL);
+	dlm->lockres_hash = (struct hlist_head *)vmalloc(DLM_HASH_SIZE);
  	if (!dlm->lockres_hash) {
  		mlog_errno(-ENOMEM);
  		kfree(dlm->name);
@@ -1203,6 +1279,14 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
  	for (i=0; i<DLM_HASH_BUCKETS; i++)
  		INIT_HLIST_HEAD(&dlm->lockres_hash[i]);

+	{
+	struct proc_dir_entry *entry = create_proc_entry("ocfs2hash", 0, NULL);
+	if (entry) {
+		entry->proc_fops = &hashdump_file_ops;
+		entry->data = dlm;
+	}
+	}
+
  	strcpy(dlm->name, domain);
  	dlm->key = key;
  	dlm->node_num = o2nm_this_node();
diff -urp 2.6.16.clean/fs/seq_file.c 2.6.16/fs/seq_file.c
--- 2.6.16.clean/fs/seq_file.c	2006-02-12 16:27:25.000000000 -0800
+++ 2.6.16/fs/seq_file.c	2006-03-08 16:59:27.000000000 -0800
@@ -106,18 +106,17 @@ ssize_t seq_read(struct file *file, char
  		if (!size)
  			goto Done;
  	}
+expand:
  	/* we need at least one record in buffer */
-	while (1) {
-		pos = m->index;
-		p = m->op->start(m, &pos);
-		err = PTR_ERR(p);
-		if (!p || IS_ERR(p))
-			break;
-		err = m->op->show(m, p);
-		if (err)
-			break;
-		if (m->count < m->size)
-			goto Fill;
+	pos = m->index;
+	p = m->op->start(m, &pos);
+	err = PTR_ERR(p);
+	if (!p || IS_ERR(p))
+		goto Errstop;
+
+	err = m->op->show(m, p);
+
+	if (err == -1) {
  		m->op->stop(m, p);
  		kfree(m->buf);
  		m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
@@ -125,12 +124,12 @@ ssize_t seq_read(struct file *file, char
  			goto Enomem;
  		m->count = 0;
  		m->version = 0;
+		goto expand;
  	}
-	m->op->stop(m, p);
-	m->count = 0;
-	goto Done;
-Fill:
-	/* they want more? let's try to get some more */
+
+	if (err)
+		goto Errstop;
+
  	while (m->count < size) {
  		size_t offs = m->count;
  		loff_t next = pos;
@@ -172,6 +171,10 @@ Enomem:
  Efault:
  	err = -EFAULT;
  	goto Done;
+Errstop:
+	m->op->stop(m, p);
+	m->count = 0;
+	goto Done;
  }
  EXPORT_SYMBOL(seq_read);


