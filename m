Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318315AbSGSCLg>; Thu, 18 Jul 2002 22:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318422AbSGSCLf>; Thu, 18 Jul 2002 22:11:35 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:50693 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S318315AbSGSCLf> convert rfc822-to-8bit; Thu, 18 Jul 2002 22:11:35 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon MP 1900+ on MSI K7D Master-L
Date: Thu, 18 Jul 2002 21:14:30 -0500
User-Agent: KMail/1.4.2
References: <200207190331.57158.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200207190331.57158.Dieter.Nuetzel@hamburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207182114.30806.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 08:31 pm, Dieter Nützel wrote:
> Alan, were should I put the "-j2/-j3" make flag for the kernel
> compilation? /usr/src/linux/Documentation/smp.txt is way
> outdated ;-(
>
> Is there a place (maybe in /usr/lib/rpmrc; SuSE/RedHat) to get
> both CPUs running during RPM packages compilation?

Alan may have a different answer for you, but in my experience, 
you can just specify the -j<whatever> flag when you run make 
(and also set the MAKE variable to "make -j<whatever>".  The 
speed benefit really kicks in when making bzImage or modules.

In general, I find it best to set the number of jobs to the 
number of CPUs _plus 1_--i.e. for single CPU, use make -j2, and 
for dual CPUs, use make -j3.  Going for that "plus 1" makes most 
builds just a smidgen faster.  For me, on my dual PPro box, the 
process would be something like:

make menuconfig
make -j3 MAKE="make -j3" dep clean bzImage modules

Doing just a bare "make -j" (using just "-j" where you'd normally 
use "-j<whatever>") is never good, even if you actually do have 
tons and tons of mem+swap.  Besides sucking up memory like 
there's no tomorrow, it hammers the system with context switches 
and forces the build to spend way too much of its time stuck in 
the process scheduler.  This makes a nice brutal stress-test for 
a system, but it slows your build to a crawl.

AFAIK, the only way to get RPM packages to use "make 
-j<whatever>" is to edit their spec files manually, have the 
%build scriptlet look in /proc/cpuinfo to discover the number of 
CPUs, and then have the scriptlet explicitly call make with 
appropriate -j parameters.  You might want to do this both in 
the %build and %install scriptlets, since environment variable 
settings in the %build scriptlet don't necessarily carry over 
into %install.

Beware, also, that many build scripts will not work properly with 
"make -j<whatever>".  A parallel build as a whole may work, or 
it may not.  Some source packages may fail loudly and die.  A 
few may appear to complete successfully, yet silently fail to 
install some file or another.  It's fairly common for source 
trees not to be 100% "parallel-build safe", and the kernel is no 
exception.

You could possibly complain to developers about this, but most 
developers have higher priorities than catering to people with 
multiple CPUs. ;)  So using "make -j<whatever>" should always be 
considered "experimental."

--
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
