Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317915AbSGKVvZ>; Thu, 11 Jul 2002 17:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317917AbSGKVvY>; Thu, 11 Jul 2002 17:51:24 -0400
Received: from pD952A525.dip.t-dialin.net ([217.82.165.37]:32899 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317915AbSGKVvX>; Thu, 11 Jul 2002 17:51:23 -0400
Date: Thu, 11 Jul 2002 15:54:01 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <200207112135.OAA03801@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.44.0207111547360.26269-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Dawson Engler wrote:
> ############################################################
> # 2.5.8 specific errors
> 
> #
> ---------------------------------------------------------
> [BUG]  it seems like one.
> /u2/engler/mc/oses/linux/2.5.8/mm/shmem.c:554:shmem_getpage_locked: ERROR:A_B:506:554:Did not reverse 'spin_lock' [COUNTER=spin_lock:506] [fit=3] [fit_fn=2] [fn_ex=5] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -1.31122013621437]
> 
> 	entry = shmem_alloc_entry (info, idx);
> 	if (IS_ERR(entry))
> 		return (void *)entry;
> 
> Start --->
> 	spin_lock (&info->lock);
> 
> 	... DELETED 42 lines ...
> 
> 			goto wait_retry;
> 
> 		error = move_from_swap_cache(page, idx, mapping);
> 		if (error < 0) {
> 			UnlockPage(page);
> Error --->
> 			return ERR_PTR(error);
> 		}
> 
> 		swap_free(*entry);

This one is easy:

Index: mm/shmem.c
===================================================================
RCS file: /var/cvs/thunder-2.5/mm/shmem.c,v
retrieving revision 1.3
diff -p -u -r1.3 shmem.c
--- mm/shmem.c  6 Jul 2002 18:17:44 -0000       1.3
+++ mm/shmem.c  11 Jul 2002 21:47:22 -0000
@@ -607,6 +607,7 @@ repeat:
                if (error < 0) {
                        unlock_page(page);
                        page_cache_release(page);
+                       spin_unlock (&info->lock);
                        return ERR_PTR(error);
                }



> ---------------------------------------------------------
> [BUG]
> /u2/engler/mc/oses/linux/2.5.8/drivers/mtd/chips/cfi_cmdset_0001.c:782:do_write_buffer: ERROR:A_B:700:782:Did not reverse 'spin_lock' [COUNTER=spin_lock:700] [fit=3] [fit_fn=1] [fn_ex=5] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -1.31122013621437]
> 	/* Let's determine this according to the interleave only once */
> 	status_OK = CMD(0x80);
> 
> 	timeo = jiffies + HZ;
>  retry:
> Start --->
> 	spin_lock_bh(chip->mutex);
> 
> 	... DELETED 76 lines ...
> 
> 			map->write16 (map, *((__u16*)buf)++, adr+z);
> 		} else if (cfi_buswidth_is_4()) {
> 			map->write32 (map, *((__u32*)buf)++, adr+z);
> 		} else {
> 			DISABLE_VPP(map);
> Error --->
> 			return -EINVAL;
> 		}
> 	}
> 	/* GO GO GO */

This one, too:

Index: drivers/mtd/chips/cfi_cmdset_0001.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/mtd/chips/cfi_cmdset_0001.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 cfi_cmdset_0001.c
--- drivers/mtd/chips/cfi_cmdset_0001.c 21 Jun 2002 22:17:29 -0000      
1.1.1.1
+++ drivers/mtd/chips/cfi_cmdset_0001.c 11 Jul 2002 21:52:35 -0000
@@ -779,6 +779,7 @@ static inline int do_write_buffer(struct
                        map->write32 (map, *((__u32*)buf)++, adr+z);
                } else {
                        DISABLE_VPP(map);
+                       spin_unlock_bh(chip->mutex);
                        return -EINVAL;
                }
        }


I'm on the rest.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

