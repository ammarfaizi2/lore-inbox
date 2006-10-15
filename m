Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422877AbWJOTep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422877AbWJOTep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422876AbWJOTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:34:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422874AbWJOTen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:34:43 -0400
Date: Sun, 15 Oct 2006 12:34:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: alan@lxorguk.ukuu.org.uk, matthew@wil.cx, val_henson@linux.intel.com,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-Id: <20061015123432.4c6b7f15.akpm@osdl.org>
In-Reply-To: <20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<20061013214135.8fbc9f04.akpm@osdl.org>
	<20061014140249.GL11633@parisc-linux.org>
	<20061014134855.b66d7e65.akpm@osdl.org>
	<20061015032000.GP11633@parisc-linux.org>
	<20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<1160922082.5732.51.camel@localhost.localdomain>
	<20061015135756.GD22289@parisc-linux.org>
	<20061015104544.5de31608.akpm@osdl.org>
	<20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006 12:16:31 -0700
David Brownell <david-b@pacbell.net> wrote:

> (From Alan Cox:)
> > The underlying bug is that someone marked pci_set_mwi must-check, that's
> > wrong for most of the drivers that use it. If you remove the must check
> > annotation from it then the problem and a thousand other spurious
> > warnings go away.
> 
> Yes, there seems to be abuse of this new "must_check" feature.
> 
> 
> (From Andrew Morton:)
> > But if MWI _does_ make a difference to performance then we should tell
> > someone that it isn't working rather than silently misbehaving?
> 
> Thing is, a "difference to performance (alone)" != "misbehavior".
> 
> If it affected correctness, then a warning would be appropriate.
> 
> Most drivers should be able to say "enable MWI if possible, but
> don't worry if it's not possible".  Only a few controllers need
> additional setup to make MWI actually work ... if they couldn't
> do that setup, that'd be worth a warning before they backed off
> to run in a non-MWI mode.
> 

So the semantics of pci_set_mwi() are "try to set MWI if this
platform/device supports it".

In that case its interface is misdesigned, because it doesn't discriminate
between "yes-it-does/no-it-doesn't" (which we don't want to report, because
either is expected and legitimate) and "something screwed up", which we do
want to report, because it is always unexpected.

So an appropriate return value protocol would be

0:	No error, unable to set MWI
1:	No error, able to set MWI
-EFOO:	Error
