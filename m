Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313945AbSDKBXz>; Wed, 10 Apr 2002 21:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313946AbSDKBXy>; Wed, 10 Apr 2002 21:23:54 -0400
Received: from air-2.osdl.org ([65.201.151.6]:57352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313945AbSDKBXx>;
	Wed, 10 Apr 2002 21:23:53 -0400
Date: Wed, 10 Apr 2002 18:20:55 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [patch-2.5.8-pre] swapinfo accounting
Message-ID: <Pine.LNX.4.33L2.0204101755170.25409-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In and around 2.5.7 & 2.5.8-pre2, with a highly stressful
VM workload (akpm's bash-shared-mapping and usemem),
causing lots of swap activity, I see some odd swap info
in /proc/meminfo.

Machine is 8-proc with 16 GB of RAM and 16 GB of swap (1 partition
and 7 files, each 2 GB).

Examples of /proc/meminfo (excerpts):

Before swapping:
MemTotal/Free: 16312504 kB/651340 kB
SwapTotal/Free: 16777088 kB/16777088 kB

After swapping:
MemTotal/Free: 16312504 kB/5092 kB
SwapTotal/Free: 16913332 kB/16777088 kB

Notice how SwapTotal grows and SwapFree never changes.
This isn't correct, is it?

It looks to me like mm/swapfile.c::si_swapinfo()
shouldn't be adding nr_to_be_unused to total_swap_pages
or nr_swap_pages for return in val->freeswap and
val->totalswap.

I.e., total_swap_pages is correct for SwapTotal and
nr_swap_pages is correct for SwapFree...except for
bad blocks accounting (?).
(nr_to_be_unused === nr_swap_pages_in_use)
(nr_swap_pages === nr_free_swap_pages)

And the for-j loop to count nr_to_be_unused is overhead...
Maybe, except for bad blocks accounting.

Here are some samples from the end of si_swapinfo():
swapinfo: nr_swap_pages: 3405953, total_swap_pages: 4194272,
nr_to_be_unused: 788319
swapinfo: nr_swap_pages: 3405537, total_swap_pages: 4194272,
nr_to_be_unused: 788735
swapinfo: nr_swap_pages: 3402977, total_swap_pages: 4194272,
nr_to_be_unused: 791295

Anyway, here is the patch that makes it better.
Not perfect, due to possibility of bad blocks, but better
than it was.   Comments?


--- linux-258-pre2/mm/swapfile.c.SI	Wed Apr 10 17:50:34 2002
+++ linux-258-pre2/mm/swapfile.c	Wed Apr 10 18:09:46 2002
@@ -1107,8 +1107,8 @@
 			}
 		}
 	}
-	val->freeswap = nr_swap_pages + nr_to_be_unused;
-	val->totalswap = total_swap_pages + nr_to_be_unused;
+	val->freeswap = nr_swap_pages;
+	val->totalswap = total_swap_pages;
 	swap_list_unlock();
 }


-- 
~Randy

