Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWJPBK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWJPBK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 21:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWJPBK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 21:10:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751191AbWJPBK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 21:10:58 -0400
Date: Sun, 15 Oct 2006 18:10:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       matthew@wil.cx, val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-Id: <20061015181044.ec414e4f.akpm@osdl.org>
In-Reply-To: <17714.54766.390707.532248@cargo.ozlabs.ibm.com>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20061015123432.4c6b7f15.akpm@osdl.org>
	<200610151545.59477.david-b@pacbell.net>
	<20061015161834.f96a0761.akpm@osdl.org>
	<1160956960.5732.99.camel@localhost.localdomain>
	<20061015164402.f9b8b4d2.akpm@osdl.org>
	<17714.54766.390707.532248@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 10:44:30 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Andrew Morton writes:
> 
> > Let me restore the words from my earlier email which you removed so that
> > you could say that:
> > 
> >   For you the driver author to make assumptions about what's happening
> >   inside pci_set_mwi() is a layering violation.  Maybe the bridge got
> >   hot-unplugged.  Maybe the attempt to set MWI caused some synchronous PCI
> >   error.  For example, take a look at the various implementations of
> >   pci_ops.read() around the place - various of them can fail for various
> >   reasons.  
> 
> Maybe aliens are firing a ray-gun at the card.  I think it's
> fundamentally wrong for the driver to deny service completely because
> of a maybe.
> 
> Either there was a transient error that only affected the attempt to
> set MWI, in which case a printk (inside pci_set_mwi!) is appropriate,
> and we carry on.  Or there is a persistent error condition, in which
> case the driver will see something else fail soon enough - something
> that the driver actually needs to have working in order to operate -
> and fail at that point.
> 
> For the driver to stop and refuse to go any further because of an
> error in pci_set_mwi has far more disadvantages than advantages.
> 

Sure.

So I think what we're needing in this case is:

- A modified version of Willy's patch which returns 0 if MWI was enabled,
  1 if MWI isn't available.

- A printk if something went bad

  It appears that the various functions which try to match the line sizes
  already have printks if something went wrong, but they're using
  KERN_DEBUG facility level and that warning would dupliate the new one in
  pci_set_mwi().

  And although the various implementations of pci_read_config_foo() and
  pci_write_config_foo() can return error codes, we have so many instances
  where we're not checking it, I don't think it's practical to try to start
  doing that everywhere.

- drop the __must_check.

Question is, should pci_set_mwi() ever return -EFOO?  I guess it should, in
the case where setting the line size didn't work out.
