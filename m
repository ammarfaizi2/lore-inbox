Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265043AbRFZRLa>; Tue, 26 Jun 2001 13:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265044AbRFZRLL>; Tue, 26 Jun 2001 13:11:11 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:59909 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S265043AbRFZRLB>;
	Tue, 26 Jun 2001 13:11:01 -0400
Date: Tue, 26 Jun 2001 19:14:05 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        <Paul.Russell@rustcorp.com.au>
Subject: [PATCH] proc_file_read() (Was: Re: proc_file_read() question)
In-Reply-To: <Pine.LNX.4.33.0106260834400.737-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.30.0106261906240.13052-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Shhh ;-)  Last time that hack was mentioned, someone wanted to _remove_
> it.  It's a very nice little hack to have around, and IKD uses it.

I am not saying it should be removed. But IMO it is a legitimate (if
not the originally intended) use of "start" to serve as a pointer to
a memory area allocated in the proc_read () function. This use is broken
with this hack in its current form, because reading from such a file
will fail depending on the (random) order of the page and start pointers.

If I understand the "hack" right, legitimate offsets generated for it
are always between 0 and PAGE_SIZE. Therefore the patch below would
not break it, while overcoming the abovementioned problem, because
legitimate page pointers will never be < PAGE_SIZE.

Please correct me if I'm wrong.

Cheers,
Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113


--- linux-2.4.5/fs/proc/generic.c	Mon Jun 25 13:46:26 2001
+++ 2.4.5mw/fs/proc/generic.c	Tue Jun 26 20:42:22 2001
@@ -104,14 +104,14 @@
  		 * return the bytes, and set `start' to the desired offset
  		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
 		 */
- 		n -= copy_to_user(buf, start < page ? page : start, n);
+ 		n -= copy_to_user(buf, (unsigned long) start < PAGE_SIZE ? page : start, n);
 		if (n == 0) {
 			if (retval == 0)
 				retval = -EFAULT;
 			break;
 		}

-		*ppos += start < page ? (long)start : n; /* Move down the file */
+		*ppos += (unsigned long) start < PAGE_SIZE ? (unsigned long) start : n; /* Move down the file */
 		nbytes -= n;
 		buf += n;
 		retval += n;

