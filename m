Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVAJWz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVAJWz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVAJWjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:39:02 -0500
Received: from guru.webcon.ca ([216.194.67.26]:35524 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S262592AbVAJWhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:37:08 -0500
Date: Mon, 10 Jan 2005 17:36:59 -0500 (EST)
From: Robert Hardy <rhardy@webcon.ca>
X-X-Sender: rhardy@vortex.int.webcon.net
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vfat unlink latency 54.6ms for 128MB files
In-Reply-To: <878y71xh7b.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.61.0501101703140.2235@vortex.int.webcon.net>
References: <20050110012330.GA10846@m.safari.iki.fi> <878y71xh7b.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, OGAWA Hirofumi wrote:
> Sami Farin <7atbggg02@sneakemail.com> writes:
>
>> Just wondering, when I remove a 128MB file on vfat partition
>> (usb-storage, memcard reader), it causes 54.6ms latency
>> in rtc_latencytest...  latency seems to increase linearly
>> as the filesize grows.  I calculated 1s would be reached with
>> 2344MB file but I didn't bother trying that yet.
>> Are there any possible fixes for fat fs so
>> that it doesn't disable interrupts for that long a time?
>
> The fatfs itself doesn't disable any interrupt.  I guess the thing
> depending on file size is the fat_free().
>
> So, the following patch may change the behavior...

diff -up linux-2.6.10/fs/fat/cache.c.orig linux-2.6.10/fs/fat/cache.c
--- linux-2.6.10/fs/fat/cache.c.orig    2004-12-25 06:35:24.000000000 +0900
+++ linux-2.6.10/fs/fat/cache.c 2005-01-11 03:34:54.000000000 +0900
@@ -491,6 +491,8 @@ int fat_free(struct inode *inode, int sk
                 if (MSDOS_SB(sb)->free_clusters != -1)
                         MSDOS_SB(sb)->free_clusters++;
                 inode->i_blocks -= MSDOS_SB(sb)->cluster_size >> 9;
+
+               cond_resched();
         } while (nr != FAT_ENT_EOF);
         fat_clusters_flush(sb);
         nr = 0;
-

Thanks for your patchset.tar (in another thread) from:
Thu, 30 Dec 2004 12:02:14 +0900.

Based on the patch above, is an additional cond_resched() call required
somewhere in your 2004/12/30 patchset?

In your 2004/12/30 patchset, if I am reading it correctly, fat_free seems to
have moved from cache.c to file.c and the code isn't similar enough for me
to see where a cond_resched() could be added.

Perhaps you have already have a newer patchset?

Thanks for your time.

Regards,
Rob

-- 
---------------------"Happiness is understanding."----------------------
Robert Hardy, B.Eng Computer Systems                  C.E.O. Webcon Inc.
rhardy <at> webcon <dot> ca    GPG Key available          (613) 276-7327
