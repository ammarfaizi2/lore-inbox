Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTFCMqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264988AbTFCMqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:46:14 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:15241 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264987AbTFCMqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:46:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
Date: Tue, 3 Jun 2003 23:00:52 +1000
User-Agent: KMail/1.5.2
Cc: Paul P Komkoff Jr <i@stingr.net>, "" <linux-kernel@vger.kernel.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com> <200306011731.04743.kernel@kolivas.org> <Pine.LNX.4.50.0306010322290.2614-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0306010322290.2614-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306032300.52084.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003 17:23, Zwane Mwaikambo wrote:
> On Sun, 1 Jun 2003, Con Kolivas wrote:
> > I get the same problem here with acpi-20030522 applied to rc6
> > P4 2.53 on an i845 mobo (P4PE).
>
> I think it could be the Bus Mastering event monitoring thing, can you
> shoehorn this (HACK HACK) patch into 2.4?
>
> Index: linux-2.5.70-mm1/drivers/acpi/processor.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.70/drivers/acpi/processor.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 processor.c
> --- linux-2.5.70-mm1/drivers/acpi/processor.c	27 May 2003 02:19:28
> -0000	1.1.1.1 +++ linux-2.5.70-mm1/drivers/acpi/processor.c	29 May 2003
> 11:32:00 -0000 @@ -711,11 +711,13 @@ acpi_processor_get_power_info (
>  		 * use this in our C3 policy.
>  		 */
>  		else {
> +			goto done;
>  			pr->power.states[ACPI_STATE_C3].valid = 1;
>  			pr->power.states[ACPI_STATE_C3].latency_ticks =
>  				US_TO_PM_TIMER_TICKS(acpi_fadt.plvl3_lat);
>  			pr->flags.bm_check = 1;
>  		}
> +		done:
>  	}
>
>  	/*

Ok I tried this hack. 

Here is vmstat before:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 494640   4088   6628    0    0     0   240 82011    34  0  1 99  
and after:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 494700   4052   6608    0    0     0   136 82182    32  0  1 99  

so it managed to give me another 100 or so interrupts on top of the 80k I was 
already getting; ie not much help
at about the same time I got a minor file system corruption but too many 
things happened together so I'm really not sure what that was.

Con

