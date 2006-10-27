Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946092AbWJ0Biq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946092AbWJ0Biq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 21:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946088AbWJ0Biq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 21:38:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22405 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946087AbWJ0Bip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 21:38:45 -0400
Date: Fri, 27 Oct 2006 11:38:02 +1000
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061027013802.GQ8394166@melbourne.sgi.com>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <1161850709.17293.23.camel@nigel.suspend2.net> <20061026085700.GI8394166@melbourne.sgi.com> <200610261111.30486.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610261111.30486.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 11:11:29AM +0200, Rafael J. Wysocki wrote:
> On Thursday, 26 October 2006 10:57, David Chinner wrote:
> > On Thu, Oct 26, 2006 at 06:18:29PM +1000, Nigel Cunningham wrote:
> > > As you have them at the moment, the threads seem to be freezing fine.
> > > The issue I've seen in the past related not to threads but to timer
> > > based activity. Admittedly it was 2.6.14 when I last looked at it, but
> > > there used to be a possibility for XFS to submit I/O from a timer when
> > > the threads are frozen but the bdev isn't frozen. Has that changed?
> > 
> > I didn't think we've ever done that - periodic or delayed operations
> > are passed off to the kernel threads to execute. A stack trace
> > (if you still have it) would be really help here.
> > 
> > Hmmm - we have a couple of per-cpu work queues as well that are
> > used on I/O completion and that can, in some circumstances,
> > trigger new transactions. If we are only flush metadata, then
> > I don't think that any more I/o will be issued, but I could be
> > wrong (maze of twisty passages).
> 
> Well, I think this exactly is the problem, because worker_threads run with
> PF_NOFREEZE set (as I've just said in another message).

Ok, so freezing the filesystem is the only way you can prevent
this as the workqueues are flushed as part of quiescing the filesystem.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
