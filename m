Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTHYMyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTHYMyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:54:11 -0400
Received: from amdext2.amd.com ([163.181.251.1]:49077 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S261850AbTHYMyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:54:06 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C080EF010@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: pavel@suse.cz
cc: davej@redhat.com, linux-kernel@vger.kernel.org, aj@suse.de,
       mark.langsdorf@amd.com, richard.brunner@amd.com
Subject: RE: Cpufreq for opteron
Date: Mon, 25 Aug 2003 07:53:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1354D9521000134-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Sent: Monday, August 25, 2003 4:36 AM
> To: Devriendt, Paul
> Cc: davej@redhat.com; linux-kernel@vger.kernel.org; aj@suse.de;
> Langsdorf, Mark; Brunner, Richard
> Subject: Re: Cpufreq for opteron
> 
> > It appears to me that the BUG_ON() macro will take the machine
> > down ? The BUG_ON() checks in this code (a sample below, but 
> > this applies to all of the driver) are not fatal conditions - 
> > execution can continue if an error is returned. Taking the 
> > machine down to report on a non-fatal condition seems somewhat 
> > rude.
> 
> It is somewhat rude, but it makes sure that the error gets fixed. [And
> it also appears safer to me: if we know error already happened we opt
> to stop the system so nothing bad happens.]
> 
> Questions:
> 
> 1) is it possible to do hardware damage from powernow-k8 driver?

There are some cases where the hardware could be damaged if the driver
was not correct. Or, if the BIOS gave the driver bad data. The algorithms
used in the driver have been thoroughly reviewed by the hardware folk,
and the driver hammered in months of testing on multiple platforms - we
did not let the smoke out of anything.

> 2) should some of those checks be fatal?

The conditions are fatal to the success of the frequency transition, but
not to the operating system. I.e., the driver can return failed to the
CPUFreq subsystem, not update the jiffies, and the operating system
continues.

> 3) for nonfatal checks, is it possible to use WARN_ON() -- warn and
> continue?

Yes, BUT an error return code has to be returned, which does not fit
into the macros nicely. If the function merely prints a warning and
continues without returning an error code, the next phase of the driver
(frequency transitions take 3 phases, each phase is multiple steps) 
potentially may cause the system to crash.

For example, to increase the frequency, you first have to increase the
voltage. If the voltage increase fails, and the driver continues on
and increases the frequency, which succeeds, then the processor is
running at a voltage that is too low for the frequency. Errors such as
data corruption are pretty certain to follow quickly in this case.

So, code like 
   WARN_ON( condition );
   return( 0 );
is badness. It would need to be of the form
   if ( condition ) {
           printk( message );
           return( 1 );
   }
   return( 0 );

> 4) given good hardware and debugged driver, will any of those
> BUG_ON()s ever trigger?

Only if there are BIOS problems. 

