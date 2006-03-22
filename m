Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751871AbWCVA1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWCVA1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWCVA1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:27:32 -0500
Received: from hera.kernel.org ([140.211.167.34]:3794 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751871AbWCVA1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:27:31 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Merge strategy for klibc
Date: Tue, 21 Mar 2006 16:27:02 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dvq5km$o0g$1@terminus.zytor.com>
References: <441F0859.2010703@zytor.com> <Pine.LNX.4.64.0603202228441.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1142987222 24593 127.0.0.1 (22 Mar 2006 00:27:02 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 22 Mar 2006 00:27:02 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.64.0603202228441.17704@scrub.home>
By author:    Roman Zippel <zippel@linux-m68k.org>
In newsgroup: linux.dev.kernel
> 
> You forgot to provide any information (at least a summary) about what this 
> is and how this will work. Please don't assume everyone is familiar with 
> it.
> 
> There is one major question: how will this interface to distributions?
> 
> How can distributions add their own initializations and configurations or 
> are they going to put an initrd on top of the kernel initrd? If this will 
> have a kernel and a distribution part, it poses the question whether klibc 
> has to be distributed with the kernel at all (a libc has a standard API 
> after all) and the kernel just provides the kernel specific parts to 
> whatever the distribution provides.
> 

Okay... quick summary (again)...

klibc is a small libc, small enough that it provides negible (or even
negative) overhead to bundle it inside the kernel binary.

The kernel tree part is there so that we can rip out in-kernel code
without breaking compatibility, or requiring a distribution-provided
initramfs.  In the future, we could consider retaining certain
binaries in the rootfs and have "on-demand userspace" by the kernel,
e.g. to do partition enumeration in userspace in a
backwards-compatible manner.

The default build provides a single binary called kinit, which is
(modulo any bugs) equivalent to the in-kernel root-mounting code, with
all its variants (initrd, nfsroot, load ramdisk from floppy, yadda
yadda.)  The existence of kinit allows the in-kernel code to be
removed without actually removing a feature.  Hence, the reason to put
this in the kernel tree is to make sure there is zero impact on
distributions.

If the distribution uses initramfs directly, kinit goes unused.  The
klibc code is also available as a standalone distribution, which at
least Ubuntu is currently using to build a custom initramfs.  Because
the kinit code is still userspace, it can share considerable amounts
of code with the standalone klibc utilities collection; in fact most
of the kinit pieces are available as standalone binaries which can be
weaved together by scripts or other C code.

The advantages of moving this code to userspace, thus is:

 - Simpler programming model (harder to screw up)
 - Easier to share code with distribution-customized setups
 - Code can be tested as standalone userspace binaries at runtime

A lot of the benefit is lost if, like now, there is a piece of code
which has to be written for kernel-mode programming, separate from
anything else and not testable except through a tedious kernel boot
cycle.

	-hpa
