Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291754AbSBANmv>; Fri, 1 Feb 2002 08:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291755AbSBANmm>; Fri, 1 Feb 2002 08:42:42 -0500
Received: from [195.66.192.167] ([195.66.192.167]:64775 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291756AbSBANmb>; Fri, 1 Feb 2002 08:42:31 -0500
Message-Id: <200202011339.g11DdKt30515@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: Errors in the VM - detailed
Date: Fri, 1 Feb 2002 15:39:21 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 January 2002 13:05, Roy Sigurd Karlsbakk wrote:
> The last month or so, I've been trying to make a particular configuration
> work with Linux-2.4.17 and other 2.4.x kernels. Two major bugs have been
> blocking my way into the light. Below follows a detailed description on
> both bugs. One of them seems to be solved in the latests -rmap patches. The
> other is still unsolved.

I've seen your posts. Can't help you directly, but:

> The two 120GB drives is configured in RAID-0 with chunk size [256|512|1024]

Do bugs bite you with plain partitions (no RAID). Maybe it's a RAID bug?

> When (RAMx2) bytes has been read from disk, I/O as reported from vmstat
> drops to a mere 1MB/s
> When reading starts, the speed is initially high. Then, slowly, the speed
> decreases until it goes to something close to a complete halt (see output
> from vmstat below).

Can you run oom_trigger at this point and watch what will happen?
It will force most (if not all) of the page cache to be flushed, speed might
increase. This is not a solution, just a way to get additional info on bug
behavior. I've got a little patch which improves (read: fixes) cache flush
behavior. Attached below. BTW, did you try -aa kernels?

> Bug #2:
>
> Doing the same test on Rik's -rmap(.*) somehow fixes Bug #1, and makes room
> for another bug to come out.
>
> Doing the same test, I can, with -rmap, get some 33-35MB/s sustained from
> /dev/md0 to memory. This is all good, but when doing this test, only 40 of
> the original processes ever finish. The same error occurs both locally (dd)
> and remotely (tux). If new i/o requests is issued to the same device, they
> don't hang. If tux is restarted, it works fine afterwards.

After they hang, make Alt-SysRq-T trace, ksymoops it and send to Rik and LKML.
CC'ing Andrea won't hurt I think.
--
vda

oom_trigger.c
=============
#include <stdlib.h>
int main() {
    void *p;
    unsigned size = 1<<20;
    unsigned long total=0;
    while(size) {
	p = malloc(size);
	if(!p) size>>=1;
	else {
	    memset(p, 0x77, size);
	    total+=size;
	    printf("Allocated %9u bytes, %12lu total\n",size,total);
	}
    }
    return 0;
}


vmscan.patch.2.4.17.d (author: "M.H.VanLeeuwen" <vanl@megsinet.net>)
====================================================================
--- linux.virgin/mm/vmscan.c	Mon Dec 31 12:46:25 2001
+++ linux/mm/vmscan.c	Fri Jan 11 18:03:05 2002
@@ -394,9 +394,9 @@
 		if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping) {
 			/*
 			 * It is not critical here to write it only if
-			 * the page is unmapped beause any direct writer
+			 * the page is unmapped because any direct writer
 			 * like O_DIRECT would set the PG_dirty bitflag
-			 * on the phisical page after having successfully
+			 * on the physical page after having successfully
 			 * pinned it and after the I/O to the page is finished,
 			 * so the direct writes to the page cannot get lost.
 			 */
@@ -480,11 +480,14 @@
 
 			/*
 			 * Alert! We've found too many mapped pages on the
-			 * inactive list, so we start swapping out now!
+			 * inactive list.
+			 * Move referenced pages to the active list.
 			 */
-			spin_unlock(&pagemap_lru_lock);
-			swap_out(priority, gfp_mask, classzone);
-			return nr_pages;
+			if (PageReferenced(page) && !PageLocked(page)) {
+				del_page_from_inactive_list(page);
+				add_page_to_active_list(page);
+			}
+			continue;
 		}
 
 		/*
@@ -521,6 +524,9 @@
 	}
 	spin_unlock(&pagemap_lru_lock);
 
+	if (max_mapped <= 0 && (nr_pages > 0 || priority < DEF_PRIORITY))
+		swap_out(priority, gfp_mask, classzone);
+
 	return nr_pages;
 }
 

