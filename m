Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTJRBcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 21:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTJRBcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 21:32:12 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:45215 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261271AbTJRBcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 21:32:08 -0400
From: Matt Chapman <matthewc@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 18 Oct 2003 11:31:37 +1000
Cc: davidm@hpl.hp.com, bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-ID: <20031018013137.GA16845@cse.unsw.EDU.AU>
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017155028.2e98b307.akpm@osdl.org> <200310171725.10883.bjorn.helgaas@hp.com> <20031017165543.2f7e9d49.akpm@osdl.org> <16272.34681.443232.246020@napali.hpl.hp.com> <20031017174955.6c710949.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017174955.6c710949.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 05:49:55PM -0700, Andrew Morton wrote:
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> >
> > One philosophy states that if
> > your kernel touches random addresses, it's better to signal a visible
> > error (machine-check) than to risk silent data corruption.
> 
> An access to an illegal address should generate a fault, period.  This puts
> the processing into the hands of software.  If software chooses to silently
> ignore the fault (ie: "silent data corruption") then it is poorly designed.

It *does* signal a fault, in the form of a machine check.  On other
architectures I'm familiar with this is usually implemented as an
interrupt, but the idea is similar - when the system bus controller
detects a bad address on the bus, it returns all 1s (for a read) and
signals an interrupt.  Usually you can turn this interrupt off (and
most likely you can on Itanium chipsets too) but that is not a good
idea.

The problem is that this interrupt is not synchronous with respect to
the instruction stream, and this makes it difficult for software to
recover from, particularly in a monolithic system like Linux where you
can't just terminate the faulting driver.  The best you can usually do
is to print the details and hope that it's a once-off.  It is not
something that you can sensibly use to abort copy_*_user.

In any case touching random addresses is just plain bad.  What if
there's a device mapped there which happens to have read side effects
like clearing the interrupt cause, so e.g. every time you read /dev/mem
you cause a timeout on your SCSI bus :)

Matt

