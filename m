Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbUK3AwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbUK3AwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUK3AwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:52:13 -0500
Received: from hera.kernel.org ([63.209.29.2]:63875 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261911AbUK3Avz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:51:55 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Tue, 30 Nov 2004 00:51:49 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cogg75$3a6$1@terminus.zytor.com>
References: <19865.1101395592@redhat.com> <cofv73$us3$1@terminus.zytor.com> <A697CF5A-4267-11D9-8DB8-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1101775909 3399 127.0.0.1 (30 Nov 2004 00:51:49 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 30 Nov 2004 00:51:49 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <A697CF5A-4267-11D9-8DB8-000393ACC76E@mac.com>
By author:    Kyle Moffett <mrmacman_g4@mac.com>
In newsgroup: linux.dev.kernel
>
> On Nov 29, 2004, at 15:01, H. Peter Anvin wrote:
> > Most people seem to have suggested include/linux-abi for this; I would
> > personally prefer include/linux-abi/arch for the second.
> 
> It seems like there are two ways to adjust the headers.  We could move
> the private headers to a new directory (include/kernel?), or we could 
> move
> the public headers to a new directory (include/linux-abi?).  I am 
> willing to
> work on some simple and trivial patches to begin doing either one, if we
> can reach an agreement as to which one is preferrable (and what to call
> the new directory.)
> 

If we can preserve compatibility, moving the private headers to a
separate place makes sense.  However, preserving compatibility is not
a good thing, because a lot of the brokenness is in how things are
exported.  Thus, you want libc to be able to have a linux/* wrapper
for backwards compatibility.

My first choice would be to put the ABI headers in linux/abi.

> > Good, except your "struct winsize" is bad; you're stepping on
> > namespace which belongs to userspace.  Since we can't use typedefs on
> > struct tags, I suggest:
> >
> > struct __kstruct_winsize {
> >        /* ... */
> > };
> >
> > .. and userspace can do:
> >
> > #define __kstruct_winsize winsize
> 
> My initial suggestion would be to leave the types as-is, primarily for
> the reasons in Linus' earlier email, but also for simplicity and to
> prevent inadvertent breakage.

True; I hadn't considered the weirdness of the namespace pollution
issue.  However, the issue with struct tags remain.

Note also that not all ABI issues can be well-described in C headers,
and certainly not the way it currently is.  Syscall numbers and ioctl
APIs are examples there (I do some hideously ugly hacks in klibc to
try to auto-derive as much of the ABI as possible; this is part of
making klibc very easy to port to new architectures and keeps
maintenance in one place.)  However, cleaning up the headers is a
major step forward.

> >>  (3) Remove all #if(n)def __KERNEL__ clauses.
> >>
> >>  (4) Remove the -D__KERNEL__ from the master kernel Makefile.
> >
> > Bad!  There is code in the kernel which can compile in userspace for
> > testing.  This is highly valuable and should be kept.
> 
> I would propose that if we decide to move the public headers instead of
> the internal kernel headers, we autogenerate headers for installation
> that have a #warning wrapper if __KERNEL__ isn't defined.

	-hpa
