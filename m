Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVC0IYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVC0IYl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVC0IYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:24:33 -0500
Received: from [221.216.56.207] ([221.216.56.207]:28642 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261450AbVC0IYY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:24:24 -0500
Date: Sun, 27 Mar 2005 16:11:59 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200503270811.j2R8BxJ12538@freya.yggdrasil.com>
To: jengelh@linux01.gwdg.de
Subject: Re: Squashfs without ./..
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>[...] . and .. do not need to show up (even they have been the 
>"leaders" of ls -l ;-), Midnight Commander (`mc`) for example synthesizes ".." 
>nevertheless.
>
>So - what about removing . and .. in readdir for all "standard harddisk 
>filesystems" (ext*,reiser*, [jx]fs)? I mean, one party always has to loose...~v

	Eliminating the "." and ".." emulation in many individual
file systems would probably eliminate a moderate amount of code
from libfs/fs.c, a number of other virtual file systems and probably
every physical file system that does not actually store "." and "..".
It is very appealing to me.

	Unfortunately, the description of readdir() in the Single Unix
Specification version 3 says:

| [...] If entries for dot or dot-dot exist, one entry shall be returned
| for dot and one entry shall be returned for dot-dot; otherwise, they
| shall not be returned.

	Unless attempts to access "." and ".." would really return -ENOENT,
then at least the C library's readdir() function has to return them.  
At least that's how I read it.

	Although I do not believe that absolute compliance to SUSPv3
is a requirement demanded by those who make the "official" kernel
releases, I think that complying closely to SUSPv3 and many other
standards is considered to be worth a lot (in terms of technical
trade-offs) so that software that complies to these standards
is more likely to run properly on systems running the Linux kernel.
So, I would expect that patches changing squashfs and other file systems
whose readdir functions currently fail to return "." and ".." would 
be likely to be integrated (if they meet all the other usual quality
standards), at least for now.

	That said, I can think of at least two approaches by which
we could eliminate the "." and ".." emulation littering most Linux
file system drivers.

	The first way would be to change the kernel so that the
underlying readdir system call does not return "." or "..", but
have the C library do the emulation.  The C library can maintain
the state information for this purpose easily because opendir()
returns a pointer to an opaque structure that the C library
allocates.

	Alternatively, we could preserve the opendir system call's
behavior, but pick apart a few of the routines in fs/libfs.c to come
up with some more general utiity routines to implement the common case
where the first readdir returns ".", the second returns "..", a seek
pointer of 0 means before the ".", a seek pointer of 1 means before
the "..", and a seek pointer of 1 means immediately after the "..".
The actual implementation would be pretty short, but having an
interface that the client file systems could easily accomodate might
take some care (for example, accomodating their locking schemes while
keeping the interface simple enough so that the client file system
drivers are still made smaller by using it).

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
