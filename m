Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265172AbUD3Mcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbUD3Mcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 08:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUD3Mcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 08:32:39 -0400
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:57642 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265172AbUD3Mch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 08:32:37 -0400
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
From: Bart Samwel <bart@samwel.tk>
Reply-To: bart@samwel.tk
To: Timothy Miller <miller@techsource.com>
Cc: Paul Jackson <pj@sgi.com>, vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au,
       jgarzik@pobox.com, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
In-Reply-To: <40918AD2.9060602@techsource.com>
References: <40904A84.2030307@yahoo.com.au>
	 <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	 <20040429133613.791f9f9b.pj@sgi.com>	<409175CF.9040608@techsource.com>
	 <20040429144737.3b0c736b.pj@sgi.com>	<40917F1E.8040106@techsource.com>
	 <20040429154632.4ca07cf9.pj@sgi.com>  <40918AD2.9060602@techsource.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083328293.2204.53.camel@samwel.tk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Apr 2004 14:31:34 +0200
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: bsamwel@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 01:08, Timothy Miller wrote:
> Agreed.  And this is why I suggested not adding another knob but rather 
> going with the existing nice value.
> 
> Mind you, this shouldn't necessarily be done without some kind of 
> experimentation.  Put two knobs in the kernel and try varying them  to 
> each other to see what sorts of jobs, if any, would benefit in a 
> disparity between cpu-nice and io-nice.  If there IS a significant 
> difference, then add the extra knob.  If there isn't, then don't.

Thought experiment: what would happen when you set the hypothetical
cpu-nice and io-nice knobs very differently?

* cpu-nice 20, io-nice -20: Read I/O will finish immediately, but then
the process will have to wait for ages to get a CPU slice to process the
data, so why would you want to read it so quickly? The process can do as
much write I/O as it wants, but why is it not okay to take ages to write
the data if it's okay to take ages to produce it?

* cpu-nice -20, io-nice 20: Read I/O will take ages, but once the data
gets there, the processor is immediately taken to process the data as
fast as possible. If it was okay to take ages to read the data, why
would you want to process it as soon as you can? It makes some sense for
write I/O though: produce data as fast as the other processes will allow
you to write it. But if you're going to hog the CPU completely, why give
other processes the chance to do a lot of I/O while they don't get the
CPU time to submit any I/O? Going for a smaller difference makes more
sense.

As far as I can tell, giving the knobs very different values doesn't
make much sense. The same arguments go for medium-sized differences. And
if we're going to give the knobs only *slightly* different values, we
might as well make them the same. If we really need cpu-nice = 0 and
io-nice = 3 somewhere, then I think that's a sign of a kernel problem,
where the kernel's various nice-knobs aren't calibrated correctly to
result in the same amount of "niceness" when they're set to the same
value. And cpu-nice = io-nice = 3 would probably have about the same
effect.


BTW, if there *are* going to be more knobs, I suggest adding
"memory-nice" as well. :) If you set memory-nice to 20, then the process
will not kick out much memory from other processes (it will require more
I/O -- but that can be throttled using io-nice). If you set memory-nice
to -20, then the process will kick out the memory of all other processes
if it needs to.

--Bart
