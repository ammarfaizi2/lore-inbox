Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264674AbUDVUsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264674AbUDVUsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264672AbUDVUsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:48:17 -0400
Received: from gherkin.frus.com ([192.158.254.49]:10898 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S264656AbUDVUsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:48:09 -0400
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (new)
In-Reply-To: <40881F1B.8060909@tmr.com> "from Bill Davidsen at Apr 22, 2004 03:38:03
 pm"
To: Bill Davidsen <davidsen@tmr.com>
Date: Thu, 22 Apr 2004 15:48:07 -0500 (CDT)
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040422204807.55E0BDBDB@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> WRT the split of code... if there is some reason why there will never be 
> another type of card then the split is unnessessary. But otherwise, 
> you've done the work, and it matches the way other drivers were split, 
> so why scrap it?
> 
> As you guessed I don't feel strongly one way or the other, just thought 
> you could use a little support for having made the effort to design for 
> the future.

You give me too much credit :-).  I inherited the split design from the
original author and simply preserved it.  As far as maintaining the
split design, the only evidence I've seen of non-PCMCIA cards using the
Symbios/NCR 53c500 controller is the existence of a driver in the FreeBSD
tree.  In any event, I don't have the hardware to test anything other
than the PCMCIA case, and if there's someone out there who needs support
for the non-PCMCIA case, I expect the Linux driver would have been written
before now.  Christoph suggested in an earlier posting that the split to
support other hardware would probably be accomplished differently these
days anyway, so we (the community) probably haven't lost all that much by
concentrating on producing a well-written PCMCIA-only driver.

I saved my first attempt at a 2.6 driver (in case someone wants to
revisit the issue).  Otherwise, although I appreciate your support,
it's OBE.  I'm waiting to hear back from Christoph on a few design
issues (questions asked off-line) before submitting a third 2.6 driver.

The main issue I'm wrestling with at the moment is support for the
improbable case of multiple HBAs...  I agree in principle with the
objective as long as I don't do something stupid that kills performance
for the normal case of a single HBA.  As I see it, there are essentially
two approaches:

(1) Calculate all the needed hardware register offsets up front at HBA
    init time, and carry them as part of the per-instance data.  This
    approach has a few things going for it -- the in-core memory
    requirement is essentially identical for the single HBA case, and
    dereferencing a structure pointer to get a register address is
    barely worse than accessing the equivalent global variable in the
    driver.

(2) Calculate a particular register offset each time that register is
    accessed, using something like shost->io_port + offset, which, it
    is claimed, is normal Linux driver practice.  Although this
    approach is extremely attractive from the standpoint of code
    simplicity, I'm concerned about the arithmetic overhead.  If it
    turns out most of the hardware register accesses occur during
    initialization, my concerns are pretty well meaningless.  Obviously
    I need to look at this more closely.

You may safely assume I'm learning more about this than I originally
anticipated :-).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
