Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRDARMw>; Sun, 1 Apr 2001 13:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRDARMn>; Sun, 1 Apr 2001 13:12:43 -0400
Received: from gear.torque.net ([204.138.244.1]:16655 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S130446AbRDARMf>;
	Sun, 1 Apr 2001 13:12:35 -0400
Message-ID: <3AC752DA.20F5A54@torque.net>
Date: Sun, 01 Apr 2001 12:10:02 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Peter Daum <gator@cs.tu-berlin.de>, linux-scsi@vger.kernel.org
Subject: Re: scsi bus numbering
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Daum <gator@cs.tu-berlin.de> wrote:
> For some reason, the order of initializing the scsi drivers
> changed between 2.4.2 and 2.4.3: If both, ncr53c8xx and aic7xxx
> drivers are included in the kernel, up to version 2.4.2, the
> adaptec driver always came first (so the first disk on an adaptec
> controller ended up as /dev/sda) while in 2.4.3, the ncr driver
> initializes first and all the device names change - with
> potentially disastrous effects for unsuspecting users.
> 
> AFAIK, the numbering of scsi busses depends only on the order the
> low-level drivers are loaded. Not that I can think of any better
> way to do this, but it would be good if things were a little bit
> more predictable - in absence of any better idea, maybe by
> loading the drivers in alphabetical order or something like that ...

Looking at the drivers/scsi/Makefile file in lk 2.4.3
you can see that aic7xxx_old.o is about half way down
the list with ncr53c8xx.o towards the end. So this
dictates the old behaviour (in the lk 2.4 series).
However the new aic7xxx driver isn't in that list,
it has its own entry:
    subdir-$(CONFIG_SCSI_AIC7XXX)   += aic7xxx
which seems to invoke drivers/scsi/aic7xxx/Makefile
_after_ all other built in adapters drivers are built.
Maybe another "make" mechanism needs to be found to
restore the previous ordering information. In any case
building the aic7xxx driver last has already surprised
a lot of people.
 
> How is it possible, to influence that order at the moment (for
> example, to revert to the old order)? I personally couldn't
> figure out, where to change this.

>>>>>>>>>  scsihosts  <<<<<<<<<<<<<

As a boot time option try:
  scsihosts=aic7xxx:ncr53c8xxx
or if you are using lilo, in /etc/lilo.conf add:
  append="scsihosts=aic7xxx:ncr53c8xxx"

Actually just doing:
  scsihosts=aic7xxx
should do the trick for most people.

In the unlikely case that the SCSI mid level is a module,
then you can pass the scsihosts argument to the
module load (or add an option line to /etc/modules.conf):
  modprobe scsi_mod scsihosts=aic7xxx:ncr53c8xxx

You could also read the SCSI-2.4-HOWTO at:
http://www.linuxdoc.org/HOWTO/SCSI-2.4-HOWTO/

BTW You can thank Richard Gooch and devfs for scsihosts.
Lucky he spotted the requirement some time back.

Doug Gilbert
