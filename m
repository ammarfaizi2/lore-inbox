Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUCTQas (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263471AbUCTQas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:30:48 -0500
Received: from ns.suse.de ([195.135.220.2]:1760 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263467AbUCTQao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:30:44 -0500
Subject: Re: [PATCH] barrier patch set
From: Chris Mason <mason@suse.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200403201723.11906.bzolnier@elka.pw.edu.pl>
References: <20040319153554.GC2933@suse.de>
	 <200403200059.22234.bzolnier@elka.pw.edu.pl>
	 <20040320095341.GA2711@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1079800362.11062.280.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Mar 2004 11:32:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 11:23, Bartlomiej Zolnierkiewicz wrote:

> > > - why are we doing pre-flush?
> >
> > To ensure previously written data is on platter first.
> 
> I know this, I want to know what for you are doing this?
> 
> Previously written data is already acknowledgment to the upper layers so you
> can't do much even if you hit error on flush cache.  IMO if error happens we
> should just check if failed sector is of our ordered write if not well report
> it and continue.  It's cleaner and can give some (small?) performance gain.
> 

The journaled filesystems need this.  We need to make sure that before
we write the commit block for a transaction, all the previous log blocks
we're written are safely on media.  Then we also need to make sure the
commit block is on media.  

We end up with a log blocks, pre-flush, commit block, post-flush cycle,
which is what gives the proper transaction ordering on disk.

For data blocks we only need the post flush, which is why Jens made
blkdev_issue_flush skip the pre-flush.

-chris


