Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTAKJfy>; Sat, 11 Jan 2003 04:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266460AbTAKJfy>; Sat, 11 Jan 2003 04:35:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14854 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266379AbTAKJfw>; Sat, 11 Jan 2003 04:35:52 -0500
Date: Sat, 11 Jan 2003 09:44:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alexander Koch <efraim@clues.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getting my serial ports back? ;-)
Message-ID: <20030111094435.A14987@flint.arm.linux.org.uk>
Mail-Followup-To: Alexander Koch <efraim@clues.de>,
	linux-kernel@vger.kernel.org
References: <20030111101241.GA3589@clues.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030111101241.GA3589@clues.de>; from efraim@clues.de on Sat, Jan 11, 2003 at 11:12:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:12:42AM +0100, Alexander Koch wrote:
> devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x1
> pnp: the driver 'serial' has been registered
> pnp: pnp: match found with the PnP device '00:0f' and the driver 'serial'
> pnp: the device '00:0f' has been activated
> devfs_register(tts/2): could not append to parent, err: -17
> tts/2 at I/O 0x3e8 (irq = 4) is a 16550A
> pnp: pnp: match found with the PnP device '00:10' and the driver 'serial'
> pnp: the device '00:10' has been activated
> devfs_register(tts/3): could not append to parent, err: -17
> tts/3 at I/O 0x2e8 (irq = 3) is a 16550A

Argh.  What I suspect has happened here is:

- the serial driver probed the ports tts/0 and tts/1 at I/O 0x3f8 and
  0x2f8, and found two UARTS there.  So it claimed IO resources at
  these addresses.

  (please show earlier messages in the boot log to confirm this.)

- PNP came along, and noticed that 0x3f8 and 0x2f8 were used, so re-
  located the ports to 0x3e8 and 0x2e8, and told the serial driver
  about them.

Since the serial driver knew there were ports at tts/0 and tts/1, it
allocated tts/2 and tts/3 to the "PNP" ports.

However, the original ports found are no longer at 0x3f8 and 0x2f8,
and therefore no longer work.

> That's coming from gpm startup, at least one of it, although
> I have /dev/tts/0 in my gpm.conf... Ah, it's hardcoded in the
> binary, it seems (doing a strings on it).

A "get you working" fix should be to tell gpm.conf to use /dev/tts/2

As for the -17 (EEXIST) error with devfs, I'd need to see the other
serial messages earlier in the boot log to work out what's going on,
as well as the kernel version the messages came from.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

