Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbTIONqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTIONql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:46:41 -0400
Received: from m029-045.nv.iinet.net.au ([203.217.29.45]:46209 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S261348AbTIONqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:46:37 -0400
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: IDE-CD issue: total capacity set to 0 incorrectly on some DVD-R
 discs. 
From: Daniel Pittman <daniel@rimspace.net>
Date: Mon, 15 Sep 2003 23:46:33 +1000
Message-ID: <873cey6u6e.fsf@enki.rimspace.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (cassava, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, I mentioned a little while ago on the linux-kernel list that I had
an issue with my DVD drive (Pioneer DVD-ROM ATAPIModel DVD-106S 012)
incorrectly determining a zero blocks size for some DVD-R discs.

After a lot of working to track down what the failure was, I found that
the following code in ide-cd.c, and cdrom.c, was the source of the
issue.

When checking the TOC of a disc the first time through, the following
code at line 2376 in ide-cd.c is executed:

	stat = cdrom_get_last_written(cdi, (long *) &toc->capacity);
	if (stat)
		stat = cdrom_read_capacity(drive, &toc->capacity, sense);
	if (stat)
		toc->capacity = 0x1fffff;

	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);

On the problematic disc/drive combination, cdrom_get_last_written
returns 0, and sets toc->capacity to 0.

At the time, the cdrom_get_last_written code went through, checked the
'ti.lra_v' field, which the comment suggests is "last recorded sector",
then did the "make it up" path.

The values of ti.track_start, ti.track_size and ti.free_blocks were all
zero as well, suggesting that the structure returned by
cdrom_get_track_info was not very well populated at all.

Obviously, though, from testing the function cdrom_read_capacity does
get the correct size for the track, but something (the recording
software, perhaps) is not setting up the "last written" stuff correctly.

For me, the following trivial patch to ide-cd.c corrects the issue, and
all my software works just fine afterwards.

I am happy to continue to work on the issue if you don't think that this
is the right fix, but I would need some guidance in how to continue --
or just a patch to test. ;)

Regards,
   Daniel Pittman

Index: ide-cd.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/ide/ide-cd.c,v
retrieving revision 1.122
diff -u -u -r1.122 ide-cd.c
--- ide-cd.c	4 Sep 2003 17:11:54 -0000	1.122
+++ ide-cd.c	15 Sep 2003 04:20:34 -0000
@@ -2365,7 +2365,7 @@
 
 	/* Now try to get the total cdrom capacity. */
 	stat = cdrom_get_last_written(cdi, (long *) &toc->capacity);
-	if (stat)
+	if (stat || toc->capacity == 0)
 		stat = cdrom_read_capacity(drive, &toc->capacity, sense);
 	if (stat)
 		toc->capacity = 0x1fffff;


-- 
These eyes see only what they wanna see 
These ears hear only what they wanna hear 
These minds think only what they wanna think 
These lies, these lies
        -- Pop Will Eat Itself, _Everything's Cool_ (Dos Dedos Mis Amigos)
