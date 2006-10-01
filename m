Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWJARNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWJARNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWJARNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:13:25 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:30818 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751280AbWJARNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:13:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=e/xePda3aXsCeGL9TvrnflXhU4KNz6Q9aFT0ytYbE1Danc0jMHwCW8ejezBatChOl91YHa1KVU2Ds27KnzY3kbauFexacSoyK2Ae/rrEESFfN9SLyP50AZB5b0Gzp+nm+E7JyXrnDizJUXLCcv5PvfxTrmiZqfA0wwi5Gx9Shxo=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 4/5] UML - Close file descriptor leaks
Date: Sun, 1 Oct 2006 19:10:37 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200609271757.k8RHvtNK005742@ccure.user-mode-linux.org>
In-Reply-To: <200609271757.k8RHvtNK005742@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610011910.37805.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 19:57, Jeff Dike wrote:
> Close two file descriptor leaks, one in the ubd driver and one to
> /proc/mounts.  The ubd driver bug also leaked some vmalloc space.
> The /proc/mounts leak was a descriptor that was just never closed.
For AKPM:
NACK on the ubd driver part. It adds a bugs and does fix the one you found in 
the right point. ACK on the other hunk.

Now, Andrew, you can ignore what follows if you want:

Jeff, please explain me the exact ubd driver bug - I believe that the open 
must be done there, that it is balanced by ubd_close(), and that the leak fix 
should be done differently. I've done huge changes to the UBD driver and I'll 
send them you briefly for your tree (they work but they're not yet in a 
perfect shape).

For what I can gather from your description and code, the leak you diagnosed 
is a bug in ubd_open_dev(), and is valid for any call to it: generally, if an 
_open function fails it should leave nothing to cleanup, and in particular 
the corresponding _close should not be called (this is the implicit standard 
I've seen in Linux). However, I did not note the ubd_open_dev() leak, and I'm 
fixing it now.

Btw, ubd_open_dev() and ubd_close() are matching functions, while ubd_close() 
does not match ubd_open(), so I renamed ubd_close -> ubd_close_dev.

About the UBD changes, they're mainly about making it SMP-ready. I've done 
also a number of other changes (for instance I removed the allocation in 
fork+execvp() by reimplementing the latter, and fixed the usage of sigio 
spinlocks), so the only big remaining bug I recall is that writes to consoles 
should be lock-free.

When there are sleep-inside-spinlock warnings inside line_open(), for 
instance, the resulting printk hangs because the line spinlock is already 
held (this is, in particular, due to um_request_irq in 
write_sigio_workaround(), and I fixed it).
However, console write driver methods must be lock-free (specified in 
Documentation/tty.txt); I fixed the warnings but I wanted to fix the hang 
caused by them.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> ---
>
>  arch/um/drivers/ubd_kern.c |    9 ++-------
>  arch/um/os-Linux/mem.c     |    6 +++++-
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> Index: linux-2.6.18-mm/arch/um/drivers/ubd_kern.c
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/drivers/ubd_kern.c	2006-09-26
> 16:28:58.000000000 -0400 +++
> linux-2.6.18-mm/arch/um/drivers/ubd_kern.c	2006-09-26 16:31:24.000000000
> -0400 @@ -667,18 +667,15 @@ static int ubd_add(int n)
>  	if(dev->file == NULL)
>  		goto out;
>
> -	if (ubd_open_dev(dev))
> -		goto out;
> -
>  	err = ubd_file_size(dev, &dev->size);
>  	if(err < 0)
> -		goto out_close;
> +		goto out;
>
>  	dev->size = ROUND_BLOCK(dev->size);
>
>  	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
>  	if(err)
> -		goto out_close;
> +		goto out;
>
>  	if(fake_major != MAJOR_NR)
>  		ubd_new_disk(fake_major, dev->size, n,
> @@ -690,8 +687,6 @@ static int ubd_add(int n)
>  		make_ide_entries(ubd_gendisk[n]->disk_name);
>
>  	err = 0;
> -out_close:
> -	ubd_close(dev);
>  out:
>  	return err;
>  }

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
