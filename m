Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbTIDT3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbTIDT3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:29:18 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:17656 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264704AbTIDT3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:29:17 -0400
Date: Thu, 4 Sep 2003 13:28:04 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@osdl.org>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-ID: <20030904132804.D15623@schatzie.adilger.int>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@osdl.org>,
	reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com> <3F578656.60005@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F578656.60005@namesys.com>; from reiser@namesys.com on Thu, Sep 04, 2003 at 10:37:10PM +0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 04, 2003  22:37 +0400, Hans Reiser wrote:
> Mike Fedyk wrote:
> >And how does reiser4 do this [export atomic ops to userspace]
> >without changing the userspace apps?
>
> We don't.  We just make the hovercraft, we don't force you to go over 
> the water.....

It is possible to do the same with ext3, namely exporting journal_start()
and journal_stop() (or some interface to them) to userspace so the application
can start a transaction for multiple operations.  We had discussed this in
the past, but decided not to do so because user applications can screw up in
so many ways, and if an application uses these interfaces it is possible to
deadlock the entire filesystem if the application isn't well behaved.

If the app doesn't eventually say "end the transaction", the filesystem might
wait indefinitely.  You could start adding more plumbing like "if the file
is closed (maybe because the process crashed), cancel the transaction",
and "if the process doesn't complete the transaction in time, cancel the
transaction", etc.  How do you guarantee in advance that the application
will be able to complete all of the operations it needs (i.e. if it runs
out of space in the filesystem or something)?

I suppose at worst, the application doesn't get its multi-op atomicity
guarantee, but I'm guessing that apps which use this interface depend on
it working properly or they wouldn't be using it.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

