Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVDMMkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVDMMkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 08:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVDMMkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 08:40:45 -0400
Received: from alog0579.analogic.com ([208.224.223.116]:6125 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261322AbVDMMkf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 08:40:35 -0400
Date: Wed, 13 Apr 2005 08:40:05 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Hacksaw <hacksaw@hacksaw.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomko <tomko@haha.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before
  using it
In-Reply-To: <200504131159.j3DBxsoa010918@hacksaw.org>
Message-ID: <Pine.LNX.4.61.0504130818300.12518@chaos.analogic.com>
References: <200504131159.j3DBxsoa010918@hacksaw.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Hacksaw wrote:

>>> Why not use it directly
>> Some of these reasons are:
>
> It seems like you gave reason why userland pointers shouldn't be trusted, not
> why userland data should be copied into kernel land. All the problems you
> mentioned would have to be solved by the kernel regardless of copying the data
> around.
>

You do not seem to understand. Assume that I did a read(fd, buf, len) and
the length would overflow a user-mode buffer. One needs to make sure
that the kernel is protected and the user gets a seg-fault. Since the
kernel, in kernel mode, can do anything it pleases, including destroying
itself, one needs to make sure that it won't. Therefore a special
kind of memcpy() was designed, called copy_to/from_user to protect the
kernel.

> Ummm... Except for the who's mapped now problem. That's pretty weird. I guess
> that's something that comes with trying to use tons of RAM in a 32 bit system.
>
> I thought the big issue was the need to lock the page(s) during the call, and
> maybe some tricky races which made the idea difficult.
> --

The kernel does NOT have to copy data from user-space before
using it. In fact, user-mode pointers are valid in kernel-space
when the kernel is performing a function on behalf of the user-
mode code. The problem is that data-space is usually allocated
in user-mode code (like using malloc()). When the kernel needs
to access that buffer, it has no clue how much the user-code
allocated. It can't trust that the user-code put in the right
buffer length. Therefore, it needs to set up a user-mode trap
if the access attempts to go beyond the buffer length.

Examples of not copying to/from user mode is memory-mapped
data. The kernel knows how much data was actually mapped. It
also knows if it will page-fault when being accessed. If
DMA is being performed to such memory, it needs to be reserved
so it won't be paged. It also has to be non-cached so that
writes that the CPU didn't do can be read properly by the CPU.

Under these conditions, the kernel-mode code writes or DMAs
directly to some user buffer. User-mode code needs to find
out when new data are available, perhaps using select() or
poll().

If you are writing a driver, never attempt to copy/to/from/user
with a spin-lock held. You need to allow page-faults to
occur because the user's RAM may have been "borrowed" by
somebody else (paged out). A page-fault needs to occur to
replace the user's RAM-data and reconnect to the user's
working-set.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
