Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVBRJqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVBRJqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 04:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVBRJqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 04:46:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:37589 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261325AbVBRJqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 04:46:35 -0500
Date: Fri, 18 Feb 2005 01:46:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, david@fubar.dk
Subject: Re: [PATCH] add I/O error uevent for block devices
Message-Id: <20050218014621.0b453232.akpm@osdl.org>
In-Reply-To: <20050218083316.GA6619@vrfy.org>
References: <20050218083316.GA6619@vrfy.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers <kay.sievers@vrfy.org> wrote:
>
> For HAL we want to get notified about I/O errors of block devices.
>  This is especially useful for devices we are unable to poll and
>  therefore can't know if something goes wrong here.
> 
>  Signed-off-by: David Zeuthen <david@fubar.dk>
>  Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
> 
>  ===== fs/buffer.c 1.270 vs edited =====
>  --- 1.270/fs/buffer.c	2005-01-21 06:02:13 +01:00
>  +++ edited/fs/buffer.c	2005-02-17 22:56:05 +01:00
>  @@ -105,6 +105,7 @@ static void buffer_io_error(struct buffe
>   	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Lu\n",
>   			bdevname(bh->b_bdev, b),
>   			(unsigned long long)bh->b_blocknr);
>  +	kobject_uevent(&bh->b_bdev->bd_disk->kobj, KOBJ_IO_ERROR, NULL);
>   }

- buffer_io_error() is called from interrupt context, and
  kobject_uevent() does multiple GFP_KERNEL allocations.  You'll need to
  use kobject_uevent_atomic().

- the prink_ratelimit() fix in end_buffer_async_read() should be a
  separate patch, really.  I'll fix that up.

- there are numerous other places where an I/O error can be detected:
  grep the tree for b_end_io and bio_end_io.
