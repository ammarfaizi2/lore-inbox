Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422903AbWBATrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422903AbWBATrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWBATrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:47:39 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:26303 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1422903AbWBATri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:47:38 -0500
X-ORBL: [67.117.73.34]
Date: Wed, 1 Feb 2006 11:47:25 -0800
From: Tony Lindgren <tony@atomide.com>
To: Anderson Briglia <anderson.briglia@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] MMC OMAP driver
Message-ID: <20060201194724.GD15939@atomide.com>
References: <43DF6750.1060505@indt.org.br> <20060201124434.GC3072@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201124434.GC3072@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk+lkml@arm.linux.org.uk> [060201 04:44]:
> On Tue, Jan 31, 2006 at 09:34:08AM -0400, Anderson Briglia wrote:
> > +	/* Any data transfer means adtc type (but that information is not
> > +	 * in command structure, so we flagged it into host struct.)
> > +	 * However, telling bc, bcr and ac apart based on response is
> > +	 * not foolproof:
> > +	 * CMD0  = bc  = resp0  CMD15 = ac  = resp0
> > +	 * CMD2  = bcr = resp2  CMD10 = ac  = resp2
> > +	 *
> > +	 * Resolve to best guess with some exception testing:
> > +	 * resp0 -> bc, except CMD15 = ac
> > +	 * rest are ac, except if opendrain
> > +	 */
> > +	if (host->data) {
> > +		cmdtype = OMAP_MMC_CMDTYPE_ADTC;
> > +	} else if (resptype == 0 && cmd->opcode != 15) {
> > +		cmdtype = OMAP_MMC_CMDTYPE_BC;
> > +	} else if (host->bus_mode == MMC_BUSMODE_OPENDRAIN) {
> > +		cmdtype = OMAP_MMC_CMDTYPE_BCR;
> > +	} else {
> > +		cmdtype = OMAP_MMC_CMDTYPE_AC;
> > +	}
> 
> The 4 command types are decodable from the information provided.
> 
> bc - broadcast commands without response
> bcr - broadcast commands with response
> ac - addressed command
> adtc - addressed data transfer command
> 
> From this, there are three bits of information required:
> 
> 1. is the command addressed or broadcast (bc/bcr vs ac/adtc)?
> 2. if broadcast, does it have a response (bc vs bcr)?
> 	(mrq->cmd->flags & MMC_RSP_MASK) != MMC_RSP_NONE
>    satisfies this by definition.
> 3. if addressed, does it have a data transfer (ac vs adtc)?
> 	mrq->data != NULL
>    satisfies this by definition.
> 
> Hence, to allow host drivers to decode the command type, we only need
> to supply information on whether this was a broadcast or addressed
> command.  This could be a flag MMC_CMD_BROADCAST, which is passed
> with the command.
> 
> I'm thinking we want a couple of helper functions:
> 
> 	mmc_resp_type(cmd)
> 	mmc_cmd_type(cmd)
> 
> which would allow the flags value to be tested for response and command
> types - in which case we'd need to also have MMC_CMD_DATA as well.  For
> an example of what I'm proposing, see the end of this message.

That sounds like a good solution.
 
> Wouldn't this be a problem which isn't host specific?  If so, why should
> the fix be limited to just omap hosts?  IOW: it's the wrong layer to fix
> this problem.
> 
> > +static inline int is_broken_card(struct mmc_card *card)
> > +{
> > +	int i;
> > +	struct mmc_cid *c = &card->cid;
> > +	static const struct broken_card_cid {
> > +		unsigned int manfid;
> > +		char prod_name[8];
> > +		unsigned char hwrev;
> > +		unsigned char fwrev;
> > +	} broken_cards[] = {
> > +		{ 0x00150000, "\x30\x30\x30\x30\x30\x30\x15\x00", 0x06, 0x03 },
> > +	};
> > +
> > +	for (i = 0; i < sizeof(broken_cards)/sizeof(broken_cards[0]); i++) {
> > +		const struct broken_card_cid *b = broken_cards + i;
> > +
> > +		if (b->manfid != c->manfid)
> > +			continue;
> > +		if (memcmp(b->prod_name, c->prod_name, sizeof(b->prod_name)) != 0)
> > +			continue;
> > +		if (b->hwrev != c->hwrev || b->fwrev != c->fwrev)
> > +			continue;
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> 
> I've already mentioned this to the OMAP folk... What problem is this
> trying to work around?  If it's a card problem, it's at the wrong
> level.  If it's a problem with the host not waiting the mandatory
> 80 cycles before starting a command, that could be the upper layers
> or a host problem.
> 
> Either way, the right place to fix this is _not_ in the request
> function but in the set_ios function.  The request function does
> not know if the card has just been powered up.

Anderson, can you pull out the broken card check from omap.c, and put
it into a separate patch? Let's fix the omap.c issues first, and have
that integrated. Then we can start working on the additional patches
and test them one at a time.

> You've already told the MMC layer that your minimum clock is 400000
> via mmc->f_min.  Therefore, you won't be offered a clock rate lower
> than this, so this test is superfluous.
> 
> > +	host->bus_mode = ios->bus_mode;
> > +	if (omap_has_menelaus()) {
> > +		if (host->bus_mode == MMC_BUSMODE_OPENDRAIN)
> > +			menelaus_mmc_opendrain(1);
> > +		else
> > +			menelaus_mmc_opendrain(0);
> > +	}
> > +	host->hw_bus_mode = host->bus_mode;
> 
> Since this is the only place where the bus mode is changed, why do you
> have similar code elsewhere in this driver?

Hmm, the other bus mode toggle could be unnecessary. Needs to be
verified on a board with a Menelaus chip.
 
> > +	if (cpu_is_omap24xx()) {
> > +		host->iclk = clk_get(&pdev->dev, "mmc_ick");
> > +		if (IS_ERR(host->iclk))
> > +			goto out;
> > +		clk_enable(host->iclk);
> > +	}
> > +
> > +	if (!cpu_is_omap24xx())
> > +		host->fclk = clk_get(&pdev->dev,
> > +				    (host->id == 1) ? "mmc1_ck" : "mmc2_ck");
> > +	else
> > +		host->fclk = clk_get(&pdev->dev, "mmc_fck");
> 
> Wrong use of the clock API:
> 
>  * clk_get - lookup and obtain a reference to a clock producer.
>  * @dev: device for clock "consumer"
>  * @id: clock comsumer ID
> 
> The ID string is supposed to be the consumer ID, not the producer ID.
> If you have multiple devices of the same type, this string is supposed
> to be a constant, and you're supposed to use the struct device to
> work out which producer is required.

I'll fix this in the omap clock framework, but probably won't get to it
until next week at some point.

Regards,

Tony
