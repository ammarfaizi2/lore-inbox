Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268673AbTBZH2a>; Wed, 26 Feb 2003 02:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268674AbTBZH2a>; Wed, 26 Feb 2003 02:28:30 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:14043 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268673AbTBZH23>; Wed, 26 Feb 2003 02:28:29 -0500
Date: Wed, 26 Feb 2003 18:45:42 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Software Suspend Functionality in 2.5
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046238339.1699.65.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Pavel and I have been discussing what functionality should be in
software suspend, and I wanted to ask your opinion since you're the
final decision maker anyway.

Under 2.4, I've added a lot functionality which has recently been merged
by Florent (swsusp beta 18). This functionality brings us as close as I
can get to the point where what you have in memory when you initiate the
suspend is very close to what you have when you finish resuming.
Settings on the proc interface and the amount of swap available do mean 
the degree to which this is true varies - you can set a soft limit on
the image size, for example - but that's the gist of the changes. I
implemented all the changes because as a user, I wanted the system to be
as responsive as possible upon resume - I didn't want a ton of thrashing
and an unresponsive system while processes tried to get back whatever
had been discarded or forced to swap. Performance with the changes does
not seem to be degraded, even though pages are currently write
synchronously (batching of requests is in the pipeline).

Where the rubber hits the road, I guess, is that the process is a bit
more complicated than the one in the kernel at the moment:
- Rather than freeing memory until no more can be freed, memory is freed
until the image fits in available swap, will be able to be saved and
reloaded and meets the user's size limit. (The limit can be disabled by
setting it to zero. If we can't reduce the image size to the requested
amount (eg the user requests a 1MB image), we continue anyway - hence
the description of 'soft limit' above.
- Pages to be saved are put into two categories - those we definitely
won't need during suspend and those that might/will be needed (simple
algorithm). The two sets of pages are saved separately - those not
needed are saved directly to disk, those needed are later copied and
then the copy is saved (as per current algorithm).
- Since we're saving more pages, we need more pages for the pagedir
(index). Unlike now, we probably won't be able to allocate (say) a
hundred contiguous set of pages, so we need to be able to have a
scattered (discontiguous) pagedir.
- We also need to be careful to free buffers & swap cache generated
during the save/resume process, so as to not corrupt the image.

Naturally there are other changes, but perhaps the simplest comparison
is to say that the 2.5.62 suspend.c is 34549 bytes (suspend.o 25132),
whereas beta18 is 77945 bytes (suspend.o 53756 with all the debugging
code turned off).

So can we please get your thoughts? Would you be willing to accept these
additions when they're ready?

Regards,

Nigel

