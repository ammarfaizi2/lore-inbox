Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbTFLPR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264856AbTFLPR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:17:27 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:13274 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264854AbTFLPR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:17:26 -0400
Date: Thu, 12 Jun 2003 21:03:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030612153355.GA1438@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612125630.GA19842@butterfly.hjsoft.com> <20030612135254.GA2482@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612135254.GA2482@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 07:22:54PM +0530, Dipankar Sarma wrote:
> I am not supprised at all by this, I can see two csets in Linus' tree 
> that will definitely break dcache -
> 
> 1. http://linux.bkbits.net:8080/linux-2.5/cset@1.1215.104.2?nav=index.html|ChangeSet@-2d
> 
> __d_drop() *must not* initialize d_hash fields. Lockfree lookup depends on
> that. If __d_drop() needs to be allowed on an unhashed dentry, the right
> thing to do would be to check for DCACHE_UNHASHED before unhashing. I will
> submit a patch a little later to do this.
> 
> 
> 2. http://linux.bkbits.net:8080/linux-2.5/cset@1.1215.104.1?nav=index.html|ChangeSet@-2d
> 
> hlist poison patch is broken. list_del_rcu() and hlist_del_rcu() 
> *must not* re-initialize the pointers. Maneesh submitted a patch
> earlier today that corrects this -
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105541206017154&w=2

John,

Can you try the patch below along with Maneesh's patch mentioned
above to see if they fix your problem ?

Thanks
Dipankar



Fix __d_drop() to be allowed on unhashed dentries correctly. Don't
re-initialize the pointers, instead check for DCACHE_UNHASHED
before really unhashing it.


 include/linux/dcache.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN include/linux/dcache.h~dentry-hash-init-fix include/linux/dcache.h
--- linux-2.5.70-bk16/include/linux/dcache.h~dentry-hash-init-fix	2003-06-12 20:43:32.000000000 +0530
+++ linux-2.5.70-bk16-dipankar/include/linux/dcache.h	2003-06-12 20:47:10.000000000 +0530
@@ -174,8 +174,10 @@ extern spinlock_t dcache_lock;
 
 static inline void __d_drop(struct dentry *dentry)
 {
-	dentry->d_vfs_flags |= DCACHE_UNHASHED;
-	hlist_del_rcu_init(&dentry->d_hash);
+	if (!(dentry->d_vfs_flags & DCACHE_UNHASHED)) {
+		dentry->d_vfs_flags |= DCACHE_UNHASHED;
+		hlist_del_rcu(&dentry->d_hash);
+	}
 }
 
 static inline void d_drop(struct dentry *dentry)

_
