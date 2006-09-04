Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWIDFcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWIDFcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWIDFcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:32:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:39590 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932299AbWIDFce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:32:34 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 4 Sep 2006 15:32:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17659.47724.27700.54965@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 4] md: Define backing_dev_info.congested_fn for
 raid0 and linear
In-Reply-To: message from Andrew Morton on Monday August 28
References: <20060829153414.6475.patches@notabene>
	<1060829053924.6610@suse.de>
	<20060828225908.af114751.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 28, akpm@osdl.org wrote:
> On Tue, 29 Aug 2006 15:39:24 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> > 
> > Each backing_dev needs to be able to report whether it is congested,
> > either by modulating BDI_*_congested in ->state, or by
> > defining a ->congested_fn.
> > md/raid did neither of these.  This patch add a congested_fn
> > which simply checks all component devices to see if they are
> > congested.
> > 
> > Signed-off-by: Neil Brown <neilb@suse.de>
> > 
> > +static int linear_congested(void *data, int bits)
> > +{
> > +	mddev_t *mddev = data;
> > +	linear_conf_t *conf = mddev_to_conf(mddev);
> > +	int i, ret = 0;
> > +
> > +	for (i = 0; i < mddev->raid_disks && !ret ; i++) {
> > +		request_queue_t *q = bdev_get_queue(conf->disks[i].rdev->bdev);
> > +		ret |= bdi_congested(&q->backing_dev_info, bits);
> 
> nit: `ret = ' would suffice here.
> 

Yeh.... I was looking at  linear_issue_flush, which aborts when
ret == 0, and dm_table_any_congested, which 'or's together the results
and combining to two.  And I kept changing my mind as to which way I
wanted to go for linear_congested et.al, and ended up going both ways
:-(
I hate indecision.  I think.  Well, probably I do.  Maybe.

NeilBrown

-- 
VGER BF report: U 0.5
