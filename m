Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWAGAyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWAGAyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWAGAyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:54:36 -0500
Received: from amdext3.amd.com ([139.95.251.6]:15079 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1030261AbWAGAyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:54:35 -0500
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Fri, 6 Jan 2006 18:01:59 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>
cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Minimise protocol awareness in Au1x00 driver
Message-ID: <20060107010159.GC17575@cosmic.amd.com>
References: <20060106234012.31480.88314.stgit@poseidon.drzeus.cx>
 <43BF00A4.8070606@drzeus.cx>
MIME-Version: 1.0
In-Reply-To: <43BF00A4.8070606@drzeus.cx>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FA1CEA42C42776355-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Whilst doing this I also noticed how horribly broken this driver is with
> regard to sending the stop command. Instead of sending the requested
> command it sends a hard coded opcode!! Jordan, please fix this ASAP.

I recognize that this is a bad thing, but bear with me for a second while
I digress.

The current thinking, as far as I can tell is that that the drivers need to
be aware that that data->stop opcode may be something other then CMD12.

If that is true, then I'm worried about this snippet from your patch:

+       if (host->mrq->data && (host->mrq->data->stop == cmd))
                mmccmd |= SD_CMD_CT_7;
-               break;
+       else if (!cmd->data)
+               mmccmd |= SD_CMD_CT_0;

Because, as the AMD specification states that CT_7 means (page 420 of
the AU1200 data book):

  * Terminate transfer of a multiple block write or read. Use when 
  * doing a STOP_TRANSMISSION (CMD12) command.

The reason why I was so protocol heavy in the original version of this
driver was because the spec is very specific in this regard.  CT_7 *means*
a CMD12, CT_3 *mean* a CMD25, so on and so forth.  Your code does an
excellent job of removing these dependencies, but it opens up the door
for scary behavior if the command opcode behind the command type is ever
changed.

That said, I recognize that my decision to hard code the stop command
was a stupid one (it was done for speed reasons - if you assume that a CMD12
always stops the transaction, then why bother parsing the cmd structure)?

So let me be blunt - why are we trying to be so generic?  Is it because
we want to keep the door open for future versions of the SD specification
that may change things up (which is an admirable goal, I admit).

If that is the case however, then perhaps we need to have some sort of 
version control mechanism in place - since the AU1200 SD controller clearly
states that:

  * The SD controllers comply with version 1.1 of the SD card specification.
  * References in this section are to that version of the specification.

So, it is perfectly reasonable for the SD controller to make assumptions,
like say that that stop is *always* CMD12, etc.  And if we allow that
to be the case, then perhaps we should insert some checking into the
subsystem that will check the supported SD version (if it should ever
change in the future), and not ask a driver to do anything it cannot.

Anyway, let me ruminate on your patch for a day or so, and I'll see if
I can scratch something together to fix the stop opcode problem.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

