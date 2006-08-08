Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWHHMJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWHHMJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWHHMJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:09:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33986 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932180AbWHHMJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:09:51 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edgar Toernig <froese@gmx.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <20060807224144.3bb64ac4.froese@gmx.de>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 13:29:17 +0100
Message-Id: <1155040157.5729.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-07 am 22:41 +0200, ysgrifennodd Edgar Toernig:
> It seems, revoke was intended to disable access to tty devices
> from old processes in a controlled way.  Sounds sane.

Thats the root from which it comes but that alone is insufficient which
is why our vhangup is not enough.

> Your implementation is much cruder - it simply takes the fd
> away from the app; any future use gives EBADF.  As a bonus,

It needs to give -ENXIO/0 as per BSD that much is clear.

> it works for regular files and even goes as far as destroying
> all mappings of the file from all processes (even root processes).
> IMVHO this is a disaster from a security and reliability point
> of view.

Actually its no different than if it didn't. The two are identical
behaviours.

To use revoke() I must own the file
If I own the file I can make it a symlink to a pty/tty pair
I can revoke a pty/tty pair

> A serious question: What do you need this feature of revoking
> regular files (or block devices) for?  Maybe my imagination
> is lacking, but I can't find a use where fuser(1) (or similar
> tools) wouldn't be as good or even better than revoke(2).

On a typical non-SELinux system with a typical desktop configuration
(SELinux can effectively replace revoke) you need revoke on block
devices in order to guarantee security and on other char devices for
privacy. I'll provide some demonstrations after we have revoke in some
form in the kernel and the problems in question fixed.

There are specific cases where being able to revoke access to one of
your files is useful as well, particularly if you are moving it from
open permissions to private permissions. That one is to be honest much
less interesting and it is easy enough to make our revoke()
implementation return -EINVAL.

The driver only case actually makes it a lot easier because you only
need to set some kind of f_revoked flag on files owned by that device,
truncate the virtual memory mappings and then call the driver method.
The driver would then honour ->f_revoked in its own ioctl/read/write
methods or in the helpers.

Alan

