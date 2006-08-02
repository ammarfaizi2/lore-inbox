Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWHBXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWHBXDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWHBXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:03:20 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:52364 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932301AbWHBXDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:03:19 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Pavel Roskin <proski@gnu.org>
Subject: Re: pccards are not detected
Date: Thu, 3 Aug 2006 01:02:47 +0200
User-Agent: KMail/1.7.2
Cc: Marcus Better <marcus@better.se>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
References: <200608021931.46058.daniel.ritz-ml@swissonline.ch> <200608022001.45140.daniel.ritz-ml@swissonline.ch> <1154551499.7714.13.camel@dv>
In-Reply-To: <1154551499.7714.13.camel@dv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030102.48045.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-02.tornado.cablecom.ch 1378;
	Body=7 Fuz1=7 Fuz2=7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 22.44, Pavel Roskin wrote:
> On Wed, 2006-08-02 at 20:01 +0200, Daniel Ritz wrote:
> > On Wednesday 02 August 2006 19.42, Pavel Roskin wrote:
> > > It depends.  For some custom systems, BIOS may be a lifesaver.  Let's
> > > not change the whole logic of the PCI detection because of one broken
> > > BIOS.
> > 
> > errm. 2.6.16 automatically uses direct access. if first shows the PCI BIOS
> > line, then the direct access line in dmesg. pci_raw_ops is first set to
> > PCI_BIOS to be overwritten with direct access immediatley after that.
> > 
> > eg. from a 2.6.16.20 on a buggy box:
> > 	PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=0
> > 	PCI: Using configuration type 1
> > cardbus would be bus 1-4. 2.6.17 breaks here...
> 
> If it's a laptop and CardBus is integrated, it's a BIOS bug.  BIOS
> should know about integrated hardware.  No excuses.
> 
> > > The standard solution for such problems is to add a "quirk" to
> > > drivers/pci/quirks.c or arch/i386/kernel/quirks.c
> 
> > no. it is a clear regression and the patch in fact just restores the old
> > behaviour with the exception that the ordering is more clear now than it
> > was before...
> 
> My intention was just to remind you about the quirks.
> 
> > 2.6.16: pci bios comes first, is overriden by direct access
> > 2.6.17: pci bios comes first. direct access is never used if pci bios probe "worked"
> > 2.6.17+patch: pci direct access probed first, if it fails pci bios is used.
> 
> The way you put it above, it sounds like a major change.  But I missed
> the actual patch.  Maybe it just reorders a few printk()s compared to
> 2.6.16, I don't know.
> 

ok, in other words:
2.6.16: end result: direct access; if direct doesn't work: pcibios
2.6.17: end result: pci bios (only direct if pcibios fails! )
2.6.17+patch: end result: direct access; if direct doesn't work: pcibios
=> net result is the same, but less code is executed, order is clear always.

> I still believe that adding quirk would be a good solution, in
> particular because it would work even if direct PCI probing is disabled.
> And then you can reorder the probing as much as you want.
> 

no, a quirk is bad for the simple reason that 2.6.16 used to work on systems
(laptops) where 2.6.17 fails for cardbus...there's no way you can wait on all
the reports and add quirks for them one-by-one. and distros are still using
kernel < 2.6.17...

btw. it's commit 92c05fc1a32e5ccef5e0e8201f32dcdab041524c
([PATCH] PCI: Give PCI config access initialization a defined ordering)
that broke things on those laptops. cc'ing Andi...

Andi, for reference:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115454028402107

rgds
-daniel

