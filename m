Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUCaOZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 09:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUCaOZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 09:25:45 -0500
Received: from ns.suse.de ([195.135.220.2]:7853 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261979AbUCaOZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 09:25:43 -0500
Subject: Re: [PATCH] barrier patch set
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1080741817.1991.34.camel@sisko.scot.redhat.com>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
	 <1080662685.1978.25.camel@sisko.scot.redhat.com>
	 <1080674384.3548.36.camel@watt.suse.com>
	 <1080683417.1978.53.camel@sisko.scot.redhat.com>
	 <1080684797.3546.85.camel@watt.suse.com>
	 <1080741817.1991.34.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Message-Id: <1080743276.3547.146.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Mar 2004 09:27:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 09:03, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2004-03-30 at 23:13, Chris Mason wrote:
> 
> > Most database benchmarks are done on scsi, and the blkdev_flush should
> > be a noop there.  For IDE based database and mail server benchmarks, the
> > results won't be pretty.  
> 
> Yep.  I'm really not too worried about big database benchmarks -- those
> are very much special cases, using rather specialised storage setup
> (SCSI or FC, striped over lots of small disks rather than fewer large
> ones.)  I'm much more concerned about your average LAMP user's mysql
> database, and how to keep performance sane on that.
> 
In some cases, it's going to be so much slower that it will look like
the old code wasn't writing the data at all.  I don't think there's much
we can do about that.

> > The reiserfs fsync code tries hard to only flush once, so if a commit is
> > done then blkdev_flush isn't called.  We might have to do a few other
> > tricks to queue up multiple synchronous ios and only flush once.
> 
> Batching is really helpful when you've got lots of threads that can be
> coalesced, yes.  ext3 does that for things like mail servers.  I'm not
> sure whether the same tricks will apply to the various databases out
> there, though.

We can do better in general when there's more then one process doing an
fsync.  reiserfs and ext3 both try to be smart about batching log
commits, but I think we could do more to streamline the data writes.

I'm playing with a few ideas, I'll post more when I've got real code to
back things up.

If there's only one process doing fsyncs, there's not much the kernel
can do except provide an aio fsync call.

-chris




