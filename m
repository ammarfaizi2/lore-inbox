Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVH3Ufg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVH3Ufg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVH3Ufg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:35:36 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:59020 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932444AbVH3Uff
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:35:35 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=a52/8Z5m1/fiF8aUSeXmJvWZAKNxkHS5FkjOQgsq9AsYdVmlLL2WG/aqjF3CLJU7O
	HPSnfyGgu5zkecFxfEqDA==
Date: Tue, 30 Aug 2005 13:35:21 -0700
From: David Brownell <david-b@pacbell.net>
To: tpoynor@mvista.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] PowerOP Take 2 1/3: ARM OMAP1 platform support
References: <20050825025357.GB28662@slurryseal.ddns.mvista.com>
In-Reply-To: <20050825025357.GB28662@slurryseal.ddns.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050830203521.D39DDC10C1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting.  I start to like this shape better; it moves more of the
logic to operating point code, where it can make the sysfs interface
talk in terms of meaningful abstractions, not cryptic numeric offsets.
But it was odd to see the first patch be platform-specific support,
rather than be a neutral framework into which platform-aware code plugs
different kinds of things...

One part I don't like is that the platform would be limited to tweaking
a predefined set of fields in registers.  That seems insufficient for
subsystems that may not be present on all boards.  Plus, to borrow some
terms from cpufreq, it only facilitates "usermode" governor models, never
"ondemand" or any other efficient quick-response adaptive algorithms.

The PM modules I imagine loading would define things that look more like:

	struct thing {
		char thing[THING_NAME_LEN];

		/* there'd be sysfs hooks here
		 *  - the thing's directory node (kobject)
		 *  - array of attributes and matching get/set code
		 *  - ... memory management fun too ...
		 */

		/* these wrap all relevant platform-specific knowledge: */
		int	(*set_thing)(struct thing *);
		void	*data;
	};

That "data" could maybe be values directly matching your predefined
list of registers on the SOC ... or it could start with them, then add
stuff specific to a given board.  (Of course it would provide its own
sysfs API.)   Let's call that the "static operating point" model.

Alternatively, the "thing" could implement some adaptive algorithm
using local measurements, predictions, and feedback to adjust any
platform power parameters dynamically.  Maybe it'd delegate management
of the ARM clock to "cpufreq", and focus on managing power for other
board components that might never get really reusable code.  Switching
between operating points wouldn't require userspace instruction;
call it a "dynamic operating point" selection model.



> Date: Wed, 24 Aug 2005 19:53:57 -0700
> From: Todd Poynor <tpoynor@mvista.com>
>
> PowerOP support for OMAP1 platforms.  Currently handles these power
> parameters:
>
>    dpllmult	DPLL_CTL reg PLL MULT bits
>    dplldiv	DPLL_CTL reg PLL DIV bits
>    armdiv	ARM_CKCTL reg ARMDIV bits
>    dspdiv	ARM_CKCTL reg DSPDIV bits

The ARM clock is already managed by arch/arm/plat-omap/clocks.c,
which is used by cpufreq through whatever governor is active.
This would just be another kind of "usermode" governor.

The DSP clock might benefit from some support though.  I've never
much looked at this, beyond noting that SPUs on CELL should have
similar issues.  Wouldn't it be nice to have "ondemand" style
governors for DSPs or SPUs?  That's got to be easy. ;)


>    tcdiv	ARM_CKCTL reg TCDIV bits

Affecting bandwidth on one of the main I/O busses ... does the
PC world usually change things like that outside of maybe in
BIOS/ACPI PM code?


>    lowpwr	1 = assert ULPD LOW_PWR, voltage scale low

Could you describe the policy effect of this bit?  I suspect
a good "PCs don't work like that!" example is lurking here.
That interacts with some other bits, and code ... when would
setting this be good, or bad?


> Other parameters such as DSPMMUDIV, LCDDIV, and ARM_PERDIV might also be
> useful.

Again, PERDIV changes would need to involve clock.c to cascade
the changes through the clock tree.  Change PERDIV and you'll
need to recalculate the peripheral clocks that derive from it...
better not do it while an I/O operation is actively using it!

As with TCDIV, that makes a useful example of something that is
clearly not within the "cpufreq" domain.  

- Dave


