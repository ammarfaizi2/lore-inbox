Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWDOOAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWDOOAn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 10:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWDOOAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 10:00:43 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:30612 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030250AbWDOOAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 10:00:42 -0400
Subject: Re: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in reset handler
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Ju, Seokmann" <Seokmann.Ju@lsil.com>, Seokmann.Ju@engenio.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20060412220011.2ddd6f63.akpm@osdl.org>
References: <890BF3111FB9484E9526987D912B261901BCC2@NAMAIL3.ad.lsil.com>
	 <20060412220011.2ddd6f63.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 15 Apr 2006 09:00:23 -0500
Message-Id: <1145109623.3573.7.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 22:00 -0700, Andrew Morton wrote:
> Oh my.  That's an awfully long interrupts-off spin.  1.7e7 operations with
> an NMI watchdog timeout of five seconds - I'm surprised it doesn't trigger.
> 
> Is that reading from a PCI register there?   Or main memory?

It's a "mailbox" region, which is a piece of main memory shared between
the driver and the card (allocated using dma_alloc_coherent).

> I'm somewhat surprised that the compiler never "optimises" this into a
> lockup, actually.  That's what `volatile' is for.

The rmb(); below ensures the compiler can't optimise.  However, I do
agree; tagging the mailbox as volatile would show the compiler better
what the intent is.

> Is it not possible to do this with an interrupt?

I'd guess not.  A lot of these types of driver have what's called a
doorbell/mailbox interface which means that as long as there's a command
slot you get access to the device (or wait for an interrupt to tell you
one's free) but you have to post the command to the device, so you wait
at the mailbox to see that it's taken (usually because the device has to
assign things like tracking numbers or indexes).  The intent is for
there to be a fairly instantaneous response however firmware doesn't
always see it that way ...

> A `cpu_relax()' in that loop would help cool things down a bit.

Actually, I think a simple udelay(25) might help in a lot of these
loops.

James


