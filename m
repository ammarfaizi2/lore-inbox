Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUIWRMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUIWRMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUIWRKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:10:36 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:32139 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S266463AbUIWRJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:09:36 -0400
Message-ID: <41530349.2050003@dssimail.com>
Date: Thu, 23 Sep 2004 12:09:29 -0500
From: "Mr. Berkley Shands" <berkley@dssimail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sendfile64() on x86_64 breaks at 2gb (MAX_NON_LFS limit)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for the opteron, the value of MAX_NON_LFS (include/linux/fs.h) is fixed 
at (1UL<<31 -1).
Since ALL 64 bit boxes force O_LARGEFILE on, shouldn't this value be 
(1UL<<63 -1) so that
sendfile64() will proceed beyond the 2gb limit?
under 2.6.6, sendfile64() has no __NR_sendfile64 entry in asm*/unistd.h 
(same for 2.6.9-rc2)
so the syscall sendfile64() maps to sendfile(), which has MAX_NON_LFS 
hard coded in fs/read_write.c
as its limit, rather than 0ULL as in sendfile64().

So the fix is to make the correct entry for sendfile64 in unistd.h (note 
that this hoses /usr/include/.../syscalls.h :-)
and update fs.h as folows:


--- fs.h.old    2004-09-23 11:44:33.469481466 -0500
+++ fs.h        2004-09-23 11:29:56.823712018 -0500
@@ -589,7 +589,11 @@
 /* Release a private file and free its security structure. */
 extern void close_private_file(struct file *file);
 
+#if BITS_PER_LONG==32
 #define        MAX_NON_LFS     ((1UL<<31) - 1)
+#else
+#define        MAX_NON_LFS     ((1UL<<63) - 1)
+#endif
 
 /* Page cache limit. The filesystems should put that into their s_maxbytes
    limits, otherwise bad things can happen in VM. */


Please consider making these updates in the next rev of the kernel sources.

Berkley Shands

