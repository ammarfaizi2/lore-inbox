Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUCVGQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUCVGQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:16:27 -0500
Received: from [198.247.175.96] ([198.247.175.96]:6565 "EHLO jethro.hick.org")
	by vger.kernel.org with ESMTP id S261757AbUCVGQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:16:18 -0500
Date: Mon, 22 Mar 2004 00:14:56 -0600 (CST)
From: Matt Miller <mmiller@hick.org>
To: linux-kernel@vger.kernel.org
cc: mmiller@hick.org
Subject: Re: [PATCH] 2.6: mmap complement, fdmap
In-Reply-To: <20040322053025.GR31500@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0403212346330.24801@jethro.hick.org>
References: <Pine.LNX.4.58.0403212157110.31106@jethro.hick.org>
 <20040322053025.GR31500@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Mar 21, 2004 at 10:43:07PM -0600, Matt Miller wrote:
> > 	``flags'' can be one of O_RDONLY, O_WRONLY, or O_RDWR.
> >
> > I have verified functionality on ia32 and sparc as these are the only
> > architectures I currently have some type of access to.  To test, start the
> > kernel configuration process and go under File systems/Pseudo filesystems
> > and select this option:
> >
> > 	[*] Virtual memory file descriptor mapping support
> >
> > Please let me know about any and all suggestions/bugs/flames.  I tried to
>
> *boggle*
>
> a) what the hell for?

It's targetted mainly as a performance enhancer.  Some of the specific
scenarios where it would be useful are:

a) When one cannot afford to take the performance hit of synchronizing
   a memory range to disk due to disk size limitations or speed
   requirements.
b) Some things can benefit from the ability to interface with memory as a
   file.

The specific reason for implementing this was to allow for loading dynamic
libraries in the context of a process without having to write them to
disk.

> b) what happens if I pass such descriptor to another task?

Indeed, this use-case is broken.  I for one think that the ability to pass
the fdmap'd descriptor to another task should be disallowed, and as such
I'll look into adding support to block it from happening.  What do you
think?  Adding support for this brings about odd scenarios due to the
requirement that the file descriptor be treated like an actual file.  For
instance, if one were to pass the descriptor opened with O_RDWR to another
task, changes to the file descriptor in the other task should be reflected
upon the memory range in the original task.  Or should it?

> c) what happens if I mmap that sucker on the source range of addresses?

Good point.  I'll fix this by prohibiting mmap'ing to an address that
is within the range of memory that the file descriptor is associated with.

> d) same for loops made of more than one of those...

This should be corrected by the response to C.


Thanks for the feedback.

Matt
