Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWDEUk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWDEUk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWDEUk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:40:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27047 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750791AbWDEUk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:40:58 -0400
To: Mike Hearn <mike@plan99.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <4431A93A.2010702@plan99.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 05 Apr 2006 14:39:16 -0600
In-Reply-To: <4431A93A.2010702@plan99.net> (Mike Hearn's message of "Tue, 04
 Apr 2006 00:01:14 +0100")
Message-ID: <m1fykr3ggb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Hearn <mike@plan99.net> writes:

> Alright, Andrew Morton indicated that he liked this patch but the idea needed
> discussion and mindshare. I asked Con Kolivas if it made sense to go in his
> desktop patchset for people to try: he said he liked it too but it's not his
> area, and that it should be discussed here.
>
> To clarify, I'm proposing this patch for eventual mainline inclusion.
>
> It adds a simple bit of API - a symlink in /proc/pid - which makes it easy to
> build relocatable software:
>
>    ./configure --prefix=/proc/self/exedir/..
>
> This is useful for a variety of purposes:
>
> * Distributing programs that are runnable from CD or USB key (useful for
>    Linux magazine cover disks)
>
> * Binary packages that can be installed anywhere, for instance, to your
>    home directory
>
> * Network admins can more easily place programs on network mounts
>
> I'm sure you can think of others. You can patch software to be relocatable
> today, but it's awkward and error prone. A simple patch can allow us to get it
> "for free" on any UNIX software that uses the idiomatic autotools build system.
>
> So .... does anybody have any objections to this? Would you like to see it go
> in? Speak now or forever hold your peace! :)

You patch needs to move proc_exedir_link into base.c instead
of replicating it twice (that is a maintenance problem).

I think if we can fix namespaces you don't have to be root to use
them that is a superioir approach, and will cover more cases.

I have concerns about security policy in this case because a proc
symlink is not a symlink.  So if you chmod an intermediate directory
in your prefix to 000 you will still be able to access it.

I'm not at all certain I like applications depending on the fact
that I have procfs mounted on /proc.  It's bad enough that system
libraries are beginning to care.   This means I can not run any of
your relocatable executalbes in a chroot environment unless I mount
proc.

If we add this it will never be removed from /proc, so we should
be certain we want this.

Given how long we have been without this I doubt many people actually
care, or their software would be written so it was relocatable from
day one.

I'm not certain the directory of an inode even makes sense, and
that is what you are asking for us to export.

Eric
