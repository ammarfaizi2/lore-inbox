Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWCXL2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWCXL2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWCXL2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:28:44 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:1936 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751651AbWCXL2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:28:43 -0500
Date: Fri, 24 Mar 2006 12:28:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: 2.6.16-mm1
In-Reply-To: <20060323144922.GA25849@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0603241140350.16802@scrub.home>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <6bffcb0e0603230631r5e6cc3d3p@mail.gmail.com>
 <20060323144922.GA25849@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Mar 2006, Russell King wrote:

> Okay, so the default is now 'm', but the legal values are still only 'n'
> and 'm'.  I can only select 'm' or 'n', and this is what I end up with in
> the config file.  Now, if I remove the prompt text:
> 
> config SYM_D
>         tristate
>         depends on SYM_M && SYM_Y
>         default y
> 
> and hey presto, suddenly 'y' becomes a legal value.
> 
> CONFIG_SYM_Y=y
> CONFIG_SYM_M=m
> CONFIG_SYM_D=y
> 
> So it would seem to be a Kconfig bug.

No, it's not a bug, that's really the correct behaviour. It has its roots 
in the cml1 converter, where statements like this:

if [ "$CONFIG_FOO" = "y" ]; then
  define_tristate CONFIG_BAR y
fi

would become:

config BAR
	default y
	depends on FOO=y

The basic idea is that the dependency only enables the default and the 
default sets the symbol to whatever you want.

I thought about the other behaviour, but at that time the if syntax or 
select didn't exists yet, so it really wasn't a problem yet and I decided 
to keep it closer to cml1 instead.

In the meantime the Kconfig syntax has grown and this is not the first 
time this has come up. I'm not completely opposed against changing the 
behaviour, but I don't want to do it just for fun either. It would require 
at least to grep through the current Kconfig rules to check whether 
something depends on the current behaviour.

As alternative you can change the default to "SYM_M" (basically repeating 
the dependency without the booleans).

bye, Roman
