Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135205AbRDLPqB>; Thu, 12 Apr 2001 11:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135208AbRDLPpn>; Thu, 12 Apr 2001 11:45:43 -0400
Received: from foo-bar-baz.cc.vt.edu ([128.173.14.103]:15492 "EHLO
	foo-bar-baz.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S135207AbRDLPpI>; Thu, 12 Apr 2001 11:45:08 -0400
Message-Id: <200104121544.f3CFiwo09924@foo-bar-baz.cc.vt.edu>
X-Mailer: exmh version 2.3.1 01/19/2001 with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad? 
In-Reply-To: Your message of "Thu, 12 Apr 2001 16:12:55 BST."
             <E14nimI-0000oY-00@the-village.bc.nu> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
In-Reply-To: <E14nimI-0000oY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-479699968P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Apr 2001 11:44:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-479699968P
Content-Type: text/plain; charset=us-ascii

On Thu, 12 Apr 2001 16:12:55 BST, Alan Cox said:
> > I've seen the same scenario about 2-3 times a week.  kswapd and one or
> > more processes all CPU bound, totalling to 100%.  I've had 'esdplay' hung
> > on several occasions, and 2-3 times it's been xscreensaver (3.29) hung.
> > The 'hung' processes are consistently immune to kill -9, even as root, which
> > indicates to me that they're hung inside a kernel call or something.
> 
> Do you have > 800Mb of RAM ?

256M of RAM, 256M of swap.

Here's /proc/meminfo as I type:
[~]3 cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  260276224 246419456 13856768        0  8347648 75317248
Swap: 271392768 58589184 212803584
MemTotal:       254176 kB
MemFree:         13532 kB
MemShared:           0 kB
Buffers:          8152 kB
Cached:          73552 kB
Active:          49716 kB
Inact_dirty:     28800 kB
Inact_clean:      3188 kB
Inact_target:      212 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254176 kB
LowFree:         13532 kB
SwapTotal:      265032 kB
SwapFree:       207816 kB
[~]3 

> > would explain the high context-switch rate.  I'm not clear on how kswapd
> > can end up getting stuck and failing to free up something - unless it ends
> > up calling __alloc_pages itself indirectly and the PF_MEMALLOC bit isn't
> > enough to get it the memory it needs, causing a deadlock/loop between
> > kswapd and __alloc_pages/wakeup_kswapd().
> 
> bounce buffers for one

It's a Dell Optiplex GX110, using IDE.  Grepping for 'bounce buffer' in
the source shows most hits in the SCSI code, and nothing obviously jumping
out at me...

<just speculating> Is it possible that i810_audio.c is to blame? I'm looking
at alloc_dmabuf() in there, and it tries to grab a big chunk of memory
for a DMA buffer (starting at order-4), which probably explains my __alloc_pages
messages.  In addition, I run Enlightenment with audio enabled - so it's
quite possible that xscreensaver will generate a 'click' sound when it
pops up its dialog window - again tossing us into i810_audio. (scenario
there - mouse event happens while screen locked, xscreensaver wakes up and
starts mapping a window - E plays the sound, hosing the i810_audio driver,
and then when xscreensaver gets the CPU back, its next call for a page
gets wedged up.

Would it be worth applying Ed Tomlinson's icache/dcache patches and seeing
if that helps?


-- 
				Valdis Kletnieks
				Operating Systems Analyst
				Virginia Tech



--==_Exmh_-479699968P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8
Comment: Exmh version 2.2 06/16/2000

iQA/AwUBOtXNd3At5Vm009ewEQIOrQCg4L09WcVlZtKxmSXDOf7QF6wuhYAAn0Pl
UTjCIJAIl3qFE44F1xNlEQ0h
=7yAZ
-----END PGP SIGNATURE-----

--==_Exmh_-479699968P--
