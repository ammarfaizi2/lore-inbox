Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310381AbSCLDri>; Mon, 11 Mar 2002 22:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310387AbSCLDr2>; Mon, 11 Mar 2002 22:47:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46348 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310381AbSCLDrK>;
	Mon, 11 Mar 2002 22:47:10 -0500
Message-ID: <3C8D7A2A.7040209@mandrakesoft.com>
Date: Mon, 11 Mar 2002 22:46:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "J. Dow" <jdow@earthlink.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111916000.18604-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
>>1) There should be a raw device command interface (not ATA or SCSI specific)
>>
>
>Well, since the raw commands themselves will be bus-specific, you can't
>really avoid THAT part.
>
>The thing I want to be generic is the fact that everybody uses the 
>"request->cmd[]" array, along with the flags in "request->flags" to 
>specify what kind of command it is.
>
>We actually have this infrastructure already, it's just not fully used.
>
I omitted "for userspace" :)

I was referring to having a userspace conduit for submitting requests, a 
la the taskfile ioctl now.


>>3) There should be capability to optionally install filter the raw 
>>device command interface.  The filter is built into the kernel at 
>>compile-time, but can also be disabled at boot time.
>>
>
>This is the part I really don't like.
>
>Thinking like a sysadmin, I want to be able to run programs that I would 
>not allow my users to run or want to be run accidentally. And I do _not_ 
>want to reboot my kernel just because one of my mirrored disks died, I 
>hot-replaced it, and I notice that I need to upgrade the firmware on the 
>thing to make it play nice with the other disks in the array.
>
>See? A setup that either allows everything or nothing is fundamentally
>flawed in this kind of situation - suddenly I as a sysadmin cannot do
>something without bringing the machine down. Which makes all the hotplug
>interfaces useless - or then I as a sysadmin just have to leave a kernel 
>in place that allows the kinds of raw command accesses that I am so scared 
>of.
>
>One solution may be to have the whole raw cmd thing as a loadable module, 
>and then I can make sure that it's not even available on the system so 
>that I have to do some work to find it, and somebody elses program won't 
>just know what to do.
>
>But in that case is should be far removed from the IDE driver - it would 
>just be a module that inserts a raw request on the request queue, and NOT 
>inside some subsystem driver that I obviously want to have available all 
>the time.
>
I like this solution, it was the one I was thinking of :)

The entire userspace raw cmd ioctl should be a separate module for 
precisely the issues you outlined.  If they choose, people can compile 
that module into the static kernel image, including filter.  Or they can 
use the module without the filter.  Or they can not use the module at 
all.  Etc.

I do understand the problems stemming from the inflexibility of the 
filter that's being discussed, but I disagree that it's a fundamental 
flaw.  It's an option that some people -shouldn't- choose, for various 
reasons.  But that's an issue for documentation and system integrators.

    Jeff



