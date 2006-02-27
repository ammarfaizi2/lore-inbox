Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWB0Wd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWB0Wd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWB0Wcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:32:42 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57985 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932474AbWB0Wci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:32:38 -0500
Message-Id: <20060227223407.671256000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:38 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Mike OConnor" <mjo@dojo.mi.org>, trond.myklebust@netapp.com,
       Greg Banks <gnb@melbourne.sgi.com>
Subject: [patch 38/39] Normal user can panic NFS client with direct I/O (CVE-2006-0555)
Content-Disposition: inline; filename=normal-user-can-panic-nfs-client-with-direct-i-o.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This is CVE-2006-0555 and SGI bug 946529.  A normal user can panic an
NFS client and cause a local DoS with 'judicious'(?) use of O_DIRECT.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/nfs/direct.c |    5 +++++
 1 files changed, 5 insertions(+)

--- linux-2.6.15.4.orig/fs/nfs/direct.c
+++ linux-2.6.15.4/fs/nfs/direct.c
@@ -106,6 +106,11 @@ nfs_get_user_pages(int rw, unsigned long
 		result = get_user_pages(current, current->mm, user_addr,
 					page_count, (rw == READ), 0,
 					*pages, NULL);
+		if (result >= 0 && result < page_count) {
+			nfs_free_user_pages(*pages, result, 0);
+			*pages = NULL;
+			result = -EFAULT;
+		}
 		up_read(&current->mm->mmap_sem);
 	}
 	return result;

--
