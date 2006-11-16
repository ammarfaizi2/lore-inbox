Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162140AbWKPBKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162140AbWKPBKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162143AbWKPBKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:10:32 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:51850 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1162140AbWKPBKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:10:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=PzdpoygjLjGzDT3GN3D0KRibfRXQ7fUVGynZy5UW0oMXVMFDjioysyBJ1qTCg4T9gAKEiRwWrHHvryC1X+cro6nOfvEnrxdCw/hVaWOUyUbwWwPAhHb1hwYuCYGHMbZr3cZBoQ3JhOj5+mFlX/fZJN3+df1miS5c57KcmiSrgZc=  ;
X-YMail-OSG: 8aVV_VsVM1l_2nv1th9YsxQdjhKg9hqoHFwUeLCfWFLfhWOEn6Q1LC3BUP0FO3v8OWx1oitVD6M9JOGn4nBcYvo2vCaySWiicdA8kVK1pBKR8ktfON9yx3KBDW3AHm8zEPh7kSkNruWfArKOwq1Zrursztdylx2O3fg-
From: David Brownell <david-b@pacbell.net>
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Wed, 15 Nov 2006 17:10:26 -0800
User-Agent: KMail/1.7.1
Cc: Len Brown <lenb@kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
References: <200611142303.47325.david-b@pacbell.net> <455B28B2.4010707@linux.intel.com> <200611151356.52985.david-b@pacbell.net>
In-Reply-To: <200611151356.52985.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611151710.26570.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 1:56 pm, David Brownell wrote:
> On Wednesday 15 November 2006 6:48 am, Alexey Starikovskiy wrote:
> > ec1.patch
> > 
> > 
> > Always enable GPE after return from notify handler.
> > 
> > From:  Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> > 
> > 
> > ---
> 
> Yes, this seems to resolve the regression as well as Len's ec_intr=0 boot param.

Whoops, I spoke too soon.  It does get rid of SOME of the AE_TIME errors.  But
the system is still confused about whether or not the AC is connected, and
whether the battery is charging or not; and the CPU is still relatively hot.
Even with this patch I later got:

ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [2006070
7]
ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE
_TIME

In short, better but evidently not yet good enough...

- Dave



> IMO this should get merged into 2.6.19 ASAP ...
> 
> 
> >  drivers/acpi/ec.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index e6d4b08..937eafc 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -465,8 +465,6 @@ static u32 acpi_ec_gpe_handler(void *dat
> >  
> >         if (value & ACPI_EC_FLAG_SCI) {
> >                 status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> > -               return status == AE_OK ?
> > -                   ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
> >         }
> >         acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
> >         return status == AE_OK ?
> 
