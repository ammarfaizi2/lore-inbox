Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbRFGUeC>; Thu, 7 Jun 2001 16:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263095AbRFGUdw>; Thu, 7 Jun 2001 16:33:52 -0400
Received: from [32.97.182.101] ([32.97.182.101]:56983 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263092AbRFGUdl>;
	Thu, 7 Jun 2001 16:33:41 -0400
Importance: Normal
Subject: Re: Please test: workaround to help swapoff behaviour
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Derek Glidden <dglidden@illusionary.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF4314E00C.5B8A0E4C-ON85256A64.006F54E0@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Thu, 7 Jun 2001 16:33:38 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.07a |May 14, 2001) at 06/07/2001
 04:32:39 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





>This is for the people who has been experiencing the lockups while running
>swapoff.
>
>Please test. (against 2.4.6-pre1)
>
>
>--- linux.orig/mm/swapfile.c Wed Jun  6 18:16:45 2001
>+++ linux/mm/swapfile.c Thu Jun  7 16:06:11 2001
>@@ -345,6 +345,8 @@
>         /*
>          * Find a swap page in use and read it in.
>          */
>+        if (current->need_resched)
>+             schedule();
>         swap_device_lock(si);
>         for (i = 1; i < si->max ; i++) {
>              if (si->swap_map[i] > 0 && si->swap_map[i] != SWAP_MAP_BAD)
{


I tested your patch against 2.4.5.  It works.  No more lockups.  Without
the
patch it took 14 minutes 51 seconds to complete swapoff (this is to recover
1.5GB of
swap space).  During this time the system was frozen.  No keyboard, no
screen, etc. Practically locked-up.

With the patch there are no more lockups. Swapoff kept running in the
background.
This is a winner.

But here is the caveat: swapoff keeps burning 100% of the cycles until it
completes.
This is not going to be a big deal during shutdowns.  Only when you enter
swapoff from
the command line it is going to be a problem.

I looked at try_to_unuse in swapfile.c.  I believe that the algorithm is
broken.
For each and every swap entry it is walking the entire process list
(for_each_task(p)).  It is also grabbing a whole bunch of locks
for each swap entry.  It might be worthwhile processing swap entries in
batches instead of one entry at a time.

In any case, I think having this patch is worthwhile as a quick and dirty
remedy.

Bulent Abali



