Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbSLNWH0>; Sat, 14 Dec 2002 17:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbSLNWH0>; Sat, 14 Dec 2002 17:07:26 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:54737 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265995AbSLNWHZ>; Sat, 14 Dec 2002 17:07:25 -0500
Date: Sat, 14 Dec 2002 15:08:04 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
In-Reply-To: <Pine.LNX.4.44.0212131707350.6750-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212142204520.9829-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 1) Its the same place on the screen or a different place every time?
>
> I think it's at the last line of the screen every time.

I think I might now what the problem is. scrup is using memcpy even when
the memory areas src, dest overlap. The key is to use memmove which
handles overlapping memory gracefully. Tell me if the following patch
works for you.

--- vt.c.orig	Sat Dec 14 13:32:42 2002
+++ vt.c	Sat Dec 14 13:34:46 2002
@@ -262,7 +262,7 @@
 		return;
 	d = (unsigned short *) (origin+video_size_row*t);
 	s = (unsigned short *) (origin+video_size_row*(t+nr));
-	scr_memcpyw(d, s, (b-t-nr) * video_size_row);
+	scr_memmovew(d, s, (b-t-nr) * video_size_row);
 	scr_memsetw(d + (b-t-nr) * video_num_columns, video_erase_char, video_size_row*nr);
 }



