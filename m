Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbTDUTDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTDUTDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:03:48 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:55017 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262639AbTDUTDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:03:47 -0400
Date: Mon, 21 Apr 2003 12:15:28 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER]  Help Needed!
In-Reply-To: <3EA3B87B.60505@colorfullife.com>
Message-ID: <Pine.GSO.4.44.0304211213210.29293-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot for your explanation! That clarifies everything.

-Junfeng

On Mon, 21 Apr 2003, Manfred Spraul wrote:

> Junfeng wrote:
>
> >It seems to us that create_dev can only be called at boot time (the
> >"__init" attribute), so devfs_name must be an untainted kernel pointer.
> >The warning on line 437 isn't a real error.
> >
> >However, this pointer is finally passed into strncpy_from_user through the
> >call chain [ sys_symlink (devfs_name, name) --> getname (oldname) -->
> >do_getname(filename, _) --> strncpy_from_user (_, filename, _)].  Is it
> >okay to call *_from_user functions with the second arguements untainted?
> >What will access_ok(VERIFY_READ, src, 1) return?
> >
> >
> The copy_{to,from}_user functions can access either user or kernel space.
> after set_fs(KERNEL_DS), they access kernel space, after
> set_fs(USER_DS), they access user space.
>
> The initial boot thread starts with set_fs(KERNEL_DS), and is switched
> back to set_fs(USER_DS) in search_binary_handler (fs/exec.c), called
> during exec of /sbin/init.
>
> --
>     Manfred
>
> P.S.: On i386, you can access both kernel and user space after
> set_fs(KERNEL_DS), or if you use __get_user() and bypass access_ok().
> Thus the __get_user() in arch/i386/kernel/traps.c, function
> show_registers is correct. This is the only instance I'm aware of where
> this is used, and noone else should be doing that. It fails on other
> archs, e.g. on sparc.
>

