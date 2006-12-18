Return-Path: <linux-kernel-owner+w=401wt.eu-S1752910AbWLRE3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbWLRE3g (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 23:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbWLRE3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 23:29:36 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:28289 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbWLRE3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 23:29:35 -0500
Date: Sun, 17 Dec 2006 23:29:13 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
In-reply-to: <4585E967.6000706@s5r6.in-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linus Torvalds <torvalds@osdl.org>,
       linux1394-devel@lists.sourceforge.net
Message-id: <200612172329.14723.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612171834.59624.gene.heskett@verizon.net>
 <4585E967.6000706@s5r6.in-berlin.de>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 December 2006 20:05, Stefan Richter wrote:
>Gene Heskett wrote:
>> The camera has been turned back off, but yes, it works absolutely
>> normally now.  With no dv1394 in memory!
>>
>> Then with the camera on and kino controlling it:
>> [root@coyote ~]# lsmod|grep 1394
>> raw1394                32264  4
>> ohci1394               39088  0
>> ieee1394              305624  2 raw1394,ohci1394
>>
>> So we still don't appear to have any use of/for ohci1394.  What the
>> heck is it supposed to be doing?
>
>What's missing in our implementation is that the use count of ohci1394
>goes up too once a "high-level driver" uses resources of a host driven
>by ohci1394.

This needs some tlc then I assume?

>The FireWire stack has three layers: Low level (ohci1394 and pcilynx;
>control the host bus adapter),
The hardware
>mid level (the ieee1394 core)
which I assume (fuggly word) steers the high level stuff to the right 
entry points in the hardware handler?
>and high level (protocol drivers: dv1394, eth1394, sbp2, video1394; and 
the
>multi-purpose bridge to userspace: raw1394). The mid level is supposed
>to isolate high-level drivers from hardware-specific drivers.

ieee1394.ko

>However dv1394 and video1394 break this architecture. Parts of them
>access ohci1394 directly.

Opps.  Bad dog, no bisquit.

>And in practice, sbp2 indirectly breaks this 
>architecture too because it never got decent DMA mapping implemented,
>and what it got in this department bitrotted to a degree that it is
>currently not really usable with pcilynx. (AFAIK, I don't have a PCILynx
>controller.)

I did, but junked it when it couldn't be made to talk to this camera.  It 
was an old card I'd bought years ago, came in a Maxtor box IIRC.  I could 
probably dig it up (I'm an inveterate packrat) and see if I could find an 
empty pci slot, but them are precious items in most systems, and test it, 
or maybe even fwd it to someone capable of investigating it.  If its 
worth the effort, I have NDI how many of them there are out there.  I 
chose to throw money at the problem, it wasn't much, $30 USD IIRC at 
WallyWorld, blisterpacked with Belkins logo on it.

>BTW, sbp2 had the same problem with missing use count of ohci1394 too
>until Linux < 2.6.17. But it's a little bit harder to get right in
> raw1394.

Humm, architectural?  I wouldn't know right from wrong as my C skills have 
rusted away over the last 15 years something awful.

>> Now, do I need dv1394 to do the export if I were to want to re-write
>> the edited video back to the tape in the camera?
>
>I suppose Kino is exporting DV via raw1394 nowadays too. Raw1394
>definitely has the means for it.

That got my curiosity bump itching, so I loaded about the first 5 minutes 
of the last wedding into kino from disk, clipped off some junk video at 
the begining, and this does use raw1394 to export back to the camera.  
Previewed it spends some time preprocessing it, about 33 seconds I'd 
guess, and then it shows on the camera's viewfinder.  So then I did the 
real export, and here it appears kino has a buglet that Dan should be 
advised of.  It starts the tape rolling while its doing this preparatory 
stuff, so its recording dead tape (I don't think its outputting black, 
but no data at all) for about 33 seconds after the camera's own preroll 
delay of about 3 seconds to load the tape around the drum.  Other than 
that, it works just fine using raw1394 to move it back to the camera and 
hence to the tape.

But, the export function screen has 5 more ways to do it.  Next tab to the 
right is DV file, with 4 methods available there,
DV avi type 1
DV avi type 2
OpenDML avi
raw DV, which I apparently have used.  There is a 5th choice, quicktime, 
but its greyed out, presumably because I don't have that library 
installed.
Next tab is Stills, with a jpeg quality slider
Next tab is audio with resampling at 3 speeds and encoding with 5 choices
Next tab is mpeg with a plethora of choices for output
Last tab is Other, currently set for std VOB and FFMPEG but has 15 choices 
in file format, and 4 in the profile selector.

All told, its a Swiss Army Knife that really needs better docs rather than 
doing something, burning it to dvd or svcd and seeing it it will play on 
the target friends machinery. You can make a lot of coasters that way.  I 
just found an Emerson TV with a builtin dvd that had no idea what to do 
with an svcd all my stuff played just fine.  This latter isn't a kernel 
problem of course.

>Anyway, I'm glad it sort of works for you now.

Yes, rather nicely except for the exports start recording dead time, a 
kino problem obviously.

Anyway, I'm a happy camper till the next time, but if by the time Dan does 
kino-1.0, that particular buglet isn't fixed, I'll still be happy as its 
otherwise a heck of a program.  It fills a niche gap that none of the 
other video processing programs even try to do.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
