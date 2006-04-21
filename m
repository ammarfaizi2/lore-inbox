Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWDUEqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWDUEqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWDUEon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:898 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932245AbWDUEoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:13 -0400
Date: Thu, 20 Apr 2006 21:39:13 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/22] x86: dont allow tail-calls in sys_ftruncate()
Message-ID: <20060421043913.GN12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="x86-don-t-allow-tail-calls-in-sys_ftruncate.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>

x86: don't allow tail-calls in sys_ftruncate[64]()

Gcc thinks it owns the incoming argument stack, but that's not true for
"asmlinkage" functions, and it corrupts the caller-set-up argument stack
when it pushes the third argument onto the stack.  Which can result in
%ebx getting corrupted in user space.

Now, normally nobody sane would ever notice, since libc will save and
restore %ebx anyway over the system call, but it's still wrong.

I'd much rather have "asmlinkage" tell gcc directly that it doesn't own
the stack, but no such attribute exists, so we're stuck with our hacky
manual "prevent_tail_call()" macro once more (we've had the same issue
before with sys_waitpid() and sys_wait4()).

Thanks to Hans-Werner Hilse <hilse@sub.uni-goettingen.de> for reporting
the issue and testing the fix.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/open.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.16.9.orig/fs/open.c
+++ linux-2.6.16.9/fs/open.c
@@ -330,7 +330,9 @@ out:
 
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length)
 {
-	return do_sys_ftruncate(fd, length, 1);
+	long ret = do_sys_ftruncate(fd, length, 1);
+	prevent_tail_call(ret);
+	return ret;
 }
 
 /* LFS versions of truncate are only needed on 32 bit machines */
@@ -342,7 +344,9 @@ asmlinkage long sys_truncate64(const cha
 
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length)
 {
-	return do_sys_ftruncate(fd, length, 0);
+	long ret = do_sys_ftruncate(fd, length, 0);
+	prevent_tail_call(ret);
+	return ret;
 }
 #endif
 

--
