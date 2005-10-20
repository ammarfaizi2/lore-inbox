Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbVJTFKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbVJTFKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 01:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbVJTFKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 01:10:13 -0400
Received: from mail.suse.de ([195.135.220.2]:1171 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751756AbVJTFKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 01:10:10 -0400
From: Neil Brown <neilb@suse.de>
To: linux-kernel@vger.kernel.org, matthew@wil.cx,
       linux-fsdevel@vger.kernel.org
Date: Thu, 20 Oct 2005 15:09:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.9874.463391.174006@cse.unsw.edu.au>
Subject: [PATCH/RFC] Fix overflow tests for compat_sys_fcntl64 locking.
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I think this came up in December last year, but never got resolved,
so I'm going to try.

A 32bit app running on a 64bit kernel sometimes gets EOVERFLOW errors
for what should be perfectly valid locking requests.
e.g. fcntl(fd, F_GETLK, {... l_start=0x7fffffff, l_len=1 ,,,} )

i.e. asking about a lock on the last possible byte of the file.

There are several problems with the current code as explained
in the commentary the following proposed patch, and fixed by the code.

Note: this code does *not* attempt to sanity-check the lock in the
request.   I don't think that is possible.
If an app asks for a lock from 0x7ffffff for 20 bytes, then whether
that is valid or returns -EOVERFLOW depending on whether the OS
supports files that big or not.  We cannot do any sensible test
related to this in compat_sys_fcntl64.

A possibly controversial aspect of this patch is that if the l_len
that would be returned is too large to fit in the data structure, it
is silently truncated.  I believe this is the most correct behaviour
possible, but I'm willing to listen to arguments.

I'm assuming that the f_start and f_len returned will never negative,
but haven't actually checked the code.  Does anyone know if they can
be negative?

Thanks,
NeilBrown 

(patch is against 2.6.14-rc4-mm1, but this area of code hasn't changed
in a while).

---------------------
When making an fctl locking call through compat_sys_fcntl64
(i.e. a 32bit app on a 64bit kernel), the syscall can return
a locking range that is in conflict with the queried lock.

If some aspect of this range does not fit in the 32bit structure,
something needs to be done.

The current code is wrong in several respects:

- It returns data to userspace even if no conflict was found
   i.e. it should check l_type for F_UNLCK
- It returns -EOVERFLOW too agressively.   A lock range covering
  the last possible byte of the file (start = COMPAT_OFF_T_MAX,
  len = 1) should be possible, but is rejected with the current test.
- An extra-long 'len' should not be a problem.  If only that part
  of the conflicting lock that would be visible to the 32bit
  app needs to be reported to the 32bit app anyway.

This patch addresses those three issues and adds a comment to
(hopefully) record it for posterity.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/compat.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff ./fs/compat.c~current~ ./fs/compat.c
--- ./fs/compat.c~current~	2005-10-20 14:22:54.000000000 +1000
+++ ./fs/compat.c	2005-10-20 14:38:46.000000000 +1000
@@ -500,10 +500,21 @@ asmlinkage long compat_sys_fcntl64(unsig
 		set_fs(KERNEL_DS);
 		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 		set_fs(old_fs);
-		if (cmd == F_GETLK && ret == 0) {
-			if ((f.l_start >= COMPAT_OFF_T_MAX) ||
-			    ((f.l_start + f.l_len) > COMPAT_OFF_T_MAX))
+		if (cmd == F_GETLK && ret == 0 && f.l_type == F_UNLCK) {
+			/* there was a conflicting lock, and we need to return
+			 * the data... but it needs to fit in the compat structure.
+			 * l_start shouldn't be too big, until the original
+			 * start + end is greater than COMPAT_OFF_T_MAX, in which
+			 * case the app was asking for trouble, so we return
+			 * -EOVERFLOW in that case.
+			 * l_len could be too big, in which case we just truncate it,
+			 * and only allow the app to see that part of the conflicting
+			 * lock that might make sense to it anyway
+			 */
+			if (f.l_start > COMPAT_OFF_T_MAX)
 				ret = -EOVERFLOW;
+			if (f.l_len > COMPAT_OFF_T_MAX)
+				f.l_len = COMPAT_OFF_T_MAX;
 			if (ret == 0)
 				ret = put_compat_flock(&f, compat_ptr(arg));
 		}
@@ -521,10 +532,12 @@ asmlinkage long compat_sys_fcntl64(unsig
 				((cmd == F_SETLK64) ? F_SETLK : F_SETLKW),
 				(unsigned long)&f);
 		set_fs(old_fs);
-		if (cmd == F_GETLK64 && ret == 0) {
-			if ((f.l_start >= COMPAT_LOFF_T_MAX) ||
-			    ((f.l_start + f.l_len) > COMPAT_LOFF_T_MAX))
+		if (cmd == F_GETLK64 && ret == 0 && f.l_type == F_UNLCK) {
+			/* need to return lock information - see above for commentary */
+			if (f.l_start > COMPAT_LOFF_T_MAX)
 				ret = -EOVERFLOW;
+			if (f.l_len > COMPAT_LOFF_T_MAX)
+				f.l_len = COMPAT_LOFF_T_MAX;
 			if (ret == 0)
 				ret = put_compat_flock64(&f, compat_ptr(arg));
 		}
