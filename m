Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWAFApx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWAFApx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWAFApx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:45:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46211 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932340AbWAFApv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:45:51 -0500
Date: Thu, 5 Jan 2006 16:46:02 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, johnpol@2ka.mipt.ru,
       mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/6] UFS: inode->i_sem is not released in error path
Message-ID: <20060106004602.GE25207@sorel.sous-sol.org>
References: <20060105235845.967478000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ufs-inode-i_sem-is-not-released-in-error-path.patch"
In-Reply-To: <20060105235947.100933000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

---

 fs/ufs/super.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.14.5/fs/ufs/super.c
===================================================================
--- linux-2.6.14.5.orig/fs/ufs/super.c
+++ linux-2.6.14.5/fs/ufs/super.c
@@ -1294,8 +1294,10 @@ static ssize_t ufs_quota_write(struct su
 		blk++;
 	}
 out:
-	if (len == towrite)
+	if (len == towrite) {
+		up(&inode->i_sem);
 		return err;
+	}
 	if (inode->i_size < off+len-towrite)
 		i_size_write(inode, off+len-towrite);
 	inode->i_version++;

--
