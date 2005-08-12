Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVHLXun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVHLXun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 19:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVHLXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 19:50:43 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64951 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750884AbVHLXum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 19:50:42 -0400
Subject: Re: copy_from_user, copy_to_user in kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Martijn van Oosterhout <kleptog@svana.org>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       KrnlUsr <kdp102@yahoo.com>
In-Reply-To: <20050812203552.GG4305@svana.org>
References: <20050812181623.6814.qmail@web80214.mail.yahoo.com>
	 <20050812203552.GG4305@svana.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 12 Aug 2005 19:50:28 -0400
Message-Id: <1123890628.5296.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-12 at 22:35 +0200, Martijn van Oosterhout wrote:
> I had this problem when writing a kernel module that was using a UDP
> socket to send and receive stuff. It would work fine in UML but fail in
> the real kernel. I never worked it out but someone later patched it by
> using the [gs]et_[df]s() functions. If you grep the kernel source you
> can see a lot of places use it. The problem is I still have no idea why
> it works...
> 

These work because you are changing the access area of the user. Well,
not really the user, but user copying macros.  Normally a
copy_(from|to)_user would fail if it were to try to access kernel area.
Otherwise, a user process could fool a system call to use kernel memory
as an output. This would be horrible for security.

Imagine:

fd=open("my_nano_kernel",O_RDONLY);
read(fd,0xc0000000,MY_NANO_KERNEL_SIZE);

If anything, on some architectures, this could rewrite the interrupt
handlers. Or with the access to System.map, you could put in your own
values to different functions. Or read from the kernel's view of memory,
to find passwords, and the list goes on. Just plain bad!

The setting of set_fs changes this area to allow system calls to be done
from the kernel, where it is ok to access kernel memory.  But these are
always done temporarily, and then changed back to limited access. Thus
you have save the old value of the get_fs, change it to use the
KERNEL_DS version, then set it back to what it was.  (don't blindly set
it back to USER_DS, since it could have been in KERNEL_DS from the start
for some reason, like kernel threads).

Although the naming of these macros are horrible, as mentioned in the
file that declares them:

/*
 * The fs value determines whether argument validity checking should be
 * performed or not.  If get_fs() == USER_DS, checking is performed, with
 * get_fs() == KERNEL_DS, checking is bypassed.
 *
 * For historical reasons, these macros are grossly misnamed.
 */

The macros are used to make things easier across architectuers.

-- Steve


