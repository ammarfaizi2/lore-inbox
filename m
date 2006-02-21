Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWBUPxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWBUPxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbWBUPxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:53:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932741AbWBUPxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:53:10 -0500
Date: Tue, 21 Feb 2006 15:52:48 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (dm/md common)
Message-ID: <20060221155248.GB12169@agk.surrey.redhat.com>
Mail-Followup-To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
	device-mapper development <dm-devel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <43F60F31.1030507@ce.jp.nec.com> <43F60F8C.8090207@ce.jp.nec.com> <20060217184435.GM12169@agk.surrey.redhat.com> <43F67274.80509@ce.jp.nec.com> <20060218195005.GT12169@agk.surrey.redhat.com> <43FB32D4.3080101@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB32D4.3080101@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 10:33:40AM -0500, Jun'ichi Nomura wrote:
> Alasdair G Kergon wrote:
> >Test with trees of devices too - where a whole tree is suspended -
> Suspending maps in the tree and reload one of them?

Reload a complete tree of devices like lvm2 does:
It loads inactivate tables wherever it needs to in the tree,
then suspends the devices in the correct order (according to
the dependencies of the live tables to avoid ever 'trapping' I/O 
between two devices), then resumes them in order.

> >I don't think you can allocate anywhere in dm_swap_table()
> >without PF_MEMALLOC (which I recently removed and am reluctant
> >to reinstate).

> I understand your reluctance and I don't want to revive it either.
> I think moving sysfs_add_link() outside of dm_swap_table() solves
> this. Am I right?

I should have said: try hard to avoid allocations in any code run 
during the 'DM_SUSPEND' ioctl - if you really have to, your options
include PF_MEMALLOC or a mempool, as appropriate.

> Or do you want to eliminate the possibility that sysfs_remove_symlink()
> may require memory allocation in future?

Either that, or:
 
> Anyway, I'll seek for bd_claim based approach.

This dodges the allocation problem because it happens in the DM_TABLE_LOAD 
ioctl where I was able to remove the restriction recently.

Alasdair
-- 
agk@redhat.com
