Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263157AbVCDXw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbVCDXw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbVCDXuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:50:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:18669 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263339AbVCDWlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:41:06 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <20050304135429.GC3485@openzaurus.ucw.cz>
References: <422428EC.3090905@jp.fujitsu.com>
	 <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
	 <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
	 <200503010910.29460.jbarnes@engr.sgi.com>
	 <20050304135429.GC3485@openzaurus.ucw.cz>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 09:37:25 +1100
Message-Id: <1109975846.5680.305.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 14:54 +0100, Pavel Machek wrote:
> Hi!
> 
> > > If there's no ->error method, at leat call ->remove so one device only
> > > takes itself down.
> > >
> > > Does this make sense?
> > 
> > This was my thought too last time we had this discussion.  A completely 
> > asynchronous call is probably needed in addition to Hidetoshi's proposed API, 
> > since as you point out, the driver may not be running when an error occurs 
> > (e.g. in the case of a DMA error or more general bus problem).  The async
> 
> Hmm, before we go async way (nasty locking, no?) could driver simply
> ask "did something bad happen while I was sleeping?" at begining of each
> function?
> 
> For DMA problems, driver probably has its own, timer-based,
> "something is wrong" timer, anyway, no?

No, there is no nasty locking, when the callback happens, pretty much
all IOs have stopped anyway due to errors, and we aren't on a critical
code path.

Polling for error might be possible, but async notification is the way
to go because whatever does error management need to be able to
separately: 

 - notify all drivers on the affected bus segment
 - one the above is done, and based on system/driver capabilities (API
to be defined) eventually re-enable IO access and do a new round of
notifications
 - based on system/driver capabilities, eventually reset the slot and
notify drivers to re-initialize themselves.

Ben.


