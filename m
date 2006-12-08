Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947538AbWLHX76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947538AbWLHX76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 18:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947523AbWLHX7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:59:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37435 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947522AbWLHX6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:58:55 -0500
Message-Id: <20061209000058.122313000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [patch 17/32] do_coredump() and not stopping rewrite attacks? (CVE-2006-6304)
Content-Disposition: inline; filename=do_coredump-and-not-stopping-rewrite-attacks.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Alexey Dobriyan <adobriyan@gmail.com>

On Sat, Dec 02, 2006 at 11:47:44PM +0300, Alexey Dobriyan wrote:
> David Binderman compiled 2.6.19 with icc and grepped for "was set but never
> used". Many warnings are on
> 	http://coderock.org/kj/unused-2.6.19-fs

Heh, the very first line:
fs/exec.c(1465): remark #593: variable "flag" was set but never used

fs/exec.c:
  1477		/*
  1478		 *	We cannot trust fsuid as being the "true" uid of the
  1479		 *	process nor do we know its entire history. We only know it
  1480		 *	was tainted so we dump it as root in mode 2.
  1481		 */
  1482		if (mm->dumpable == 2) {	/* Setuid core dump mode */
  1483			flag = O_EXCL;		/* Stop rewrite attacks */
  1484			current->fsuid = 0;	/* Dump root private */
  1485		}

And then filp_open follows with "flag" totally ignored.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 fs/exec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.19.orig/fs/exec.c
+++ linux-2.6.19/fs/exec.c
@@ -1515,7 +1515,8 @@ int do_coredump(long signr, int exit_cod
 		ispipe = 1;
  	} else
  		file = filp_open(corename,
-				 O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+				 O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE | flag,
+				 0600);
 	if (IS_ERR(file))
 		goto fail_unlock;
 	inode = file->f_dentry->d_inode;

--
