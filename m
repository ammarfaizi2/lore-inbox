Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSKVRRK>; Fri, 22 Nov 2002 12:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKVRRK>; Fri, 22 Nov 2002 12:17:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:39862 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265058AbSKVRRI>; Fri, 22 Nov 2002 12:17:08 -0500
Date: Fri, 22 Nov 2002 09:20:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
cc: Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup 
Message-ID: <1053855634.1037956835@[10.10.2.3]>
In-Reply-To: <200211221640.gAMGetJ02979@localhost.localdomain>
References: <200211221640.gAMGetJ02979@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And every other header file is under the include path ... putting them
>> all mixed in with C files is just making a mess.
> 
> No, look at e.g. SCSI.  We have a scsi.h file in drivers/scsi which defines 
> subsystem specific things that we only use within SCSI.  We have 
> include/scsi/scsi.h which defines things other subsystems can use.

The fact that it exists elsewhere does not necessarily make it a 
model to follow ...
 
>> Que? How is include/asm-i386 any more "kernel core" than arch/i386? 
> 
> Because the files are spreading.  I think there's value to keeping something 
> tightly contained unless you're going to encourage others to use it.  
> Interfaces are dangerous things: If you release them into the wild 
> willy-nilly, they can come back and bite you (athough more often they just 
> bite other people).

I think that's somewhat unlikely, but still .... let's go back to the
root of the problem here, and look at how to fix it. It seems that the
current way that subarch is implemented is not workable for current
subarches - we've gone through this before on IRC, and you agreed it
was broken, but let's do it again for the sake of argument, and so that
other people can see the problem ....

Imagine for a second that we have 5 different subarches (say visws, 
voyager, numaq, summit, generic). Assign a letter to each (ABCDE) and
a number to each of the code areas they need to modify:

A: 123456 (generic, thus needs a default for everything).
B: 12
C: 3
D: 45
E: 56

Duplicating all the code sections into all the subarches is an
impractical maintainance nightmare. Yet that's how it seems
to be set up at the moment (kind of OK if you only have 1 subarch
apart from generic, but not in general).

Let's stick to discussing header files at first ... what we need is 
to pick up the machine specific file if there is one, else fall back
and pick up the generic file. The way I'd like to see this fixed is
to have an include path statement that picks things up in order ie
append include/asm/mach-specific then include/asm/mach-generic in
the include search path. The easiest way to do that (to me) seems to
be to convert the #include "foo.h" to #include <foo.h> statements
and break things out as John did - we'll automatically pick up the
correct include file from the path.

If you have a different suggestion for fixing subarch support, please
outline it ....

Martin.




