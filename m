Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279720AbRJYHvr>; Thu, 25 Oct 2001 03:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279724AbRJYHvi>; Thu, 25 Oct 2001 03:51:38 -0400
Received: from marine.sonic.net ([208.201.224.37]:41836 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S279721AbRJYHva>;
	Thu, 25 Oct 2001 03:51:30 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 25 Oct 2001 00:52:03 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe problem with block-major-11
Message-ID: <20011025005202.A24125@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24102.1003989096@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 03:51:36PM +1000, Keith Owens wrote:
> On Wed, 24 Oct 2001 21:53:28 -0700, 
> Mike Castle <dalgoda@ix.netcom.com> wrote:
> >Now, if I try something like ``head /dev/scd0''  I see the following in
> >dmesg:
> >SCSI subsystem driver Revision: 1.00
> >Uniform CD-ROM driver unloaded
> >
> >And the following in /var/log/ksymoops:
> >20011024 214049 start /sbin/modprobe -s -k -- block-major-11 safemode=1
> >20011024 214050 probe ended
> 
> Check syslog for any error messages.  The only unusual thing is that

Only thing in syslog around that time:
Oct 24 21:40:49 thune kernel: SCSI subsystem driver Revision: 1.00 
Oct 24 21:40:50 thune insmod: /lib/modules/2.4.12/kernel/drivers/cdrom/cdrom.o: pre-install sr_mod failed
Oct 24 21:40:50 thune insmod: /lib/modules/2.4.12/kernel/drivers/cdrom/cdrom.o: insmod block-major-11 failed
Oct 24 21:40:50 thune kernel: Uniform CD-ROM driver unloaded 

> modprobe is running in safe mode (user supplied input data) which
> suppresses some command expansions.  Post your entire modules.conf
> exactly as is, i.e. read the file into your mail, do not cut and paste
> it.

A lot of cruft from over the years.

Also output from lsmod, since modules.conf implies more than I actually
load:

Module                  Size  Used by
sg                     26756   1  (autoclean)
sr_mod                 12184   1  (autoclean)
ide-scsi                7488   2 
ide-cd                 26240   0 
cdrom                  27200   0  (autoclean) [sr_mod ide-cd]
scsi_mod               58572   3  (autoclean) [sg sr_mod ide-scsi]
nfsd                   64864   1  (autoclean)
lockd                  46688   1  (autoclean) [nfsd]
sunrpc                 58388   1  (autoclean) [nfsd lockd]
ip_nat_ftp              2944   0  (autoclean) (unused)
ip_conntrack_ftp        3200   0  (autoclean) (unused)
iptable_nat            12756   1  (autoclean) [ip_nat_ftp]
ip_conntrack           12908   2  (autoclean) [ip_nat_ftp ip_conntrack_ftp iptable_nat]
ip_tables              10400   3  [iptable_nat]
ne2k-pci                4768   1  (autoclean)
8390                    5920   0  (autoclean) [ne2k-pci]
tulip                  35520   1  (autoclean)
lvm-mod                44704  10  (autoclean)
md                     43520   0  (autoclean) (unused)
unix                   13700  36  (autoclean)

:r /etc/modules.conf
alias block-major-58  lvm-mod
alias char-major-109  lvm-mod

alias char-major-14 sb
options sb irq=5 io=0x220 dma=1 dma16=5

add above sb adlib_card
options adlib_card io=0x388

alias parport_lowlevel parport_pc

alias char-major-15 joystick

alias block-major-8 ppa
add above ppa sd_mod

#pre-install serial  modprobe -k lirc_serial
alias char-major-61 lirc_serial
options lirc_serial port=0x2f8 irq=3

alias eth0 tulip
alias eth1 ne2k-pci
# TV
alias   char-major-81    videodev
alias   char-major-81-0  bttv
#pre-install bttv        modprobe -k msp3400; modprobe -k tuner
pre-install bttv        modprobe -k tuner
options bttv            radio=0 pll=0 card=0
options tuner           debug=1 type=0

add above ip_conntrack ip_conntrack_ftp
add above iptable_nat ip_nat_ftp

options ide-cd ignore=hdc            # tell the ide-cd module to ignore h
alias block-major-11 sr_mod          # load sr_mod upon access of scd0
pre-install sg     modprobe ide-scsi # load ide-scsi before sg
pre-install sr_mod modprobe ide-scsi # load ide-scsi before sr_mod
pre-install ide-scsi modprobe ide-cd # load ide-cd   before ide-scsi
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
