Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267000AbUBRW6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267091AbUBRW6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:58:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:48345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267000AbUBRW6W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:58:22 -0500
Date: Wed, 18 Feb 2004 14:57:40 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: root@chaos.analogic.com
Cc: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [NET] 64 bit byte counter for 2.6.3
Message-Id: <20040218145740.6b47c218@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.53.0402181645220.27707@chaos>
References: <1077123078.9223.7.camel@midux>
	<20040218101711.25dda791@dell_ss3.pdx.osdl.net>
	<Pine.LNX.4.53.0402181527000.7318@chaos>
	<1077137014.18843.10.camel@midux>
	<Pine.LNX.4.53.0402181645220.27707@chaos>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 17:45:16 -0500 (EST)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> On Wed, 18 Feb 2004, Markus [ISO-8859-1] Hästbacka wrote:
> 
> > On Wed, 2004-02-18 at 22:32, Richard B. Johnson wrote:
> > > Manipulation of a 'long long' is not atomic in 32 bit architectures.
> > > Please explain how we don't care, if we shouldn't care. Also some
> > > /proc entries might get read incorrectly with existing tools.
> > Please, tell me all the tools, I'll test them. ifconfig and netstat
> > works correctly atleast.
> >
> 
> Hum, they will work when they see 2^64 written in ASCII in /proc/net/dev ?
> I doubt that. Have you ever even seen 64-bit ASCII?
> 
> The largest unsigned long long will be 18446744073709551615.
> If it's read with 32-bit tools (sscanf), it will read 4294967295.
> 
> > And about the caring, is rx/tx bytes so important that they can't use
> > long long? I would care to see more than 4GB, and maybe some error in
> > the counter at some point (Have you _ever_ seen that happen?) than only
> > 4GB.
> >
> 
> The 32-bit wrap is a serious problem. It can't be ignored. The writing
> of any multiple-part variable in the kernel can be interrupted at
> any time. Interrupting half-written variables can have dire
> consequences. Let's pretend that gcc knows how to write a long-long
> with minimum overhead..... high word is in edx and the low word is
> in eax. The memory variable is addressed by ebx....
> 
> 		addl	%eax, (%ebx)		# Sum low word
> 		adcl	%edx, 0x04(%ebx)	# Sum CY and high
> 
> Now, get interrupted...
> 
> 		addl	%eax, (%ebx)		# Sum low word
> 		->>> interrupt <<<--
> 
>                 Do some code that adds more stuff to
> 		the variable....
> 
> 		Return to the interrupted code.
> 
> 		adcl	%edx, 0x04(%ebx)	# Sum CY and high
> 
> The memory variable is now wrong. If it's an event counter, maybe
> it doesn't make any difference. That's what needs to be addressed.
> You can't just dismiss it. Any time you write code that knowingly
> results in the wrong results, its impact needs to be fully understood.
> 
> Changing a bunch of variables in a 32-bit machine to 64-bit ones
> is a major change, regardless of how trivial it may seem.
> 
> You need to make a spin-locked thingy for every variable you
> want to manipulate if the result needs to be correct.
> 
> > And no, I didn't post this to be merged into the mainline kernel, just
> > to let users know that there maybe is an option for seeing maximum 4GB.
> >
> > This has been working for me since, umm.. let's say 2.4.20. All the
> > tools I've needed have worked.
> 
> Just wait until your packet count is 4294967296. It will likely read 0.
> When 4294967297, may read 1.  That's off by quite a bit.
> 
> >
> >         Markus
> >
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an Intel Pentium III machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 

Do it right:
	* use per-cpu long long for both bytes and packet counts
	  and change each driver ...
	* expose both a new 64 bit and legacy 32 bit /proc interface
	* no tools use /sys yet, so that needs to show long long
	* have both a get_stats and get_stats64 hook in netdevice so not all drivers
	  have to be converted at once.

