Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313196AbSDHHTk>; Mon, 8 Apr 2002 03:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSDHHTj>; Mon, 8 Apr 2002 03:19:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45238 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313196AbSDHHTi>; Mon, 8 Apr 2002 03:19:38 -0400
Message-ID: <3CB144BE.9DC8B034@in.ibm.com>
Date: Mon, 08 Apr 2002 12:50:30 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org,
        lkcd-devel@lists.sourceforge.net
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
In-Reply-To: <00c501c1dce3$0ed806d0$7e0aa8c0@bridge> <1674141067.1018028922@[10.10.2.3]> <003301c1dd16$855df1b0$7e0aa8c0@bridge>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
> 
> ----- Original Message -----
> From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
> Sent: Friday, April 05, 2002 5:48 PM
> 
> > I need to avoid going through the BIOS ... this is a
> > multiquad NUMA machine, and it doesn't take kindly
> > to the reboot through the BIOS for various reasons.
> > It also takes about 4 minutes, which is a pain ;-)
> >
> > I have source code access to our BIOS if I really wanted,
> > I just want to avoid modifying it if possible.
> 
> well keep in mind that the fastest LinuxBIOS boot is 3 seconds...
> a large part of the boot time on most PCs is the BIOS setting up
> DOS support and painting silly logos on the screen, all of which
> can go away.  I'm guessing your NUMA system has a bit more
> to do at this stage due to the hardware, but still...
> 
> >
> > > there are patches where a kernel can load another
> > > kernel, also.
> >
> > Hmmm ... sounds interesting ... any pointers?
> 
> LOBOS,
> 
> http://www.acl.lanl.gov/linuxbios/papers/index.html
> http://www.usenix.org/publications/library/proceedings/als2000/minnichLOBOS.
> html
> 
> two kernel monte,
> 
> http://www.scyld.com/products/beowulf/software/monte.html
> 
> There's also suspend to disk support, which is closely related.
> Kind of a restartable crash dump, without the crash:
> 
> http://falcon.sch.bme.hu/~seasons/linux/swsusp.html
> 
> >
> > > As for taking crashdumps on the way up, I believe
> > > (SGI's ?) linux kernel crash dumps does *exactly*
> > > this.
> >
> > I was under the impression that most BIOSes reset
> > memory on reboot, so this was impossible during a
> > BIOS reboot?
> 
> oss.sgi.com seems to be down today... but iirc,
> it doesn't boot through bios, but stashes some critical state
> in a buffer previously reserverd, uses one of the above methods
> to boot a new kernel, lets this kernel do the dump, then boots
> through the bios to make sure hardware is completely restored
> after the crash.  I'm sure it could be tailored to suit though.

What you just described is the way Mission Critical's 
crash dump facility implements this. It makes use of bootimg
Werner Almesberger's implementation of linux-boots-linux, to
soft reboot a new kernel without going through the bios on x86 
machines.

SGI lkcd doesn't do it that way today (btw, the lkcd project 
has now shifted to sourceforge, so the right place to look at 
is lkcd.sourceforge.net), but we are actually working on integrating
this mechanism from Mission Critical's mcore into lkcd, with
some enhancements/improvements. 

I'm cc'ing the lkcd-devel mailing list which is where we discuss
such stuff.

> 
> I'm currently researching combining the two, to create a LinuxBIOS
> firmware debug console, which will allow complete crash dump to
> be taken after a hardware reset, with the smallest possible Heisenburg
> effect, aside from a hardware debugger.

So how is the actual writeout accomplished ?(via LinuxBIOS ?)
 
> 
> Basically when the kernel panics, it dumps the CPU registers and
> resets the CPU.  The firmware console makes no alterations to
> the state of the hardware, instead running a modified kgdb stub
> like routine, possibly without even touching RAM.  Also, if an SMI
> button is available, this can be used as a hardware break switch,
> allowing panics to use an even less invasive HLT instruction.
> 
> Jeremy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
