Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTJYLFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 07:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJYLFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 07:05:23 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:34576 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262573AbTJYLFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 07:05:17 -0400
Date: Sat, 25 Oct 2003 13:05:14 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Vid Strpic <vms@bofhlet.net>, linux-kernel@vger.kernel.org
Subject: Re: *FAT problem in 2.6.0-test8
Message-ID: <20031025110514.GA9553@win.tue.nl>
References: <20031024103225.GC1046@home.bofhlet.net> <20031024185953.GA9265@win.tue.nl> <87ismdoc2s.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ismdoc2s.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 07:18:03PM +0900, OGAWA Hirofumi wrote:

> It looks like it doesn't conform to Microsoft's or SmartMedia's
> specifications.
> 
> Yes. It will be important to know how it was formated. 

Yesterday I wondered whether I should propose a patch,
say something like

--- /linux/2.6/linux-2.6.0test6/linux/fs/fat/inode.c    Sat Aug  9 22:16:54 2003
+++ ./inode.c   Sat Oct 25 00:04:18 2003
@@ -931,13 +931,17 @@
                error = first;
                goto out_fail;
        }
-       if (FAT_FIRST_ENT(sb, media) != first
-           && (media != 0xf8 || FAT_FIRST_ENT(sb, 0xfe) != first)) {
-               if (!silent) {
+       if (FAT_FIRST_ENT(sb, media) == first) {
+               /* all is as it should be */
+       } else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xfe) == first) {
+               /* bad, reported on pc9800 */
+       } else if (first == 0) {
+               /* bad, reported once with a SmartMedia card */
+       } else {
+               if (!silent)
                        printk(KERN_ERR "FAT: invalid first entry of FAT "
                               "(0x%x != 0x%x)\n",
                               FAT_FIRST_ENT(sb, media), first);
-               }
                goto out_invalid;
        }
 
but maybe a single report does not suffice. It would be good to confirm
that certain devices write 0 there. (I would have asked the reporter
to do "dd if=/dev/zero of=/dev/something" and reinsert the card into
the camera, but fiddling with smartmedia cards is a bit dangerous -
not all readers and not all cameras are able to recover from such a
situation, so the card might become unusable without access to other
readers or other cameras.)

Andries

[BTW - Does anyone have more information about this other nonstandard
value, apparently found on pc9800?]

