Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263670AbUDYW7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbUDYW7S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 18:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbUDYW7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 18:59:18 -0400
Received: from gherkin.frus.com ([192.158.254.49]:1943 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S263670AbUDYW7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 18:59:09 -0400
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (round 3 - the charm?)
In-Reply-To: <20040425223341.C13748@flint.arm.linux.org.uk> "from Russell King
 at Apr 25, 2004 10:33:41 pm"
To: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sun, 25 Apr 2004 17:59:08 -0500 (CDT)
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040425225908.5A2ECDBDB@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Driver attempt 4 posted to linux-scsi a few minutes ago.)

Russell King wrote:
> On Sun, Apr 25, 2004 at 04:26:34PM -0500, Bob Tracy wrote:
> > Russell King wrote:
> > > Hmm, so what happens if you're in the middle of a transaction, and
> > > you receive a CS_EVENT_CARD_RESET.  What happens to the command in
> > > progress ?
> > 
> > Candidly, I don't know.  A fair question to ask in return is, under
> > what circumstances might a PCMCIA driver see a CS_EVENT_CARD_RESET?
> 
> When the user issues "cardctl reset"

Would it then be fair to characterize this action as either a self-
inflicted gunshot wound or a desperate attempt to restore things to
a sane state?  I can see someone trying a reset if things got wedged
in the middle of a critical transaction, and I guess the actions that
could be taken by the low-level driver would properly depend on what
can be assumed with respect to the mid and upper layers.  In the case
of the self-inflicted wound, the task at hand would be roughly
equivalent to ensuring the integrity of a floppy diskette when the
user ejects it from the drive in the middle of a write.

> From the brief look I had, it didn't look like (the mid and upper
> driver layers were handling the "command in progress" issue) - I
> suspect things will go gaga if someone ever invoked "cardctl reset".

Ouch!  I hate to be like the doctor that suggests if something hurts
when you do it, then don't do it, but it sounds like the user is
already hurting if he's reaching for the "card reset" hammer.  For a
sequential access device (magnetic tape and such), the user would
probably end up having to restart the job anyway (read or write).  For
random access devices, I think the results would be minimally bad in
the case of an interrupted read.  If the user is in the middle of a
write operation, it's probably fsck time (or enjoy your new coaster in
the case of one-shot writable media).  Mitigating factors?  If things
are truly wedged, the attached devices are probably in a pretty much
quiescent state anyway, implying any damage caused by a reset would be
minimal compared to what has already occurred.

Has this been discussed before?  If so, I don't recall.  Any ideas
as far as what *should* be done (by the drivers at any level)?
Resetting the host hardware is an obviously correct thing to do if
there's anything to be done in response to the card reset event.  The
software state is a trickier matter: doing nothing might well be the
best option.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
