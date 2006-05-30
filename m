Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWE3V4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWE3V4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWE3V4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:56:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25061 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932510AbWE3V4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:56:00 -0400
Subject: [Patch -rc5-mm1] Lockdep annotate rpc_populate for
	child-relationship of its mutex
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <adaodxf5i6h.fsf@cisco.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <adaac8z70yc.fsf@cisco.com> <20060530202654.GA25720@elte.hu>
	 <ada1wub6y6b.fsf@cisco.com> <20060530204901.GA27645@elte.hu>
	 <adawtc35iws.fsf@cisco.com>
	 <1149022880.3636.116.camel@laptopd505.fenrus.org>
	 <adaodxf5i6h.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 23:55:56 +0200
Message-Id: <1149026156.3636.126.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:14 -0700, Roland Dreier wrote:
> Here it is with KALLSYMS_ALL:


ok this ought to do it 


rpc_populate is creating a child inode in a directory, and the
parent already has it's mutex locked. Similar to the VFS code
this needs I_MUTEX_CHILD nesting annotation

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 net/sunrpc/rpc_pipe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rc5-mm1-lockdep/net/sunrpc/rpc_pipe.c
===================================================================
--- linux-2.6.17-rc5-mm1-lockdep.orig/net/sunrpc/rpc_pipe.c
+++ linux-2.6.17-rc5-mm1-lockdep/net/sunrpc/rpc_pipe.c
@@ -557,7 +557,7 @@ rpc_populate(struct dentry *parent,
 	struct dentry *dentry;
 	int mode, i;
 
-	mutex_lock(&dir->i_mutex);
+	mutex_lock_nested(&dir->i_mutex, I_MUTEX_CHILD);
 	for (i = start; i < eof; i++) {
 		dentry = d_alloc_name(parent, files[i].name);
 		if (!dentry)


