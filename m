Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWAGBJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWAGBJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWAGBJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:09:32 -0500
Received: from [85.8.13.51] ([85.8.13.51]:39873 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932301AbWAGBJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:09:31 -0500
Message-ID: <43BF14C6.2000209@drzeus.cx>
Date: Sat, 07 Jan 2006 02:09:26 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Minimise protocol awareness in Au1x00 driver
References: <20060106234012.31480.88314.stgit@poseidon.drzeus.cx> <43BF00A4.8070606@drzeus.cx> <20060107010159.GC17575@cosmic.amd.com>
In-Reply-To: <20060107010159.GC17575@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:
>> Whilst doing this I also noticed how horribly broken this driver is with
>> regard to sending the stop command. Instead of sending the requested
>> command it sends a hard coded opcode!! Jordan, please fix this ASAP.
>>     
>
> I recognize that this is a bad thing, but bear with me for a second while
> I digress.
>
> The current thinking, as far as I can tell is that that the drivers need to
> be aware that that data->stop opcode may be something other then CMD12.
>
> If that is true, then I'm worried about this snippet from your patch:
>
> +       if (host->mrq->data && (host->mrq->data->stop == cmd))
>                 mmccmd |= SD_CMD_CT_7;
> -               break;
> +       else if (!cmd->data)
> +               mmccmd |= SD_CMD_CT_0;
>
> Because, as the AMD specification states that CT_7 means (page 420 of
> the AU1200 data book):
>
>   * Terminate transfer of a multiple block write or read. Use when 
>   * doing a STOP_TRANSMISSION (CMD12) command.
>
>   

Quite correct. A test for the opcode and an error if it's "wrong" would
be the safest approach. Usually these types of command types are there
to kick the controller's state machine in the correct direction. So it
probably doesn't care what the command is (CMD12 happens to be the only
valid command for this transition ATM). Only those who know the
hardware's internal workings can answer this. So we either get in touch
with one of these people or we create a test case to determine this.

> The reason why I was so protocol heavy in the original version of this
> driver was because the spec is very specific in this regard.  CT_7 *means*
> a CMD12, CT_3 *mean* a CMD25, so on and so forth.  Your code does an
> excellent job of removing these dependencies, but it opens up the door
> for scary behavior if the command opcode behind the command type is ever
> changed.
>
> That said, I recognize that my decision to hard code the stop command
> was a stupid one (it was done for speed reasons - if you assume that a CMD12
> always stops the transaction, then why bother parsing the cmd structure)?
>
> So let me be blunt - why are we trying to be so generic?  Is it because
> we want to keep the door open for future versions of the SD specification
> that may change things up (which is an admirable goal, I admit).
>
>   

Yes. The hardware should be an interface to the MMC/SD bus. No more.
Anything else will eventually create a maintenance nightmare.

> If that is the case however, then perhaps we need to have some sort of 
> version control mechanism in place - since the AU1200 SD controller clearly
> states that:
>
>   * The SD controllers comply with version 1.1 of the SD card specification.
>   * References in this section are to that version of the specification.
>
>   

I do not think we should cater to the laziness of hardware manufacturers
(even if we happen to work for said manufacturer). The hardware has no
business caring about the opcodes, only their semantics. If the spec.
keeps referring to specific opcodes then we have to try and see past
those through guessing and testing. I am convinced that the hardware has
no requirements on the SD spec on a protocol layer. Only the
specification suffers from such a limitation. Let's try and overcome
that limitation in the driver.

What it boils down to is that layers and abstractions are there for a
reason. Let's try and not to break them because of short gains since it
usually ends up costing us in the long run.

Rgds
Pierre
