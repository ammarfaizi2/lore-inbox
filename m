Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTKFXnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTKFXnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:43:21 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46319 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263861AbTKFXnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:43:12 -0500
From: Schulman.Andrew@epamail.epa.gov (by way of Andrew Schulman
	<andrex@deadspam.com>)
Subject: hw_random and the missing Intel RNGs
Date: Thu, 6 Nov 2003 18:43:09 -0500
User-Agent: KMail/1.5.4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311061843.09676.andrex@REMOVEalumni.utexas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hw_random has two problems with Intel chipsets:

(1) It fails to detect when no RNG is present.
(2) Intel has stopped putting RNGs into their chipsets.

I've written a description of this problem at
http://home.comcast.net/~andrex/hardware-RNG/index.html.  Here's a summary:

(1) On my home machine, with an Intel 865 chipset (82865PE + 82801ER)
and kernel 2.6.0-test4, hw_random loads normally, but /dev/hwrandom
emits only 0xFF's.  With debugging options compiled in, hw_random emits
only normal diagnostic messages; there are no complaints about a missing
RNG (the RNG Present bit of the hardware status register is on).

(2) hw_random doesn't check for the existence of an 82802 firmware hub.
Instead, it looks on the PCI bus for various devices in the 82801 I/O 
controller hub family.  If it finds them, it implicitly concludes that the 
82802 must also be present.

(3) But even if an 82802 is present, it probably doesn't matter because
Intel is no longer putting RNGs into these devices.  See the disclaimer
in the box at http://www.intel.com/design/security/rng/rng.htm.

(4) Intel has confirmed to me by email that there is no RNG in the 865 and 875 
chipsets, and they will not be putting RNGs into future chipsets.  As for 
older chipsets, the picture isn't entirely clear.  The RNG appears to have 
been an optional component; some chipsets got them, some didn't.

(5) I've scoured the web and newsgroups for cases of someone successfully 
using a hardware RNG in a recent Intel chipset.  So far I haven't found 
_anyone_ who can verify to me that they actually have a working RNG.

Proposals:

Users of hw_random and rngd need to be given more help in determining
whether they have an RNG.

- Better software checks:  This would be the best option, but
unfortunately, as I documented at the link above, it's hard to test with
any certainty whether an RNG is present.  Part of the equation is
checking reliably for an 82802.  But in my case, I believe that I have
an 82802, with no RNG.  So checking for an 82802 doesn't help.  My case
also shows that even the RNG Present bit is unreliable (which the
datasheet admits-- thanks a lot Intel).

- Better documentation: hw_random.txt and rngd.8 need to provide more
information about which chipsets really have hardware RNGs; how an end
user can tell if they have one; and what will happen if you don't have
one but use hw_random anyway.  In particular, hw_random.txt right now
implies that all Intel i8xx chipsets have RNGs.  (Not necessarily the authors' 
fault, since much of the Intel documentation does the same.)

- Better diagnostic messages: rngd performs FIPS tests on the output of
/dev/hwrandom, and sends "failed fips test" messages to syslog if it
doesn't pass.  This is fine as far as it goes, but at the very least,
the user needs to be made aware (in hw_random.txt and rngd.8) that if
rngd continuously emits these messages, they probably don't have an RNG.
A better solution would be to improve the diagnostic or at least the
error message, to warn the user that they probably don't have an RNG.

I'm sorry that it's come to this.  I was looking forward to using my
hardware RNG, and to packaging rng-tools for Debian.  But now I can't do
either, because Intel has killed their RNGs.

