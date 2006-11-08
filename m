Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423694AbWKHUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423694AbWKHUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423698AbWKHUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:48:28 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:7660 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1423694AbWKHUs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:48:27 -0500
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>
In-Reply-To: <200611081310.19100.rjw@sisk.pl>
References: <20061107183459.GG6993@agk.surrey.redhat.com>
	 <20061107234951.GD30653@agk.surrey.redhat.com>
	 <20061108023039.GF30653@agk.surrey.redhat.com>
	 <200611081310.19100.rjw@sisk.pl>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 07:48:20 +1100
Message-Id: <1163018900.8844.2.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-11-08 at 13:10 +0100, Rafael J. Wysocki wrote:
> On Wednesday, 8 November 2006 03:30, Alasdair G Kergon wrote:
> > On Tue, Nov 07, 2006 at 11:49:51PM +0000, Alasdair G Kergon wrote:
> > > I hadn't noticed that -mm patch.  I'll take a look.  
> > 
> > swsusp-freeze-filesystems-during-suspend-rev-2.patch
> > 
> > I think you need to give more thought to device-mapper
> > interactions here.  If an underlying device is suspended
> > by device-mapper without freezing the filesystem (the
> > normal state) and you issue a freeze_bdev on a device
> > above it, the freeze_bdev may never return if it attempts
> > any synchronous I/O (as it should).
> 
> Well, it looks like the interactions with dm add quite a bit of
> complexity here.
> 
> > Try:
> >   while process generating I/O to filesystem on LVM
> >   issue dmsetup suspend --nolockfs (which the lvm2 tools often do)
> >   try your freeze_filesystems()
> 
> Okay, I will.
> 
> > Maybe: don't allow freeze_filesystems() to run when the system is in that
> > state;
> 
> I'd like to avoid that (we may be running out of battery power at this point).
> 
> > or, use device-mapper suspend instead of freeze_bdev directly where 
> > dm is involved;
> 
> How do I check if dm is involved?
> 
> > or skip dm devices that are already frozen - all with 
> > appropriate dependency tracking to process devices in the right order.
> 
> I'd prefer this one, but probably the previous one is simpler to start with.

Shouldn't we just go for the right thing to begin with? Otherwise we'll
just make more problems for ourselves later.

If we do this last one, I guess we want to do something like I was doing
before (creating a list of the devices we've frozen)?

Regards,

Nigel

