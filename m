Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVASTEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVASTEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVASTDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:03:15 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:4530 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261852AbVASTBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:01:25 -0500
Date: Wed, 19 Jan 2005 11:01:19 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather than
Message-ID: <20050119190119.GA10429@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501070313.j073DCaQ009641@hera.kernel.org> <20050107034145.GI9636@holomorphy.com> <Pine.LNX.4.58.0501062222500.2272@ppc970.osdl.org> <Pine.LNX.4.58.0501062236060.2272@ppc970.osdl.org> <20050119162902.GA20656@work.bitmover.com> <Pine.LNX.4.58.0501190843220.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501190843220.8178@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:14:33AM -0800, Linus Torvalds wrote:
> I think you are perhaps confused about the fact that what makes this all
> possible in the first place really is the _pipe_. You probably think of
> "splice()" as going from one file descriptor to another. It's not. 

You seem to have misunderstood the original proposal, it had little to do
with file descriptors.  The idea was that different subsystems in the OS
export pull() and push() interfaces and you use them.  The file decriptors
are only involved if you provide them with those interfaces(which you
would, it makes sense).  You are hung up on the pipe idea, the idea I
see in my head is far more generic.  Anything can play and you don't
need a pipe at all, you need 

	struct pagev {
		pageno	page;	// or whatever the type is to get the page
		u16	offset;	// could be u32 if you have large pages
		u16	len;	// ditto
	};
	struct splice {
		pagev	pages[];
		u8	gift:1;
		u8	loan:1;
	};

You can feed these into pipes for sure, but you can source and sink
them from/to anything which exports a pull()/push() entry point.
It's as generic as read()/write() in the driver object.

I never proposed restricting this to file descriptors, that makes
no sense.  File descriptors are nothing more than something which
gets you to the underlying object (socket/file/pipe/whatever) and
lets you call into that object to move some data.
		
See how more generic that is?  Pipes are just one source/sink but 
everything else needs to play as well.  How are you going to 
implement a socket sending data to a file without the VM nonsense
and the extra copies?
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
