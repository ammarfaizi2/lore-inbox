Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVCYOfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVCYOfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVCYOfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:35:50 -0500
Received: from mail.dif.dk ([193.138.115.101]:1159 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261649AbVCYOfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:35:37 -0500
Date: Fri, 25 Mar 2005 15:37:28 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: ecashin@noserose.net, linux-kernel <linux-kernel@vger.kernel.org>,
       Greg K-H <greg@kroah.com>, axboe@suse.de
Subject: Re: [PATCH 2.6.11] aoe [5/12]: don't try to free null bufpool
In-Reply-To: <1111684626.6290.103.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0503251534540.2498@dragon.hyggekrogen.localhost>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com> 
 <1111677437.28285@geode.he.net>  <1111679884.6290.93.camel@laptopd505.fenrus.org>
  <1111683853.31205@geode.he.net> <1111684626.6290.103.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, Arjan van de Ven wrote:

> On Thu, 2005-03-24 at 09:04 -0800, ecashin@noserose.net wrote:
> > Arjan van de Ven <arjan@infradead.org> writes:
> > 
> > > On Thu, 2005-03-24 at 07:17 -0800, ecashin@noserose.net wrote:
> > >> don't try to free null bufpool
> > >
> > > in linux there is a "rule" that all memory free routines are supposed to
> > > also accept NULL as argument, so I think this patch is not needed (and
> > > even wrong)
> > >
> > 
> > Hmm.  The mm/mempool.c:mempool_destroy function immediately
> > dereferences the pointer passed to it:
> > 
> > void mempool_destroy(mempool_t *pool)
> > {
> > 	if (pool->curr_nr != pool->min_nr)
> > 		BUG();		/* There were outstanding elements */
> > 	free_pool(pool);
> > }
> > 
> > ... so I'm not sure mempool_destroy fits the rule.  Are you suggesting
> > that the patch should instead modify mempool_destroy?
> 
> hmm perhaps... Jens?
> 

Having mempool_destroy() be the one that checks seems safer, then callers 
won't forget to check - easier to just check in one place.
If that's what you want, then here's a patch. If this is acceptable I can 
create another one that removes the (then pointless) NULL checks from all 
callers - let me know if that's wanted.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/mm/mempool.c	2005-03-21 23:12:43.000000000 +0100
+++ linux-2.6.12-rc1-mm3/mm/mempool.c	2005-03-25 15:34:04.000000000 +0100
@@ -176,6 +176,8 @@ EXPORT_SYMBOL(mempool_resize);
  */
 void mempool_destroy(mempool_t *pool)
 {
+	if (!pool)
+		return;
 	if (pool->curr_nr != pool->min_nr)
 		BUG();		/* There were outstanding elements */
 	free_pool(pool);


