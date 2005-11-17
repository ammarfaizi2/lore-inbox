Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVKQWtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVKQWtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVKQWtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:49:55 -0500
Received: from fmr22.intel.com ([143.183.121.14]:46054 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964944AbVKQWty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:49:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: maxcpus=1 broken, ACPI bug?
Date: Thu, 17 Nov 2005 14:49:00 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60065B5BFA@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: maxcpus=1 broken, ACPI bug?
Thread-Index: AcXrsL7qzWii41STRPyirT/C9iEMDgAFqXaQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Maneesh Soni" <maneesh@in.ibm.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 17 Nov 2005 22:49:02.0297 (UTC) FILETIME=[1AF25490:01C5EBC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 

>-----Original Message-----
>From: Linus Torvalds [mailto:torvalds@osdl.org] 
>Sent: Thursday, November 17, 2005 11:55 AM
>To: Maneesh Soni
>Cc: LKML; Pallipadi, Venkatesh; Brown, Len; Andrew Morton
>Subject: Re: maxcpus=1 broken, ACPI bug?
>
>
>
>On Thu, 17 Nov 2005, Maneesh Soni wrote:
>> 
>> Using maxcpus=1 boot option, hangs the system while booting. It was
>> working till 2.6.13-rc2. After git bisect I found that after backing
>> out this ACPI patch it works again, though I had to manually sort the
>> reject while backing out.
>> 
>> 
>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.
6.git;a=commitdiff;h=acf05f4b7f558051ea0028e8e617144123650272
>
>Hmm. That patch had a totally idiotic thinko in it (look at 
>the for-loop 
>in acpi_processor_get_power_info_default() and notice how it doesn't 
>actually change anything in the loop).
>
>That thinko was later fixed (albeit in a really stupid way, 
>and the same 
>cut-and-paste bug still exists in 
>acpi_processor_get_power_info_fadt()).
>

Oops. I had missed the memset in ..info_fadt() in my stupid bug fixing
patch.

There is another patch here http://bugme.osdl.org/show_bug.cgi?id=4485
That touches the same code and doing memset in a loop turned out to be
useful
as we want to initialize only some of those states.

>Anyway, can you test this diff? It
>
> (a) removes the insane (and in one case incorrect) memset loop
> (b) makes the code that sets "pr->flags.power = 1" match the 
>comment and 
>     the previous behaviour.

Regarding the last hunk in the patch below..
Actually, we want to have acpi_processor_idle() used even when only C1
is supported and that C1 has nothing to do with ACPI. The reason being
that there is no generic interface that can show the cstate usage and
time spent in cstate etc. We want to reuse the cstate statistics in
/proc interface in acpi_processor_idle(). However, in long term, this
needs a cleanup and a generic cstate handler is required (similar to
cpufreq for P-state) and acpi should just plugin the handler and latency
and similar details for each cstate into this generic cstate handler.

And I tried on couple of Xeons here and haven't had luck in reproducing
this hang yet. 

Thanks,
Venki

>
>Does that make a difference?
>
>		Linus
>
>---
>diff --git a/drivers/acpi/processor_idle.c 
>b/drivers/acpi/processor_idle.c
>index 573b6a9..2445828 100644
>--- a/drivers/acpi/processor_idle.c
>+++ b/drivers/acpi/processor_idle.c
>@@ -524,8 +524,7 @@ static int acpi_processor_get_power_info
> 	if (!pr->pblk)
> 		return_VALUE(-ENODEV);
> 
>-	for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
>-		memset(pr->power.states, 0, sizeof(struct 
>acpi_processor_cx));
>+	memset(pr->power.states, 0, sizeof(pr->power.states));
> 
> 	/* if info is obtained from pblk/fadt, type equals state */
> 	pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
>@@ -559,9 +558,7 @@ static int acpi_processor_get_power_info
> 
> 	ACPI_FUNCTION_TRACE("acpi_processor_get_power_info_default_c1");
> 
>-	for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
>-		memset(&(pr->power.states[i]), 0,
>-		       sizeof(struct acpi_processor_cx));
>+	memset(pr->power.states, 0, sizeof(pr->power.states));
> 
> 	/* if info is obtained from pblk/fadt, type equals state */
> 	pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
>@@ -873,7 +870,8 @@ static int acpi_processor_get_power_info
> 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
> 		if (pr->power.states[i].valid) {
> 			pr->power.count = i;
>-			pr->flags.power = 1;
>+			if (pr->power.states[i].type >= ACPI_STATE_C2)
>+				pr->flags.power = 1;
> 		}
> 	}
> 
>
