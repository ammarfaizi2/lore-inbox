Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUHICjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUHICjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 22:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUHICjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 22:39:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63433 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265872AbUHICiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 22:38:00 -0400
Date: Sun, 8 Aug 2004 19:37:43 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org
Subject: Re: warning: comparison is always false due to limited range of
 data type
Message-Id: <20040808193743.6076bdd3.pj@sgi.com>
In-Reply-To: <20040808142107.GB94449@muc.de>
References: <411562FD.5040500@blue-labs.org>
	<20040807174133.1e368fbc.pj@sgi.com>
	<20040808142107.GB94449@muc.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Someone else please take care of it.

Let's give this a try.  It fixes the warning in my i386 and ia64 trees.

Unfortunately, this patch uses the notorious "gcc warning suppression
by obfuscation" technique.

What seems to be going on is that the uid and gid convert macros in
include/linux/highuid.h:

#define __convert_uid(size, uid) \
        (size >= sizeof(uid) ? (uid) : high2lowuid(uid))

only call high2lowuid in the case of trying to put a bigger (32 bit,
say) uid/gid in a smaller (16 bit, in this case) word.  Gcc is smart
enough to see that the comparison in high2lowuid() macro is silly if
called with a 16 bit source uid, but not smart enough to understand
from the __convert_uid() logic that this is exactly the case that
high2lowuid() won't be called.

So replace the logical "<" operator with the bit op "&~".  This
obfuscates things enough to shut gcc up.

Only build the half-dozen files that use SET_UID/SET_GID, on arch
i386 and ia64.  Only the file fs/smbfs/inode.c showed the warning,
both arch's, and this patch fixed both.  Untested further, past
staring at the code long enough to convince myself the change has
no actual affect on the code's  results.


Index: 2.6.8-rc2-mm2/include/linux/highuid.h
===================================================================
--- 2.6.8-rc2-mm2.orig/include/linux/highuid.h	2004-08-04 19:27:48.000000000 -0700
+++ 2.6.8-rc2-mm2/include/linux/highuid.h	2004-08-08 19:03:47.000000000 -0700
@@ -44,8 +44,8 @@ extern void __bad_gid(void);
 #ifdef CONFIG_UID16
 
 /* prevent uid mod 65536 effect by returning a default value for high UIDs */
-#define high2lowuid(uid) ((uid) > 65535 ? (old_uid_t)overflowuid : (old_uid_t)(uid))
-#define high2lowgid(gid) ((gid) > 65535 ? (old_gid_t)overflowgid : (old_gid_t)(gid))
+#define high2lowuid(uid) ((uid) & ~0xFFFF ? (old_uid_t)overflowuid : (old_uid_t)(uid))
+#define high2lowgid(gid) ((gid) & ~0xFFFF ? (old_gid_t)overflowgid : (old_gid_t)(gid))
 /*
  * -1 is different in 16 bits than it is in 32 bits
  * these macros are used by chown(), setreuid(), ...,
@@ -89,8 +89,8 @@ extern int fs_overflowgid;
  * Since these macros are used in architectures that only need limited
  * 16-bit UID back compatibility, we won't use old_uid_t and old_gid_t
  */
-#define fs_high2lowuid(uid) ((uid) > 65535 ? (uid16_t)fs_overflowuid : (uid16_t)(uid))
-#define fs_high2lowgid(gid) ((gid) > 65535 ? (gid16_t)fs_overflowgid : (gid16_t)(gid))
+#define fs_high2lowuid(uid) ((uid) & ~0xFFFF ? (uid16_t)fs_overflowuid : (uid16_t)(uid))
+#define fs_high2lowgid(gid) ((gid) & ~0xFFFF ? (gid16_t)fs_overflowgid : (gid16_t)(gid))
 
 #define low_16_bits(x)	((x) & 0xFFFF)
 #define high_16_bits(x)	(((x) & 0xFFFF0000) >> 16)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
