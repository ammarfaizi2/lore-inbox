Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbTH2Kkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTH2Kkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:40:47 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:63686 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264512AbTH2Kkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:40:43 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Ed Sweetman <ed.sweetman@wmich.edu>
Date: Fri, 29 Aug 2003 12:40:22 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: mem issues with G450 and matroxfb
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <B81F20E3631@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 03 at 17:29, Ed Sweetman wrote:
> Petr Vandrovec wrote:
> > On 28 Aug 03 at 14:55, Ed Sweetman wrote:
> > 
> >>I'm aware that the accel features of matroxfb (ala 2.5/2.6) can only
> >>take advantage of the lower 16MB of a 32MB G450 card.  My question
> >>revolves around the fact that fbset -i tells me my card has 16MB even
> >>though dmesg reports the driver detecting 32MB like it should.  
> > 
> > 
> > It reports 16MB because 16MB is only memory you can use with matroxfb.
> > Any mode set which would consume more than 16MB of memory would fail, and
> > for preventing this from happenning matroxfb reports only 16MB. Actually
> > it can report even less - memory used by mouse cursor and by secondary
> > head is not reported as available on primary head too.
> > 
> > If you have nothing to do, you can send me patch which will overcome
> > this 16MB limitation by using SRCORG and DSTORG registers. Only problem is
> > that transfers > 16MB have to be split into couple of separate steps.
> > And if you are going to use SRCORG/DSTORG registers, you MUST fix mga
> > driver in XFree to not access accelerator when they are not on foreground. 
> > Otherwise you may end up with accelerator painting into the main memory, 
> > causing spectacular crashes.
> > 
> 
> so basically if you have matroxfb loaded, you have 16MB of video ram 
> doing nothing? Wouldn't the mga driver avoid overwriting the 
> framebuffer's memory use by using the fbdev backend? I thought that's 
> what the backend was basically for, to not have them dumping on eachother.

Top 16MB of videoram is used as secondary head's framebuffer. Each
G400/G450/G550 presents itself as two framebuffer devices.
 
> >>This is what is in my /proc/mtrr file for the video card.
> >>reg02: base=0xe4000000 (3648MB), size=  32MB: write-combining, count=3
> >>reg05: base=0xe0000000 (3584MB), size=  64MB: write-combining, count=1
> > 
> > Bug XFree people. They are trying to find 16MB mtrr range, and they miss
> > that there is already single 32MB one which covers both primary and
> > secondary heads. It is even worse: if they find such range, they remove
> > it on exit (XF4.2.1).
> >                                                 Petr
> 
> if they didn't remove it on exit, would it corrupt anything to use the 
> 32MB mtrr range or would it be possible to manually make the 16MB mtrr 
> range overlap the 32MB mtrr range (assuming i dont run anything that 
> uses the 32MB mtrr range at the same time) ?

They should only decrement range's use count when they exit. But I'm
not sure that /proc/mtrr API available to the userspace makes this feature
somehow accessible.

You can create 16MB range which overlaps 32MB, but there is no point in doing
that... It only consumes one MTRR register, and there is very few of
them.
 
> i'm a little confused as to why the X mga driver can use all 32MB when 
> using it's xaa and  such features without the framebuffer device loaded 
> but the fb device can only use 16.  Is the framebuffer doing more 
> aggressive optimizations where by accessing the upper 16MB would hurt 
> that acceleration while the X server doesn't care or some other reason? 
> If it's a performance hurting issue then ok, but if it's just a lack of 
> time or something like that then i'd be willing to help take a stab at it.

See 'if (pMga->AccelFlags & LARGE_ADDRESSES)' in the mga_storm.c in XFree.
G450/G550 accelerators can only read from 16MB window at SRCORG, and write
to 16MB window at DSTORG. matroxfb just leaves both SRCORG & DSTORG at
zeroes. 

BTW, I did not find where XFree mga driver reinitializes accelerator
if bitblt or fill covers area larger than 16MB, so it looks to me like that
XFree driver also cannot use >16MB for on-screen memory. And as matroxfb
reports only on-screenable memory...

But splitting bitblt and fillrect on 16th MB should not be a big problem.
As I said, if someone will write it... (note that SRCORG/DSTORG are G200+,
so you must create two code paths, one for older chips, and one for G200+
(actually G450+, as older chips can address all its memory, and matroxfb
does not need accelerator painting directly to/from the main system memory)).
                                                    Petr Vandrovec
                                                    

