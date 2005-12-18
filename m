Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbVLRBC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbVLRBC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 20:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVLRBC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 20:02:27 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:41180 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932658AbVLRBC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 20:02:26 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: "Vijay Sampath" <Vijay.Sampath@aktino.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MTD (kernel 2.4.32): kernel stuck in tight loop occasionally on flash access
Date: Sun, 18 Dec 2005 12:01:45 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <jkc9q1pb27j1484eh4f0vkeft85rs2qqjc@4ax.com>
References: <02DAE179D5CEED4C992055C823ED90FF8ACE8B@ex1>
In-Reply-To: <02DAE179D5CEED4C992055C823ED90FF8ACE8B@ex1>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2005 16:18:23 -0800, "Vijay Sampath" <Vijay.Sampath@aktino.com> wrote:

>We are running a Timesys modified version of the 2.4 kernel.
>Occasionally we see board lockups on heavy file system and direct MTD
>flash accesses. I have traced this down to a bug in the 2.4 MTD code
>(chip driver to be specific) and see this problem even in the latest 2.4
>kernel (2.4.32). I realize that this problem may not be seen by others
>using the stock kernel, but I think it needs to be fixed anyway for
>correctness.
>
>The problem is in cfi_cmdset_0001.c, and is present in drivers for other
>chips as well. In the function cfi_intelext_sync() function before
>calling schedule(), the current process needs to be put to sleep by
>calling set_current_state(TASK_INTERRUPTIBLE). If it is not put to
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Why does the patch add set_current_state(TASK_UNINTERRUPTIBLE) call?


>sleep, the task remains in the run queue of the kernel and if its
>priority is high enough, the kernel will constantly keep scheduling this
>process, the state of the chip will never change.
>
>Adding this one line seems to make our lockups go away.

Leaves me confused :)  Description and patch should match?

>
>I am not subscribed to the mailing list, so please CC me on any replies.
>
>Signed-off-by: Vijay Sampath <vijay.sampath@aktino.com>
>
>---
>
>diff -uprN -X linux-2.4.32/Documentation/dontdiff
>linux-2.4.32/Documentation/dontdiff
>/home/vsampath/my-linux-2.4.32/Documentation/dontdiff
>--- linux-2.4.32/Documentation/dontdiff	2005-12-17 15:00:14.000000000
>-0800
>+++ /home/vsampath/my-linux-2.4.32/Documentation/dontdiff
>1969-12-31 16:00:00.000000000 -0800
>@@ -1,140 +0,0 @@
>-*.a
>-*.aux

Something is wrong here?  Your patch should not alter dontdiff.

[snip]

>diff -uprN -X linux-2.4.32/Documentation/dontdiff
>linux-2.4.32/drivers/mtd/chips/amd_flash.c
>/home/vsampath/my-linux-2.4.32/drivers/mtd/chips/amd_flash.c
>--- linux-2.4.32/drivers/mtd/chips/amd_flash.c	2003-06-13
>07:51:34.000000000 -0700
>+++ /home/vsampath/my-linux-2.4.32/drivers/mtd/chips/amd_flash.c
>2005-12-17 14:55:20.000000000 -0800
>@@ -1350,6 +1350,7 @@ static void amd_flash_sync(struct mtd_in
> 
> 		default:
> 			/* Not an idle state */
>+			set_current_state(TASK_UNINTERRUPTIBLE);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Doesn't match patch description.

> 			add_wait_queue(&chip->wq, &wait);
> 			
> 			spin_unlock_bh(chip->mutex);
>diff -uprN -X linux-2.4.32/Documentation/dontdiff
>linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0001.c
>/home/vsampath/my-linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0001.c
>--- linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0001.c	2004-11-17
>03:54:21.000000000 -0800
>+++ /home/vsampath/my-linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0001.c
>2005-12-17 14:53:42.000000000 -0800
>@@ -1687,6 +1687,7 @@ static void cfi_intelext_sync (struct mt
> 
> 		default:
> 			/* Not an idle state */
>+			set_current_state(TASK_UNINTERRUPTIBLE);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Doesn't match patch description.

> 			add_wait_queue(&chip->wq, &wait);
> 			
> 			spin_unlock(chip->mutex);
>diff -uprN -X linux-2.4.32/Documentation/dontdiff
>linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0002.c
>/home/vsampath/my-linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0002.c
>--- linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0002.c	2004-11-17
>03:54:21.000000000 -0800
>+++ /home/vsampath/my-linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0002.c
>2005-12-17 14:53:58.000000000 -0800
>@@ -1172,6 +1172,7 @@ static void cfi_amdstd_sync (struct mtd_
> 
> 		default:
> 			/* Not an idle state */
>+			set_current_state(TASK_UNINTERRUPTIBLE);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Doesn't match patch description.

> 			add_wait_queue(&chip->wq, &wait);
> 			
> 			cfi_spin_unlock(chip->mutex);
>diff -uprN -X linux-2.4.32/Documentation/dontdiff
>linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0020.c
>/home/vsampath/my-linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0020.c
>--- linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0020.c	2004-11-17
>03:54:21.000000000 -0800
>+++ /home/vsampath/my-linux-2.4.32/drivers/mtd/chips/cfi_cmdset_0020.c
>2005-12-17 14:54:09.000000000 -0800
>@@ -1036,6 +1036,7 @@ static void cfi_staa_sync (struct mtd_in
> 
> 		default:
> 			/* Not an idle state */
>+			set_current_state(TASK_UNINTERRUPTIBLE);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Doesn't match patch description.

> 			add_wait_queue(&chip->wq, &wait);
> 			
> 			spin_unlock_bh(chip->mutex);
>
Cheers,
Grant.
