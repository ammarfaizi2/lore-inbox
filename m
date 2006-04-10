Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWDJJxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWDJJxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDJJxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:53:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48519 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751103AbWDJJxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:53:40 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 10 Apr 2006 19:53:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17466.11008.209715.489582@cse.unsw.edu.au>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       prasanna@in.ibm.com, davem@davemloft.net
Subject: Re: [patch 2/8] use hlist_move_head()
In-Reply-To: message from Andrew Morton on Monday April 10
References: <20060330081605.085383000@localhost.localdomain>
	<20060330081729.880726000@localhost.localdomain>
	<20060410012220.53b374d2.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday April 10, akpm@osdl.org wrote:
> Akinobu Mita <mita@miraclelinux.com> wrote:
> >
> > This patch converts the combination of hlist_del(A) and hlist_add_head(A, B)
> > to hlist_move_head(A, B).
> > 
> > ...
> >
> > --- 2.6-git.orig/fs/nfsd/nfscache.c
> > +++ 2.6-git/fs/nfsd/nfscache.c
> > @@ -113,8 +113,7 @@ lru_put_end(struct svc_cacherep *rp)
> >  static void
> >  hash_refile(struct svc_cacherep *rp)
> >  {
> > -	hlist_del_init(&rp->c_hash);
> > -	hlist_add_head(&rp->c_hash, hash_list + REQHASH(rp->c_xid));
> > +	hlist_move_head(&rp->c_hash, hash_list + REQHASH(rp->c_xid));
> >  }
> 
> Just got an oops here.

Hmmm:
static inline void hlist_del_init(struct hlist_node *n)
{
	if (n->pprev)  {
		__hlist_del(n);
		INIT_HLIST_NODE(n);
	}
}
.....

static inline void hlist_move_head(struct hlist_node *n, struct hlist_head *h)
{
	__hlist_del(n);
	hlist_add_head(n, h);
}

I guess n->pprev was NULL

NeilBrown

> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
                                                                           ^^^^^^^^
Yep!

NeilBrown
