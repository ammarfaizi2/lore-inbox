Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289906AbSAPJpS>; Wed, 16 Jan 2002 04:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289910AbSAPJpC>; Wed, 16 Jan 2002 04:45:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62173 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289907AbSAPJol>;
	Wed, 16 Jan 2002 04:44:41 -0500
Date: Wed, 16 Jan 2002 04:44:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre4
In-Reply-To: <20020116102256.C824@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.21.0201160441040.6091-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Jan 2002, Ingo Oeser wrote:

> [1]
> +  do {
> +     block_end = block_start+blocksize;
> +     if (block_end <= from)
> +        continue;
> [2]
> 
> The situation between [1] and [2] won't change, so I don't
> understand the "continue" here and think it will either never be
> triggered or an endless loop.
> 
> Could you or the one introducing this clarify?

Lovely...   Thanks for spotting.
--- fs/buffer.c	Wed Jan 16 04:39:56 2002
+++ fs/buffer.c.new	Wed Jan 16 04:43:29 2002
@@ -1686,7 +1686,7 @@
 	do {
 		block_end = block_start+blocksize;
 		if (block_end <= from)
-			continue;
+			goto skip_it;
 		if (block_start >= to)
 			break;
 		if (buffer_new(bh)) {
@@ -1696,6 +1696,7 @@
 			set_bit(BH_Uptodate, &bh->b_state);
 			mark_buffer_dirty(bh);
 		}
+	skip_it:
 		block_start = block_end;
 		bh = bh->b_this_page;
 	} while (bh != head);

