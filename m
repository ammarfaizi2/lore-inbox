Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271330AbTHCXyW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 19:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271333AbTHCXyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 19:54:22 -0400
Received: from waste.org ([209.173.204.2]:25236 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S271330AbTHCXyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 19:54:20 -0400
Date: Sun, 3 Aug 2003 18:54:18 -0500
From: Matt Mackall <mpm@selenic.com>
To: Heikki Tuuri <Heikki.Tuuri@innodb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Message-ID: <20030803235418.GW22824@waste.org>
References: <009201c3599f$04ff05c0$322bde50@koticompaq> <20030803165522.GS22824@waste.org> <004c01c359e2$47db2110$322bde50@koticompaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004c01c359e2$47db2110$322bde50@koticompaq>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 08:11:29PM +0300, Heikki Tuuri wrote:
> Matt,
> 
> > On Sun, Aug 03, 2003 at 12:10:01PM +0300, Heikki Tuuri wrote:
> > >
> > > What to do? People who write drivers should run heavy, multithreaded
> file
> > > i/o tests on their computer using some SQL database which calls fsync().
> For
> > > example, run the Perl '/sql-bench/innotest's all concurrently on MySQL.
> If
> > > the problems are in drivers, that could help.
> >
> > Did you know that until test2-mm3, nothing would report errors that
> > occurred on non-synchronous writes? There was no infrastructure to
> > propagate the error back to userspace. If you wrote a page, the write
> > failed on an intermittent I/O error, and then read again, you'd
> > silently get back the old page.
> 
> we are not using the Linux async i/o. Do you mean that? Or the flush which
> the Linux kernel does from the file cache to the disk time to time on its
> own? I assume it will write to the system log an error message if a disk
> write fails?

This has nothing to do with the AIO interface.

Any write where the write returns immediately without syncing the file
is asynchronous. This includes most normal write()s where you're not
using O_DIRECT, O_SYNC or somesuch, and writes to memory-mapped files.

And no, prior to -mm3, there was absolutely no indication that these
failed writes occurred. It was simply dropped. Now it should be
reported in the logs and at the next sync point.
 
> The error 5 Shane reported came from a call of fsync(), and apparently he
> also got that same 5 from a simple file read which CHECK TABLE in MyISAM
> does.

Not sure what you're referring to here.

> Why would a write in the Linux async i/o fail? I am using aio on Windows,
> and if the disk space can be allocated, it seems to fail only in the case of
> a hardware failure.

For various reasons, there was previously no infrastructure for
transmitting write failure back to the writer after the page cache had
taken ownership of the write.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
