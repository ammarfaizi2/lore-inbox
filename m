Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268343AbUGXHOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268343AbUGXHOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 03:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbUGXHOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 03:14:25 -0400
Received: from [217.111.56.18] ([217.111.56.18]:54403 "EHLO spring.sncag.com")
	by vger.kernel.org with ESMTP id S268343AbUGXHOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 03:14:22 -0400
To: "bradgoodman.com" <bkgoodman@bradgoodman.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.4.27 - MTD cfi_cmdset_0002.c - Duplicate cleanup in
 error path
In-Reply-To: <200407231947.i6NJlwo32224@bradgoodman.com> (bradgoodman com's
 message of "Fri, 23 Jul 2004 15:47:58 -0400")
References: <200407231947.i6NJlwo32224@bradgoodman.com>
From: Rainer Weikusat <rainer.weikusat@sncag.com>
Date: Sat, 24 Jul 2004 15:14:03 +0800
Message-ID: <87k6wtlvwk.fsf@farside.sncag.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"bradgoodman.com" <bkgoodman@bradgoodman.com> writes:
> Patch to 2.4.x: Corrects an obvious error where all of the cleanups are done
> twice in the event of a chip programming error. This can result in
> kernel BUG() getting called on subsequent programming attempts.
>
>
> --- linux-2.4.22.prepatch/drivers/mtd/chips/cfi_cmdset_0002.c	Fri Jun 13 10:51:34 2003
> +++ linux-2.4.22/drivers/mtd/chips/cfi_cmdset_0002.new	Thu Jul 15 14:44:30 2004
> @@ -549,11 +549,6 @@
>  			}
>  		} else {
>  			printk(KERN_WARNING "Waiting for write to complete timed out in do_write_oneword.");        
> -			
> -			chip->state = FL_READY;
> -			wake_up(&chip->wq);
> -			cfi_spin_unlock(chip->mutex);
> -			DISABLE_VPP(map);
>  			ret = -EIO;
>  		}
>  	}

I suggest the following instead:

--------------------------
--- cfi_cmdset_0002.c.orig	2004-07-24 15:05:31.000000000 +0800
+++ cfi_cmdset_0002.c	2004-07-24 15:06:06.000000000 +0800
@@ -461,7 +461,6 @@
 	unsigned int dq6, dq5;	
 	struct cfi_private *cfi = map->fldrv_priv;
 	DECLARE_WAITQUEUE(wait, current);
-	int ret = 0;
 
  retry:
 	cfi_spin_lock(chip->mutex);
@@ -554,7 +553,7 @@
 			wake_up(&chip->wq);
 			cfi_spin_unlock(chip->mutex);
 			DISABLE_VPP(map);
-			ret = -EIO;
+			return -EIO;
 		}
 	}
 
@@ -563,7 +562,7 @@
 	wake_up(&chip->wq);
 	cfi_spin_unlock(chip->mutex);
 
-	return ret;
+	return 0;
 }
 
 static int cfi_amdstd_write (struct mtd_info *mtd, loff_t to , size_t len, size_t *retlen, const u_char *buf)
----------------------------

That way, it is consistent with the other low-level chip access
functions. But the algorithm is per se buggy, anyway, because except
if DQ5 was raised before, the chip is not 'ready' (for reading array
data), but still in programming mode and will remain there until the
'embedded programming algorithm' stops, because (according to the
docs) a reset command will not be accepted until DQ5 has been raised
and the opportunityto check for that is gone after the syscall
returned to the caller.


