Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135189AbRAHRfm>; Mon, 8 Jan 2001 12:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135346AbRAHRfd>; Mon, 8 Jan 2001 12:35:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48872 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135201AbRAHRfU>;
	Mon, 8 Jan 2001 12:35:20 -0500
Date: Mon, 8 Jan 2001 12:35:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Alan Cox <alan@redhat.com>, Stefan Traby <stefan@hello-penguin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <97890000.978970315@tiny>
Message-ID: <Pine.GSO.4.21.0101081153150.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Chris Mason wrote:

> 
> On Monday, January 08, 2001 10:47:41 AM -0500 Alexander Viro
> <viro@math.psu.edu> wrote:
> > +	do {
> > +		if (buffer_mapped(bh)) {
> > +			bh->b_end_io = end_buffer_io_async;
> > +			atomic_inc(&bh->b_count);
> > +			set_bit(BH_Uptodate, &bh->b_state);
> > +			set_bit(BH_Dirty, &bh->b_state);
>                         ^^^^^^^
> 
> Sorry, missed this the first time I read it.  We need to clear the dirty bit
> before sending to submit_bh, otherwise it stays dirty until
> try_to_free_buffers writes it again.

Umm... It does recovery, but we do extra write on blocks we've managed to
allocate. Thanks for spotting - looks like a bug that had been in the patch
for a month or so ;-/ clear_bit it is...

Looking one more time... generic_file_write() is very odd:
        if (pos > inode->i_sb->s_maxbytes)
        {
                send_sig(SIGXFSZ, current, 0);
                err = -EFBIG;
                goto out;
        }

        if (pos + count > inode->i_sb->s_maxbytes)
        {
                count = inode->i_sb->s_maxbytes - count;
                goto out;
        }
 
looks funny - goto out means that new (and rather meaningless) value of
count goes to hell. Shouldn't we remove that line and s/- count/- pos/
in the previous one? Besides, do we really want the limit on size ber
0x.......f for ext2? 0x7fffffff comes from s32 returned by lseek(), and
thus - for size. ext2 limit should be a multiple of block size...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
