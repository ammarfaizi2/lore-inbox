Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266179AbSLIVQr>; Mon, 9 Dec 2002 16:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSLIVQr>; Mon, 9 Dec 2002 16:16:47 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43906 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266179AbSLIVQq>; Mon, 9 Dec 2002 16:16:46 -0500
Message-Id: <200212092124.gB9LOL3J007516@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 - sound driver issues with i810_audio
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-69212871P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Dec 2002 16:24:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-69212871P
Content-Type: text/plain; charset=us-ascii

(please cc: on replies)

Dell Latitude C840.  Under 2.4.18, sound works adequately, using these drivers:

Intel 810 + AC97 Audio, version 0.21, 14:20:41 Jun  5 2002
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH3 found at IO 0xdc80 and 0xd800, IRQ 11
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x4352:0x595b (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
ac97_codec: AC97 Modem codec, id: 0x5349:0x4c21 (Unknown)

Under 2.5.50, I'm using:

intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801CA-ICH3 at 0xd800, irq 11

Sound almost-kinda-sort of works - audio comes out, and sometimes sounds OK,
but there seems to be a buffering issue.  Short bursts of audio (less than a
few seconds) work OK, but longer audio clips tend to break up into distortion.
The odd part is *how* it breaks up.

I've been testing with a several-second audio clip I generated with Festival,
a female voice saying "New mail from I B M I-source List Server".  When I
play it, "New mail from" is almost always OK, sometimes all of it is OK, and
usually it loses it about halfway through.  What comes out sounds like:

New Mail from I B I-sour<M>ce <distorted>list server  st server"

Yes, it sounds like it's taking about half the frames and delaying them a chunk
of time.  The distortion sounds like transients caused by the discontinuities
between frames.  Looking at the code, it seems like the driver is sometimes
managing to get "behind" when adding frames to the ring buffer, so some of
the frames have to wait for a complete loop through before they get output,
or "ahead" so they're played now rather than in proper order, or something.

sound/core/pcm_lib.c has this warning:

/* CAUTION: call it with irq disabled */
int snd_pcm_update_hw_ptr(snd_pcm_substream_t *substream)
{

and a race condition on the various hw_ptr variables *would* explain the
symptoms I'm seeing.  For what it's worth, everything listed in 'lspci' is
on IRQ 11.  I'm wondering if CONFIG_PREEMPT is allowing something else to
get called that unblocks IRQ 11 when pcm_lib thinks it's blocked - but I've
tested this mostly under near-zero loads - no CPU or paging pressure.  Also,
my 2.4.18 kernel has the PREEMPT patches on it as well, so I'm not TOTALLY
convinced they're to blame....

This ring any bells? Any advice how to proceed debugging?
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-69212871P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE99QoFcC3lWbTT17ARAkH8AJ4kMENss6/KUVhZmopUZk59xVUAjACgxPZz
roCjnhgxNzT6G+ab3z5Goro=
=hjER
-----END PGP SIGNATURE-----

--==_Exmh_-69212871P--
