Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVJaGeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVJaGeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJaGeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:34:50 -0500
Received: from ns1.suse.de ([195.135.220.2]:13487 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932490AbVJaGeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:34:50 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Oct 2005 17:34:44 +1100
Message-Id: <1051031063444.9586@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH against 2.6.14] truncate() or ftruncate shouldn't change mtime if size doesn't change.
References: <20051031173358.9566.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



According to Posix and SUS, truncate(2) and ftruncate(2) only update
ctime and mtime if the size actually changes.  Linux doesn't currently
obey this.

There is no need to test the size under i_sem, as loosing any race
will not make a noticable different the mtime or ctime.

(According to SUS, truncate and ftruncate 'may' clear setuid/setgid
 as well, currently we don't.  Should we?
)


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/open.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff ./fs/open.c~current~ ./fs/open.c
--- ./fs/open.c~current~	2005-10-31 16:22:44.000000000 +1100
+++ ./fs/open.c	2005-10-31 16:22:44.000000000 +1100
@@ -260,7 +260,8 @@ static inline long do_sys_truncate(const
 		goto dput_and_out;
 
 	error = locks_verify_truncate(inode, NULL, length);
-	if (!error) {
+	if (!error &&
+	    length != i_size_read(dentry->d_inode)) {
 		DQUOT_INIT(inode);
 		error = do_truncate(nd.dentry, length);
 	}
@@ -313,7 +314,8 @@ static inline long do_sys_ftruncate(unsi
 		goto out_putf;
 
 	error = locks_verify_truncate(inode, file, length);
-	if (!error)
+	if (!error &&
+	    length != i_size_read(dentry->d_inode))
 		error = do_truncate(dentry, length);
 out_putf:
 	fput(file);
