Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTB1Glx>; Fri, 28 Feb 2003 01:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbTB1Glx>; Fri, 28 Feb 2003 01:41:53 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:30726 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267560AbTB1Glu>; Fri, 28 Feb 2003 01:41:50 -0500
Message-Id: <200302280645.h1S6ims00404@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: wyleus <coyote1@cytanet.com.cy>, Robert Redelmeier <redelm@ev1.net>
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Date: Fri, 28 Feb 2003 08:41:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy> <200302261151.h1QBp2s23777@Port.imtp.ilyichevsk.odessa.ua> <20030227082312.1a56684b.coyote1@cytanet.com.cy>
In-Reply-To: <20030227082312.1a56684b.coyote1@cytanet.com.cy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 February 2003 15:23, wyleus wrote:
> > cpuburn will help you rule out defective CPU theory.
> > Also you can start removing/swapping hardware parts.
>
> Thanks for taking the time to reply time, Dennis.  I ran cpuburn as
> you suggested.  Specifically, I ran the burnK6 binary for about an
> hour (from an xterm, and I also had other stuff like galeon running
> simultaneously) and didn't get any hiccups.  Monitoring with top, I
> saw that I had 0% free cpu during the test.
>
> However I also later ran the burnMMX binary, and that one would quit
> after running a few minutes without printing any error messages to
> the screen - nor did it leave any messages in /var/log/*.  Dunno if
> that's normal?  Shouldn't it keep running until I kill it?

AFAIK there is a README in cpuburn. Let me see... yes, and Design.
Here is an exerpt:
==== Design ====
All at 2 * 5.5 * 97 MHz (26'C ambient).  Higher and my CPU1 will lockup
under burnP6 in 5-10 min .  kernel compiles are stable to 99 MHz for
24 h.  But 98 MHz will give `burnBX` errors every 5-8 hours, and 95
MHz will give burnMMX D errors every ~6 hours, so now I run 94 MHz.
Errors seem to increase 10x for every 1 MHz.
...
REVISED BURNMMX:  I started this project as simply a way for AMD system
owners to check out their systems.  I was very surpised when my own
system started throwing errors with the MMX memory moves, and had to
downclock from 2 * 5.5 * 97 MHz to 94 MHz. It would seem that the simple
memory moves are more fragile (less robust to interrupts) than the 2%
higher bandwidth string moves.
==== README ====
TO USE:  root priviliges are NOT required.  It has been designed for ELF
         Linux, but also tested under FreeBSD. and a.out.  Burn Testing
         is best done from a ramdisk distribution (tomsrtbt) or with
         filesystems unmounted or mounted read-only.  untar the source
         in a convenient directory:
`tar zxf cpuburn`
         compile excutables
`make`
         run desired program in background [ _repeat_ for SMP]:
`burnP6 || echo $? &`

Monitor progress of cpuburn by `ps`.  When finished, `kill` the burn*
process(es).  If you have temperature probes (fingers) or the lm-sensors
package, you can check your CPU temperature and/or system voltages.

If an error occurs in calculations, it will be preserved, and the
program will terminate with error code 254 for an integer/memory error,
and error code 255 for a FP/MMX error.  Error checking happens every
10-40 sec for burnP6/K6/K7 and I haven't seen any CPU errors in testing
[lockups occur first].  burnBX and burnMMX check for error every 512 MB
(4-10 sec), and error termination is frequently seen, lockups are rarer.

burnBX and burnMMX are essentially very intense RAM testers.  They can
also take an optional parameter indicating the RAM size to be tested:

  A =  2 kB   E =  32 kB   I = 512 kB   M =  8 MB
  B =  4      F =  64      J =   1 MB   N = 16
  C =  8      G = 128      K =   2      O = 32
  D = 16      H = 256      L =   4      P = 64
================

so, you need to run "burnMMX x; echo $?" to see an error code.
It's definitely bad that it does not run forever. 
(btw I'm CCing cpuburn author)

> Can I draw any conclusions thus far?  Could I conclude now that the
> CPU and RAM are OK (because of the memtest86 and cpuburn tests)?

As you see abobe, something in hw is not ok.

> Also, assuming that all of my hardware is OK (yes a big assumption),
> could the problems I have be due to a misconfiguration or otherwise
> software problem?
>
> As for swapping parts, I don't have any extra computer parts.  Given
> the nature of these kernel bug messages in the syslog, can I use that
> fact to logically limit the range of hardware that can cause these
> problems?  I.E. can I say for example that malfunctioning PSU, RAM,
> CPU or Mobo can cause these symptoms, but that the ISA sound card, or
> the video card would not?  Or do I have no choice but to suspect each
> and every piece of hardware in my box?

We don't know. If it's a PSU, removing some seemingly irrelevant part
can reduce wattage and make system stable... There are tons
of possibilities, the only way to know is to experiment.

> > Test with some vanilla 2.4 kernels, not a distro one. If 2.4.20
> > crashes, try some of the earlier kernels too. Compile them for 386
> > uniprocessor with debugging and magic SysRq enabled. Provide your
> > .config
>
> As I mentioned to John, I'm still a newbie and don't feel comfortable
> yet in my competency to replace the kernel.  I have a lot of (newbie)
> time invested in this installation and don't want to break it by
> messing with stuff that's way beyond my understanding.

It's not that scary as it seems. Compiling kernel won't damage a system.
You can damage it only by improper install. Read lilo (or what is Mandrake
using?) docs carefully first.

> > Run your klogd with -x to make it stop decoding oopses.
> > Run oopses thru ksymoops and provide result.
>
> I'm not clear whether you intended these suggestions to apply after
> I've changed the kernel, or also to my current setup.

To current setup.

> Assuming you mean applying it currently - grepping for klogd in /etc
> shows that mandrake uses an environment variable KLOGD_OPTIONS to run
> klogd.  This was set to "-2".  However the variable is set to this
> value in no less than 32 different files.  24 of them see to be
> related to runlevels (4x6), and 8 unrelated.  This means that (if my
> logic is correct) that the same variable is set 9 times for a
> particular runlevel (rl-3 in my case).  Which one should I change
> that won't get overridden?  Or should I change them all, or use
> another approach?

Wow. Maybe simply turn them all into "-x -2"?
(my man klogd says nil about -2)

> > Provide lsmod, lspci output, some of /proc/* files (interrupts etc)
>
> Assuming more is better than less;
>
> # lsmod
> Module                  Size  Used by    Not tainted
> tdfx                   31524   1
> agpgart                31840   0  (autoclean) (unused)
> sr_mod                 15096   0  (autoclean) (unused)
> parport_pc             21672   1  (autoclean)
> lp                      6720   0  (autoclean)
> parport                23936   1  (autoclean) [parport_pc lp]
> ipt_TOS                  984  12  (autoclean)
> ipt_LOG                 3384   5  (autoclean)
> ipt_REJECT              2744   4  (autoclean)
> ipt_state                568   9  (autoclean)
> iptable_mangle          2072   1  (autoclean)
> ip_nat_irc              2384   0  (unused)
> ip_nat_ftp              2992   0  (unused)
> iptable_nat            15224   2  [ip_nat_irc ip_nat_ftp]
> ip_conntrack_irc        3056   1
> ip_conntrack_ftp        3952   1
> ip_conntrack           18400   4  [ipt_state ip_nat_irc ip_nat_ftp
> iptable_nat i p_conntrack_irc ip_conntrack_ftp]
> iptable_filter          1644   1  (autoclean)
> ip_tables              11672   9  [ipt_TOS ipt_LOG ipt_REJECT
> ipt_state iptable_ mangle iptable_nat iptable_filter]
> nfsd                   66576   0  (autoclean)
> lockd                  46480   0  (autoclean) [nfsd]
> sunrpc                 60188   0  (autoclean) [nfsd lockd]
> ppp_synctty             5952   1  (autoclean)
> ppp_generic            20064   3  (autoclean) [ppp_synctty]
> slhc                    5072   0  (autoclean) [ppp_generic]
> n_hdlc                  6368   1  (autoclean)
> nls_iso8859-1           2844   1  (autoclean)
> nls_cp850               3580   1  (autoclean)
> vfat                    9588   1  (autoclean)
> fat                    31864   0  (autoclean) [vfat]
> supermount             14340   1  (autoclean)
> ide-cd                 28712   0
> cdrom                  26848   0  [sr_mod ide-cd]
> ide-scsi                8212   0
> scsi_mod               90372   2  [sr_mod ide-scsi]
> sb                      7668   0
> sb_lib                 34958   0  [sb]
> uart401                 6628   0  [sb_lib]
> sound                  55732   0  [sb_lib uart401]
> soundcore               3780   0  [sb_lib sound]
> usb-ohci               18216   0  (unused)
> usbcore                58304   1  [usb-ohci]
> rtc                     6560   0  (autoclean)
> ext3                   74004   2
> jbd                    38452   2  [ext3]

Wow. Do you really use ALL this stuff or it's Mandrake install
default?
--
vda
