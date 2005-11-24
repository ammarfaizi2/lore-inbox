Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbVKXUt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbVKXUt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbVKXUt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:49:28 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:225 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161046AbVKXUt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:49:27 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
Date: Thu, 24 Nov 2005 21:50:22 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
References: <1132715288.26560.262.camel@gaston> <200511240122.46125.rjw@sisk.pl> <1132795396.26560.382.camel@gaston>
In-Reply-To: <1132795396.26560.382.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511242150.23205.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24 of November 2005 02:23, Benjamin Herrenschmidt wrote:
> 
> > Unfortunately with this patch the EHCI controller in my box (Asus L5D,
> > x86-64 kernel) does not resume from suspend.  Appended is the relevant
> > snippet from the serial console log (EHCI is the only device using IRQ #5).
> 
> Hrm... let me see... You are getting an interrupt for EHCI after it has
> been resumed, so it should work.
> 
>  /me double-checks the patch
> 
> > ehci_hcd 0000:00:02.2: lost power, restarting
> 
> Hrm... I can't find that line in the code...
> 
>  /me rechecks with david's other patches
> 
> Ah ... I see it. There might have been some screwup between david's
> patch and mine.
> 
> Make sure that 
> 
>        set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> 
> Is still done before anything else in ehci_pci_resume().

Well, it's there (actually the problem occurs in vanilla 2.6.15-rc2-mm1 that
contains the patch).  Do you mean it should go before the

if (readl(&ehci->regs->configured_flag) != FLAG_CF)
		goto restart;

thing?

> It may be worth following it with a memory barrier actually... just in case
> (due to the absence of locks in that area).

wmb()?

Rafael
