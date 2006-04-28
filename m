Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWD1AYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWD1AYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWD1AYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:24:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63701 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965037AbWD1AX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:23:27 -0400
Date: Thu, 27 Apr 2006 17:21:54 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       James Morris <jmorris@namei.org>, Al Viro <viro@zeniv.linux.org.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>, Chris Wright <chrisw@sous-sol.org>
Subject: [patch 18/24] LSM: add missing hook to do_compat_readv_writev()
Message-ID: <20060428002154.GS18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="lsm-add-missing-hook-to-do_compat_readv_writev.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: James Morris <jmorris@namei.org>

This patch addresses a flaw in LSM, where there is no mediation of readv()
and writev() in for 32-bit compatible apps using a 64-bit kernel.

This bug was discovered and fixed initially in the native readv/writev
code [1], but was not fixed in the compat code.  Thanks to Al for spotting
this one.

  [1] http://lwn.net/Articles/154282/

Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 fs/compat.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.16.11.orig/fs/compat.c
+++ linux-2.6.16.11/fs/compat.c
@@ -1215,6 +1215,10 @@ static ssize_t compat_do_readv_writev(in
 	if (ret < 0)
 		goto out;
 
+	ret = security_file_permission(file, type == READ ? MAY_READ:MAY_WRITE);
+	if (ret)
+		goto out;
+
 	fnv = NULL;
 	if (type == READ) {
 		fn = file->f_op->read;

--
