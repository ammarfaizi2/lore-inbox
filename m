Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbUB2Eog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 23:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUB2Eog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 23:44:36 -0500
Received: from mailout1.pacific.net.au ([61.8.0.84]:23277 "EHLO
	mailout1.pacific.net.au") by vger.kernel.org with ESMTP
	id S261972AbUB2Eod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 23:44:33 -0500
Date: Sun, 29 Feb 2004 15:44:26 +1100
From: David Luyer <david@luyer.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-rc1
Message-ID: <20040229044426.GA4381@pacific.net.au>
References: <Pine.LNX.4.58L.0402051037190.9788@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402051037190.9788@logos.cnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 10:44:31AM -0200, Marcelo Tosatti wrote:
> Here goes the first release candidate.
> 
> It contains mostly networking updates, XFS update, amongst others.
> 
> This release contains a fix for excessive inode memory pressure with
> highmem boxes. Help is specially wanted with testing this on heavy-load
> highmem machines.

How is this likely to manifest itself?

We just had a box which crashed only 2 hour from deployment, and
reading over the recent changes this seems like a potential cause
(although being new, faulty hardware is always a possibility); the
last items on its serial console were:

INIT: Sending processes the TERM signal
memory.c:100: bad pmd 000001e3.
memory.c

Was still responding to ICMP after crash.

Details:

  * running 2.4.25 (release with small local patch to put MPT SCSI devices
    before Adaptec SCSI devices, as "scsihosts" cannot do this)

  * IBM x335

  * dual Xeon 3.066GHz (hyperthreads in 2.4.25)

  * 2.5Gb RAM (HIGHMEM4G)

  * high CPU load (two processes around 75% of a CPU each at time of crash,
    being bzip2 compression of gigabytes of data, and some other processes
    using somewhat less CPU for network and disk IO)

  * moderate IO load (3Mbps on tg3 ethernet, more than double that on each
    of MPT SCSI and AIC SCSI)

  * high inode / file descriptor load -- a single process may open hundreds
    of thousands of file desciptors over a 5 minute period and then close
    them all at once; file-max is set to 1024^2

  * newly deployed (ie no track record of stability to refer to)

Role of system is basically to receive a constant 3Mbps stream of UDP data
which is then written to the internal RAID array, this data is then read
from the internal array and written to an external RAID array (in the process
doubling in volume; each piece of data ends up in two places; and sometimes
being read/written a few times before ending up in the right place) and
ultimately compressed and archived.

I've rebooted into 2.4.25 for a second chance but if it fails again,
will reboot to 2.4.24 and then if that fails, revert to old hardware
and kernel (which was running kernel 2.4.24 on an old Intel ISP2150).

David.
