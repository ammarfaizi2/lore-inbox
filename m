Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279022AbRJ2Fuc>; Mon, 29 Oct 2001 00:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279023AbRJ2FuV>; Mon, 29 Oct 2001 00:50:21 -0500
Received: from [63.231.122.81] ([63.231.122.81]:34108 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279022AbRJ2FuQ>;
	Mon, 29 Oct 2001 00:50:16 -0500
Date: Sun, 28 Oct 2001 22:46:16 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        "Theodore Ts'o" <tytso@mit.edu>, torvalds@transmeta.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAJOR random.c bugfix
Message-ID: <20011028224616.H1311@lynx.no>
Mail-Followup-To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	Theodore Ts'o <tytso@mit.edu>, torvalds@transmeta.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <adilger@turbolabs.com> <200110282357.f9SNv2kD011923@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200110282357.f9SNv2kD011923@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sun, Oct 28, 2001 at 08:57:02PM -0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 28, 2001  20:57 -0300, Horst von Brand wrote:
> I have now seen various bits and pieces about this flying around. To get it
> right will be hard, as over/under estimates will show up only under unusual
> circumstances; and as you _can't_ really know how much "entropy" there
> should be, testing this is very hard.  So the only way to get it right is
> make it "obviously" right.

                ********** LATE BREAKING NEWS ***********

Is add_entropy_words() broken for multi-word input???  That would be very bad.
In one most cases we are only dealing with two word inputs, but is really bad
where it counts - transferring values to the secondary pool, which is where
we really get data from for /dev/random.

It appears that we repeatedly add the first word to the entropy pool, no
matter how many words are passed!!!  I checked the kernel CVS repository,
and it has been like this since a big change in 2.3.16.  Ugh!!!

http://innominate.org/cgi-bin/lksr/linux/drivers/char/random.c.diff?r1=1.1.1.4&r2=1.1.1.5&cvsroot=v2.3

Is there something I'm missing?  Even in the 2.3.16 version, we never
change "in" from its initial value, so we only use the first input word.
The older (2.2, 2.3.15-) code had it correct, in that it explicitly worked
on both of the input words.

A quick patch to fix this is below.

Cheers, Andreas

PS: what's up with new_rotate?  Why not just do it like:
	r->input_rotate = (r->input_rotate + (i ? 7 : 14)) & 31;

===========================================================================
--- linux/drivers/char/random.c.old	Sun Oct 28 22:26:31 2001
+++ linux/drivers/char/random.c	Sun Oct 28 22:25:11 2001
@@ -564,7 +564,7 @@
 	__u32 w;
 
 	while (nwords--) {
-		w = rotate_left(r->input_rotate, *in);
+		w = rotate_left(r->input_rotate, *in++);
 		i = r->add_ptr = (r->add_ptr - 1) & wordmask;
 		/*
 		 * Normally, we add 7 bits of rotation to the pool.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

