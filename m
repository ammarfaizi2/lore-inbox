Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268968AbRHFTqW>; Mon, 6 Aug 2001 15:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268966AbRHFTqD>; Mon, 6 Aug 2001 15:46:03 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:49447 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S268960AbRHFTp7>;
	Mon, 6 Aug 2001 15:45:59 -0400
To: linux-kernel@vger.kernel.org
Cc: Tim Jansen <tim@tjansen.de>
Subject: How to hack a network driver to use a specific ethX (was Re: How does "alias ethX drivername" in modules.conf work?)
In-Reply-To: <m33d78de7d.fsf@flash.localdomain>
	<15SnZL-05h4nQC@fmrl06.sul.t-online.com>
From: Mark Atwood <mra@pobox.com>
Date: 06 Aug 2001 12:46:00 -0700
In-Reply-To: Tim Jansen's message of "Sat, 4 Aug 2001 00:39:20 +0200"
Message-ID: <m3g0b5q8ef.fsf_-_@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Jansen <tim@tjansen.de> writes:
> On Friday 03 August 2001 23:29, Mark Atwood wrote:
> > I'm trying to figure out how "alias ethX" works in /etc/modules.conf
> > Is it some "magic" in depmod / modprobe? And how is the network
> > interface identifier then passed into the module when it loads?
> 
> If some user-space app accesses ethX the kernel calls "/sbin/modprobe ethX". 
> The alias in /etc/modules.conf just gives ethX the name of the real module. 
> The interface identifier isn't passed to the module, you have to initialize 
> your interfaces in the right order (or set it using an option for modprobe, 
> but I don't whether any drivers support setting the interface identifier).

Are their any examples of drivers that can set the interface identifier?

If it possible that a driver may do so, does that mean that the kernel
can handle interface identifiers being set "out of order"?


My problem stems the following situation:

  eth0 is an "ordinary" PCI hme ethernet device. That works just fine.

  eth1 is a weird device that is still under hardware development,
   and, depending on the phase of the moon and the favor of the Gods,
   sometimes comes up and sometimes doesnt

   there is a line in /etc/modules that looks like

    alias eth1 weirddevice

  eth2 is to be a hot plugged PCMCIA ethernet device


In the cases when "weirddevice" properly comes up, I can
 see it's driver in lsmod,
 see it's interface in ifconfig as eth1,
 and then when I plug in the PCMCIA card
  it gets eth2, and works fine

In the cases when "weirddevice" doesnt come up, I can
  still see it's driver in lsmod
   but it's marked "(unused)"
  dont see it in ifconfig
  and then when I plug in the PCMCIA card
   it gets eth1,
    i can see the module driver in lsmod
    i can see the interface in eth1
   BUT
    it doesnt work, and the cardmgr error log says that cardmgr keeps trying to reset the card to make it work


I suspect that the cardmgr is loading the correct card driver module,
but then some sort of argument is happening under the hood, as the
card driver knows that it registered eth1, but the modules.conf has
the "alias eth1 weirddevice" line.

I'm feeling that the easiest way to make my headache go away is be
able to somehow insist to each network driver "YOU go in eth1, no
matter what, and YOU go in eth2, no matter if their is a eth1 or not".

I cannot do this by MAC address, because I have a small herd of these
boxes, with different MACs for each interface in each box, and, if my
employers dreams come true, there will soon enough be hundreds and
then thousands of these boxes.

If it's not too terribly hard to modify a network driver to go to an
interface specified as a module option, I can probably hack that into
the module drivers (I do have the source to them, thank gods.)

-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
