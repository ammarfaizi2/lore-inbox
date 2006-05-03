Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWECCy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWECCy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 22:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWECCy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 22:54:26 -0400
Received: from hera.kernel.org ([140.211.167.34]:31104 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965075AbWECCyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 22:54:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Simple header cleanups
Date: Tue, 2 May 2006 19:53:35 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e395vf$dcj$1@terminus.zytor.com>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com> <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org> <20060427231200.GW3570@stusta.de> <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1146624815 13716 127.0.0.1 (3 May 2006 02:53:35 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 3 May 2006 02:53:35 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
> > 
> > Normal userspace programs will simply not care about the contents of the 
> > kernel ABI headers - the libc will present them pretty headers adhering 
> > to all past, current and future standards.
> 
> As long as that is clear - that the kernel ABI headers are _never_ seen by 
> normal programs, even indirectly #include'd from the standard include 
> headers.
> 

For some of them, there isn't really any reason not to; in particular
when it comes to things like ioctl constants and structures that
describe what is functionally an RPC interface between the user-space
application and the kernel -- the library couldn't realistically
intervene even if it wanted to.

This is also by orders of magnitude the fastest evolving part of the
kernel ABI.

When it comes to more serious stuff like "struct stat" it should be
pretty obvious any "struct stat" the kernel exports is going to be
wrong.  klibc, which cares about size and not ABI stability, could
export it directly, but it still wants to be able to *choose* which
"struct stat" to use -- on most platform, it's what the kernel calls
"struct stat64", except with a 32-bit dev_t instead of a 64-bit
unsigned long long for st_[r]dev, plus of course appropriate padding.

One solution would of course be to have a purely declarative language
for that stuff.  A C program won't use it because a C program *can't*
use it without further processing, and the declarative language
processor is the ideal place for such stuff.  In that scenario even
the kernel would have to use a processed version of the ABI
declarations.

An intermediate solution might be to take sparse, and something like
it, and use it as the declarative language processor.  Then the kernel
could still use them as C, but the library would have an easy way to
process them.  The risk is that something might not.

What David has done is yet one step down from this in ambition level,
but at least he's gotten the ball rolling.

	-hpa
