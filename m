Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968315AbWLEPlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968315AbWLEPlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968314AbWLEPlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:41:19 -0500
Received: from mta15.mail.adelphia.net ([68.168.78.77]:35062 "EHLO
	mta15.adelphia.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968312AbWLEPlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:41:19 -0500
Message-ID: <4575779C.1050204@acm.org>
Date: Tue, 05 Dec 2006 07:43:56 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH 7/12] IPMI: add poll delay
References: <20061202043520.GC30531@localdomain> <20061203132610.471786ca.akpm@osdl.org>
In-Reply-To: <20061203132610.471786ca.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 1 Dec 2006 22:35:20 -0600
> Corey Minyard <minyard@acm.org> wrote:
>
>   
>> Make sure to delay a little in the IPMI poll routine so we can pass in
>> a timeout time and thus time things out.
>>
>> Signed-off-by: Corey Minyard <minyard@acm.org>
>>
>> Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
>> ===================================================================
>> --- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
>> +++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
>> @@ -807,7 +807,12 @@ static void poll(void *send_info)
>>  {
>>  	struct smi_info *smi_info = send_info;
>>  
>> -	smi_event_handler(smi_info, 0);
>> +	/*
>> +	 * Make sure there is some delay in the poll loop so we can
>> +	 * drive time forward and timeout things.
>> +	 */
>> +	udelay(10);
>> +	smi_event_handler(smi_info, 10);
>>  }
>>     
>
> I don't understand what this patch is doing.  It looks fishy.  More
> details, please?
>   
Yeah, it does look a little fishy.  This is a poll routine that is only
called at panic
time; it is used to force things to happen in the driver without
scheduling or
timers.  The driver does this so it can set watchdog parameters and store
panic information in the event log at panic time.

Without this change, if something goes wrong in the BMC the driver will
never
time out the operation since it doesn't see time being driven forward. 
So this
makes sure the driver sees time advancing as it should.

-Corey

