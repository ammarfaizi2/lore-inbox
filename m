Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbRFZRzp>; Tue, 26 Jun 2001 13:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265064AbRFZRzZ>; Tue, 26 Jun 2001 13:55:25 -0400
Received: from geos.coastside.net ([207.213.212.4]:52201 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S265057AbRFZRzN>; Tue, 26 Jun 2001 13:55:13 -0400
Mime-Version: 1.0
Message-Id: <p05100308b75e7a57e777@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.30.0106261906240.13052-100000@biker.pdb.fsc.net>
In-Reply-To: <Pine.LNX.4.30.0106261906240.13052-100000@biker.pdb.fsc.net>
Date: Tue, 26 Jun 2001 10:54:51 -0700
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Mike Galbraith <mikeg@wen-online.de>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] proc_file_read() (Was: Re: proc_file_read() question)
Cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        <Paul.Russell@rustcorp.com.au>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:14 PM +0200 2001-06-26, Martin Wilck wrote:
>Hi,
>
>>  Shhh ;-)  Last time that hack was mentioned, someone wanted to _remove_
>>  it.  It's a very nice little hack to have around, and IKD uses it.
>
>I am not saying it should be removed. But IMO it is a legitimate (if
>not the originally intended) use of "start" to serve as a pointer to
>a memory area allocated in the proc_read () function. This use is broken
>with this hack in its current form, because reading from such a file
>will fail depending on the (random) order of the page and start pointers.
>
>If I understand the "hack" right, legitimate offsets generated for it
>are always between 0 and PAGE_SIZE. Therefore the patch below would
>not break it, while overcoming the abovementioned problem, because
>legitimate page pointers will never be < PAGE_SIZE.
>
>Please correct me if I'm wrong.

I use the hack myself, to implement a record-oriented file where the 
file position is a record number. I could probably live with 
PAGE_SIZE, but the current hack works fine with start bigger than 
that, and it's possible that someone counts on it.

But if you're allocating your own buffer, you'd probably be better 
off writing your own file ops, and not using the default 
proc_file_read() at all. At the very least you'd save a redundant 
__get_free_page/free_page pair.

>Cheers,
>Martin
>
>--
>Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
>FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113
>
>
>--- linux-2.4.5/fs/proc/generic.c	Mon Jun 25 13:46:26 2001
>+++ 2.4.5mw/fs/proc/generic.c	Tue Jun 26 20:42:22 2001
>@@ -104,14 +104,14 @@
>  		 * return the bytes, and set `start' to the desired offset
>  		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
>  		 */
>-		n -= copy_to_user(buf, start < page ? page : start, n);
>+		n -= copy_to_user(buf, (unsigned long) start < 
>PAGE_SIZE ? page : start, n);
>  		if (n == 0) {
>  			if (retval == 0)
>  				retval = -EFAULT;
>  			break;
>  		}
>
>-		*ppos += start < page ? (long)start : n; /* Move down 
>the file */
>+		*ppos += (unsigned long) start < PAGE_SIZE ? 
>(unsigned long) start : n; /* Move down the file */
>  		nbytes -= n;
>  		buf += n;
>  		retval += n;

-- 
/Jonathan Lundell.
