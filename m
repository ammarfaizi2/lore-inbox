Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266160AbUA1VB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266162AbUA1VB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:01:27 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:36100 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266160AbUA1VBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:01:24 -0500
To: Frodo Looijaard <frodol@dds.nl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH to access old-style FAT fs
References: <20040126173949.GA788@frodo.local>
	<bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp>
	<4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp>
	<20040128115655.GA696@arda.frodo.local>
	<87y8rr7s5b.fsf@devron.myhome.or.jp>
	<20040128202443.GA9246@frodo.local>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 29 Jan 2004 06:01:18 +0900
In-Reply-To: <20040128202443.GA9246@frodo.local>
Message-ID: <87bron7ppd.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frodo Looijaard <frodol@dds.nl> writes:

> On Thu, Jan 29, 2004 at 05:08:32AM +0900, OGAWA Hirofumi wrote:
> > 
> > "stop when DIR_Name[0] == 0" should be added after cleanup. The option
> > is not needed.
> 
> OK. That would be nice. Like I said, I just hope it does not break other
> FAT implementations, but that is not very likely. At least, that would
> allow read-only mounted EPOC FAT partitions to be handled correctly.

This is spec as hpa saied. So this is right things, and other fat
driver also does, AFAIK.

> > Honestly, I wouldn't like to add the "add a new DIR_Name[0] = 0" part.
> > The option is added easy, but it is not removed easy. And we must
> > maintain it. 
> 
> I understand. I could always maintain that patch separately for those
> who need it (for read-write mounted EPOC FAT partitions).

Thanks.

> > (BTW, looks like that patch is buggy)
> 
> Could well be. Any suggestions what to look out for?

@@ -200,4 +202,8 @@
 parse_record:
 		long_slots = 0;
+		if (oldfat && (de->name[0] == EOD_FLAG)) 
+			last_entry = 1;
+		if (last_entry)
+			continue;
                        ^^^^^^^^
 		if (de->name[0] == DELETED_FLAG)
 			continue;

The above should "goto EODir;". Likewise, another "contiure" of
fat_search_long().


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

mark_inode_dirty(dir) is not needed, instead of it we should do
mark_buffer_dirty(bh).

And this fat_get_entry() updates bh and de, but it should be point to
allocated bh and de, not free entry. It's needed by msdos_add_entry().

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
