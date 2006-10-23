Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWJWQ6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWJWQ6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWJWQ6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:58:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932188AbWJWQ6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:58:02 -0400
Date: Mon, 23 Oct 2006 09:51:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Thaw userspace and kernel space separately.
Message-Id: <20061023095124.7be583ce.akpm@osdl.org>
In-Reply-To: <1161604811.3315.12.camel@nigel.suspend2.net>
References: <1161560896.7438.67.camel@nigel.suspend2.net>
	<200610231226.03718.rjw@sisk.pl>
	<1161604811.3315.12.camel@nigel.suspend2.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 23 Oct 2006 22:00:11 +1000 Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> Hi.
> 
> On Mon, 2006-10-23 at 12:26 +0200, Rafael J. Wysocki wrote:
> > On Monday, 23 October 2006 01:48, Nigel Cunningham wrote:
> > > Modify process thawing so that we can thaw kernel space without thawing
> > > userspace, and thaw kernelspace first. This will be useful in later
> > > patches, where I intend to get swsusp thawing kernel threads only before
> > > seeking to free memory.
> > 
> > Please explain why you think it will be necessary/useful.
> > 
> > I remember a discussion about it some time ago that didn't indicate
> > we would need/want to do this.
> 
> This is needed to make suspending faster and more reliable when the
> system is in a low memory situation. Imagine that you have a number of
> processes trying to allocate memory at the time you're trying to
> suspend. They want so much memory that when you come to prepare the
> image, you find that you need to free pages. But your swapfile is on
> ext3, and you've just frozen all processes, so any attempt to free
> memory could result in a deadlock while the vm tries to swap out pages
> using the frozen kjournald. So you need to thaw processes to free the
> memory. But thawing processes will start the processes allocating memory
> again, so you'll be fighting an uphill battle.
> 
> If you can only thaw the kernel threads, you can free memory without
> restarting userspace or deadlocking against a frozen kjournald.
> 

kjournald will not participate in writing to swapfiles.

The situation where we would need this feature is where the loop driver is
involved in the path-to-disk.  But I doubt if that's a thing we'd want to
support.

otoh there may be other kernel threads which are a saner thing to have in
the swapout path and which we do want to support.  md_thread, perhaps?
