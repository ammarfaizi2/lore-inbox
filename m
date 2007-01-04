Return-Path: <linux-kernel-owner+w=401wt.eu-S965082AbXADUYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbXADUYR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbXADUYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:24:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55829 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965084AbXADUYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:24:15 -0500
Date: Thu, 4 Jan 2007 20:24:12 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops return values
Message-ID: <20070104202412.GY17561@ftp.linux.org.uk>
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org> <459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org> <459D4897.4020408@redhat.com> <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 11:30:22AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 4 Jan 2007, Al Viro wrote:
> > 
> > How about "makes call graph analysis easier"? ;-)  In principle, I have
> > no problem with force-casting, but it'd better be cast to the right
> > type...
> 
> Do we really care in the kernel? We simply never use function pointer 
> casts like this for anything non-trivial, so if the graph analysis just 
> doesn't work for those cases, do we really even care?

Umm...  Let me put it that way - amount of things that can be done to
void * is much more than what can be done to function pointers.  So
keeping track of them gets easier if we never do casts to/from void *.
What's more, very few places in the kernel try to do that _and_ most
of those that do are simply too lazy to declare local variable with
the right type.  bad_inode.c covers most of what remains.

IMO we ought to start checking for that kind of stuff; note that we _still_
have strugglers from pt_regs removal where interrupt handler still takes
3 arguments, but we don't notice since argument of request_irq() is cast
to void * ;-/

That's local stuff; however, when trying to do non-local work (e.g. deduce
that foo() may be called from BH, bar() is always called from process
context, etc. _without_ fuckloads of annotations all over the place), the
ban on mixing void * with function pointers helps a _lot_.

So my main issue with fs/bad_inode.c is not even cast per se; it's that
cast is to void *.
