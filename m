Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWIAXuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWIAXuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 19:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWIAXuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 19:50:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53694 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750707AbWIAXuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 19:50:09 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 2 Sep 2006 09:50:00 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17656.50984.845357.143322@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Olaf Kirch <okir@suse.de>
Subject: Re: [PATCH 004 of 19] knfsd: lockd: introduce nsm_handle
In-Reply-To: message from Andrew Morton on Thursday August 31
References: <20060901141639.27206.patches@notabene>
	<1060901043825.27464@suse.de>
	<20060831232029.b003e8a7.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 31, akpm@osdl.org wrote:
> On Fri, 1 Sep 2006 14:38:25 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> > +nsm_release(struct nsm_handle *nsm)
> > +{
> > +	if (!nsm)
> > +		return;
> > +	if (atomic_read(&nsm->sm_count) == 1) {
> > +		down(&nsm_sema);
> > +		if (atomic_dec_and_test(&nsm->sm_count)) {
> > +			list_del(&nsm->sm_link);
> > +			kfree(nsm);
> > +		}
> > +		up(&nsm_sema);
> > +	}
> > +}
> 
> That's weird-looking.  Are you sure?  afaict, if ->sm_count ever gets a
> value of 2 or more, it's unfreeable.  

How do you *do* that?  I thought I had already found the bugs...

Thanks :-)
NeilBrown


---
Subject: Fix locking in nsm_release

The locking is all backwards and broken.

We first atomic_dec_and_test.
If this fails, someone else has an active reference and we need do
no more.
If it succeeds, then the only ref is in the hash table, but someone
might be about to find and use that reference.  nsm_mutex provides
exclusion against this.  If sm_count is still 0 once the
mutex has been gained, then it is safe to discard the nsm.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-09-01 18:56:39.000000000 +1000
+++ ./fs/lockd/host.c	2006-09-02 09:44:04.000000000 +1000
@@ -507,9 +507,9 @@ nsm_release(struct nsm_handle *nsm)
 {
 	if (!nsm)
 		return;
-	if (atomic_read(&nsm->sm_count) == 1) {
+	if (atomic_dec_and_test(&nsm->sm_count)) {
 		mutex_lock(&nsm_mutex);
-		if (atomic_dec_and_test(&nsm->sm_count)) {
+		if (atomic_read(&nsm->sm_count) == 0) {
 			list_del(&nsm->sm_link);
 			kfree(nsm);
 		}

-- 
VGER BF report: H 0
