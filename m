Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUGJQFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUGJQFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 12:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUGJQFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 12:05:08 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:24986 "EHLO
	tp-timw.internal.splhi.com") by vger.kernel.org with ESMTP
	id S265782AbUGJQEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 12:04:52 -0400
Subject: Re: rmmod st "hangs" - bad interaction with sg
From: Tim Wright <timw@splhi.com>
Reply-To: timw@splhi.com
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040710154145.GA17691@infradead.org>
References: <1089473460.1473.17.camel@tp-timw.internal.splhi.com>
	 <20040710154145.GA17691@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1089475422.1473.25.camel@tp-timw.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 09:03:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph!
On Sat, 2004-07-10 at 08:41, Christoph Hellwig wrote:
> On Sat, Jul 10, 2004 at 08:31:00AM -0700, Tim Wright wrote:
> > Hi,
> > I was working on the qlogicisp/isp1020 driver in 2.6, as I still have
> > one of these antiques and the driver is a bit out of date (a patch is
> > forthcoming). In the process of testing my changes, I came across the
> > following:
> 
> qlogicisp is slowly going away.  If you look at the qla1280 driver in current
> mainline you'll see it has most of the support for the 1020/1040 already,
> I just need to fix a final bug and add firmware/pci ids.  This has come up
> on linux-scsi a few times..
> 

Ah thanks. Of course, as soon as I posted, I realized I should probably
have copied linux-scsi and/or gone and checked the archives there sigh.
Just getting back into the swing of things. If you need a tester, I'm
happy to do so on my setup.

> > This seems bad to me - either the original rmmod should fail with EBUSY,
> > or it should complete. However, for it to do so, it seems that st needs
> > to know that sg has its hooks into the device it controls, and it needs
> > to be able to make it let go. My workaround is impractical if sg is in
> > use on other devices too.
> 
> I don't think we can fix much about this, it's how the driver model code
> works.  Best workarond is to not use sg.

Hmmm... the problem was that it was autoloaded - I haven't gone and
checked the code yet, but it seems that unless you don't actually build
sg at all, it gets pulled in whether you want it or not. Now that the
ATA passthrough stuff works for CDRW etc., I actually have no good
reason to load it. It just seemed a little "sucky" - if I had tried to
e.g. rmmod qlogicisp, it would correctly fail because st depends on it.
It seems weak that an attempt to unload st didn't catch the hidden
dependency. Actually, it seems that a workaround with no side effects is
to 'echo 1 > /sys/class/scsi_device/.../delete' for the tape drive. That
frees things up and unhooks sg without unloading it.

Thanks,

Tim

