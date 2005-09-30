Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVI3CYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVI3CYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVI3CXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:23:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964797AbVI3CXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:23:05 -0400
Message-Id: <20050930022228.946664000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 05/10] [PATCH]: Missing acct/mm calls in compat_do_execve()
Content-Disposition: inline; filename=missing-acct-mm-calls-in-compat_do_execve.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

As I do periodically, I checked to see how far out of sync
compat_do_execve() has gotten from do_execve().  And as usual there
was some missing stuff in the former.  Perhaps we need some tighter
consolidation of these two routines to make this less likely to happen
in the future.

Anyways, on the success path of compat_do_execve() we forget
to call acct_update_integrals() and update_mem_hiwater(), as
is done in do_execve().

Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 fs/compat.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.13.y/fs/compat.c
===================================================================
--- linux-2.6.13.y.orig/fs/compat.c
+++ linux-2.6.13.y/fs/compat.c
@@ -44,6 +44,8 @@
 #include <linux/nfsd/syscall.h>
 #include <linux/personality.h>
 #include <linux/rwsem.h>
+#include <linux/acct.h>
+#include <linux/mm.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -1567,6 +1569,8 @@ int compat_do_execve(char * filename,
 
 		/* execve success */
 		security_bprm_free(bprm);
+		acct_update_integrals(current);
+		update_mem_hiwater(current);
 		kfree(bprm);
 		return retval;
 	}

--
