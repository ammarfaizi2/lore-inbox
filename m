Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbVKRJ5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbVKRJ5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 04:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030600AbVKRJ5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 04:57:00 -0500
Received: from mx1.suse.de ([195.135.220.2]:49570 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030565AbVKRJ47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 04:56:59 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 18 Nov 2005 20:56:45 +1100
Message-Id: <1051118095645.17025@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: matthew@wil.cx, linux-kernel@vger.kernel.org
Subject: [PATCH - 2.6.15-rc1-mm1 ] Re-fix compat_sys_fcntl64
References: <20051118204902.15825.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Finally got some testing done on this, and it wasn't quite right.  We
need to return information from F_GETLK no-matter what l_type is - at
the very least we return a value in l_type, but might return start/length as well. 

This patch has been tested (LSB test suite), and works.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/compat.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff ./fs/compat.c~current~ ./fs/compat.c
--- ./fs/compat.c~current~	2005-11-18 11:49:08.000000000 +1100
+++ ./fs/compat.c	2005-11-18 11:49:57.000000000 +1100
@@ -493,9 +493,9 @@ asmlinkage long compat_sys_fcntl64(unsig
 		set_fs(KERNEL_DS);
 		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 		set_fs(old_fs);
-		if (cmd == F_GETLK && ret == 0 && f.l_type == F_UNLCK) {
-			/* there was a conflicting lock, and we need to return
-			 * the data... but it needs to fit in the compat structure.
+		if (cmd == F_GETLK && ret == 0) {
+			/* GETLK was successfule and we need to return the data...
+			 * but it needs to fit in the compat structure.
 			 * l_start shouldn't be too big, unless the original
 			 * start + end is greater than COMPAT_OFF_T_MAX, in which
 			 * case the app was asking for trouble, so we return
@@ -526,7 +526,7 @@ asmlinkage long compat_sys_fcntl64(unsig
 				((cmd == F_SETLK64) ? F_SETLK : F_SETLKW),
 				(unsigned long)&f);
 		set_fs(old_fs);
-		if (cmd == F_GETLK64 && ret == 0 && f.l_type == F_UNLCK) {
+		if (cmd == F_GETLK64 && ret == 0) {
 			/* need to return lock information - see above for commentary */
 			if (f.l_start > COMPAT_LOFF_T_MAX)
 				ret = -EOVERFLOW;
