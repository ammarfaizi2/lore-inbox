Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWAEXJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWAEXJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbWAEXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:09:12 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:26726 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1752279AbWAEXJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:09:10 -0500
Date: Fri, 6 Jan 2006 01:06:27 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <s5hmziaird8.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Takashi Iwai wrote:

> > If you have sound device without this soft mixing is moved to user space 
> > .. but  applications do not need know about this even now because all
> > neccessary details are handled on library level. Is it ?
> > So question is: why the hell *ALL* mixing details are not moved to kernel 
> > space to SIMPLE and NOT GROWING abstraction ?
> 
> Because many people believe that the softmix in the kernel space is
> evil.
This is the usual argument against kernel level mixing. Somebody has once 
said that all this is evil. However this is not necessarily correct.

OSS has done kernel level mixing for years. The vmix driver has been used 
as the default audio device by hundreds of thousands of customers for 
years. We have not received any single bug report that is caused 
by the concept of kernel mixing.

Kernel mixing is not rocket science. All you need to do is picking a 
sample from the output buffers of each of the applications, sum them 
together (with some volume scaling) and feed the result to the physical 
device. Ok, handling different sample formats/rates makes it much more 
difficult but that could be done in the library level.
 
> >    Why Linux can't provide only OSS API abstraction for user space
> >    application ? And/or why ALSA developers want to replace this by
> >    mostly bloated and pourly documented ALSA user space API ?
> 
> Because OSS API doesn't cover many things.  For example, 
> 
> - PCM with non-interleaved formats
There is no need to handle non-interleaved data in kernel level drivers 
because all the devices use interleaved formats. Handling 
interleaving/de-interleaving in the application/driver code can be done in 
a simple for loop. So why to make the driver/API more complicated with 
this.

> - PCM with 3-bytes-packed 24bit formats
Applications have no reasons to use for this kind of stupid format so OSS 
translates it to the usual 32 bit format on fly. In fact OSS API does 
have support for this format.

> These functions are popluar on many sound devices.
> 
> In addition, imagine how you would implement the following:
> 
> - Combination of multiple devices
> - Split of channels to concurrent accesses
Could you be more specific with the above isues?

> - Handling of floating pointer samples
This is not necessary in the kernel drivers because user land apps/libs do 
this themselves. However OSS API defines a floating point data type just 
in case some future device needs it.

> - Post/pre-effects (like chorus/reverb)
OSS already does this (part of the softoss/vmix driver).

> Forcing OSS API means to force to process the all things above in
> the kernel.  I guess many people would disagree with it.
Wrong. This is not an API issue at all. It's an implementation one. 

An alternative for doing some operations in the kernel is looping the 
audio data through an user land daemon. The application itself is still 
using the usual OSS API without knowing anything about any daemons. We 
have tested this approach and it works. There just has not been any good 
reason to use this approach instead of using kernel space approach. 
Passing data through multiple applications makes the latency issues to 
accumulate. If you do the processing in the kernel you will hit by the 
task scheduling latencies at most once.

The OSS approach is not to make everything in the kernel. Things that can 
be done easier in the applications (or in libraries) have been left 
out from the API.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
