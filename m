Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbRDCWm3>; Tue, 3 Apr 2001 18:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132736AbRDCWmL>; Tue, 3 Apr 2001 18:42:11 -0400
Received: from web5204.mail.yahoo.com ([216.115.106.85]:16903 "HELO
	web5204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132636AbRDCWl4>; Tue, 3 Apr 2001 18:41:56 -0400
Message-ID: <20010403224115.3664.qmail@web5204.mail.yahoo.com>
Date: Tue, 3 Apr 2001 15:41:15 -0700 (PDT)
From: Rob Landley <telomerase@yahoo.com>
Subject: Repeatable hang in 2.4.3 with 4 ide drives.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to make 3 copies of a 40 gig IBM deskstar
IDE drive.  I've got red hat 7 booted into single user
mode, doing the following:

cat /dev/hda | count | tee /dev/hdb | tee /dev/hdc >
/dev/hdd

The copy seems to work fine if I never let the console
blank.  I copied 2 gigs worth of data (at about 1.5
megabytes/second) by hitting the shift key every few
minutes.  It never even paused.

It also hasn't been having problems copying just hda
to hdb.  It's adding hdc and hdd into the mix that
triggers the hang.  I suspect the two IDE controllers
are fighting somehow.

Unblanking the screen locks it solid semi-reliably, 3
of the 4 times I've let it do that.  (Perhaps console
blanking/unblanking causes a latency spike?  The
console unblanks but the red hard drive writing light
goes off instantly and the progress display "count"
gives you stops moving.  The kernel's still there,
num-lock changes the keyboard light, but I can't
ctrl-c out of the process.)

The one time it continued writing after unblanking it
hung again a minute or so later, unblocked itself
after thirty seconds or so, and then hung again and
stayed that way for five minutes until I turned it
off.  It was not happy.

"count" is a ten-line program I wrote to read data
from stdin and write it back to stdout with a progress
indicator going to stderr.  (fprintf(stderr,"%lld
bytes\r",bytecount);  In a loop.  Woo.))

The chipset is sis 5513.  The 4 IBM deskstars are
ata66 drive with an ata66 cable but the 2.4.3
unconditionally refuses to allow me to switch on DMA
on any of them.  (hdparm -d1 /dev/hda goes operation
not permitted.)  I left it off for this test cause I
just want to get it to work at the moment.  I have
tried it with -c1 and without -c1, it hangs either
way.

Rob

(Yes, I'm copying the mounted drive's block device out
from under it.  It's a bit impolite to the system, but
I've done this lots of times.  That's why I boot into
single user mode and sync beforehand.  Yes, the new
drive fscks on the way back up, but since nothing's
actually changing the data it's fine.  This is a
seperate issue, even if I was copying hosed data it
still shouldn't be hanging.)

Update: back to the ide0 only master-to-slave copy. 
"cat /dev/hda | count > /dev/hdb".  It's done 3 gigs
so far with no complaints, and I let it blank and
unblank twice now and it didn't even pause.

Also, the single controller copy is going
significantly faster (about twice as fast) even though
the two drives still share the same cable.  Are the
two ide controllers sharing some kind of lock?  (The
data SHOULD be able to go in paralell,  but it doesn't
look like it was...  I thought the google guys had a
patch for that back at ALS...?)

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
