Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129857AbQLAXzm>; Fri, 1 Dec 2000 18:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129891AbQLAXzc>; Fri, 1 Dec 2000 18:55:32 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:16023 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129857AbQLAXz0>; Fri, 1 Dec 2000 18:55:26 -0500
Message-ID: <3A283409.C6DEFDB9@uow.edu.au>
Date: Sat, 02 Dec 2000 10:28:09 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Alexander Viro <viro@math.psu.edu>, Jonathan Hudson <jonathan@daria.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au>,
		<3A26C82D.26267202@uow.edu.au>; from andrewm@uow.edu.au on Fri, Dec 01, 2000 at 08:35:41AM +1100 <20001201141659.A4562@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Fri, Dec 01, 2000 at 08:35:41AM +1100, Andrew Morton wrote:
> >
> > I bet this'll catch it:
> >
> >  static __inline__ void list_del(struct list_head *entry)
> >  {
> >       __list_del(entry->prev, entry->next);
> > +     entry->next = entry->prev = 0;
> >  }
> 
> No, because the buffer hash list is never referenced unless
> buffer->b_inode is non-null, so we can't ever do a double-list_del on
> the buffer.

You are right.  An overnight diskthrash with the above patch didn't
oops, but it turned up three instances of the EXT2 directory warnings.

Incidentally, there's something wrong in blockdev/VM land. The
overnight run consisted of:

- one looping instance of `dbench 4 ; sleep 120'
- one looping instance of 'lmbench ; sleep 120'
- one looping instance of `bonnie++ ; sleep 120'
- one looping instance of `mmap001;mmap002;misc001;sleep 120'

Things which went wrong (after ten hours):

- the first dbench run never completed.

- the first bonnie++ run never completed.

- I then killed everything with ALT-SYSRQ-T.  It's been 20 minutes
  now and the disk LED is *still* hard on.  This machine has 256 megs
  and the hdparm disk bandwidth is 20 megs/sec.

You can observe the latter problem pretty easily by running `misc001' on
its own.  Kill it after 20 seconds and the disk remains active for *ages*.
Usually ninety seconds.  Long enough to write all physical memory out
ten times...
 
> The patch below should fix it.  It has been sent to Linus.  The
> important part is the first hunk of the inode.c diff.

Okay, will test.  (25 minutes now.  It's fsck time...)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
