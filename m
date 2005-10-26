Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVJZTIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVJZTIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVJZTIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:08:42 -0400
Received: from web50111.mail.yahoo.com ([206.190.39.137]:19293 "HELO
	web50111.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964864AbVJZTIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:08:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=N1mwlfdwaVmiI5pkUYsj526F6vlQDqojoGR+UiQ2D9CwY4UvgiAqAeCzAhooWfWZYtDe2KNEahTuXyNrMmR1Cb2GVt+2rKaJABtdJ84EBDo5S2mlUVJolkG1072qzlFKo6sVm7wRIa4xN3TDUKLspiGO9l8dpKNDGdHT5R06f3E=  ;
Message-ID: <20051026190838.85701.qmail@web50111.mail.yahoo.com>
Date: Wed, 26 Oct 2005 12:08:38 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: EDAC (was: Re: 2.6.14-rc5-mm1)
To: linux-kernel@vger.kernel.org
Cc: sander@humilis.net, Avuton Olrich <avuton@gmail.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051026131157.GA12963@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Sander <sander@humilis.net> wrote:

> Alan Cox wrote (ao):
> > On Mer, 2005-10-26 at 09:48 +0200, Sander wrote:
> > > Stupid question: should EDAC work on a Via Epia
> board? Because I see the
> > > "Detected Parity Error" messages too (and a lot
> of them), but figured
> > > that the option is just 'not an option' :-)
> > 
> > The PCI parity check should work on every
> correctly built PCI card and
> > bridge. 
> > 
> > > If it should work I'll be happy to send the
> error and lspci if that
> > > helps.
> > 
> > Please do. I'm trying to find the common items
> that cause spurious pci
> > errors
> 
> Via Epia MII 10000, kernel 2.6.14-rc4-mm1:
> 
> $ grep EDAC .config
> # EDAC - error detection and reporting (RAS)
> CONFIG_EDAC=y
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_MM_EDAC=y
> # CONFIG_EDAC_AMD76X is not set
> # CONFIG_EDAC_E7XXX is not set
> # CONFIG_EDAC_E752X is not set
> # CONFIG_EDAC_I82875P is not set
> # CONFIG_EDAC_I82860 is not set
> # CONFIG_EDAC_R82600 is not set
> CONFIG_EDAC_POLL=y
> 
> 
> [42949380.590000] Freeing unused kernel memory: 168k
> freed
> [42949381.350000] PCI- Detected Parity Error on
> 0000:00:01.0 0000:00:01.0
> [42949382.350000] PCI- Detected Parity Error on
> 0000:00:01.0 0000:00:01.0
> [42949383.350000] PCI- Detected Parity Error on
> 0000:00:01.0 0000:00:01.0
> [42949384.350000] PCI- Detected Parity Error on
> 0000:00:01.0 0000:00:01.0
> 
> etc
> 

The EDAC scanning code first scans the STATUS register
of all the PCI devices in the system. This status
register reflects operations on the main bus.
Second, the code scans the SECONDARY STATUS register
of all bridge devices, which reflects operations on
the sub-bus.

This instance (0000:00:01.0) of output shows me the
VIA VT8633 is generating the parity bit. The default
poll interval if 1000 ms and the above output shows
this. This bridge is either having a parity error on
the main bus OR more likely is generating false
positives. How to determine which? More investigation
is needed.  

But at least there is some DETECTION occurring. If it
is false positives, then this device could be placed
on the "future" blacklist list and at boot time fed to
the EDAC module.

There is a difference between "detecting" the parity
and "handling" it. Currently edac is setup to detect
and report. 

doug thompson


> 
> lspci -vxx:
> 

<snip>

> 0000:00:01.0 PCI bridge: VIA Technologies, Inc.
> VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal
> decode])
> 	Flags: bus master, 66MHz, medium devsel, latency 0
> 	Bus: primary=00, secondary=01, subordinate=01,
> sec-latency=0
> 	Memory behind bridge: e4000000-e5ffffff
> 	Prefetchable memory behind bridge:
> e0000000-e3ffffff
> 	Capabilities: [80] Power Management version 2
> 00: 06 11 91 b0 07 01 30 a2 00 00 04 06 00 00 01 00
> 10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 a2
> 20: 00 e4 f0 e5 00 e0 f0 e3 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

