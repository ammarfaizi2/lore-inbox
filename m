Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWCFC6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWCFC6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 21:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWCFC6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 21:58:14 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:16680 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751026AbWCFC6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 21:58:14 -0500
Date: Sun, 5 Mar 2006 18:58:00 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Daniel Phillips <phillips@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
Message-ID: <20060306025800.GA27280@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org> <440B9035.1070404@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440B9035.1070404@google.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 05:28:21PM -0800, Daniel Phillips wrote:
> Note, this is uniprocessor, single node on a local disk.  Something
> pretty badly broken all right.  Tomorrow I will take a look at the hash
> distribution and see what's up.
> 
> I guess there are about 250k symbols in the table before purging
> finally kicks in, which happens 5th or 6th time I untar a kernel tree.
> So, 20,000 names times 5-6 times the three locks per inode Mark
> mentioned.  I'll actually measure that tomorrow instead of inferring
> it.
> 
> I think this table is per-ocfs2-mount, and really really, a meg is
> nothing if it makes CPU cycles  go away.  That's .05% of the memory
> on this box, which is a small box where clusters are concerned.  But
> there is also some gratuitous cpu suck still happening in there that
> needs investigating.  I would not be surprised at all to learn that
> full_name_hash is a terrible hash function.
Can you try the attached patch? Here's a sample OCFS2 lock name:

M0000000000000000036cc0458354c5

So as you can see, things at the beginning of the name are very regular -
something that I don't think full_name_hash() is handling very well. I
hacked a (barely) new hash function to avoid the first 7 bytes and it
reliably saves me 2 seconds in real time on my untars. I think we can
actually make it much better (this is still pretty dumb) than that, but I'm
just curious as to how much it helps on your tests.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 8f3a9e3..06cebb2 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -81,6 +81,15 @@ void __dlm_unhash_lockres(struct dlm_loc
 	dlm_lockres_put(lockres);
 }
 
+static inline unsigned int
+dlm_name_hash(const unsigned char *name, unsigned int len)
+{
+	/* optimize for OCFS2 lock names */
+	if (len > 7)
+		return full_name_hash(&name[7], len - 7);
+	return full_name_hash(name, len);
+}
+
 void __dlm_insert_lockres(struct dlm_ctxt *dlm,
 		       struct dlm_lock_resource *res)
 {
@@ -90,7 +99,7 @@ void __dlm_insert_lockres(struct dlm_ctx
 	assert_spin_locked(&dlm->spinlock);
 
 	q = &res->lockname;
-	q->hash = full_name_hash(q->name, q->len);
+	q->hash = dlm_name_hash(q->name, q->len);
 	bucket = &(dlm->lockres_hash[q->hash % DLM_HASH_BUCKETS]);
 
 	/* get a reference for our hashtable */
@@ -112,7 +121,7 @@ struct dlm_lock_resource * __dlm_lookup_
 
 	assert_spin_locked(&dlm->spinlock);
 
-	hash = full_name_hash(name, len);
+	hash = dlm_name_hash(name, len);
 
 	bucket = &(dlm->lockres_hash[hash % DLM_HASH_BUCKETS]);
 
