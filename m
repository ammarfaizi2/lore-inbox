Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVFPBDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVFPBDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 21:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVFPBDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 21:03:47 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:54024 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261658AbVFPBDn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 21:03:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QdGjQ8YdKUKrfCAufhEKz+tLYpS1Lihy7R44lwUiwBFMAtKU+focuhAlm31eCL0k3qJh/vUSX/CRZHrcFysQ8S79/0eP2lDGXNOri9l6hEXM7JzdENa5e2HAnkZsedKIMG0XUDhkGKI0SX6RXqjrT2JKD9GBAImLN0ZFFiVFI9k=
Message-ID: <8783be6605061518034b220fce@mail.gmail.com>
Date: Wed, 15 Jun 2005 18:03:41 -0700
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RCF] Linux memory error handling
Cc: Russ Anderson <rja@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61L.0506151545410.13835@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
	 <Pine.LNX.4.61L.0506151545410.13835@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/05, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Wed, 15 Jun 2005, Russ Anderson wrote:
> 
> >
> >           Polling Threshold:  A solid single bit error can cause a burst
> >               of correctable errors that can cause a significant logging
> >               overhead.  SBE thresholding counts the number of SBEs for
> >               a given page and if too many SBEs are detected in a given
> >               period of time, the interrupt is disabled and instead
> >               linux periodically polls for corrected errors.
> 
>  This is highly undesirable if the same interrupt is used for MBEs.  A
> page that causes an excessive number of SBEs should rather be removed from
> the available pool instead.  Logging should probably take recent events
> into account anyway and take care of not overloading the system, e.g. by
> keeping only statistical data instead of detailed information about each
> event under load.
> 

First, SBEs and MBEs are named historically and are currently called
correctable and uncorrectable errors.  Modern chip sets can often
handle many incorrect bits in a single word and still correct the
problem.  So please don't assume you can make any inferences into the
probability of an MBE because you are seeing SBEs.  Any such
inferences would need to be chip set specific.

Some common chip sets have bugs in them that can cause an excessive
number of reported SBEs.  On those chip sets with out any error
reporting, there is a noticeable performance hit when the SBE counters
go wild.  If every SBE generated an interrupt the system would grind
to a halt.  So there needs to be easy ways to disable interrupts
associated with SBEs.

Also some memory/chip set combinations generate a significant number
of SBEs with out any significant danger of an MBE, so many people will
want to ignore SBEs entirely, or only poll once in a while.

Finally, many chip sets have memory scrubbing technology that can
simultaneously generate SBEs in memory not being accessed by the
kernel and fix those errors. So don't just assume that because the
kernel isn't allowing access to a page, you won't see SBEs or MBEs
from that page.

Otherwise, anything done in this direction seems like a good idea to me.

    Ross
