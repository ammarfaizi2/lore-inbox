Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbRE0Ced>; Sat, 26 May 2001 22:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262721AbRE0CeY>; Sat, 26 May 2001 22:34:24 -0400
Received: from mail.alphalink.com.au ([203.24.205.7]:6417 "EHLO
	mail.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S262719AbRE0CeJ>; Sat, 26 May 2001 22:34:09 -0400
Message-ID: <3B1069E4.DA4A7E1B@alphalink.com.au>
Date: Sun, 27 May 2001 12:43:48 +1000
From: Greg Banks <gnb@alphalink.com.au>
X-Mailer: Mozilla 4.07 [en] (X11; I; Linux 2.2.1 i586)
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Jaswinder Singh <jaswinder.singh@3disystems.com>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Configure.help entries wanted
In-Reply-To: <20010525012200.A5259@thyrsus.com> <3B0F3268.A671BC7A@pocketpenguins.com> <002401c0e5aa$0049a000$47a6b3d0@Toshiba> <3B0F8042.90DD5C5D@pocketpenguins.com> <20010526174829.A1726@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

esr@thyrsus.com wrote:
> 
> Greg Banks <gbanks@pocketpenguins.com>:
> >   Having said that, I agree that the help text entries for the SH
> > port are in general of less than stellar quality, for various
> > (mostly good) reasons.  I'm hoping ESR will give us some editorial
> > feedback which will provide a good excuse to fix them.
> 
> Since you asked...
> 
> # Choice: superhsys
> Generic
> CONFIG_SH_GENERIC
>   Select Generic if configuring for a generic SuperH system.

  The "generic" option compiles in *all* the possible hardware
support and relies on the sh_mv= kernel commandline option to choose
at runtime which routines to use.  "MV" stands for "machine vector";
each of the machines below is described by a machine vector and
the "generic" option chooses to compile them all in.

>   Select SolutionEngine if configuring for a Hitachi SH7709
>   or SH7750 evalutation board.
> 
>   Select Overdrive if configuring for a ST407750 Overdrive board.
>   More information at
>   <http://linuxsh.sourceforge.net/docs/7750overdrive.php3>
> 
>   Select HP620 if configuring for a HP Jornada HP620.
>   More information at
>   <http://www.hp.com/jornada>.
> 
>   Select HP680 if configuring for a HP Jornada HP680.
>   More information at
>   <http://www.hp.com/jornada/products/680>.
> 
>   Select HP690 if configuring for a HP Jornada HP690.
>   More information at <http://www.hp.com/jornada/products/680>.

  You won't get any information about Linux on Jornadas at HP.

> 
>   Select CqREEK if configuring for a CqREEK SH7708 or SH7750.
>   More information at
>   <http://sources.redhat.com/ecos/hardware.html#SuperH>.
> 
>   Select DMIDA if configuring for a DataMyte 4000 Industrial
>   Digital Assistant. More information at <http://www.dmida.com>.
> 
>   Select EC3104 if configuring for a system with an Eclipse
>   International EC3104 chip, e.g. the Harris AD2000.
> 
>   Select Dreamcast if configuring for a SEGA Dreamcast.
>   More information at
>   <http://www.m17n.org/linux-sh/dreamcast>.

  The Dreamcast project is at <http://linuxdc.sourceforge.net/>
They usually have slightly newer DC support than
linuxsh.sourceforge.net,
to which they sync regularly.

> 
>   Select BareCPU if you know what this means, and it applies
>   to your system.
> 
> Can you be any more explicit about the BareCPU option?

  "Bare CPU" aka "unknown" means an SH-based system which is not
one of the specific ones mentioned above, which means you need to
enter all sorts of stuff like CONFIG_MEMORY_START because the config
system doesn't already know what it is.  You get a machine vector
without any platform-specific code in it, so things like the RTC may
not work.

  This option is for the early stages of porting to a new machine.

  Basically the machine choices are laid out like this:

  generic = all of the known machines
  machine foo
  machine bar
  unknown = none of the known machines

> Physical memory start address
> CONFIG_MEMORY_START
>   The physical memory start address will be automatically
>   set to 08000000, unless you selected one of the following
>   processor types: SolutionEngine, Overdrive, HP620, HP680, HP690,
>   in which case the start address will be set to 0c000000.
> 
>   Do not change this address unless you know what you are doing.
> 
> Why might someone want to change this address?

  Only when porting to a new machine which is not already
known by the config system.  Changing it from the known correct
value on any of the known systems will only lead to disaster.

> Early printk support
> CONFIG_SH_EARLY_PRINTK
>   Say Y here to redirect kernel printks from the boot console to an
>   SCI serial console as soon as one is available.
> 
> This was my guess.  Is it correct?

  Nearly.

-  the serial console can be either SCI or SCIF (the latter has a FIFO)

-  the redirect happens *before* the serial console is available, and
   stops when the serial console is initialised

-  printks go to a BIOS conforming to the LinuxSH standard (i.e.
   the SH-IPL bootloader)

  Try:

Say Y here to redirect kernel messages to the serial port
used by the SH-IPL bootloader, starting very early in the boot
process and ending when the kernel's serial console is initialised.
This option is only useful porting the kernel to a new machine,
when the kernel may crash or hang before the serial console is
initialised.

> SuperH SCI (serial) support
> CONFIG_SH_SCI
>   Selecting this option will allow the Linux kernel to transfer
>   data over SCI (Serial Communication Interface) and/or SCIF
>   which are built into the Hitachi SuperH processor.
> 
>   If in doubt, press "y".
> 
> What data?  Is this just an on-board RS232C controller?

  Sorry, the description is unclear.  It's an on-CPU RS232 controller,
usually used as the console.  The option provides 1 to 3 (depending
on the CPU model) standard Linux tty devices, /dev/ttySC[012].

> 
> Use LinuxSH standard BIOS
> CONFIG_SH_STANDARD_BIOS Say Y here if your target has the gdb-sh-stub
>   package from www.m17n.org (or any conforming standard LinuxSH BIOS)
>   in FLASH or EPROM.  The kernel will use standard BIOS calls during
>   boot for various housekeeping tasks (including calls to read and
>   write characters to a system console, get a MAC address from an
>   on-board Ethernet interface, and shut down the hardware).  Note this
>   does not work with machines with an existing operating system in
>   mask ROM and no flash (WindowsCE machines fall in this category).
>   If unsure, say N.
> 
> Note that I mixed in some information I gathered from reasding the source.
> Please check for correctness.

  That's fine.

Greg.
-- 
If it's a choice between being a paranoid, hyper-suspicious global
village idiot, or a gullible, mega-trusting sheep, I don't look
good in mint sauce.                      - jd, slashdot, 11Feb2000.
