Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbTH1VCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTH1VCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:02:38 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:59778 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262979AbTH1VCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:02:36 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Ed Sweetman <ed.sweetman@wmich.edu>
Date: Thu, 28 Aug 2003 23:02:24 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: mem issues with G450 and matroxfb
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <B744FD65069@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 03 at 14:55, Ed Sweetman wrote:
> 
> I'm aware that the accel features of matroxfb (ala 2.5/2.6) can only
> take advantage of the lower 16MB of a 32MB G450 card.  My question
> revolves around the fact that fbset -i tells me my card has 16MB even
> though dmesg reports the driver detecting 32MB like it should.  

It reports 16MB because 16MB is only memory you can use with matroxfb.
Any mode set which would consume more than 16MB of memory would fail, and
for preventing this from happenning matroxfb reports only 16MB. Actually
it can report even less - memory used by mouse cursor and by secondary
head is not reported as available on primary head too.

If you have nothing to do, you can send me patch which will overcome
this 16MB limitation by using SRCORG and DSTORG registers. Only problem is
that transfers > 16MB have to be split into couple of separate steps.
And if you are going to use SRCORG/DSTORG registers, you MUST fix mga
driver in XFree to not access accelerator when they are not on foreground. 
Otherwise you may end up with accelerator painting into the main memory, 
causing spectacular crashes.

> Now on top of this. X seems to not be using the mtrr's that the matroxfb
> driver setup.
> mtrr: no MTRR for e4000000,1000000 found
> is what X reports according to dmesg.  and xfree86.log shows this as
> what is being requested.
> 
> This is what is in my /proc/mtrr file for the video card.
> reg02: base=0xe4000000 (3648MB), size=  32MB: write-combining, count=3
> reg05: base=0xe0000000 (3584MB), size=  64MB: write-combining, count=1
> 
> One appears to be the video card's memory, the other agp's access to
> system memory.
> 
> Perhaps this is due to the 16MB visible thing? Is fbset just reporting 
> wrong? How can i tell if i'm really only accessing 16MB of my card's 
> memory or if i actually am utilizing all of it?

Bug XFree people. They are trying to find 16MB mtrr range, and they miss
that there is already single 32MB one which covers both primary and
secondary heads. It is even worse: if they find such range, they remove
it on exit (XF4.2.1).
                                                Petr
                                                

