Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbUA0USE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUA0USE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:18:04 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:54799 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265629AbUA0URz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:17:55 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Frodo Looijaard <frodol@dds.nl>, linux-kernel@vger.kernel.org
Subject: Re: PATCH to access old-style FAT fs
References: <20040126173949.GA788@frodo.local>
	<bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp>
	<4016B316.4060304@zytor.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 28 Jan 2004 05:17:45 +0900
In-Reply-To: <4016B316.4060304@zytor.com>
Message-ID: <87ad4987ti.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> OGAWA Hirofumi wrote:
> > 
> > The new cluster for directory entries must be initialized by 0x00.
> > And, when the directory entry is deleted, the name[0] is updated by
> > 0xe5 not 0x00.
> > 
> > So, if the name[0] is 0x00, it after, all bytes in cluster is 0x00.
> > 
> > The fat driver can stop at name[0] == 0x00, but this is just optimization.
> > The behavior shouldn't change by this.
> 
> I looked at the spec, and yes, that is how the spec reads:
> 
> If DIR_Name[0] == 0x00, then the directory entry is free (same as for
> 0xE5), and there are no allocated directory entries after this one (all
> of the DIR_Name[0] bytes in all of the entries after this one are also
> set to 0). The special 0 value, rather than the 0xE5 value, indicates to
> FAT file system driver code that the rest of the entries in this
> directory do not need to be examined because they are all free.
> 
> I guess the original poster has found filesystems which have a 0
> followed by garbage.  In cases like that, the cardinal rule for FAT is
> WWDD (What Would DOS Do)... since I'm pretty sure DOS stops examining at
> that point, we should do the same.
> 
> It's the same thing as with using 0xF8 for ending clusters; it's correct
> according to spec, but WWDD says 0xFF is the right thing.

The new cluster for directory entries must be initialized by 0x00.
This is required by spec.

If cluster has garbage, the fat driver needs to do such the following
part. Stop at DIR_Name[0] == 0 is not enough, and I don't think DOS
does this.

@@ -709,7 +731,20 @@
 		}
 
-		if (IS_FREE((*de)->name)) {
-			if (++row == slots)
+		if ((oldfat && ((*de)->name[0] == EOD_FLAG)))
+			last_entry = 1;
+		if (last_entry || IS_FREE((*de)->name)) {
+			if (++row == slots) {
+				if (last_entry) {
+					/* If we encounter a last_entry, we
+					 * need to mark the entry after the
+					 * one to be inserted as last_entry
+					 * now! */
+					if (fat_get_entry(dir,&curr,bh,de,i_pos) > -1) {
+						(*de)->name[0] = 0;
+						mark_inode_dirty(dir);
+					}
+				}
 				return offset;
+			}
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
