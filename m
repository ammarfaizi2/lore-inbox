Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVASWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVASWPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVASWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:15:23 -0500
Received: from modemcable240.48-200-24.mc.videotron.ca ([24.200.48.240]:24705
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261937AbVASWLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:11:13 -0500
Date: Wed, 19 Jan 2005 17:10:47 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
cc: Jonas Munsin <jmunsin@iki.fi>, Simone Piunno <pioppo@ferrara.linux.it>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
In-Reply-To: <20050119215209.77950499.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.61.0501191608010.5315@localhost.localdomain>
References: <200501080150.44653.pioppo@ferrara.linux.it>
 <20050108172020.64999e50.khali@linux-fr.org> <200501082023.54881.pioppo@ferrara.linux.it>
 <200501102023.44847.pioppo@ferrara.linux.it> <20050110203427.5061cf0d.khali@linux-fr.org>
 <Pine.LNX.4.61.0501191448160.5315@localhost.localdomain>
 <20050119215209.77950499.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1369728004-1106172647=:5315"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1369728004-1106172647=:5315
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 19 Jan 2005, Jean Delvare wrote:

> Hi Nicolas,
> 
> > FWIW, I have a Gigabyte motherboard with an it87 chip too.  Reading 
> > about this it87 polarity thing I'm suspecting something is really
> > wrong  here:
> > 
> > When system is idle, the sensors report shows:
> > CPU temp = +25°C and CPU fan = 2136 RPM (and rather noisy)
> > 
> > When system is 100% busy (with dd if=/dev/urandom of=/dev/null):
> > CPU temp = +41°C and CPU fan =   1288 RPM (and obviously much quieter)
> > 
> > I'm running a 2.6.10 kernel (not -mm) so I guess the BIOS settings for
> > fan control are not altered.  And incidentally the BIOS has a setting 
> > called "smart fan control" set to "enabled" which maps to the ITxxF 
> > automatic PWM control mode I suppose.  So if the BIOS actually set the
> > fan polarity wrong then the fan would slow down when the temperature 
> > rises and vice versa, right?
> 
> That's right, what you describe really sounds like a wrong polarity
> setting.
> 
> Could you please tell us what model it is, with what BIOS revision?

>From dmidecode:

        BIOS Information
                Vendor: Award Software International, Inc.
                Version: F5
                Release Date: 11/01/2004

        Base Board Information
                Manufacturer: Gigabyte Technology Co., Ltd.
                Product Name: 8I915GMF
                Version: x.x
                Serial Number:

> I would also appreciate a dump of the chip (isadump 0x295 0x296 unless 
> it lives at some uncommon address) to confirm the guess.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 10 80 00 37 ff 00 37 ff 07 13 5b 00 51 40 ff
10: fe fe ff 71 d7 fe 7f fe 00 00 ff ff ff ff ff ff
20: 53 a4 cc b9 b9 89 8b ff c9 c9 fe 19 60 f7 f7 f7
30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
40: 7f 7f 7f 7f 46 7f ff ff 2d ff ff ff ff ff ff ff
50: ff 1c 7f 7f 7f ff 5f 5f 90 5f f9 12 55 00 00 00
60: ff 14 41 23 82 23 ff ff 7f 7f 7f 00 00 7f ff ff
70: ff 14 41 23 82 23 ff ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 ff ff ff ff 40 40 ff ff ff ff ff ff
90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

> The code Jonas and I have been adding to the it87 driver recently will
> probably not work for you if you leave the "smart fan control" enabled
> in your BIOS setup screen (because we supposed that no reponsible
> motherboard maker would enable this mode without properly configuring
> the polarity beforehand - wrong guess in your case - and are not
> allowing a polarity inversion in this case).

Heh... and it's the default value.

> However, by disabling this
> mode in the BIOS setup screen, you should be able to use the new
> fix_pwm_polarity module register to get the polarity fixed, with manual
> PWM control (no auto mode yet).

I guess the BIOS setting will simply be overwritten so changing the BIOS 
should not affect subsequent use, no?

> You might also search for a BIOS update for your board. I consider the
> behavior your describe a major problem and would expect Gigabyte to fix
> it at some point in time.

Well... I can't find a straight BIOS update for this board.  There is a 
Windows application to fetch and install a new BIOS from the net but 
installing Windows on this machine just for that is not really 
practical.


Nicolas
--8323328-1369728004-1106172647=:5315--
