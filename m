Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUJNWrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUJNWrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUJNWn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:43:28 -0400
Received: from goose.movealong.org ([66.93.3.77]:62156 "EHLO
	goose.movealong.org") by vger.kernel.org with ESMTP id S268135AbUJNWkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:40:43 -0400
Date: Thu, 14 Oct 2004 18:40:40 -0400
From: Nate Riffe <inkblot@movealong.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Norbert van Nobelen <Norbert@edusupport.nl>
Subject: Re: 2.8.6.1 deadlock and ext3/i2o corruption (Was: Spam on the list)
Message-ID: <20041014224040.GA27670@movealong.org>
References: <416EA06E.3050608@colannino.org> <Pine.LNX.4.53.0410141201470.7694@chaos.analogic.com> <200410142041.33694.Norbert@edusupport.nl> <200410142325.31972.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410142325.31972.rjw@sisk.pl>
X-pw: reindeer flotilla
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot believe Rafael J. Wysocki said this on the ENTARNET:
> On Thursday 14 of October 2004 20:41, Norbert van Nobelen wrote:
> > Can't we run it through spamassassin with a whitelist for the real users on 
> > the list, and standard filters for the new users. With keeping track of the 
> > pointsscore they will be auto whitelisted if they are not spammers.
> 
> I'd rather not like _legitimate_ messages being filtered out as 
> false-positives.  You can always run spamassassin locally with any rules you 
> like and feed the LKML traffic to it before it gets to your mailbox.

This whole thread is spam.  Can we talk about kernels or something?

I've recently (re-)subscribed to the list and I've been watching to
see if anyone was discussing a problem like the one I had.

Specifically, about three weeks ago I attempted to build and boot a
series of 2.8.6.1 kernels which each failed in exactly the same way.
With each kernel, the system would freeze up solid partway through the
initscripts.  The *timing* of the deadlock was incredibly consistent,
but related to any specific activity in userspace which I determined
after enabling and disabling various things in my initscripts.  Every
permutation that I tried hung about 45 seconds after LILO handed
control over to the kernel.

I tried about a half dozen slightly different configs to try to
isolate the problem and I have determined that none of the following
made any difference: ACPI vs. no ACPI, i2o_block vs. dpt_i2o (for an
Adaptec 2100S), eepro100 vs. 3c59x (they're both in there, but I only
use one anymore... it doesn't really matter which as long as it's
eth0), modular vs. static, and probably a couple of others (this was a
few weeks ago, after all).  I gave up and decided to wait for 2.6.9,
and went back to my old and reliable 2.4 kernel.

Fast forward to two days ago, I started to have major problems
exec()ing things and decided to take the machine down.  The root
partition (ext3) was severely corrupted.  /lib, lots of stuff in
/sbin, lots of stuff in /etc, and a few things in /dev had become
unlinked or crossed with other inodes.  In particular, /etc/init.d/rc
had gotten relinked as /lib.

I suspect that the series of crashing 2.8.6.1 kernels introduced
incosistencies in the filesystem which e2fsck never caught because all
it ever did was replay the journal, and as a result my 2.4 kernel was
left working with a corrupted filesystem for three weeks,
proliferating the corruption to new and interesting places.  All other
filesystems (all of which are in LVM volumes) were clean.

MB Chipset: VIA KT133
CPU: 1 Ghz Athlon (Thunderbird)
RAM: 1 GB PC133
Network: 3Com 905B and Intel EE Pro 100
RAID: Adaptec 2100S with 3-way RAID 5 (contains the root partition)
IDE: Promise PDC20265 with a single drive attached

Everything except / is in two LVM groups, one on each of the RAID and
the IDE drive.  Video is in text mode.  Audio, USB, serial ports,
parallel ports, and ISA bus are enabled in the kernel but otherwise
unused.

Last attempted 2.6.8.1 config is here:
http://goose.movealong.org/~inkblot/config-2.6.8.1-goose

I'll do my best to provide more information on request, but I'd like
to avoid taking the system down other than for a new permanent kernel.

-Nate

-- 
--< ((\))< >----< inkblot@movealong.org >----< http://www.movealong.org/ >--
pub  1024D/05A058E0 2002-03-07 Nate Riffe (06-Mar-2002) <inkblot@movealong.org>
     Key fingerprint = 0DAC F5CB D182 3165 D757  C466 CD42 12A8 05A0 58E0
