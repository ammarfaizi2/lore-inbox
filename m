Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992863AbWJUNZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992863AbWJUNZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 09:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992887AbWJUNZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 09:25:10 -0400
Received: from mail.parknet.jp ([210.171.160.80]:23300 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S2992863AbWJUNZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 09:25:07 -0400
X-AuthUser: hirofumi@parknet.jp
To: Damien Wyart <damien.wyart@free.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
References: <20061021104454.GA1996@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 21 Oct 2006 22:24:57 +0900
In-Reply-To: <20061021104454.GA1996@localhost.localdomain> (Damien Wyart's message of "Sat\, 21 Oct 2006 12\:44\:54 +0200")
Message-ID: <87lkn9x0ly.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damien Wyart <damien.wyart@free.fr> writes:

> I have noticed something strange (and bad :) since using 2.6.19-rc2-mm2
> (the problem is NOT present on 2.6.19-rc2-mm1 ; do not know for
> mainline, I have not been able to test yet, but I think there have not
> been recent changes in this area) : writing a file to a vfat
> fs (fat 32) writes it, but with size 0 and no content. All this is
> silent : no error message, nothing in the logs. After several attempts,
> I checked the fs with fsck.vfat and it reported errors about some of the
> files and told it was truncating them to size 0 (but their displayed
> size was already 0, btw).

diff -puN fs/fat/inode.c~fs-prepare_write-fixes fs/fat/inode.c
--- a/fs/fat/inode.c~fs-prepare_write-fixes
+++ a/fs/fat/inode.c
@@ -150,7 +150,11 @@ static int fat_commit_write(struct file 
 			    unsigned from, unsigned to)
 {
 	struct inode *inode = page->mapping->host;
-	int err = generic_commit_write(file, page, from, to);
+	int err;
+	if (to - from > 0)
+		return 0;
+
+	err = generic_commit_write(file, page, from, to);
 	if (!err && !(MSDOS_I(inode)->i_attrs & ATTR_ARCH)) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;

This change does't update ->i_size. Could you just delete, and test it?
Anyway, this seems wrong even if it's "if ((to - from) == 0)".  The zero
range is valid for cont_prepare_write()...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
