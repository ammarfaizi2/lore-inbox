Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVKOCDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVKOCDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVKOCDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:03:44 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61905 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932274AbVKOCDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:03:43 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 15 Nov 2005 13:03:21 +1100
Message-Id: <1051115020321.9502@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: [PATCH ] Fix overflow tests for compat_sys_fcntl64 locking.
References: <20051115130026.9469.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmitting this fix for compat_sys_fcntl64's handling of locking
(previous version had some typos).

Is against 2.6.14-mm2, should be suitable for 2.6.15, but can be held
over to 2.6.16 if you are feeling cautious.

Thanks,
NeilBrown

### Comments for Changeset

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
- A extra-long 'len' should not be a problem.  If only that part
  of the conflicting lock that would be visible to the 32bit
  app needs to be reported to the 32bit app anyway.

This patch addresses those three issues and adds a comment to
(hopefully) record it for posterity.

Note: this patch mainly affects test-cases.  Real applications rarely
is ever see the problems.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/compat.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff ./fs/compat.c~current~ ./fs/compat.c
--- ./fs/compat.c~current~	2005-11-15 10:31:19.000000000 +1100
+++ ./fs/compat.c	2005-11-15 10:31:19.000000000 +1100
@@ -493,10 +493,22 @@ asmlinkage long compat_sys_fcntl64(unsig
 		set_fs(KERNEL_DS);
 		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 		set_fs(old_fs);
-		if (cmd == F_GETLK && ret == 0) {
-			if ((f.l_start >= COMPAT_OFF_T_MAX) ||
-			    ((f.l_start + f.l_len) > COMPAT_OFF_T_MAX))
+		if (cmd == F_GETLK && ret == 0 && f.l_type == F_UNLCK) {
+			/* there was a conflicting lock, and we need to return
+			 * the data... but it needs to fit in the compat structure.
+			 * l_start shouldn't be too big, unless the original
+			 * start + end is greater than COMPAT_OFF_T_MAX, in which
+			 * case the app was asking for trouble, so we return
+			 * -EOVERFLOW in that case.
+			 * l_len could be too big, in which case we just truncate it,
+			 * and only allow the app to see that part of the conflicting
+			 * lock that might make sense to it anyway
+			 */
+
+			if (f.l_start > COMPAT_OFF_T_MAX)
 				ret = -EOVERFLOW;
+			if (f.l_len > COMPAT_OFF_T_MAX)
+				f.l_len = COMPAT_OFF_T_MAX;
 			if (ret == 0)
 				ret = put_compat_flock(&f, compat_ptr(arg));
 		}
@@ -514,10 +526,12 @@ asmlinkage long compat_sys_fcntl64(unsig
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
