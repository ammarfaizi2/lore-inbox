Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbTDRJIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 05:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTDRJIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 05:08:44 -0400
Received: from dsl-170-219.dsl.cambrium.nl ([213.239.170.219]:15021 "EHLO
	fratser") by vger.kernel.org with ESMTP id S262992AbTDRJIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 05:08:43 -0400
Date: Fri, 18 Apr 2003 11:20:01 +0200 (CEST)
From: John v/d Kamp <john@connectux.com>
X-X-Sender: john@fratser
To: Dave Olien <dmo@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DAC960_Release bug (2.4.x)
In-Reply-To: <20030417202714.GA30622@osdl.org>
Message-ID: <Pine.LNX.4.53.0304181052230.3981@fratser>
References: <Pine.LNX.4.53.0304161136270.18523@fratser> <20030416224013.GA11514@osdl.org>
 <Pine.LNX.4.53.0304171004160.10181@fratser> <20030417202714.GA30622@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The libhd can be found here:
ftp://ftp.suse.com/pub/suse/i386/8.1/suse/src/hwinfo-5.39-2.src.rpm
We use a somewhat older version, but that probably doesn't matter.

I've compiled the module, and our install software ran just fine.
Repartitioning the drive was no problem. Using the driver on a normal
system was no problem either (never was).

--
John van der Kamp, ConnecTUX

On Thu, 17 Apr 2003, Dave Olien wrote:

>
> I've been looking over the kernel's code paths that call a block driver's
> release method.  In linux 2.4 and 2.5, it looks like nowhere does the
> kernel EVER call the release method with a non-NULL file descriptor.
> The file pointer argument to the release method seems to be a left-over
> from linux 2.2.
>
> I think the DAC960_Open and DAC960_Release methods in 2.4 and 2.5
> are more broken than it first appears.
>
> The SPECIAL file descriptor that you get with O_NONBLOCK
> is a BAD idea.  But we're probably stuck because applications use it.
> Could you pass me a URL to the libhd library you're using?  I'd like
> to look it over.  What behavior does it expect with the O_NBLOCK flag?
>
> I think what I'll do is assert that there can be ONLY ONE such SPECIAL
> file descriptor open at a time.  At Open time, we'll save a pointer to
> the inode for this special file descriptor in a module-local variable.
> If at open time, we discover there is already such an open file descriptor,
> we'll refuse to open another one.
>
> In the release function, we'll compare the inode pointer passed in with
> the saved inode pointer, and do the SPECIAL close case, and then zero
> out the saved inode pointer.  This isn't a completely reliable solution.
> But, it's the best I think of for now.
>
> A patch for 2.4 is attached at the end of this mail.  I'd appreciate it if
> you could give it a try and let me know how it works.
>
