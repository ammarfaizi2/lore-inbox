Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262422AbRENTim>; Mon, 14 May 2001 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbRENTic>; Mon, 14 May 2001 15:38:32 -0400
Received: from comverse-in.com ([38.150.222.2]:25295 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S262431AbRENTiW>; Mon, 14 May 2001 15:38:22 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678EC4@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Chris Wing'" <wingc@engin.umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: uid_t and gid_t vs. __kernel_uid_t and __kernel_gid_t
Date: Mon, 14 May 2001 15:37:28 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,
thanks for your reply.

My case is exactly when copying has to be made, hence the awareness
of the user/kernel uid/gid "personalities".

I am trying to understand what's the cleanest coding that would allow
1) user code to just use uid/gid for interfacing the driver control
structures
2) driver code to read/write the corresponding structure fields with minimum
awareness of the actual difference between kernel and user uid_t/gid_t
layout.
3) all the messy adaptation confined as much as possible at the types
declaration (in the header included by both)
4) (2) & (3) should take into acct different platforms.

Right now, I allocate a uid_t/gid_t in the corresponding structure field
at the user level, and add arch-dependent padding in the kernel; and I had
to wrap the kernel-level access to these fields with special encoder/decoder
macros as long as user<->kernel interaction is taking place :-(
- see my orig. post for details.

My driver code doesn't use the __kernel types directly, but in the wrapping 
header macros I preferred those because I was explicitly defining the
padding logic, 
and was treating difference betw. user and kernel-level uids and gids.

V.
-----Original Message-----
From: Chris Wing [mailto:wingc@engin.umich.edu]

Vassilii:

__kernel_uid_t is my fault. The names are confusing, but uid_t and gid_t
are NOT supposed to be different in kernel and user space.

[snip]

Kernel code should always use uid_t as a type, except when copying data
between user and kernel space. In that case, just make sure that whatever
data structure you use is big enough to contain a Linux uid_t. (as of 2.4,
Linux uses 32-bit uid_t on all platforms) All new interfaces to user space
should use 32-bit uids, i.e. type unsigned int.

Don't use __kernel_uid_t at all in new code. The name is basically there
only because the older libc5 C library included the kernel headers and we
have to preserve it so that programs still compile on these old systems.

if you look inside /include/linux/types.h, this is made explicit:

#ifdef __KERNEL__
typedef __kernel_uid32_t	uid_t;

[snip]
