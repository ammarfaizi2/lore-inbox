Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbQLILNB>; Sat, 9 Dec 2000 06:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131117AbQLILMw>; Sat, 9 Dec 2000 06:12:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25826 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129538AbQLILMh>;
	Sat, 9 Dec 2000 06:12:37 -0500
Date: Sat, 9 Dec 2000 05:40:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@chiara.elte.hu>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.LNX.4.10.10012082356020.2121-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012090415330.29053-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Linus Torvalds wrote:

> This is a preliminary patch that I have not compiled and probably breaks,
> but you get the idea. I'm going to sleep, to survive another night with
> three small kids.
> 
> If somebody wants to run with this, please try it out, but realize that
> it's a work-in-progress. And realize that bugs in this area tend to
> corrupt filesystems very quickly indeed. I would strongly advice against
> trying this patch out without really grokking what it does and feeling
> confident that it actually works.
> 
> NOTE NOTE NOTE! I've tried to keep the patch small and simple. I've tried
> to make all the changes truly straightforward and obvious. I want this bug
> squashed, and I don't want to see it again. But I _still_ think this is a
> dangerous patch until somebody like Al has given it a green light. Caveat
> Emptor.
 
> @@ -1001,7 +995,7 @@
>  	 * and it is clean.
>  	 */
>  	if (bh) {
> -		init_buffer(bh, end_buffer_io_sync, NULL);
> +		init_buffer(bh, end_buffer_io_bad, NULL);

	How about NULL?

> @@ -1210,7 +1204,6 @@
[breada()]
	Umm... why do we keep it, in the first place? AFAICS the only
in-tree user is hpfs_map_sector() and it doesn't look like we really
need it there. OTOH, trimming the buffer.c down is definitely nice.
Mikulas?

> @@ -1439,7 +1431,7 @@
[create_page_buffers()]
	Linus, compare the result with create_empty_buffers(). Then look
at the only caller and notice that it will merrily loop over these
buffer_heads. IOW, I propose to mark them mapped and set the ->b_blocknr
in brw_page(), replace create_page_buffers() call with create_empty_buffers()
and let create_page_buffers() go to hell. Oh, and let create_empty_buffers()
take device as an argument, not inode as it does now.

> @@ -1600,6 +1590,8 @@
[__block_write_full_page()]
>  
>  	bh = head;
>  	i = 0;
> +
> +	/* Stage 1: make sure we have all the buffers mapped! */
>  	do {
>  		/*
>  		 * If the buffer isn't up-to-date, we can't be sure

Ahem. Think what will happen if we are sitting over the hole in file,
map some buffers and fail in the middle of the fun. Notice that we
do not submit any IO requests in that case, i.e. we just had created
a random crap in file.

More recovery needed here. I would just break out of the mapping loop,
then proceed as above, but limited the activity to mapped blocks only.
And did if (err) ClearPageUptodate(page) in the end.

> @@ -1669,7 +1665,6 @@
[__block_prepare_write()]

Same problem with recovery - see the patch I've sent recently (handling
get_block() failures).

> @@ -1793,35 +1787,40 @@
[block_read_full_page()]
> -		init_buffer(bh, end_buffer_io_async, NULL);
	Fine
> -		atomic_inc(&bh->b_count);

	Why? It's cleaner the old way - why bother postponing that until we
lock the thing?

> +	/* Stage two: lock the buffers */
> +	for (i = 0; i < nr; i++) {
> +		struct buffer_head * bh = arr[i];
> +		lock_buffer(bh);
> +		bh->b_end_io = end_buffer_io_async;
> +		atomic_inc(&bh->b_count);

See above.

> @@ -2263,67 +2261,31 @@
>   */
>  int brw_page(int rw, struct page *page, kdev_t dev, int b[], int size)

>  	if (!page->buffers)
> +		create_page_buffers(rw, page, dev, b, size);

		create_empty_buffers(page, dev, size);

> +
> +	head = bh = page->buffers;
> +	if (!head)
>  		BUG();
>  
> -	head = page->buffers;
> -	bh = head;
> -	nr = 0;
> +	/* Stage 1: lock all the buffers */
>  	do {
> -		block = *(b++);
> +		lock_buffer(bh);
> +		bh->b_end_io = end_buffer_io_async;

		bh->b_blocknr = *(b++);
		set_bit(BH_Mapped, &bh->b_state);

	Modulo the comments above - fine with me. However, there is stuff in
drivers/md that I don't understand. Ingo, could you comment on the use of
->b_end_io there?

	Another bad thing is in mm/filemap.c::writeout_one_page() - it doesn't
even check for buffers being mapped, let alone attempt to map them.
	Fortunately, ext2 doesn't use it these days, but the rest of block
filesystems... <doubletake> WTF? fsync() merrily ignores mmap()'ed stuff?
I mean, we can mmap() an area, dirty the bloody thing, call fsync() and
get zero traffic. Hmm... OTOH, it might be correct behaviour...
	Anyway, fsync() on block filesystems other than ext2 needs fixing.
Badly. I'll port Stephen's patch to them.

	IMO patch is mostly safe (the worst part is error recovery on
block_write_full_page()), except the writeout_one_page() part and possibly
the RAID stuff.
	Linus, Ingo, Mikulas - comments?
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
