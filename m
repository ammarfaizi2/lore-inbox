Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293557AbSCPAIV>; Fri, 15 Mar 2002 19:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293550AbSCPAHJ>; Fri, 15 Mar 2002 19:07:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:18356 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293543AbSCPAGX>; Fri, 15 Mar 2002 19:06:23 -0500
Message-Id: <200203160006.g2G06Jq09111@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: Greg KH <greg@kroah.com>, Gordon J Lee <gordonl@world.std.com>
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Date: Fri, 15 Mar 2002 16:06:18 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315233441.GG5563@kroah.com>
In-Reply-To: <20020315233441.GG5563@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 03:34 pm, Greg KH wrote:
> On Fri, Mar 15, 2002 at 06:09:50PM -0500, Gordon J Lee wrote:
> > IBM has a brand new xSeries PC server called the x360.
> > It has 1-4 Xeon MP's, DDR SDRAM, PCI-X backplane, IBM Summit chipset.
> > Full specs are here:
> >
> > http://www.pc.ibm.com/us/eserver/xseries/x360.html
>
> Eeek, these machines are now in the wild?  Didn't realize this :)

They've officially been released for a while now.  (December? January?  
Something like that.)

> > Has anyone tried running Linux on one of these ?
>
> Yes.
>
> > I have tried a few versions and found:
> >
> > 2.2.18    fails in boot
> > 2.2.20    fails in boot
> > 2.2.21rc2 fails in boot
>
> Ouch :(

Not surprising.  x360s have XAPICs in them and need reasonably up-to-date 
APIC handling code.  Try 2.4.14 or higher.  That also includes Intel's 
"hyperthreading" code, should you want to try that.  (Well, minus my 
forthcoming patch to that.  It's in Alan's 2.4 tree.)

Recent 2.4.x also properly detects and uses APICs without going through a PIC 
phase.  This is important as many x360 IRQ sources do not run through a PIC, 
and will fail any attempt to use PIC mode interrupts.

Also, I've got some patches that avoid a problem on SMP XAPIC boxes:  all the 
external interrupts hit on CPU 0.

I use a simple static round robin routine to bind the irqs roughly evenly 
across all CPUs.  Ingo has a different patch that rotates the irqs randomly 
to idle CPUs on every received interrupt.  This spreads the load much more 
evenly, but has a bit more overhead and limits cache warmth for the handler 
code/data.  If you're going to be beating on the x360 much, you'll probably 
want to install one patch or the other.

> > 2.4.9     works fine!
>
> Glad to see this.
>
> > I know the hardware is in good shape because a 2.4.9 kernel works
> > fine on this machine.  I have scoured the IBM site, linux-kernel,
> > and Google for clues, but to no avail.
> >
> > The boot sequence failure under the 2.2.x versions that I tried is
> > always the same, it fails to recognize the IDE and SCSI devices.  From
> > the messages, the system appears to be deaf to interrupts and so it
> > cannot recognize its devices.  Notable messages from the boot sequence
> > that support this idea are:

See above; 2.2.x is not expected to work.

> I don't know if anyone ever tried a 2.2.x kernel on these boxes :)
> Is there a reason you _really_ need a 2.2.x kernel for this machine?
>
> You also might try a UP 2.2.x kernel on this box to see if the problem
> is in the parsing of the APIC tables (as I think it is.)
>
> thanks,
>
> greg k-h
> -

-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com

