Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbQLBVeu>; Sat, 2 Dec 2000 16:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130498AbQLBVel>; Sat, 2 Dec 2000 16:34:41 -0500
Received: from hera.cwi.nl ([192.16.191.1]:21403 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130449AbQLBVee>;
	Sat, 2 Dec 2000 16:34:34 -0500
Date: Sat, 2 Dec 2000 22:03:21 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200012022103.WAA17527.aeb@kaneel.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: usbdevfs mount 2x, umount 1x
Cc: jbglaw@lug-owl.de, randy.dunlap@intel.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just noticed a nonsense thread on mount/umount, entirely about
trivialities, but people are studying strace output as if
there is something here that is not well-understood.

I missed the start of this thread but just retrieved it
from a friendly archive.


Randy Dunlap wrote on 29 Nov 2000 16:47:27

: % mount usb /proc/bus/usb -t usbdevfs
: % mount usbdevfs /proc/bus/usb -t usbdevfs
: % umount usbdevfs
:
: and I can't rmmod usbcore.

Of course not, you undid one mount but not the other
so usb is still in use. You need one more umount.


Alexander Viro wrote:

: So umount it twice.

Indeed.


Randy Dunlap wrote:

: I don't see a way to umount it twice or I would have done that.
: Is there a way?

Yes, of course. You just say

% umount /proc/bus/usb


Alexander Viro wrote:

: Erm... Say umount one more time?

Indeed.


Randy Dunlap wrote:

: Looks to me like umount unmounted it 2 times
: I don't see a way for me to rmmod usbcore.
: As it is, I have to reboot the system (or just DDT).

No, umount just does a single umount.
You have to call it once more and all is fine.


Alexander Viro wrote:

: Bug in umount(8). I bet that the second time
: it didn't even call umount(2)

But there is no evidence at all that Randy ever called
umount a second time. Umount just works correctly and
as expected, as far as the kernel interface is concerned.
I do not think there is a bug in the sense that umount(2)
is not called.

Something else is the question of what should happen with
/etc/mtab. Until now umount(8) has happily done an umount
even without any entry in /etc/mtab. After all, there is
no reason to suppose that the /etc/mtab contents is up-to-date.
Indeed, /etc/mtab is just a random file without intrinsic meaning.
This also means that the number of umount calls (one) need not
equal the number of lines removed from /etc/mtab (zero, one, more).
Now that things have changed, umount should probably not try to
remove more than one line. I just changed umount.

Andries


[PS - Possibly part of the confusion is that in the good old
days "umount dev" and "umount dir" were equivalent.
They no longer are, you must always say "umount dir".
Of course umount(8) is friendly enough to convert your
"umount dev" into "umount dir", but can do that only when
/etc/mtab still has a "dev dir type .." line.]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
