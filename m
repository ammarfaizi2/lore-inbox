Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753733AbWKHACc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbWKHACc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 19:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbWKHACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 19:02:32 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:5264 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1753733AbWKHACb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 19:02:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alasdair G Kergon <agk@redhat.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Wed, 8 Nov 2006 01:00:17 +0100
User-Agent: KMail/1.9.1
Cc: Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611080005.50070.rjw@sisk.pl> <20061107234951.GD30653@agk.surrey.redhat.com>
In-Reply-To: <20061107234951.GD30653@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611080100.18290.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 8 November 2006 00:49, Alasdair G Kergon wrote:
> On Wed, Nov 08, 2006 at 12:05:49AM +0100, Rafael J. Wysocki wrote:
> > But freeze_bdev() is supposed to return the result of get_super(bdev)
> > _unconditionally_.  Moreover, in its current form freeze_bdev() _cannot_
> > _fail_, so I don't see how this change doesn't break any existing code.
> > For example freeze_filesystems() (recently added to -mm) will be broken
> > if the down_trylock() is unsuccessful.
>  
> I hadn't noticed that -mm patch.  I'll take a look. Up to now, device-mapper 
> (via dmsetup) and xfs (via xfs_freeze, which dates from before device-mapper
> handled this automatically) were the only users.  Only one freeze should be
> issued at once.  A freeze is a temporary thing, normally used while creating a
> snapshot.  (One problem we still have is lots of old documentation on the web
> advising people to run xfs_freeze before creating device-mapper snapshots.)
> 
> You're right that the down_trylock idea is more trouble than it's worth and
> should be scrapped.

Well, having looked at it once again I think I was wrong that this change would
break freeze_filesystems(), because it only calls freeze_bdev() after checking
if sb->s_frozen is not set to SB_FREEZE_TRANS (freeze_filesystems() is only
called after all of the userspace processes have been frozen).

However, XFS_IOC_FREEZE happily returns 0 after calling freeze_bdev(),
apparetnly assuming that it won't fail.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
