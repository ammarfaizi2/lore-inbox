Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278084AbRJPDwd>; Mon, 15 Oct 2001 23:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278517AbRJPDwZ>; Mon, 15 Oct 2001 23:52:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62213 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278084AbRJPDwO>; Mon, 15 Oct 2001 23:52:14 -0400
Date: Mon, 15 Oct 2001 20:52:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.LNX.4.33.0110151936580.4179-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110152032340.8668-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Oct 2001, Linus Torvalds wrote:
>
> (In other words: with a structured approach you can make guarantees about
> the stability of each entry - you just can't necessarily guarantee that
> all entries are shown or that some entries might not be duplicated..)

Note that this can actually be important, with suid applications that
trust /proc. It is a GoodThing(tm) to have a read() that never returns
"mixed" output from different lines, ie even if a mount/umount happens in
parallel with reading /proc/mounts, you never get the filenames wrong..

Some stuff definitely wants more than 1 page per entry (/proc/mount
happens to be the only one I can think of - it can have the pathname
already be PAGE_SIZE-1, with the options being another PAGE_SIZE), so some
interface like

 - "proc_read_data" data structure:

	struct proc_read_data {
		struct semaphore sem;
		int (*fillme)(struct proc_read_data *);
		unsigned long this_index;
		unsigned long next_index;
		unsigned int buffer_len;
		char buffer[0];
	};

 - allocate it on /proc open, de-allocate it on close, save it away in
   filp->f_private_data or whatever...

 - read ends up looking something like


	/* Max 4 pages per entry */
	#define INDEX_SHIFT (PAGE_SHIFT + 2)
	#define EOF_INDEX   (0xffff)

	..
	/* We don't do 'pread()' */
	if (pos != &file->f_pos)
		return -EPIPE;
	struct proc_read_data *prd = file->f_private_data;
	down(&prd->sem);
	index = file->f_pos >> INDEX_SHIFT;
	offset = file->f_pos & ((1UL << INDEX_SHIFT)-1);
	if (index == prd->this_index) {
   repeat:
		if (index == EOF_INDEX)
			goto out;
		/* copy the rest of the buffer.. */
		if (offset < prd->buffer_len) {
			int nr = prd->buffer_len - offset;
			if (nr > count)
				nr = count;
			copy_to_user(buffer, prd->buffer + offset, nr);
			offset += nr;
			count -= nr;
			if (!count)
				goto out;
		}

		/* Jump to "next" */
		index = prd->next_index;
	}
	offset = 0;
	prd->this_index = index;
	prd->fillme(prd);
	goto repeat;

   out:
	file->f_pos = (index << INDEX_SHIFT) | offset;
	up(&prd->sem);
	return retval;

.. and that's it (except for "fillme()", which is obviously the hard part,
and which has to fill in not only the buffer with the data for the right
index, it also has to fill in "prd->next_index" and "prd->buffer_len".

Al, do you see any problems in this?  I bet a lot of /proc files will fit
this model, and need only a fairly simple "fillme()" function..

Also note that because we cache _one_ entry, we absolutely _guarantee_
that a user that just does consecutive "read()" calls will never _ever_
see inconsistent lines, regardless of what his size of the read buffer is.
And if you use "lseek()", it will work as expected within reason (trivial
caution: "fillme()" has to be careful to not trip on bogus indexes, but
return an error or zero and just set next_index to something sane).

		Linus

