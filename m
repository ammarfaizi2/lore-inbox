Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288113AbSA3Cwg>; Tue, 29 Jan 2002 21:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288173AbSA3Cw1>; Tue, 29 Jan 2002 21:52:27 -0500
Received: from codepoet.org ([166.70.14.212]:5547 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288113AbSA3CwJ>;
	Tue, 29 Jan 2002 21:52:09 -0500
Date: Tue, 29 Jan 2002 19:52:12 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec 1480b SlimSCSI vs hotplug
Message-ID: <20020130025212.GA5240@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020129232629.GB937@codepoet.org> <200201300048.g0U0mrI59231@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201300048.g0U0mrI59231@aslan.scsiguy.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jan 29, 2002 at 05:48:53PM -0700, Justin T. Gibbs wrote:
> >Does this look agreeable?
> 
> The only thing you've really changed is the class_mask.  I don't
> understand why testing against *more bits* of the class allows your
> card to be detected.  Can you explain why the old code fail?

Exactly, the class_mask is the significant bit.  The rest I just
tidied since I hate seeing magic numbers.  Anyways, I started off
with the simple observation that it didn't work.  Watching
/sbin/hotplug (diethotplug with debugging enabled) closely during
add events showed me the following:


    Jan 29 19:34:59 sage kernel: cs: cb_alloc(bus 3): vendor 0x9004, device 0x6075
    Jan 29 19:34:59 sage kernel: PCI: Enabling device 03:00.0 (0000 -> 0003)
    Jan 29 19:34:59 sage hotplug: pci_handler: action = add
    [---------snip--------]
    Jan 29 19:34:59 sage hotplug: match_vendor: vendor = 9004, device = 6075, subvendor = 9004, subdevice = 7560
    [---------snip--------]
    Jan 29 19:34:59 sage hotplug: match_vendor: looking at aic7xxx
    Jan 29 19:34:59 sage hotplug: match_vendor: loading aic7xxx
    Jan 29 19:34:59 sage hotplug: load_module: loading module aic7xxx
    Jan 29 19:34:59 sage hotplug: match_vendor: looking at aic7xxx
    Jan 29 19:34:59 sage hotplug: match_vendor: vendor check failed 9005 != 9004

Here we can see it is looking at aic7xxx twice, once for vendor
0x9004, where it notices that the vendor matches, but then fails
to match due to the 0xFFFF00 class_mask filter, and once for
vendor 9005 which of course doesn't match.  After changing the
class_mask to ~0 I now see:


    Jan 29 19:44:52 sage kernel: cs: cb_alloc(bus 3): vendor 0x9004, device 0x6075
    Jan 29 19:44:52 sage kernel: PCI: Enabling device 03:00.0 (0000 -> 0003)
    Jan 29 19:44:52 sage hotplug: pci_handler: action = add
    [---------snip--------]
    Jan 29 19:44:52 sage hotplug: match_vendor: vendor = 9004, device = 6075, subvendor = 9004, subdevice = 7560
    [---------snip--------]
    Jan 29 19:44:52 sage hotplug: match_vendor: looking at aic7xxx
    Jan 29 19:44:52 sage hotplug: match_vendor: loading aic7xxx
    Jan 29 19:44:52 sage hotplug: load_module: loading module aic7xxx
    Jan 29 19:44:52 sage hotplug: match_vendor: looking at aic7xxx
    Jan 29 19:44:52 sage hotplug: match_vendor: vendor check failed 9005 != 9004
    Jan 29 19:44:52 sage cardmgr[561]:   product info: "Adaptec", "APA-1480 SCSI Host Adapter", "Version 1.10       ", ""
    Jan 29 19:44:52 sage cardmgr[561]:   manfid: 0x012f, 0xcb01  function: 8 (SCSI)
    Jan 29 19:44:52 sage cardmgr[561]:   PCI id: 0x9004, 0x6075

So let me turn the question back to you:  What is the intended 
purpose of masking out part of the class space?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
