Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265297AbRF0IFb>; Wed, 27 Jun 2001 04:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265295AbRF0IFW>; Wed, 27 Jun 2001 04:05:22 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:10760 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S265292AbRF0IFD>;
	Wed, 27 Jun 2001 04:05:03 -0400
Date: Wed, 27 Jun 2001 10:07:57 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Jonathan Lundell <jlundell@pobox.com>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Mike Galbraith <mikeg@wen-online.de>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        <Paul.Russell@rustcorp.com.au>
Subject: Re: [PATCH] proc_file_read() (Was: Re: proc_file_read() question)
In-Reply-To: <p05100308b75e7a57e777@[207.213.214.37]>
Message-ID: <Pine.LNX.4.30.0106270925540.13052-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001, Jonathan Lundell wrote:

> I use the hack myself, to implement a record-oriented file where the
> file position is a record number. I could probably live with
> PAGE_SIZE, but the current hack works fine with start bigger than
> that, and it's possible that someone counts on it.

Ok, let's use PAGE_OFFSET instead of PAGE_SIZE, then (see new patch
below).

Unless I'm mislead, legitimate values of "start" as a pointer are always
larger than that, and I can hardly imagin e a case where the "unsigned
int" value of start must be greater than PAGE_OFFSET.

I insist that relying on the comparison of two pointers is the wrong
thing. If (as you suggest) the major use of "start" has migrated from the
original intention to that of the "hack", this should be reflected
in the interface by making the "start" parameter to read_proc ()
an unsigned long. Everything else is misleading and error-prone.
For now, "start" is a char* and should be treated as such.

> But if you're allocating your own buffer, you'd probably be better
> off writing your own file ops, and not using the default
> proc_file_read() at all. At the very least you'd save a redundant
> __get_free_page/free_page pair.

That's right, but nevertheless (repeat) comparing "start" and "page" is
wrong.

Regards,
Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113

--- linux-2.4.5/fs/proc/generic.c	Mon Jun 25 13:46:26 2001
+++ 2.4.5mw/fs/proc/generic.c	Wed Jun 27 11:22:14 2001
@@ -104,14 +104,14 @@
  		 * return the bytes, and set `start' to the desired offset
  		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
 		 */
- 		n -= copy_to_user(buf, start < page ? page : start, n);
+ 		n -= copy_to_user(buf, (unsigned long) start < PAGE_OFFSET ? page : start, n);
 		if (n == 0) {
 			if (retval == 0)
 				retval = -EFAULT;
 			break;
 		}

-		*ppos += start < page ? (long)start : n; /* Move down the file */
+		*ppos += (unsigned long) start < PAGE_OFFSET ? (unsigned long) start : n; /* Move down the file */
 		nbytes -= n;
 		buf += n;
 		retval += n;



