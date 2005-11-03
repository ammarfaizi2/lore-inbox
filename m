Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbVKCWyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbVKCWyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbVKCWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:54:46 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:22248 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932632AbVKCWyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:54:45 -0500
Subject: Re: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: rddunlap@osdl.org, Len Brown <len.brown@intel.com>, macro@linux-mips.org,
       Jean-Christian de Rivaz <jc@eclis.ch>
Cc: linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
In-Reply-To: <436A8ADB.2090307@eclis.ch>
References: <4369464B.6040707@eclis.ch>
	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>
	 <43694DD1.3020908@eclis.ch>
	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>
	 <43695D94.10901@eclis.ch>
	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>
	 <43697550.7030400@eclis.ch>
	 <1131046348.27168.537.camel@cog.beaverton.ibm.com>
	 <436A7D4B.8080109@eclis.ch>
	 <1131054087.27168.595.camel@cog.beaverton.ibm.com>
	 <436A8ADB.2090307@eclis.ch>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 03 Nov 2005 14:54:41 -0800
Message-Id: <1131058482.27168.612.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 23:10 +0100, Jean-Christian de Rivaz wrote:
> john stultz a écrit :
> > On Thu, 2005-11-03 at 22:12 +0100, Jean-Christian de Rivaz wrote:
> > 
> >>A have tested 7 differents vanilla kernel on the same suspect hardware:
> >>
> >>                2.6.8  : ntpd working : drift from    -77ppm to   -144ppm
> >>                2.6.9  : ntpd working : drift from    -99ppm to   -231ppm
> >>                2.6.10 : ntpd failed  : drift from -37825ppm to -29912ppm
> >>                2.6.12 : ntpd failed  : drift from -43429ppm to -45251ppm
> > 
> > 
> > Ok, that makes it pretty clear we have a regression w/ 2.6.10. I really
> > appreciate your helping narrow down this issue. If you have the time,
> > could you test the three 2.6.10-rcX patches? 
> > 
> > You can find them here: 
> > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/
> > 
> > And they apply independently (not cumulatively) ontop of 2.6.9
> 
> I will try, but compiling the kernels take time even with 3 machines 
> (one per kernel version)...
> 
> 
> I compared the dmesg log of the different kernel, but since I don't know 
> what I should find it's a little difficult. There is many differences 
> between each kernels. Despit that, I noticed this difference between the 
> kernel 2.6.9 (ntps working) and the kernel 2.6.10 (ntpd failed):
> 
> --- linux-2.6.9.txt  2005-11-03 22:49:29.000000000 +0100
> +++ linux-2.6.10.txt  2005-11-03 22:48:41.000000000 +0100
> [...snip...]
> @@ -67,16 +68,12 @@
>    Enabling unmasked SIMD FPU exception support... done.
>    Checking 'hlt' instruction... OK.
>    ENABLING IO-APIC IRQs
> - vector=0x31 pin1=2 pin2=-1
> - 8254 timer not connected to IO-APIC
> - ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> - ...trying to set up timer as Virtual Wire IRQ... failed.
> - ...trying to set up timer as ExtINT IRQ... works.
> + vector=0x31 pin1=0 pin2=-1
>    Registered protocol family 16
>    PCI BIOS revision 2.10 entry at 0xfbbb0, last bus=3
>    Using configuration type 1
> [..snip...]
> 
> Maybe a way to go ?


You might check booting w/ noapic to see if that changes the behaviour
in 2.6.10.

I know there were some pretty troubling issues w/ the nforce2 early in
the 2.6 cycle.  See
http://atlas.et.tudelft.nl/verwei90/nforce2/index.html for some details.


Maciej: I noticed you had been involved with earlier nforce2 issues.
Does the above change in the ioapic pin1 value look familiar?


Digging around in the bkcvs git web between 2.6.9 and 2.6.10, I found
the following ioapic related changes:

Randy:
http://kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=0b517c442f66f9b1e280ca49d4b215cc3681d4e5;hp=60a7a584ad5a266afa5d7fde5f2828894e615c17

Len:
http://kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=eb3f18413cb759662b34230674fb6f07c9e16e56;hp=e87e2e7669129dc0e8b2959c656650d7ea5c066f

Any clues?


Jean-Christian: Since it ACPI is involved, have you verified that you're
running the current BIOS for your system?

thanks
-john


