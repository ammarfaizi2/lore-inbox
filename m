Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289905AbSAPJjA>; Wed, 16 Jan 2002 04:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289896AbSAPJis>; Wed, 16 Jan 2002 04:38:48 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:64005 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287768AbSAPJij>; Wed, 16 Jan 2002 04:38:39 -0500
Message-ID: <3C45489A.718A5F86@zip.com.au>
Date: Wed, 16 Jan 2002 01:32:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre4
In-Reply-To: <Pine.LNX.4.21.0201151955460.27118-100000@freak.distro.conectiva>,
		<Pine.LNX.4.21.0201151955460.27118-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Jan 15, 2002 at 07:56:38PM -0200 <20020116102256.C824@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Tue, Jan 15, 2002 at 07:56:38PM -0200, Marcelo Tosatti wrote:
> [pre4 Announcement]
> 
> What is this hunk supposed to do?
> diff -urN linux-2.4.18-pre3/fs/buffer.c linux/fs/buffer.c
> --- linux-2.4.18-pre3/fs/buffer.c   Fri Dec 21 09:41:55 2001
> +++ linux/fs/buffer.c   Tue Jan 15 15:10:18 2002
> @@ -1633,12 +1671,34 @@
>     */
>    while(wait_bh > wait) {
>       wait_on_buffer(*--wait_bh);
> -     err = -EIO;
>       if (!buffer_uptodate(*wait_bh))
> -        goto out;
> +        return -EIO;
>    }
>    return 0;
>  out:
> +  /*
> +   * Zero out any newly allocated blocks to avoid exposing stale
> +   * data.  If BH_New is set, we know that the block was newly
> +   * allocated in the above loop.
> +   */
> +  bh = head;
> +  block_start = 0;
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

Good eyes.  I missed that in both reviewing and in testing.

I'll go test this:

--- linux-2.4.18-pre4/fs/buffer.c	Tue Jan 15 15:08:25 2002
+++ linux-akpm/fs/buffer.c	Wed Jan 16 01:30:25 2002
@@ -1686,7 +1686,7 @@ out:
 	do {
 		block_end = block_start+blocksize;
 		if (block_end <= from)
-			continue;
+			goto next_bh;
 		if (block_start >= to)
 			break;
 		if (buffer_new(bh)) {
@@ -1696,6 +1696,7 @@ out:
 			set_bit(BH_Uptodate, &bh->b_state);
 			mark_buffer_dirty(bh);
 		}
+next_bh:
 		block_start = block_end;
 		bh = bh->b_this_page;
 	} while (bh != head);
