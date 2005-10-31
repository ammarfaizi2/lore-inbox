Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVJaP7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVJaP7D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVJaP7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:59:03 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:14473 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932327AbVJaP7C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:59:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M2RG5Rup8eUcFd/bXDFQVUYB9mGwVfkAzGzAiUbQPQ2SqBEuBjuJfbBqW1+7xgP1PdFGavgQ5Np04jE15hlnPHwn8uc1mHyJx05kO3o6V5A1yHo6vfeAbSrYll2jkaZz1Z28Ijw0b9/YDxbLDkjCs/z72+vM0ek+lktP5ONUNDI=
Message-ID: <35fb2e590510310758t7fd13cd1nec5a4881ccd9e5fa@mail.gmail.com>
Date: Mon, 31 Oct 2005 15:58:59 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: [PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
In-Reply-To: <43660693.6040601@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4363B081.7050300@jonmasters.org>
	 <35fb2e590510291035n297aa22cv303ae77baeb5c213@mail.gmail.com>
	 <43660693.6040601@weizmann.ac.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/05, Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il> wrote:
> Jon Masters wrote:

> > Let me know if this fixes it for you - should bomb out now if you try.
> > The error isn't the cleanest (blame mount), but it does fail.

> This works fine, thanks!

Good. This raises the general problem of devices knowing about their
underlying media status.

> For what it worth, though, mount -o remount,rw
> says remounting read-only yet still returns success. (Opposite to
> busybox, which now says "Permission denied" - rather misleading, but at
> least it fails).

Mount needs some fixing :-) It just tries calling sys_mount and
retries ro if that fails, then returns success because the last call
worked ok. Or so it would seem from the strace output.

> My question is, shouldn't it be implemented at a more generic level?

Yes. Right now, I think the gendisk policy is the best place to store
this - but having some generic "check the media status" VFS callback
might be a good thing.

> Floppy is just one example. Others are all kind of USB storage, ZIP/Jazz
> drives, and even normal SCSI disks (which have a RO jumper - at least
> some of them do).

I'll check, but they probably do something like this in their implementation.

> I got an ancient USB disk on key with a write-protection switch. When I
> plug it in in the RO mode, everything goes exactly as it was (before
> your patch) with floppy. Now something interesting:
> 1. The thingy is plugged in RW and mounted
> 2. While connected, I switch it to RO
>    dmesg says:
>    -> SCSI device sda: 129024 512-byte hdwr sectors (66 MB)
>    -> sda: Write Protect is on
>    -> sda: Mode Sense: 03 00 80 00
>    -> sda: assuming drive cache: write through
> 3.
> # mount -o remount,rw  /mnt
> mount: block device /dev/sda1 is write-protected, mounting read-only
> # echo $?
> 0
>
> So it seems there is some layer in bd which does know about RO status
> (and furthermore it's set by hot events)?

There's a callback for remount requests, perhaps they use that. Bear
in mind that USB devices tend to be more communicative than ancient
floppy disk drives. I'll have a look into this though - anyone else
reading who thinks we need a generic way of checking media read/write
status in addition to media change detect?

Jon.
