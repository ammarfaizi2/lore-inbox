Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUKFQa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUKFQa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 11:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUKFQa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 11:30:57 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:55816 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261417AbUKFQao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 11:30:44 -0500
Message-ID: <418CEE3A.40503@conectiva.com.br>
Date: Sat, 06 Nov 2004 13:31:06 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Len Brown <len.brown@intel.com>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de>
In-Reply-To: <20041106114844.GK1295@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adrian Bunk wrote:
> On Fri, Nov 05, 2004 at 09:10:08PM -0500, Len Brown wrote:
> 
>>On Fri, 2004-11-05 at 16:50, Adrian Bunk wrote:
>>
>>>The patch below completely removes 7 functions that were
>>>EXPORT_SYMBOL'ed but had exactly zero users in the kernel and makes
>>>another one that was previously EXPORT_SYMBOL'ed static.
>>>
>>>It also removes another unused global function to completely remove
>>>drivers/acpi/hardware/hwtimer.c which contained no function used
>>>anywhere in the kernel.
>>>
>>>Please comment on whether this patch is correct or whether in-kernel
>>>users of these functions are pending.
>>>
>>>
>>>diffstat output:
>>> drivers/acpi/acpi_ksyms.c        |    8 -
>>> drivers/acpi/events/evxfevnt.c   |  191 -----------------------------
>>> drivers/acpi/hardware/Makefile   |    2
>>> drivers/acpi/hardware/hwtimer.c  |  200
>>>-------------------------------
>>> drivers/acpi/resources/rsxface.c |   52 --------
>>> drivers/acpi/scan.c              |    6
>>> drivers/acpi/utilities/utxface.c |   89 -------------
>>> include/acpi/achware.h           |   17 --
>>> include/acpi/acpi_bus.h          |    1
>>> include/acpi/acpixf.h            |   24 ---
>>> 10 files changed, 6 insertions(+), 584 deletions(-)
>>
>>No, I can't apply this one as-is.
>>Some of these routines are not called now
>>simply because Linux/ACPI is evolving and we don't
>>yet take advantage of some of the things supported
>>by ACPICA core we use.
> 
> 
> I understand this, that's why I asked for comments on this patch.
> 
> But it seems a bit strange for me that e.g. the file hwtimer.c was added 
> nearly three years ago and exports functions - but currently has exactly 
> zero users. One effect is a needless code bloat for every single user 
> with CONFIG_ACPI_INTERPRETER=y.
> 
> Removing unused global functions is a pretty cheap way to get the kernel 
> smaller without any loss of functionality. Please check which of the 
> functions touched in my patch will actually be used in the foreseeable 
> future (if it would e.g. take another three years until hwtimer.c will 
> be used, it might be better to re-add it when it will actually be used).


Suggestion that satisfies both of you, I think:

#undef ACPI_FUTURE_USAGE
#ifdef ACPI_FUTURE_USAGE
tons of unused exported functions
#endif /* ACPU_FUTURE_USAGE */

This is what is being done in at least one case in the kernel network
subsystem, incremental patches adds new functions, to be used by
future patches, but sometimes Real Life (tm) gets in the way and the
programmer stalls development for some time, no problem, just ifdef it.

When, in the future, some functions start being used, hey, very easy
to remove the #ifdef.

Even for people trying to debug such subsystems eventually to get
something working its _nice_ to know at first glance what is really
being used, speeding up the process for the benefit or everybody.

Best Regards,

- Arnaldo

> 
> BTW: ACPI has tons of other unused global functions.
> 

And other areas as well, keep up the good work Adrian.
