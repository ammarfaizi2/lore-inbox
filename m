Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWAGBZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWAGBZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWAGBZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:25:14 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:10503 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932673AbWAGBZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:25:12 -0500
Date: Sat, 7 Jan 2006 01:56:45 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>,
       linux-sound@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060107005645.GA67447@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jaroslav Kysela <perex@suse.cz>,
	ALSA development <alsa-devel@alsa-project.org>,
	linux-sound@vger.kernel.org
References: <s5hpsn8md1j.wl%tiwai@suse.de> <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr> <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de> <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr> <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe> <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <20060106034026.c37c1ed9.diegocg@gmail.com> <20060106145723.GA73361@dspnet.fr.eu.org> <Pine.LNX.4.61.0601061938390.10811@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601061938390.10811@tm8103.perex-int.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 09:26:42PM +0100, Jaroslav Kysela wrote:
> You're proposing to add more content switches versus current ALSA 
> implementation:
> 
> user space <-> kernel
> 
> While your daemon requires:
> 
> user space <-> kernel <-> user space (daemon)

Dmix _is_ a context switch, you know?


> So your solution is even more realtime and proper scheduling dependant.
> Unfortunately, Linux kernels still do not have perfect realtime behaviour 
> (mostly due to broken drivers etc.).

You only get context switches if you go through plugins, which is
pretty much the same way alsa currently is, isn't it?


> Also, the API is completely irrelevant from this scheme. If daemon does 
> everything, the ALSA kernel API can go public and documented (altough I 
> still does not agree with it - see bellow).

The ALSA kernel API better go documented soon or I'll have to document
it myself.  Security and openness-wise, it is just not acceptable to
have a user-accessive kernel API kept under wraps.


> > ALSA does not have a documented kernel interface nor an optional
> > library but a mandatory library.  A highly complex, ipc-using library
> 
> It's also not very true. You can create your own ALSA library,

After reverse-engineering your kernel interface.  How convenient.


> but this library will not be supported with our team.

Of course.  You won't have to though, since you claim the API is
upwards compatible.


> The ALSA from 1.0 version is 
> binary compatible (even 0.9.0rc4+ linked applications should work) and old 
> ioctls are emulated.

Good.


> I'd like to point that this code runs with standard user priviledges. I 
> think that the security things are and should be in a different place (in 
> the kernel). If IPC is broken, other applications (not only using sound) 
> might be broken.

Every application that does inter-process communication has potential
protocol-level security issues.  Current ALSA creates two shared
memory zones and one semaphore with group write permissions.  In a
setup where a number of people are in the same group (student group
for instance), are you 100% positive that another user cannot take
control of the running application by writing the right values at the
right time in these zones?  Shared memory is the most dangerous
communication vector there is when the other application is
untrustable.


> > At least OSS, with all its flaws, is a documented kernel interface.
> > You can static link a oss-using program, whether it uses it directly
> > or through interfaces like sdl-audio, and it will just work.
> 
> Please, see your words. You're simply anarchistic. You replaced 
> flexibility of dynamic library with a possibility to have static binary.

I am indeed not really interested in reproducing the dll hell of
windows in linux.  I want simple but really efficient interfaces to
kernel services which then give the possibility to build special needs
libraries over it[1].  At that point you're designing an API for a
specific class of professional audio users and essentially telling all
the other users to bugger off.  Bad karma.


> ALSA library can be also compiled as static library, so it's not a 
> problem. The ALSA kernel API is stable.

Yeah, that's the second time you're saying that.  I'm sure Dave Jones
will be really happy to know that his impressions were mistaken and
his bugzilla was just having hallucinations:
  http://marc.theaimsgroup.com/?l=linux-kernel&m=113589615627420&w=2
  http://marc.theaimsgroup.com/?l=linux-kernel&m=113225994603627&w=2


> Also, we use symbol versions for 
> all exported functions, so all old binaries linked with the dynamic alsa 
> library will work.

Like all the programs I had which segfaulted after the alsa upgrade
that changed set_rate_near.  Beautiful versioning there guys.


> Of course, the drivers might change some universal 
> control names,

Yeah, also known as "the stick which broke jwz's back".


> Also note, that if OSS had the API in userspace from the first days,
> the emulation or redirection of this API to another API or user space 
> drivers wouldn't be so much complicated nowadays. Bummer.

It would be exactly as complicated because of the static link issue.

  OG.

[1] SDL, jack and slmodem are I think good examples
