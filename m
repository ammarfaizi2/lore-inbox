Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbTEMXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTEMXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:33:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17929 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261275AbTEMXdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:33:05 -0400
Date: Wed, 14 May 2003 00:43:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030514004332.I15172@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk> <20030513163854.A27407@infradead.org> <20030513131754.7f96d4d0.akpm@digeo.com> <20030513222532.GA13317@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513222532.GA13317@suse.de>; from davej@codemonkey.org.uk on Tue, May 13, 2003 at 11:25:32PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 11:25:32PM +0100, Dave Jones wrote:
> Though, for some archs (sparc32 springs to mind), we may end up waiting
> quite a while, so perhaps just settle on a handful of 'to be kept
> up-to-date' archs ?

As far as the ARM patch is concerned, last time I checked, there's still
a fair amount outstanding.  Recently, I haven't been able to put the
usual amount of time into Linux, but there is a partial merge pending
as of tonight (with 57K of about a 1.8MB overall ARM patch.)

I don't think I'm going to get through all this and get it sanely
merged for 2.6, which means ARM will probably end up spending yet
another stable kernel release outside the main stream kernel.  That
coupled with probably a raft of new ARM machine types during 2.6
with their own random oddball drivers.

Stuff outstanding (this is based upon 2.5.68 + knowledge of what's
changed and pending merging, so might not be completely accurate):

Core arch-independent stuff:
- modules / /proc/kcore / vmalloc
  This needs sorting and testing to ensure that stuff like gdb vmlinux
  /proc/kcore works as expected.  I believe this is the only show stopper
  preventing any ARM platform being built in Linus' kernel.

- update acorn partition parsing code - making all acorn schemes
  appear in check.c so we don't have to duplicate the scanning of
  multiple types, and adding support for eesox partitions.

- lib/inflate.c must not use static variables (causes these to be
  referenced via GOTOFF relocations in PIC decompressor.  We have
  a PIC decompressor to avoid having to hard code a per platform
  zImage link address into the makefiles.)


Drivers:
- several OSS drivers for SA11xx-based hardware in need of ALSA-ification
  and L3 bus support code for these.

- UCB1[23]00 drivers, currently sitting in drivers/misc in the ARM tree.
  (touchscreen, audio, gpio, type device.)

- EPXA (ARM platform) PLD hotswap drivers (drivers/pld)

- linux/sound/drivers/mpu401/mpu401.c and linux/sound/drivers/virmidi.c
  complained about 'errno' at some time in the past, need to confirm
  whether this is still a problem.

- need to complete ALSA-ification of the WaveArtist driver for both
  NetWinder and other stuff (there's some fairly fundamental differences
  in the way the mixer needs to be handled for the NetWinder.)

- unconverted keyboard/mouse drivers (there's a deadline of 2.6.0
  currently on these remaining in my/Linus' tree.)

- SA11xx USB client/gadget code
  (David B has been doing some work on this, and keeps trying to prod me,
   but unfortunately I haven't had the time to look at his work, sorry
   David.)

- I think we need a generic RTC driver (which is backed by real RTCs).
  Integrator-based stuff has a 32-bit 1Hz counter RTC with alarm, as
  has the SA11xx, and probably PXA.  There's another implementation
  for the RiscPC and ARM26 stuff.  I'd rather not see 4 implementations
  of the RTC userspace API, but one common implementation so that stuff
  gets done in a consistent way.

  We postponed this at the beginning of 2.4 until 2.5 happened.  We're
  now at 2.5, and I'm about to add at least one more (the Integrator
  implementation.)  This isn't sane imo.

- missing raw keyboard translation tables for all ARM machines.  Haven't
  even looked into this at all.  This could be messy since there isn't
  an ARM architecture standard.  I'm presently hoping that it won't be
  an issue.  If it does, I guess we'll see drivers/char/keyboard.c
  explode.

- network drivers.  ARM people like to add tonnes of #ifdefs into these
  to customise them to their hardware platform (eg, chip access methods,
  addresses, etc.)  I cope with this by not integrating them into my
  tree.  The result is that many ARM platforms can't be built from even
  my tree without extra patches.  This isn't sane, and has bread a
  culture of network drivers not being submitted.  I don't see this
  changing for 2.6 though.


Net:
- Refuse IrDA initialisation if sizeof(structures) is incorrect
  (I'm not sure if we still need this; I think gcc 2.95.3 on ARM shows
   this problem though.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

