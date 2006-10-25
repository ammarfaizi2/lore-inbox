Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422844AbWJYAOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422844AbWJYAOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 20:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422848AbWJYAOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 20:14:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61856 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422844AbWJYAOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 20:14:15 -0400
Date: Wed, 25 Oct 2006 10:13:31 +1000
From: David Chinner <dgc@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Chinner <dgc@sgi.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061025001331.GP8394166@melbourne.sgi.com>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com> <200610241730.00488.rjw@sisk.pl> <20061024163345.GG11034@melbourne.sgi.com> <20061024213737.GD5662@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024213737.GD5662@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 11:37:37PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Do you mean calling sys_sync() after the userspace has been frozen
> > > may not be sufficient?
> > 
> > In most cases it probably is, but sys_sync() doesn't provide any
> > guarantees that the filesystem is not being used or written to after
> > it completes. Given that every so often I hear about an XFS filesystem
> > that was corrupted by suspend, I don't think this is sufficient...
> 
> Userspace is frozen. There's noone that can write to the XFS
> filesystem.

Sure, no new userspace processes can write data, but what about the
internal state of the filesystem?

All a sync guarantees is that the filesystem is consistent when the
sync returns and XFS provides this guarantee by writing all data and
ensuring all metadata changes are logged so if a crash occurs it can
be recovered (which provides the sync guarantee). hence after a
sys_sync(), XFS will still have lots of dirty metadata that needs to
be written to disk at some time in the future so the transactions
can be removed from the log.

This dirty metadata can be flushed at any time, and the dirty state
is kept in XFS structures and not always in page structures (think
multipage metadata buffers). Hence I cannot see how suspend can
guarantee that it has saved all the dirty data in XFS, nor
restore it correctly on resume. Once you toss dirty metadata that
is currently in the log, further operations will result in that log
transaction being overwritten without it ever being written to disk.
That then means any subsequent operations after resume will corrupt
the filesystem....

Hence the only way to correctly rebuild the XFS state on resume is
to quiesce the filesystem on suspend and thaw it on resume so as to
trigger log recovery.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
