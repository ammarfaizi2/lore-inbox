Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVCGFIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVCGFIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCGFIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:08:36 -0500
Received: from orb.pobox.com ([207.8.226.5]:41604 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261622AbVCGFIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:08:32 -0500
In-Reply-To: <422B4E97.4090303@inode.info>
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <93832c6db45c33f7b2f195aae0d469dc@pobox.com> <422A041E.40105@inode.info> <0a8f9833de8ba3f767f3b3211bbb693a@pobox.com> <422B4E97.4090303@inode.info>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bda000da0eb3b797500d90992d30a99d@pobox.com>
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
From: Scott Feldman <sfeldma@pobox.com>
Subject: Re: slab corruption in skb allocs
Date: Sun, 6 Mar 2005 21:07:26 -0800
To: Richard Fuchs <richard.fuchs@inode.info>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 6, 2005, at 10:40 AM, Richard Fuchs wrote:

> Scott Feldman wrote:
>> A bug in the driver.  I have a hunch: please try this patch with 
>> 2.6.9 or higher:
>> http://marc.theaimsgroup.com/?l=linux-netdev&m=110726809431611&w=2
>
> bingo, that fixes it. too bad neither this patch nor the removal of 
> the NAPI config option made it into 2.6.11...

Jesse Brandeburg @ Intel found the fix for the bug but I don't think 
it's been pushed out to Jeff's tree yet, AFAIK.  Soon, I would guess.

Would you mind giving this patch a try against 2.6.11?  I think it's 
equivalent to Jesse's patch, but less intrusive to the driver.

--- linux-2.6.11/drivers/net/e100.c.orig        Sun Mar  6 20:58:15 2005
+++ linux-2.6.11/drivers/net/e100.c     Sun Mar  6 21:01:34 2005
@@ -1471,8 +1471,12 @@ static inline int e100_rx_indicate(struc

         /* If data isn't ready, nothing to indicate */
         if(unlikely(!(rfd_status & cb_complete)))
-               return -EAGAIN;
+               return -ENODATA;

+       /* This allows for a fast restart without re-enabling 
interrupts */
+       if(le16_to_cpu(rfd->command) & cb_el)
+               nic->ru_running = 0;
+
         /* Get actual data size */
         actual_size = le16_to_cpu(rfd->actual_size) & 0x3FFF;
         if(unlikely(actual_size > RFD_BUF_LEN - sizeof(struct rfd)))
@@ -1527,7 +1531,11 @@ static inline void e100_rx_clean(struct
                         break; /* Better luck next time (see watchdog) 
*/
         }

-       e100_start_receiver(nic);
+       /* NAPI: attempt to restart the receiver iff the list is
+        * totally clean otherwise we'll race between hardware and
+        * nic->rx_to_clean. */
+       if(!work_done || *work_done == 0)
+               e100_start_receiver(nic);
  }

  static void e100_rx_clean_list(struct nic *nic)


>> No.  e1000 is a totally different driver/device with very similar 
>> name.
>
> too bad, i was hoping for an explanation for some unexplainable 
> crashes i've been experiencing... ;)

Take the e1000 issue to linux-netdev.

-scott

