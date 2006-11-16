Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424264AbWKPQVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424264AbWKPQVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424257AbWKPQVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:21:22 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:21941 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1424267AbWKPQVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:21:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=r8HythgeXQUE5TaFnxjXLCUv0/stSpw20aIiI5wY+P7NCuYKpgNy9YCDIyA1xM2XkGk2HsSVhNeMWcM+gZz5eQaoN2aWS5mK+P5fVbY8Kuutd2gkwSIwmD3Y3sv/Jgt4I4X5IwL6bTt7eDxG34LqZQ78VhXtbGf3VZ1wJdro0Rg=  ;
X-YMail-OSG: o1Damz4VM1nAbtKkVFFxEMoGanuHASUVAl7oGrEELSkR1UusoXf22rTqyAU1p0Og_NAJybL6AHU5n6emEPotiGik9Y4lxO7SvVdmWvrkV7qfovd9cS4GTjN5Jx1M94BBsUTomaqsMskDt82M36j0ZhY7crDR.jqKO6w-
From: David Brownell <david-b@pacbell.net>
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Thu, 16 Nov 2006 08:03:03 -0800
User-Agent: KMail/1.7.1
Cc: Len Brown <lenb@kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
References: <200611142303.47325.david-b@pacbell.net> <200611151710.26570.david-b@pacbell.net> <455C8696.80508@linux.intel.com>
In-Reply-To: <455C8696.80508@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160803.04152.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 7:41 am, Alexey Starikovskiy wrote:
> Looks like either EC GPE or whole ACPI irq got disabled... Could you 
> check that ACPI interrupts still arrive after
> you notice AE_TIME?

If I unplug AC, /proc/interrrupts reports 2 IRQs going to ACPI.
Then on replug, it reports 10-12 IRQs going to ACPI.


> Also, may be attached patch will help?

I'l give it a try next time I can reboot (presumably by this PM).

- Dave


> 
> Regards,
>     Alex.
> 
> David Brownell wrote:
> > On Wednesday 15 November 2006 1:56 pm, David Brownell wrote:
> >   
> >> On Wednesday 15 November 2006 6:48 am, Alexey Starikovskiy wrote:
> >>     
> >>> ec1.patch
> >>>
> >>>
> >>> Always enable GPE after return from notify handler.
> >>>
> >>> From:  Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> >>>
> >>>
> >>> ---
> >>>       
> >> Yes, this seems to resolve the regression as well as Len's ec_intr=0 boot param.
> >>     
> >
> > Whoops, I spoke too soon.  It does get rid of SOME of the AE_TIME errors.  But
> > the system is still confused about whether or not the AC is connected, and
> > whether the battery is charging or not; and the CPU is still relatively hot.
> > Even with this patch I later got:
> >
> > ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
> > ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [2006070
> > 7]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE
> > _TIME
> >
> > In short, better but evidently not yet good enough...
> >
> > - Dave
> >
> >
> >
> >   
> >> IMO this should get merged into 2.6.19 ASAP ...
> >>
> >>
> >>     
> >>>  drivers/acpi/ec.c |    2 --
> >>>  1 files changed, 0 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >>> index e6d4b08..937eafc 100644
> >>> --- a/drivers/acpi/ec.c
> >>> +++ b/drivers/acpi/ec.c
> >>> @@ -465,8 +465,6 @@ static u32 acpi_ec_gpe_handler(void *dat
> >>>  
> >>>         if (value & ACPI_EC_FLAG_SCI) {
> >>>                 status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> >>> -               return status == AE_OK ?
> >>> -                   ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
> >>>         }
> >>>         acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
> >>>         return status == AE_OK ?
> >>>       
> 
> 
