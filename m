Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <169010-3563>; Sat, 20 Mar 1999 17:39:14 -0500
Received: by vger.rutgers.edu id <168918-3563>; Sat, 20 Mar 1999 17:38:54 -0500
Received: from neon-best.transmeta.com ([206.184.214.10]:26781 "EHLO neon.transmeta.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <168828-3562>; Sat, 20 Mar 1999 17:38:47 -0500
Date: Sat, 20 Mar 1999 14:41:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Gerard Roudier <groudier@club-internet.fr>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: disk head scheduling
In-Reply-To: <Pine.LNX.3.95.990320224514.1123A-100000@localhost>
Message-ID: <Pine.LNX.3.95.990320142738.5385U-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Sat, 20 Mar 1999, Gerard Roudier wrote:
> 
> The kernel IO-request queue is one queue and a device TASK SET is also one
> queue, the SCSI sub-system passes requests between the kernel request
> queue and device queues.

The kernel IO-request queue is NOT one queue.

This is a common misunderstanding, and I'm really fed up with it. 

The generic kernel low-level driver interface was designed to have
multiple requests queues, and the fact is that sadly the SCSI layer
doesn't understand this, so the SCSI layer uses just one queue.

The IDE driver is much better in this regard, for example. The IDE driver
uses one queue per controller, rather than one global queue. That means
that the generic code doesn't waste time trying to schedule requests for
different controllers, only schedule them on a per-controller basis.

There is indeed a global upper limit of total requests that the kernel
will queue up, but that's a separate issue or memory management, and is
actually just a single define.. It means that all IO requests are allocated
from the same pool of requests entries, but that does NOT MEAN, and has
NEVER MEANT that there is only one queue.

Sorry for shouting, but this is one of my major gripes with the SCSI
layer: it was just badly designed. And now that bad design means that
driver writers believe that the generic kernel is doing something stupid.
It isn't. It's the SCSI layer that is stupid, and it wouldn't have to be. 

Just to give you an idea: right now the generic disk interface layer in
the kernel sees only one queue for all SCSI devices, which means that it
tries to sort all the requests according to that. That obviously fails: in
the presense of multiple disks, the sorting criteria just do not make all
that much sense.

So the generic layer spends time sorting the requests onto one queue,
doesn't do a good job because of that, and then the SCSI layer spends MORE
time unsorting the requests. 

This means, for example, that while the kernel is making up a request for
one SCSI disk and has "plugged" the request queue in order to give just
one large requests to the disk, that "plug" will now plug all other SCSI
devices too - even though that wasn't the reason for doing the plugging. 

With just one controller, this usually isn't a problem, but if you have
multiple controllers you can only blame the SCSI layer if it doesn't scale
up nicely.

This is one reason why people like Leonard decide to not use the SCSI
layer at all for their newer drivers. 

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
