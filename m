Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281052AbRKCWKE>; Sat, 3 Nov 2001 17:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281051AbRKCWJo>; Sat, 3 Nov 2001 17:09:44 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:24461 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281050AbRKCWJd>; Sat, 3 Nov 2001 17:09:33 -0500
Message-Id: <5.1.0.14.2.20011103220442.02ca57e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 03 Nov 2001 22:09:30 +0000
To: torvalds@transmeta.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] 2.4.14-pre7 Missing disk req queue unplugs
Cc: linux-kernel@vger.kernel.org, will_dyson@pobox.com
In-Reply-To: <E1602ki-0001Uw-00@draco.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not needed after all. Implementing the sync_page method in 
the address_space operations using fs/buffer.c::block_sync_page() 
completely fixed the hangs I was seing with NTFS TNG.

Best regards,

Anton

At 15:30 03/11/2001, Anton Altaparmakov wrote:
>Linus,
>
>Please apply below patch for your next -pre kernel.
>
>This patch adds two disk request queue unplugs in mm/filemap.c which are
>present in -ac kernels but not in -pre kernels.
>
>Without this patch NTFS TNG will hang when it tries to read anything using
>the page cache. Same for BeFS as reported by Will Dyson. The hangs would
>"unhang" as soon as something else caused disk io to happen (e.g. doing
>md5sum on an ext2 partition on a file that hasn't been accessed before
>so it isn't in the page cache yet).
>
>With this patch NTFS TNG no longer hangs. I haven't tried BeFS but I am
>confident it will be fixed by this patch, too.
>
>Thanks go to Andrew Morton for locating the problem causing the hangs.
>
>Best regards,
>
>         Anton
>--
>Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
>ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>
>--- linux-2.4.14-pre7-unplug.diff ---
>
>diff -u -urN linux-2.4.14-pre7-vanilla/mm/filemap.c 
>linux-2.4.14-pre7-aia1/mm/filemap.c
>--- linux-2.4.14-pre7-vanilla/mm/filemap.c      Sat Nov  3 12:17:55 2001
>+++ linux-2.4.14-pre7-aia1/mm/filemap.c Sat Nov  3 15:18:22 2001
>@@ -769,6 +769,7 @@
>                 if (!PageLocked(page))
>                         break;
>                 sync_page(page);
>+               run_task_queue(&tq_disk);
>                 schedule();
>         } while (PageLocked(page));
>         tsk->state = TASK_RUNNING;
>@@ -800,7 +801,9 @@
>                 set_task_state(tsk, TASK_UNINTERRUPTIBLE);
>                 if (PageLocked(page)) {
>                         sync_page(page);
>+                       run_task_queue(&tq_disk);
>                         schedule();
>+                       continue;
>                 }
>                 if (!TryLockPage(page))
>                         break;

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

