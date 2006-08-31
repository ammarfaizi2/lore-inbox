Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWHaPD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWHaPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWHaPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:03:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932341AbWHaPD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:03:26 -0400
Subject: Re: [PATCH 01/16] GFS2: Core header files
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0608311607441.5900@yvahk01.tjqt.qr>
References: <1157030918.3384.785.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0608311607441.5900@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 31 Aug 2006 16:07:20 +0100
Message-Id: <1157036840.3384.827.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the comments...

On Thu, 2006-08-31 at 16:16 +0200, Jan Engelhardt wrote:
> >+ *
> >+ * This copyrighted material is made available to anyone wishing to use,
> >+ * modify, copy, or redistribute it subject to the terms and conditions
> >+ * of the GNU General Public License v.2.
> >+ */
> 
> "v2" perhaps? From a math pov, the extra dot implies v0.2.
> 
or you could argue that the addition of a space (i.e. v. 2) would be
correct since its an abbreviation, but point taken and I'll clean it up
shortly.

> >+struct gfs2_log_operations;
> 
> I would suggest listing only struct lines that are actually required, i.e. the
> compiler would barf without them.
> 
Ok. I'll take a look and see which of them are not required.

> >+enum {
> >+	/* Actions */
> >+	HIF_MUTEX		= 0,
> >+	HIF_PROMOTE		= 1,
> >+	HIF_DEMOTE		= 2,
> >+	HIF_GREEDY		= 3,
> 
> I leave it to you whether going with the above or
> 
> enum {
>    HIF_MUTEX = 0,
>    HIF_PROMOTE,
>    HIF_DEMOTE,
>    HIF_GREEDY,
>    ...
> };
> 
> If these values need to stay the same, for example to maintain on-disk
> compatibility, I prefer the former, though.
> 
They are not on-disk visible (they'd in in gfs2_ondisk.h otherwise) but
we may well want to change them as I think it should be possible to
merge the gh_flags and gh_iflags fields in the struct gfs2_holder to
save a bit of space.

> >+	/* Quota stuff */
> >+
> >+	struct gfs2_quota_data *al_qd[4];
> 
> What four quotas can there be? Use the MAXQUOTAS macro if feasible.
> 
Its related to the way the GFS2's fuzzy quota system works. In order to
avoid contention on a global quota structure, each node has its own
which is synced back to the master one from time to time. This is done
according to user specified constants and more frequently in the case of
users nearing their quota. In the default case this means that no user
can exceed their quota by more than twice, in practice a user would have
to work very hard to manage even that.

As a result there are the overall user/group limits and the local
differences which are saved to by synced back to the master quota
information, hence four of them.

> >+struct gfs2_quota_lvb {
> >+        uint32_t qb_magic;
> >+        uint32_t __pad;
> >+        uint64_t qb_limit;      /* Hard limit of # blocks to alloc */
> >+        uint64_t qb_warn;       /* Warn user when alloc is above this # */
> >+        int64_t qb_value;       /* Current # blocks allocated */
> >+};
> 
> Is this an on-disk structure or why is there a __pad field?
> 
> 
> 
> Jan Engelhardt

It isn't an on-disk structure, on the other hand  we treat it as one. It
probably ought to be changed to use __be types. Its the structure which
the quota code keeps in the lock value block of DLM locks, so it is
directly shared between nodes, hence the need to treat it the same as
the on-disk structures in terms of making any changes to it, and keeping
it aligned, and of defined byte order etc,

Steve.


