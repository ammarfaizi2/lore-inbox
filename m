Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbTFQPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbTFQPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 11:55:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51213 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264809AbTFQPzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 11:55:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] VFS autmounter support
Date: 17 Jun 2003 09:08:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bcneds$or6$1@cesium.transmeta.com>
References: <6516.1055861757@warthog.warthog>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <6516.1055861757@warthog.warthog>
By author:    David Howells <dhowells@redhat.com>
In newsgroup: linux.dev.kernel
>
> 
> Hi Linus, Al,
> 
> The attached patch adds automounting support and mountpount expiry support to
> the VFS.
> 
> This patch involves the adding the following features:
> 
>  (1) A new dentry operation that (a) marks a dentry as being an automount
>      point, and (b) gets called by the VFS to come up with a vfsmount
>      structure which the VFS then stitches into the mount tree fabric at the
>      appropriate place.
> 
>  (2) A new lookup flag that is used by sys_*stat() to prevent automounting of
>      the path endpoint. This means "ls -l" in an automounter directory doesn't
>      cause a mount storm, but will display all the mountpoints in that
>      directory as subdirectories (either the underlying mountpoint dir or the
>      root dir of the mounted fs if the mountpoint has been triggered already).
> 
>  (3) do_kern_mount() is now exported.
> 
>  (4) The vfsmount structure has acquired, amongst other things, a timeout
>      field. If mntput() notices a vfsmount reach a usage count of 1, then the
>      vfsmount expiry time is set and the namespace that contains the vfsmount
>      has its expiration work chitty queued.
> 
>  (5) The namespace structure has acquired a work struct that is used to
>      actually perform vfsmount expiry under process context.
> 

This seems a bit heavyweight; although some VFS support is needed for
a complex filesystem, effectively doing it all in the kernel (#3)
seems a bit... excessive.

At least #2 can be done with existing means using follow_link.

I think using a revalidation pointer like dentries might be a better
way to do #4/#5, although using the existing one in the dentries is
probably better.

#1 isn't really clear to me what you're going for, but it seems to be
to duplicate bookkeeping.

I also don't see how this solves the biggest problems with complex
automounts, which are:

a) how to guarantee that a large mount tree can be safely destroyed;
b) how to detect partial unmounts.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
