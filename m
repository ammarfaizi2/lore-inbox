Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265926AbRFZGuF>; Tue, 26 Jun 2001 02:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265928AbRFZGtz>; Tue, 26 Jun 2001 02:49:55 -0400
Received: from www.wen-online.de ([212.223.88.39]:48134 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S265927AbRFZGtt>;
	Tue, 26 Jun 2001 02:49:49 -0400
Date: Tue, 26 Jun 2001 08:48:43 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        <Paul.Russell@rustcorp.com.au>
Subject: Re: proc_file_read() question
In-Reply-To: <Pine.LNX.4.30.0106252141181.13052-100000@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.4.33.0106260834400.737-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001, Martin Wilck wrote:

> Hi,
>
> the "hack" below in proc_file_read() fs/proc/generic.c (2.4.5)
> irritates me:
>
> If I do use "start" for a pointer into a memory area
> allocated in read_proc, will it be always guaranteed
> that (start > page)?
>
> If no, this will IMO lead to spuriously wrong output.
> If yes, I'd like to understand why.

Shhh ;-)  Last time that hack was mentioned, someone wanted to _remove_
it.  It's a very nice little hack to have around, and IKD uses it.

	-Mike

diff -urN linux-2.4.4.virgin/fs/proc/generic.c linux-2.4.4.ikd.mike/fs/proc/generic.c
--- linux-2.4.4.virgin/fs/proc/generic.c	Mon Dec 11 22:45:42 2000
+++ linux-2.4.4.ikd/fs/proc/generic.c	Sun Dec 17 07:58:56 2000
@@ -104,6 +104,11 @@
  		 * return the bytes, and set `start' to the desired offset
  		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
 		 */
+		/* Ensure that the data will fit when using the ppos hack,
+		 * otherwise userland receives truncated data.
+		 */
+		if (n > count-1 && start && start < page)
+			break;
  		n -= copy_to_user(buf, start < page ? page : start, n);
 		if (n == 0) {
 			if (retval == 0)

