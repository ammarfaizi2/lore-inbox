Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131226AbRC0MPq>; Tue, 27 Mar 2001 07:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbRC0MPg>; Tue, 27 Mar 2001 07:15:36 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:65497 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131226AbRC0MP3> convert rfc822-to-8bit; Tue, 27 Mar 2001 07:15:29 -0500
Message-Id: <l03130332b6e632432b9f@[192.168.239.101]>
In-Reply-To: <200103271059.MAA18765@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 27 Mar 2001 13:14:24 +0100
To: R.E.Wolff@BitWizard.nl (Rogier Wolff), linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: OOM killer???
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Out of Memory: Killed process 117 (sendmail).
>
>What we did to run it out of memory, I don't know. But I do know that
>it shouldn't be killing one process more than once... (the process
>should not exist after one try...)

This is a known bug in the Out-of-Memory handler, where it does not count the buffer and cache memory as "free" (it should), causing premature OOM killing.  It is, however, normal for the OOM killer to attempt to kill a process more than once - it takes a few scheduler cycles for the SIGKILL to actually reach the process and take effect.

Also, it probably shouldn't have killed Sendmail, since that is usually a long-running, low-UID (and important) process.  The OOM-kill selector is another thing that wants fixing, and my patch contains a *very rough* beginning to this.

The following patch should solve your problem for now, until a more detailed fix (which also clears up many other problems) is available in the stable kernel.

Alan and/or Linus may wish to apply this patch too...

(excerpt from my original patch from Saturday follows)

--- start ---
diff -u linux-2.4.1.orig/mm/oom_kill.c linux/mm/oom_kill.c
--- linux-2.4.1.orig/mm/oom_kill.c      Tue Nov 14 18:56:46 2000
+++ linux/mm/oom_kill.c Sat Mar 24 20:35:20 2001
@@ -76,7 +76,9 @@
        run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);

        points /= int_sqrt(cpu_time);
-       points /= int_sqrt(int_sqrt(run_time));
+
+       /* Long-running processes are *very* important, so don't take the 4th root */
+       points /= run_time;

        /*
         * Niced processes are most likely less important, so double
@@ -93,6 +95,10 @@
                                p->uid == 0 || p->euid == 0)
                points /= 4;

+       /* Much the same goes for processes with low UIDs */
+       if(p->uid < 100 || p->euid < 100)
+         points /= 2;
+
        /*
         * We don't want to kill a process with direct hardware access.
         * Not only could that mess up the hardware, but usually users
@@ -192,12 +198,20 @@
 int out_of_memory(void)
 {
        struct sysinfo swp_info;
+       long free;

        /* Enough free memory?  Not OOM. */
-       if (nr_free_pages() > freepages.min)
+       free = nr_free_pages();
+       if (free > freepages.min)
+               return 0;
+
+       if (free + nr_inactive_clean_pages() > freepages.low)
                return 0;

-       if (nr_free_pages() + nr_inactive_clean_pages() > freepages.low)
+       /* Buffers and caches can be freed up (Jonathan "Chromatix" Morton) */
+       free += atomic_read(&buffermem_pages);
+       free += atomic_read(&page_cache_size);
+       if (free > freepages.low)
                return 0;

        /* Enough swap space left?  Not OOM. */
--- end ---

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


