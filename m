Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWJMQgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWJMQgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWJMQgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:36:38 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:19371 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751749AbWJMQgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:36:37 -0400
Date: Fri, 13 Oct 2006 10:36:35 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Adam Belay <abelay@MIT.EDU>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
Message-ID: <20061013163635.GC11633@parisc-linux.org>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org> <1160753187.25218.52.camel@localhost.localdomain> <1160753390.3000.494.camel@laptopd505.fenrus.org> <1160755562.25218.60.camel@localhost.localdomain> <1160757260.26091.115.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160757260.26091.115.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 12:34:20PM -0400, Adam Belay wrote:
> I agree this needs to be fixed.  However, as I previously mentioned,
> this isn't the right place to attack the problem.  Remember, this wasn't
> originally a kernel regression.  Rather it's a workaround for a known
> X/lspci/whatever bug.  It's not the kernel's job to babysit userspace.
> If a userspace app that has the proper permissions decides to take a
> course of action that could potentially crash the system, then it has a
> right to do so.  There are probably dozens of vectors for these sorts of
> problems (e.g. mmap as Arjan has mentioned) so why stop at the pci
> config sysfs interface?

The patch I posted (to deny user access while the device is
transitioning D-states) is to fix a bug where *any* local user can bring
the system into undefined territory, simply by typing lspci at the right
moment.  No special permission is needed.

I hadn't realised that pci_block_user_cfg_access() would call
pci_save_state().  There's only one other user of pci_block_user_cfg_access()
-- drivers/scsi/ipr.c and I think it could be induced to call
pci_save_state() itself.  It's an odd asymmetry anyway -- block calls
save state, but unblock doesn't call restore_state.
