Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753899AbWKHCbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbWKHCbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753909AbWKHCbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:31:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34688 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753899AbWKHCbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:31:24 -0500
Date: Wed, 8 Nov 2006 02:30:39 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061108023039.GF30653@agk.surrey.redhat.com>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061107122837.54828e24.akpm@osdl.org> <45510C73.7060408@redhat.com> <200611080005.50070.rjw@sisk.pl> <20061107234951.GD30653@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107234951.GD30653@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 11:49:51PM +0000, Alasdair G Kergon wrote:
> I hadn't noticed that -mm patch.  I'll take a look.  

swsusp-freeze-filesystems-during-suspend-rev-2.patch

I think you need to give more thought to device-mapper
interactions here.  If an underlying device is suspended
by device-mapper without freezing the filesystem (the
normal state) and you issue a freeze_bdev on a device
above it, the freeze_bdev may never return if it attempts
any synchronous I/O (as it should).

Try:
  while process generating I/O to filesystem on LVM
  issue dmsetup suspend --nolockfs (which the lvm2 tools often do)
  try your freeze_filesystems()

Maybe: don't allow freeze_filesystems() to run when the system is in that
state; or, use device-mapper suspend instead of freeze_bdev directly where
dm is involved; or skip dm devices that are already frozen - all with
appropriate dependency tracking to process devices in the right order.

Alasdair
-- 
agk@redhat.com
