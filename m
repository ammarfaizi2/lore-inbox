Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLANBU>; Fri, 1 Dec 2000 08:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQLANBK>; Fri, 1 Dec 2000 08:01:10 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:49568 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129210AbQLANBB>; Fri, 1 Dec 2000 08:01:01 -0500
Message-ID: <3A279ABD.957C0EF@uow.edu.au>
Date: Fri, 01 Dec 2000 23:34:05 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au> <3A26F77B.2800C58D@asiapacificm01.nt.com>,
		<3A26F77B.2800C58D@asiapacificm01.nt.com>; from morton@nortelnetworks.com on Fri, Dec 01, 2000 at 12:57:31AM +0000 <20001201131814.C21309@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Fri, Dec 01 2000, Andrew Morton wrote:
> > Andrew Morton wrote:
> > >
> > > I bet this'll catch it:
> > >
> > > --- include/linux/list.h.orig   Fri Dec  1 08:33:36 2000
> > > +++ include/linux/list.h        Fri Dec  1 08:33:55 2000
> > > @@ -90,6 +90,7 @@
> > >  static __inline__ void list_del(struct list_head *entry)
> > >  {
> > >         __list_del(entry->prev, entry->next);
> > > +       entry->next = entry->prev = 0;
> > >  }
> > >
> > >  /**
> > >
> > > First person to send a ksymoops trace gets a cookie.
> >
> > mmmm... choc-chip.
> >
> > With the above patch applied the machine crashed after an hour. Crashed
> > a second time during the e2fsck.  gdb backtrace:
> 
> Very interesting. IDE / SCSI?

hmm..  Overlapping emails.

The crash with e2fsck was easily repeatable with the above patch.  Just
dirty a few buffers and run /sbin/sync.  It's due to the __make_request
queue_head thing which you fixed in test12-pre3.  Yes, this was IDE.

However the original problem of a list_del being performed on a wild
pointer is being seen on SCSI systems.  I expect the above patch will
catch it if it's still happening.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
