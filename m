Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbRFFLk7>; Wed, 6 Jun 2001 07:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbRFFLkt>; Wed, 6 Jun 2001 07:40:49 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:24547 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261894AbRFFLkn>; Wed, 6 Jun 2001 07:40:43 -0400
From: Stefan.Bader@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: andrea@suse.de
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A63.0040224E.00@d12mta05.de.ibm.com>
Date: Wed, 6 Jun 2001 13:40:29 +0200
Subject: [Question]: end_buffer_io_async() dilemma
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,

I know you are surely overworked, but I am not sure who else may know
enough about this
buffer_head/page cache stuff... Feel free to ingore this if you havn't got
the time.

What I try to do:
Adding multipath support to the LVM. One part of this is to get informed
whenever an IO
completes to do set some counters. I thought it would be a clever idea to
save the old
b_end_io and b_private values and replace them with my end_io function and
the pointer
to the saved data. At the end of my_end_io I restore the data and call the
original b_end_io.

# Savepointers
save = kmalloc(sizeof(savestruct),...);
if(save) {
        save->old_end_io = bh->b_end_io;
        save->old_private = bh->b_private;
        bh->b_end_io = my_end_io;
        bh->b_private = save;
}

...

# Restore
save = bh->b_private;

bh->b_end_io = save->old_end_io;
bh->b_private = save->old_private;
kfree(save);

bh->b_end_io(bh, uptodate);


First all seemed ok. As I have no real hardware to test multipathing, I
came to the idea of
using to loop devices that point to the same file. As I asked some
colleques this is a bit
weird, but should work since the loop.c code uses file access to write and
the LVM code
takes care that no overlapping blocks are written.
Doing some basic test (writing random data to the pseudo multipath device
and at the same
time to a normal device, then comparing the two) it seemed the idea worked
(linux-2.4.0 plus
loop6.patch)

But then (since about linux-2.4.4, the loop.c code changed a bit the way
it accesses files) I got
kernel bug in buffer.c line 826. First I suspected the loop.c code to be
responsible but on a
second glance the problem is that a page that contains buffer_head's get
unlocked a second
or third time. It seems that end_buffer_io_async() assumes that the page
is ready to be unlocked
by checking the circular list of b_this_page buffer_heads and if there is
no other buffer_head with
b_end_io==end_buffer_io_async and with the buffer_head locked.
But since I replace b_end_io in some buffer_heads I guess sometimes the
check fails!

# in buffer.c: end_buffer_io_async...
tmp = bh->b_this_page;
while(tmp != bh) {
        if(tmp->b_end_io == end_buffer_io_async && buffer_locked(tmp))
                goto page_still_busy;
        tmp = tmp->b_this_page;
}
# Assume page is done here...

Now I am in deep trouble. I don't understand enough of all this
buffer/page caching to tell why
the function pointer is important to tell whether the page can be
unlocked.
Would it help to create a new buffer_head and save the old one in
new_bh->b_private (like
the loop device does) or could this bh end up in a page where buffer_heads
with b_end_io =
end_buffer_io_async that would give away that page when my request ist
still going... ?
Beside I imagine this would not help the performance of mutlipathing... :(
So, is there a nice way to get that hook into end_io?

Regards,
Stefan

IBM Development, Germany
Linux for eServer development
Stefan.Bader@de.ibm.com
----------------------------------------------------------------------------------

  When all other means of communication fail, try words.


