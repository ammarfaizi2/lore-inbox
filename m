Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWBUPcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWBUPcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWBUPcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:32:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932530AbWBUPcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:32:31 -0500
Message-ID: <43FB32D4.3080101@ce.jp.nec.com>
Date: Tue, 21 Feb 2006 10:33:40 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (dm/md common)
References: <43F60F31.1030507@ce.jp.nec.com> <43F60F8C.8090207@ce.jp.nec.com> <20060217184435.GM12169@agk.surrey.redhat.com> <43F67274.80509@ce.jp.nec.com> <20060218195005.GT12169@agk.surrey.redhat.com>
In-Reply-To: <20060218195005.GT12169@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alasdair and Neil,

Alasdair G Kergon wrote:
> Test with trees of devices too - where a whole tree is suspended -

Suspending maps in the tree and reload one of them?
I'll try that.

> I don't think you can allocate anywhere in dm_swap_table()
> without PF_MEMALLOC (which I recently removed and am reluctant
> to reinstate).

I understand your reluctance and I don't want to revive it either.
I think moving sysfs_add_link() outside of dm_swap_table() solves
this. Am I right?
Or do you want to eliminate the possibility that sysfs_remove_symlink()
may require memory allocation in future?

Anyway, I'll seek for bd_claim based approach.

> Have you considered if anything is feasible based around bd_claim()?
> Doesn't it make more sense for the links to be set up at table
> load time - i.e. superset of both tables if present?

I think it makes sense. But I have difficulty with it.

What I once thought was extending bd_claim() like:
   bd_claim_with_owner(bdev, void *holder, struct kobject *owner)
where "owner" is a kobject for "slaves" directory.
We may have the object embedded in gendisk structure.
Then we can create symlinks like:
   /sys/block/<bdev>/holders/<owner> --> /sys/block/<owner>
   /sys/block/<owner>/slaves/<bdev> --> /sys/block/<bdev>

This should work for md.

However, dm needs more for its flexibility.
Because multiple dm devices can hold one device and one dm device
can hold a device twice (i.e. current table and new table),
we need to reference-count per relationship basis, not per slave
device.
This might be solved by allocating management struct in bd_claim()
to reference-counting the relationship.
I'll try this. Comments are welcome.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
