Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUHYOrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUHYOrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUHYOpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:45:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267341AbUHYOo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:44:56 -0400
Date: Wed, 25 Aug 2004 10:44:39 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Michal Ludvig <mludvig@suse.cz>
cc: CryptoAPI List <cryptoapi@lists.logix.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /dev/crypto for Linux
In-Reply-To: <412BB517.4040204@suse.cz>
Message-ID: <Xine.LNX.4.44.0408251025120.25396-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Michal Ludvig wrote:

> How does it work?
> - - Process opens /dev/crypto and with a set of ioctl() commands does what
> it wants to. I.e. obtains a crypto session, does the {enc,dec}ryption
> and finally closes the session. The sessions are bound to "struct file"
> of the open /dev/crypto and thus are automatically removed even if the
> process dies unexpectedly.

I don't think this is the way forward for the user crypto API.  Rather 
than using the openbsd device as a starting point, we need to look at what 
is the best for Linux and work from there.

In any case, the openbsd device is the wrong model.  An ioctl() based 
interface is just a set of backdoor syscalls, but with weak semantics, and 
a potential maintenance nightmare.

At this stage, the only real use for the device is to make it easier to 
test and benchmark the crypto modules, and I'm not sure if this is enough 
justification for integration with the kernel at this stage.  Currently, 
the tcrypt module provides a convienient way to test modules on whatever 
architecture you can boot a kernel on, without the need for external 
userspace packages.  It also tests some specific scatterlist cases.  So, 
your crypto dev would not likely be considered a full replacement for 
tcrypt at this stage.

I would also want to see the user API evolve with the development of 
hardware crypto support, and not lock us into forever supporting some 
potentially inadequate/broken model.  So, any user API at this stage 
should be marked experimental if it is going to be merged, if at all.

I think there are really two options for developing the user API:

1) a set of syscalls, or
2) a filesystem.

The main idea being to provide a well-structured, text-based (as far as
possible) API with strong semantics.  I have a preference for a filesystem
API (and done some initial design), but have not established yet whether
it is feasible compared to the syscall approach.

I would encourage you to look at a filesystem API, as a project which 
evolves with the addition of hardware support.  I guess this is something 
we could discuss in more detail on the crypto list rather than annoy the 
lkml folk with.


- James
-- 
James Morris
<jmorris@redhat.com>



