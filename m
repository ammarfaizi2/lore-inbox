Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWEYWFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWEYWFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWEYWFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:05:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030442AbWEYWFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:05:09 -0400
Date: Thu, 25 May 2006 15:01:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Lang <dlang@digitalinsight.com>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Message-Id: <20060525150149.666c8476.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0605251240160.1814@dlang.diginsite.com>
References: <348469535.17438@ustc.edu.cn>
	<20060525084415.3a23e466.akpm@osdl.org>
	<Pine.LNX.4.63.0605251240160.1814@dlang.diginsite.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <dlang@digitalinsight.com> wrote:
>
> On Thu, 25 May 2006, Andrew Morton wrote:
> 
> > Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >>
> >
> > These are nice-looking numbers, but one wonders.  If optimising readahead
> > makes this much difference to postgresql performance then postgresql should
> > be doing the readahead itself, rather than relying upon the kernel's
> > ability to guess what the application will be doing in the future.  Because
> > surely the database can do a better job of that than the kernel.
> >
> > That would involve using posix_fadvise(POSIX_FADV_RANDOM) to disable kernel
> > readahead and then using posix_fadvise(POSIX_FADV_WILLNEED) to launch
> > application-level readahead.
> >
> > Has this been considered or attempted?
> 
> Postgres chooses not to try and duplicate OS functionality in it's I/O 
> routines.
> 
> it doesn't try to determine where on disk the data is (other then 
> splitting the data into multiple files and possibly spreading things 
> between directories)
> 
> it doesn't try to do it's own readahead.
> 
> it _does_ maintain it's own journal, but depends on the OS to do the right 
> thing when a fsync is issued on the files.
> 
> yes it could be re-written to do all this itself, but the project has 
> decided not to try and figure out the best options for all the different 
> filesystems and OS's that it runs on and instead trust the OS developers 
> to do reasonable things instead.
> 
> besides, do you really want to have every program doing it's own 
> readahead?
> 

If the developers of that program want to squeeze the last 5% out of it
then sure, I'd expect them to use such OS-provided I/O scheduling
facilities.  Database developers do that sort of thing all the time.

We have an application which knows what it's doing sending IO requests to
the kernel which must then try to reverse engineer what the application is
doing via this rather inappropriate communication channel.

Is that dumb, or what?

Given that the application already knows what it's doing, it's in a much
better position to issue the anticipatory IO requests than is the kernel.
