Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759223AbWLEWLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759223AbWLEWLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759822AbWLEWLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:11:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46554 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759191AbWLEWLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:11:53 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200612051536_MC3-1-D404-9990@compuserve.com> 
References: <200612051536_MC3-1-D404-9990@compuserve.com> 
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: David Howells <dhowells@redhat.com>, vojtech@suse.cz, ak@muc.de,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kasper Sandberg <lkml@metanurb.dk>, Andrew Morton <akpm@osdl.org>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Dec 2006 22:11:11 +0000
Message-ID: <26586.1165356671@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:

> I only have 32-bit userspace.  When I run your program against
> a directory on a JFS filesystem (msdos ioctls not supported)
> I get this on vanilla 2.6.19:

Can I just check?  You're using an x86_64 CPU in 64-bit mode with a 64-bit
kernel, but with a completely 32-bit userspace?

> I only have 32-bit userspace.  When I run your program against
> a directory on a JFS filesystem (msdos ioctls not supported)
> I get this on vanilla 2.6.19:

Wait!  You're using JFS, not VFAT?  Oh... I see.

Okay: It's not the MSDOS/VFAT patch that's wrong.  Please don't revert that.
It's the compat ioctl code that's "wrong".

So compat_sys_ioctl() used to return ENOTTY (ENOIOCTLCMD internally) because
the MSDOS ioctl was listed as one that could be translated but it didn't apply
to JFS.

But now, since all the block-based filesystem ioctls have been removed from
that list, you now get EINVAL, not ENOTTY.

> So apparently this is a feature?

Unfortunately, I think it has to be.  We could add a master list of ioctls to
be issued with particular errors if the driver doesn't support them, but is it
worth it?

A question for you: Why is userspace assuming that it'll get ENOTTY rather
than EINVAL?

David
