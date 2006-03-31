Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWCaDyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWCaDyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWCaDyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:54:38 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:6573 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751205AbWCaDyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:54:37 -0500
Date: Fri, 31 Mar 2006 11:54:29 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Karsten Keil <kkeil@suse.de>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Jan Kara <jack@suse.cz>,
       David Woodhouse <dwmw2@infradead.org>,
       Sridhar Samudrala <sri@us.ibm.com>
Subject: Re: [patch 3/8] use list_add_tail() instead of list_add()
Message-ID: <20060331035429.GA8767@miraclelinux.com>
References: <20060330081605.085383000@localhost.localdomain> <20060330081730.068972000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330081730.068972000@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 04:16:08PM +0800, Akinobu Mita wrote:
> This patch converts list_add(A, B.prev) to list_add_tail(A, &B)
> for readability.

>  drivers/isdn/capi/capi.c |    2 +-
>  fs/coda/psdev.c          |    2 +-
>  fs/coda/upcall.c         |    2 +-
>  fs/dcache.c              |    2 +-
>  fs/dquot.c               |    4 ++--
>  fs/jffs2/compr.c         |    4 ++--
>  net/sctp/outqueue.c      |    2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)

I realized that the replacements in isdn, jffs2, and sctp made them less
readable. Because these are trying to insert the list node into right
place, not trying to insert the tail of the list head.

This patch reverts them.

Index: 2.6-git/net/sctp/outqueue.c
===================================================================
--- 2.6-git.orig/net/sctp/outqueue.c
+++ 2.6-git/net/sctp/outqueue.c
@@ -370,7 +370,7 @@ static void sctp_insert_list(struct list
 		lchunk = list_entry(pos, struct sctp_chunk, transmitted_list);
 		ltsn = ntohl(lchunk->subh.data_hdr->tsn);
 		if (TSN_lt(ntsn, ltsn)) {
-			list_add_tail(new, pos);
+			list_add(new, pos->prev);
 			done = 1;
 			break;
 		}
Index: 2.6-git/drivers/isdn/capi/capi.c
===================================================================
--- 2.6-git.orig/drivers/isdn/capi/capi.c
+++ 2.6-git/drivers/isdn/capi/capi.c
@@ -238,7 +238,7 @@ static struct capiminor *capiminor_alloc
 		
 		if (minor < capi_ttyminors) {
 			mp->minor = minor;
-			list_add_tail(&mp->list, &p->list);
+			list_add(&mp->list, p->list.prev);
 		}
 	}
 		write_unlock_irqrestore(&capiminor_list_lock, flags);
Index: 2.6-git/fs/jffs2/compr.c
===================================================================
--- 2.6-git.orig/fs/jffs2/compr.c
+++ 2.6-git/fs/jffs2/compr.c
@@ -231,7 +231,7 @@ int jffs2_register_compressor(struct jff
 
         list_for_each_entry(this, &jffs2_compressor_list, list) {
                 if (this->priority < comp->priority) {
-                        list_add_tail(&comp->list, &this->list);
+                        list_add(&comp->list, this->list.prev);
                         goto out;
                 }
         }
@@ -394,7 +394,7 @@ reinsert:
         list_del(&comp->list);
         list_for_each_entry(this, &jffs2_compressor_list, list) {
                 if (this->priority < comp->priority) {
-                        list_add_tail(&comp->list, &this->list);
+                        list_add(&comp->list, this->list.prev);
                         spin_unlock(&jffs2_compressor_list_lock);
                         return 0;
                 }
