Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVLPAcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVLPAcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVLPAcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:32:19 -0500
Received: from mail.dvmed.net ([216.237.124.58]:55522 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751218AbVLPAcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:32:18 -0500
Message-ID: <43A20B0B.5090205@pobox.com>
Date: Thu, 15 Dec 2005 19:32:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH 0/3] *at syscalls: Intro
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>
In-Reply-To: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Ulrich Drepper wrote: > Here is a series of patches
	which introduce in total 11 new system calls > which take a file
	descriptor/filename pair instead of a single file name. > These
	functions, openat etc, have been discussed on numerous occasions. >
	They are needed to implement race-free filesystem traversal, they are >
	necessary to implement a virtual per-thread current working directory >
	(think multi-threaded backup software), etc. > > We have in glibc today
	implementations of the interfaces which use the > /proc/self/fd magic.
	But this code is rather expensive. Here are some > results (similar to
	what Jim Meyering posted before): > > The test creates a deep directory
	hierarchy on a tmpfs filesystem. > Then rm -fr is used to remove all
	directories. Without syscall support > I get this: > > real 0m31.921s >
	user 0m0.688s > sys 0m31.234s > > With syscall support the results are
	much better: > > real 0m20.699s > user 0m0.536s > sys 0m20.149s > > >
	The implemenation is really small: > > arch/i386/kernel/syscall_table.S
	| 11 ++ > arch/x86_64/ia32/ia32entry.S | 11 ++ > fs/compat.c | 48
	+++++++++-- > fs/exec.c | 2 > fs/namei.c | 167
	++++++++++++++++++++++++++++++--------- > fs/open.c | 60 +++++++++++---
	> fs/stat.c | 54 ++++++++++-- > include/asm-i386/unistd.h | 13 ++- >
	include/asm-x86_64/ia32_unistd.h | 13 ++- > include/asm-x86_64/unistd.h
	| 24 +++++ > include/linux/fcntl.h | 7 + > include/linux/fs.h | 7 + >
	include/linux/namei.h | 7 - > include/linux/time.h | 2 > 14 files
	changed, 355 insertions(+), 71 deletions(-) > > I've split the patch in
	three parts. The first part is the actual > code change. It mostly
	consists of passing down an additional parameter > with a file
	descriptor and add wrapper functions which pass down the > default
	parameter AT_FDCWD. Three new constants are defined in >
	<linux/fcntl.h> which must correspond to the values already in use > in
	glibc. In a few cases I've modified some code which would not >
	necesarily need changing but the change makes it a bit more efficient >
	in presence of the [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Here is a series of patches which introduce in total 11 new system calls
> which take a file descriptor/filename pair instead of a single file name.
> These functions, openat etc, have been discussed on numerous occasions.
> They are needed to implement race-free filesystem traversal, they are
> necessary to implement a virtual per-thread current working directory
> (think multi-threaded backup software), etc.
> 
> We have in glibc today implementations of the interfaces which use the
> /proc/self/fd magic.  But this code is rather expensive.  Here are some
> results (similar to what Jim Meyering posted before):
> 
> The test creates a deep directory hierarchy on a tmpfs filesystem.
> Then rm -fr is used to remove all directories.  Without syscall support
> I get this:
> 
> real    0m31.921s
> user    0m0.688s
> sys     0m31.234s
> 
> With syscall support the results are much better:
> 
> real    0m20.699s
> user    0m0.536s
> sys     0m20.149s
> 
> 
> The implemenation is really small:
> 
>  arch/i386/kernel/syscall_table.S |   11 ++
>  arch/x86_64/ia32/ia32entry.S     |   11 ++
>  fs/compat.c                      |   48 +++++++++--
>  fs/exec.c                        |    2 
>  fs/namei.c                       |  167 ++++++++++++++++++++++++++++++---------
>  fs/open.c                        |   60 +++++++++++---
>  fs/stat.c                        |   54 ++++++++++--
>  include/asm-i386/unistd.h        |   13 ++-
>  include/asm-x86_64/ia32_unistd.h |   13 ++-
>  include/asm-x86_64/unistd.h      |   24 +++++
>  include/linux/fcntl.h            |    7 +
>  include/linux/fs.h               |    7 +
>  include/linux/namei.h            |    7 -
>  include/linux/time.h             |    2 
>  14 files changed, 355 insertions(+), 71 deletions(-)
> 
> I've split the patch in three parts.  The first part is the actual
> code change.  It mostly consists of passing down an additional parameter
> with a file descriptor and add wrapper functions which pass down the
> default parameter AT_FDCWD.  Three new constants are defined in
> <linux/fcntl.h> which must correspond to the values already in use
> in glibc.  In a few cases I've modified some code which would not
> necesarily need changing but the change makes it a bit more efficient
> in presence of the wrapper functions.
> 
> The real change needed is the additional else-clause in what is now
> do_path_lookup.  That's it.

Definitely gets my ACK, for my own motivations:  I want to create 
race-free cp(1)/mv(1)/rm(1) utilities for my posixutils project.

It would be nice to add the additional argument to path_lookup(), rather 
than calling do_path_lookup() everywhere.

	Jeff



