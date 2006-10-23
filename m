Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWJWSiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWJWSiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWJWSiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:38:09 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:22975 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964999AbWJWSiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:38:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Thaw userspace and kernel space separately.
Date: Mon, 23 Oct 2006 20:37:13 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
References: <1161560896.7438.67.camel@nigel.suspend2.net> <1161604811.3315.12.camel@nigel.suspend2.net> <20061023095124.7be583ce.akpm@osdl.org>
In-Reply-To: <20061023095124.7be583ce.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232037.13899.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 18:51, Andrew Morton wrote:
> > On Mon, 23 Oct 2006 22:00:11 +1000 Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> > Hi.
> > 
> > On Mon, 2006-10-23 at 12:26 +0200, Rafael J. Wysocki wrote:
> > > On Monday, 23 October 2006 01:48, Nigel Cunningham wrote:
> > > > Modify process thawing so that we can thaw kernel space without thawing
> > > > userspace, and thaw kernelspace first. This will be useful in later
> > > > patches, where I intend to get swsusp thawing kernel threads only before
> > > > seeking to free memory.
> > > 
> > > Please explain why you think it will be necessary/useful.
> > > 
> > > I remember a discussion about it some time ago that didn't indicate
> > > we would need/want to do this.
> > 
> > This is needed to make suspending faster and more reliable when the
> > system is in a low memory situation. Imagine that you have a number of
> > processes trying to allocate memory at the time you're trying to
> > suspend. They want so much memory that when you come to prepare the
> > image, you find that you need to free pages. But your swapfile is on
> > ext3, and you've just frozen all processes, so any attempt to free
> > memory could result in a deadlock while the vm tries to swap out pages
> > using the frozen kjournald. So you need to thaw processes to free the
> > memory. But thawing processes will start the processes allocating memory
> > again, so you'll be fighting an uphill battle.
> > 
> > If you can only thaw the kernel threads, you can free memory without
> > restarting userspace or deadlocking against a frozen kjournald.
> > 
> 
> kjournald will not participate in writing to swapfiles.
> 
> The situation where we would need this feature is where the loop driver is
> involved in the path-to-disk.  But I doubt if that's a thing we'd want to
> support.
> 
> otoh there may be other kernel threads which are a saner thing to have in
> the swapout path and which we do want to support.  md_thread, perhaps?

md_thread needs some consideration I think.  Having a swapfile on RAID
is a legit thing and we should support that.


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
