Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUGQSoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUGQSoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 14:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUGQSoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 14:44:13 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:25998 "EHLO
	kryten.internal.splhi.com") by vger.kernel.org with ESMTP
	id S261159AbUGQSoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 14:44:08 -0400
Subject: Re: [PATCH] fix rmmod sbp2 hang in 2.6.7
From: Tim Wright <timw@splhi.com>
To: Ben Collins <bcollins@debian.org>
Cc: Hugang <hugang@soulinfo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040714113304.GB30536@phunnypharm.org>
References: <20040714114854.29d4e015@localhost>
	 <20040714161357.426b5c08@localhost> <20040714171107.49aa64f7@localhost>
	 <20040714102417.A12942@flint.arm.linux.org.uk>
	 <20040714113304.GB30536@phunnypharm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1090089796.14032.11.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 17 Jul 2004 11:43:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a wild guess. Is the 'sg' driver loaded. This sounds similar to
my complaint with trying to rmmod 'st'. When I load my SCSI HBA driver,
it automagically pulls in st for my tape drive *and* sg. Now, if you try
to remove it, it "hangs". It's because sg also got a reference. If you
rmmod 'sg' then the rmmod of st frees up too.

The problem above is that st has module use count of 0, but that's a
lie. sg has glommed on that device, and the true reference count is
actually one (if you consider that st owns the tape device). It seems to
me that what should happen is for the SCSI layer/drivers to handle
kicking sg out when they want to unload. If the consensus is that this
is desirable, I'm happy to go off and see what needs to be done.
Otherwise, I'll crawl back into my hole :-)

Tim

On Wed, 2004-07-14 at 04:33, Ben Collins wrote:
> On Wed, Jul 14, 2004 at 10:24:17AM +0100, Russell King wrote:
> > On Wed, Jul 14, 2004 at 05:11:07PM +0800, Hugang wrote:
> > > On Wed, 14 Jul 2004 16:13:57 +0800
> > > Hugang <hugang@soulinfo.com> wrote:
> > > | On Wed, 14 Jul 2004 11:48:54 +0800
> > > | Hugang <hugang@soulinfo.com> wrote:
> > > | 
> > > ....
> > > | Sorry, the above patch, can't fix rmmod sbp2 complete,I still got hang when
> > > | rmmod sbp2 in my PowerBook G4 sometimes.
> > > | 
> > > 
> > > This new patch can complete fix the bug. That's really hack. Any comment are
> > > welcome.
> > 
> > This down+up prevents drivers from being unloaded until there are no
> > references to their struct device_driver.  By removing this, you open
> > the very real possibility for an oops to occur.
> > 
> > If you're waiting inside that function for the last reference to be
> > dropped, the real question is why you still have references to it.
> 
> Seems like every 2 months or so I have to revisit the sbp2 module to see
> where the scsi layer has changed (or the driver model) so that I can get
> all the reference counting to equal out properly. Guess it's been two
> months again :)
-- 
Tim Wright <timw@splhi.com>
Splhi
