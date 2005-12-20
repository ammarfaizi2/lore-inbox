Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVLTPrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVLTPrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVLTPrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:47:36 -0500
Received: from smtp.nextra.cz ([195.70.130.4]:27397 "EHLO smtp.nextra.cz")
	by vger.kernel.org with ESMTP id S1751108AbVLTPrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:47:35 -0500
Message-ID: <43A82764.8050305@nextra.cz>
Date: Tue, 20 Dec 2005 16:46:44 +0100
From: Zdenek Pavlas <pavlas@nextra.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Rob Landley <rob@landley.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] misc: Make *[ug]id16 support optional
References: <11.282480653@selenic.com> <200511160721.30845.rob@landley.net> <20051116180140.GO31287@waste.org>
In-Reply-To: <20051116180140.GO31287@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

> On Wed, Nov 16, 2005 at 07:21:30AM -0600, Rob Landley wrote:
>>Is there an easy way to make sure our programs aren't using these?  (If I 
>>build a new system from source with busybox and uclibc, how do I know if I 
>>can disable this?)
> 
> These should only be found in legacy binaries, ie 5+ years old.

Not true, unfortunately.  To make uClibc work with linux-tiny
and [ug]id16 disabled one has to apply patches like this.
uClibc probably assumes 16 bit __kernel_[ug]id_t and uses
legacy syscalls exclusively.

--- uClibc-0.9.28/libc/sysdeps/linux/common/chown.c
+++ uclibc/libc/sysdeps/linux/common/chown.c
@@ -10,16 +10,11 @@
  #include "syscalls.h"
  #include <unistd.h>

-#define __NR___syscall_chown __NR_chown
+#define __NR___syscall_chown __NR_chown32
  static inline _syscall3(int, __syscall_chown, const char *, path,
                 __kernel_uid_t, owner, __kernel_gid_t, group);

  int chown(const char *path, uid_t owner, gid_t group)
  {
-       if (((owner + 1) > (uid_t) ((__kernel_uid_t) - 1U))
-               || ((group + 1) > (gid_t) ((__kernel_gid_t) - 1U))) {
-               __set_errno(EINVAL);
-               return -1;
-       }
         return (__syscall_chown(path, owner, group));
  }

-- 
Zdenek Pavlas
NEXTRA Czech Republic s.r.o.  http://www.nextra.cz
