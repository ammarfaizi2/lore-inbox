Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTH1V3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTH1V3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:29:13 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:32191 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264290AbTH1V3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:29:09 -0400
Message-ID: <3F4E741D.8040802@wmich.edu>
Date: Thu, 28 Aug 2003 17:29:01 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: mem issues with G450 and matroxfb
References: <B744FD65069@vcnet.vc.cvut.cz>
In-Reply-To: <B744FD65069@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> On 28 Aug 03 at 14:55, Ed Sweetman wrote:
> 
>>I'm aware that the accel features of matroxfb (ala 2.5/2.6) can only
>>take advantage of the lower 16MB of a 32MB G450 card.  My question
>>revolves around the fact that fbset -i tells me my card has 16MB even
>>though dmesg reports the driver detecting 32MB like it should.  
> 
> 
> It reports 16MB because 16MB is only memory you can use with matroxfb.
> Any mode set which would consume more than 16MB of memory would fail, and
> for preventing this from happenning matroxfb reports only 16MB. Actually
> it can report even less - memory used by mouse cursor and by secondary
> head is not reported as available on primary head too.
> 
> If you have nothing to do, you can send me patch which will overcome
> this 16MB limitation by using SRCORG and DSTORG registers. Only problem is
> that transfers > 16MB have to be split into couple of separate steps.
> And if you are going to use SRCORG/DSTORG registers, you MUST fix mga
> driver in XFree to not access accelerator when they are not on foreground. 
> Otherwise you may end up with accelerator painting into the main memory, 
> causing spectacular crashes.
> 

so basically if you have matroxfb loaded, you have 16MB of video ram 
doing nothing? Wouldn't the mga driver avoid overwriting the 
framebuffer's memory use by using the fbdev backend? I thought that's 
what the backend was basically for, to not have them dumping on eachother.


>>Now on top of this. X seems to not be using the mtrr's that the matroxfb
>>driver setup.
>>mtrr: no MTRR for e4000000,1000000 found
>>is what X reports according to dmesg.  and xfree86.log shows this as
>>what is being requested.
>>
>>This is what is in my /proc/mtrr file for the video card.
>>reg02: base=0xe4000000 (3648MB), size=  32MB: write-combining, count=3
>>reg05: base=0xe0000000 (3584MB), size=  64MB: write-combining, count=1
>>
>>One appears to be the video card's memory, the other agp's access to
>>system memory.
>>
>>Perhaps this is due to the 16MB visible thing? Is fbset just reporting 
>>wrong? How can i tell if i'm really only accessing 16MB of my card's 
>>memory or if i actually am utilizing all of it?
> 
> 
> Bug XFree people. They are trying to find 16MB mtrr range, and they miss
> that there is already single 32MB one which covers both primary and
> secondary heads. It is even worse: if they find such range, they remove
> it on exit (XF4.2.1).
>                                                 Petr

if they didn't remove it on exit, would it corrupt anything to use the 
32MB mtrr range or would it be possible to manually make the 16MB mtrr 
range overlap the 32MB mtrr range (assuming i dont run anything that 
uses the 32MB mtrr range at the same time) ?

i'm a little confused as to why the X mga driver can use all 32MB when 
using it's xaa and  such features without the framebuffer device loaded 
but the fb device can only use 16.  Is the framebuffer doing more 
aggressive optimizations where by accessing the upper 16MB would hurt 
that acceleration while the X server doesn't care or some other reason? 
If it's a performance hurting issue then ok, but if it's just a lack of 
time or something like that then i'd be willing to help take a stab at it.

