Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUIARZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUIARZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUIARYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:24:39 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:13045 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267165AbUIAPzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:55:15 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
X-Message-Flag: Warning: May contain useful information
References: <20040901072245.GF13749@mellanox.co.il>
	<20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 01 Sep 2004 08:55:11 -0700
In-Reply-To: <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk> (viro@parcelfarce.linux.theplanet.co.uk's
 message of "Wed, 1 Sep 2004 08:32:19 +0100")
Message-ID: <52zn4a0ysg.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2004 15:55:11.0453 (UTC) FILETIME=[1006B8D0:01C4903C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This thread raises the issue of the best way for a driver to handle
commands from userspace.  The typical situation is where the driver
needs to process commands from multiple processes and return a status
for each command.

I happen to work on the same type of drivers as Michael (InfiniBand),
and there are a fairly large number of operations that userspace would
like to call into the kernel for.  User applications ask the kernel
driver to do things like "create completion queue."  One would like to
make this call in a clean, simple, efficient way.

I can think of four ways to do this:

 - ioctl on char device:
     Nice because it is synchronous and allows for the kernel to
     return a status value easily.  Has a well-defined mechanism for
     handling 32-bit/64-bit compatibility.  Unfortunately ioctl
     methods run under the BKL.

 - read/write on char device:
     OK, except requires some mechanism (tag #) for matching requests
     and responses.  Nowhere clean to put 32/64 compatibility code.

 - netlink:
     Similar to read/write except it adds the possibility of dropping
     messages.

 - syscall:
     Syscalls are great in some ways.  They are the most direct way
     into the kernel, they allow 

     However: syscalls can't be added from modules; it's (quite
     correctly) very hard to get new syscalls added to the kernel;
     every arch numbers its syscalls differently.  Let's forget about
     syscalls.

ioctls end up looking like the least bad solution, although I'm open
to other opinions and I'd love to hear better ideas.  I'd be happy
with a policy of only accepting ioctls that are sparse and 32/64 clean
and generally maintainable-looking, but I don't think driver authors
have much alternative to ioctl right now.

Thanks,
  Roland
