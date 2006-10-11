Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWJKV1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWJKV1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161401AbWJKVFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:05:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:51102 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161398AbWJKVFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:05:22 -0400
Date: Wed, 11 Oct 2006 14:04:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, gregkh@suse.de,
       bunk@stusta.de
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/67] S390: user readable uninitialised kernel memory (CVE-2006-5174)
Message-ID: <20061011210431.GM16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="s390-user-readable-uninitialised-kernel-memory.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] user readable uninitialised kernel memory.

A user space program can read uninitialised kernel memory
by appending to a file from a bad address and then reading
the result back. The cause is the copy_from_user function
that does not clear the remaining bytes of the kernel
buffer after it got a fault on the user space address.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/s390/lib/uaccess.S   |   12 +++++++++++-
 arch/s390/lib/uaccess64.S |   12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/arch/s390/lib/uaccess.S
+++ linux-2.6.18/arch/s390/lib/uaccess.S
@@ -40,7 +40,17 @@ __copy_from_user_asm:
 	# move with the reduced length which is < 256
 5:	mvcp	0(%r5,%r2),0(%r4),%r0
 	slr	%r3,%r5
-6:	lr	%r2,%r3
+	alr	%r2,%r5
+6:	lgr	%r5,%r3		# copy remaining size
+	ahi	%r5,-1		# subtract 1 for xc loop
+	bras	%r4,8f
+	xc	0(1,%2),0(%2)
+7:	xc	0(256,%2),0(%2)
+	la	%r2,256(%r2)
+8:	ahji	%r5,-256
+	jnm	7b
+	ex	%r5,0(%r2)
+9:	lr	%r2,%r3
 	br	%r14
         .section __ex_table,"a"
 	.long	0b,4b
--- linux-2.6.18.orig/arch/s390/lib/uaccess64.S
+++ linux-2.6.18/arch/s390/lib/uaccess64.S
@@ -40,7 +40,17 @@ __copy_from_user_asm:
 	# move with the reduced length which is < 256
 5:	mvcp	0(%r5,%r2),0(%r4),%r0
 	slgr	%r3,%r5
-6:	lgr	%r2,%r3
+	algr	%r2,%r5
+6:	lgr	%r5,%r3		# copy remaining size
+	aghi	%r5,-1		# subtract 1 for xc loop
+	bras	%r4,8f
+	xc	0(1,%r2),0(%r2)
+7:	xc	0(256,%r2),0(%r2)
+	la	%r2,256(%r2)
+8:	aghi	%r5,-256
+	jnm	7b
+	ex	%r5,0(%r2)
+9:	lgr	%r2,%r3
 	br	%r14
         .section __ex_table,"a"
 	.quad	0b,4b

--
