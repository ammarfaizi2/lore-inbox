Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTEIQ23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTEIQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:28:29 -0400
Received: from SCULLY.TRAFFORD.DEMENTIA.ORG ([128.2.245.230]:43438 "EHLO
	scully.trafford.dementia.org") by vger.kernel.org with ESMTP
	id S263279AbTEIQ20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:28:26 -0400
Date: Fri, 9 May 2003 12:40:47 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
X-X-Sender: shadow@scully.trafford.dementia.org
To: David Howells <dhowells@redhat.com>
cc: openafs-devel@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: Adding an "acceptable" interface to the Linux kernel for AFS
In-Reply-To: <10180.1052475409@warthog.warthog>
Message-ID: <Pine.LNX.4.53.0305091056490.31198@scully.trafford.dementia.org>
References: <10180.1052475409@warthog.warthog>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, David Howells wrote:

> I'm trying to write an AFS syscall framework for the Linux kernel that can do
> two things:

Pick any 2? ;-)

>  (1) Handle PAGs without the need to subvert the groups list and override the
>      set/getgroups syscalls.
>
>  (2) Cache authentication data per PAG, doing garbage collection automatically
>      when a PAG no longer has any attached processes.
>
>  (3) Pass other AFS syscall operations to interfaces in whatever AFS
>      filesystem module is currently loaded (OpenAFS, Arla, etc.).
>
> However, (3) is somewhat tricky as the interface isn't very consistent. For
> instance, it would appear that all PIOCTL commands should require a path, but
> some of them don't:-/ I don't know why these commands were made PIOCTLs rather
> than using the CALL interface, but it makes multiplexing in the core kernel
> more difficult.

History. Realistically I'd only worry about pioctls that do take a path,
and assume the others will be handled some other way. In fact:

> I'm wondering how attached OpenAFS is to this interface? Can OpenAFS be
> altered to use the following access points instead:

Generally I think this interface will work. I have a few questions:

>  (1) setpag(pag_t pag)

If you don't specify a pag it should allocate you one, and for non-priviledged
users this should be the only allowed mode.

>  (2) getpag()

I assume:
fs is a text representation of whose filesystem you're doing this for?
("openafs", "arla", etc)
domain is what's typically referred to as an afs cell

I'd also like to see a priviledged "unsetpag()", e.g. I no longer wish to be
in a pag.

>  (3) settok(const char *fs, const char *domain, size_t size, const void *data)
>
>  (4) gettok(const char *fs, const char *domain, size_t size, void *data)
>
>  (5) deltok(const char *fs, const char *domain)
>
>  (6) cleartoks(const char *fs)

Currently it's possible to set a token when you have no pag, and these
become associated with the uid that set them. (The pag number is not the uid;
Instead any process without a pag but with a uid that has tokens associated
with it gets those tokens.) As long as the above don't bind tightly to a pag,
sure.

As to pioctl, will it be able to handle things where path cannot be stat'd
in advance? For instance, the prefetching hint (VIOCPREFETCH), if you
could stat it, it wouldn't be a prefetch. Another concern there would be
dangling mount points (a mount point you still have to a volume that's
been deleted) when calling VIOC_AFS_DELETE_MT_PT or VIOC_AFS_STAT_MT_PT.

As long as this is doable, we will conform.

>  (7) pioctl(const char *path, int cmd, void *arg, int followsymlinks)
>
>      (Where path is mandatory.)
>
>      It may be possible to replace this entirely with calls to setxattr and
>      co. from userspace... apart from VIOC_AFS_STAT_MT_PT that is, and that
>      could be done with open/ioctl/close on the directory.

To the extent we can we'd avoid relying on this (8), but I think we'll need it
for now.

>  (8) fsctl(const char *fs, const char *cmd, struct fsctl_buf)
>
>      Using:
>
>       struct fsctl_buf { size_t in_size, out_size; void *in, *out; };
>
>      All miscellaneous ops would be done through this. It would work
>      internally as nfsservctl does in 2.5.

The only other concern is transition for existing sites, and that need not
be done in the kernel. All we ask is the current "afs syscall" number be
left vacant, and sites that care can patch their kernel. Nothing need be
distributed.

