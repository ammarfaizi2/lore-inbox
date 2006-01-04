Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWADKnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWADKnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWADKnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:43:46 -0500
Received: from affenbande.org ([81.169.150.36]:51437 "EHLO
	tarzan.affenbande.org") by vger.kernel.org with ESMTP
	id S1751659AbWADKno convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:43:44 -0500
Date: Wed, 4 Jan 2006 11:37:26 +0100
From: tapas <tapas@affenbande.org>
To: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060104113726.3bd7a649@mango.fruits.de>
In-Reply-To: <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
References: <s5h1wzpnjrx.wl%tiwai@suse.de>
	<20060103203732.GF5262@irc.pl>
	<s5hvex1m472.wl%tiwai@suse.de>
	<9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	<20060103215654.GH3831@stusta.de>
	<20060103221314.GB23175@irc.pl>
	<20060103231009.GI3831@stusta.de>
	<Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	<20060104000344.GJ3831@stusta.de>
	<Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
	<20060104010123.GK3831@stusta.de>
	<Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
Reply-To: mista.tapas@gmx.net
Organization: affenbande
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 03:51:09 +0100 (CET)
Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl> wrote:

> After four years ALSA development quality of sound support in Linux is IMO 
> on the ~same (still bad) level as four years ago. Still to complicated 
> but now more bloated and additionaly not ready for handle fancy gadgets 
> like BT headsets.

Hi,

i want to chime in here in the defense of ALSA. ALSA is vastly superiour
for musicians using linux as opposed to a mere music consumer. Right,
for a music consumer (mp3s, cd's, etc), OSS was probably easier to setup
and use, but there's other advantages of ALSA vs. OSS:

- userspace software mixing (or better software mixing at all. OSS
doesn't have this (the libre version in the kernel, not the closed
source proprietary one)

- userspace resampling (i.e. you have crappy AC97 card that sounds like
shit when resampling automatically? Use the ALSA resampler. It might
sound like shit, too, but at least it can be fixed ;)

- the biggest benefit for me: MIDI routing in between any number of
applications.

- more capable (more complicated yeah but wtf :)) mixer implementation
(the thing to control the volumes, etc)

- way more flexible in handling more than one soundcard/device, etc..

Drawbacks yet:

- complicated device naming scheme. There has been recent changes in
this area to build up a list from which the user can select a device.

- so so documentation: 

-- many apps still use the ALSA api wrongly due to the complex nature of
it and lacking tutorials, etc (for example: ALSA apps should always use
the "default" device if not otherwise indicated by the user. The user
must be able to enter any device identifier string, or additionally
select from the newly built ALSA provided choices list).

-- Users get frustrated often, too, because their distros fail to setup
their ALSA system correctly. Documentation does exist, but it's often of
a technical nature, which is too much for joe user. 

- a single badly behaved OSS app can kill the whole software mixing
setup, leaving the user with seemingly hanging applications. This is
IMHO completely unacceptable. ALSA devs have, more than once, stated
that it is perfectly well acceptable for them :(

- there's two reasons for above:

-- ALSA's kernel level OSS emulation (as opposed to aoss) cannot provide
software mixing. As aoss cannot provide OSS emulation to all OSS apps,
the kernel level OSS emu must be fixed. I would probably have a look at
FUSE to redirect OSS access to userspace. I suppose oss2jack could be
modified to use ALSA instead of jack.

-- ALSA's default open mode is "blocking". But the ALSA API uses the
term blocking in two meanings and throws them together into the open
mode of a pcm device. Normally on device files, blocking access means a
read()/write() returns, when there's data which has actually been
read/written to the device. nonblocking access means, read()/write()
return immediately. In ALSA blocking mode means above _plus_ that the
open call will only immediately return (in case of contention) when the
previous user of the audio device has given it up. 

The combination of the last two is deadly :) It leaves users with
nonfunctional sound plus seemingly hanging apps when their soundcard is
not hardware mixing capable. So IMHO, to fix these two issues really is
the most pressing matter of all, but like i said, sadly ALSA devs seem
to disagree (i haven't followed ALSA development that closely lately
though).

> On other systems (MOX, Win*, Solaris ..) on handle sound situations is now 
> better than four years ago. IMO this allow form conclution: generaly 
> current ALSA is step back compare to other systems and probaly Linux need 
> some deeper work then simple polishing sound device drivers.

ALSA is a definitive step forward from OSS. It even is superior to the
original windows sound system (except for ease of configuration - but
windows had no interapp midi routing (extra software needed) plus you
need another audio device driver system (ASIO) to get reliable low
latency operation, and even there it still sucks compared to
linux/ALSA/jack/-rt). MAC OS X almost got it right. Their design has
another drawback though which makes OS X always have ca. 1 period of
latency more. I.e. in terms of low latency operation for musicians with
jackd and -rt kernels, linux is ATM the _superior_ platform.

It is, when setup correctly simply a joy to work with and make music
with.

Regards,
Florian Schmidt
