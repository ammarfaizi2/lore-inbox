Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263966AbTI2Rk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbTI2RiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:38:18 -0400
Received: from coderock.org ([193.77.147.115]:15372 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263930AbTI2Req (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:34:46 -0400
From: Domen Puncer <domen@coderock.org>
To: intermezzo-devel@lists.sourceforge.net
Subject: replicator.c - bug in izo_rep_cache_clean()?
Date: Mon, 29 Sep 2003 19:34:39 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309291934.39891.domen@coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Another repost after more than a month, since this bug is still in kernel tree.
Now CC-ing lkml, folks at intermezzo ml don't care?

I've been doing some janitor work and came across this:


On Saturday 12 of July 2003 18:07, Matthew Wilcox wrote:
> On Sat, Jul 12, 2003 at 05:22:55PM +0200, Domen Puncer wrote:
> > ---
> > fs/intermezzo/replicator.c:83: //izo_rep_cache_clean()
> >                 tmp = bucket = &fset->fset_clients[i];
> >
> >                 tmp = tmp->next;
> >                 while (tmp != bucket) {
> >                         struct izo_offset_rec *offrec;
> >                         tmp = tmp->next;
> >                         list_del(tmp);
> >                         offrec = list_entry(tmp, struct izo_offset_rec,
> >                                             or_list);
> >                         PRESTO_FREE(offrec, sizeof(struct
> > izo_offset_rec)); }
> >
> > This code just doesn't look right.
> > We delete tmp (tmp->next = LIST_POISON1)... next time we'll
> >  list_del(LIST_POISON1)!!
> > We also do not delete first entry in the list
> > &fset->fset_clients[i]->next.
>
> Yup, looks like a bug.  I bet they meant to list_del(&tmp->prev).

I guess it could be written like this:
	list_for_each_save(tmp, next, bucket) {
		struct izo_offset_rec *offrec;
		list_del(tmp);
		...


	Domen
