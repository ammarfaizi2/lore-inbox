Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVHDNYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVHDNYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVHDNYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:24:43 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:32242 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262528AbVHDNYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:24:10 -0400
Message-ID: <42F216F7.6070604@acm.org>
Date: Thu, 04 Aug 2005 08:24:07 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver update part 1, add per-channel IPMB addresses
References: <42F14AC9.2060109@acm.org> <20050803225954.27aa6ffd.akpm@osdl.org>
In-Reply-To: <20050803225954.27aa6ffd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>ipmi-per-channel-slave-address.patch  unknown/unknown (13533 bytes)]
>>    
>>
>
>Could you fix up the mimetype, please?  It makes it hard for various email
>clients.
>  
>
Dang, you switch to a new mail client and everything is screwed up.  Sorry.

>  
>
>>IPMI allows multiple IPMB channels on a single interface, and
>>each channel might have a different IPMB address.  However, the
>>driver has only one IPMB address that it uses for everything.
>>This patch adds new IOCTLS and a new internal interface for
>>setting per-channel IPMB addresses and LUNs.  New systems are
>>coming out with support for multiple IPMB channels, and they
>>are broken without this patch.
>>
>>...
>>+	for (i=0; i<IPMI_MAX_CHANNELS; i++)
>>    
>>
>
>Preferred coding style is actually
>
>	for (i = 0; i < IPMI_MAX_CHANNELS; i++)
>
>but we've kinda lost that fight in drivers :(
>  
>
Ok, I'll see what I can do.  It's the wrong way all over the driver 
right now.

>  
>
>>+#define IPMICTL_SET_MY_CHANNEL_ADDRESS_CMD _IOR(IPMI_IOC_MAGIC, 24, struct ipmi_channel_lun_address_set)
>>+#define IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD _IOR(IPMI_IOC_MAGIC, 25, struct ipmi_channel_lun_address_set)
>>+#define IPMICTL_SET_MY_CHANNEL_LUN_CMD	   _IOR(IPMI_IOC_MAGIC, 26, struct ipmi_channel_lun_address_set)
>>+#define IPMICTL_GET_MY_CHANNEL_LUN_CMD	   _IOR(IPMI_IOC_MAGIC, 27, struct ipmi_channel_lun_address_set)
>>    
>>
>
>Are these all OK wrt compat handling?
>  
>
Yes, it is a structure of an unsigned short and an unsigned char, so it 
should be ok.

>  
>
>> 	case IPMICTL_SET_MY_ADDRESS_CMD:
>> 	{
>> 		unsigned int val;
>>...
>> 	case IPMICTL_GET_MY_ADDRESS_CMD:
>> 	{
>>-		unsigned int val;
>>+		unsigned int  val;
>>+		unsigned char rval;
>>...
>> 	case IPMICTL_GET_MY_LUN_CMD:
>> 	{
>>-		unsigned int val;
>>+		unsigned int  val;
>>+		unsigned char rval;
>>+
>>...
>>+	case IPMICTL_SET_MY_CHANNEL_ADDRESS_CMD:
>>+	{
>>+		struct ipmi_channel_lun_address_set val;
>>...
>>+	case IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD:
>>+	{
>>+		struct ipmi_channel_lun_address_set val;
>>...
>>+	case IPMICTL_SET_MY_CHANNEL_LUN_CMD:
>>+	{
>>+		struct ipmi_channel_lun_address_set val;
>>...
>>+	case IPMICTL_GET_MY_CHANNEL_LUN_CMD:
>>+	{
>>+		struct ipmi_channel_lun_address_set val;
>>...
>> 	case IPMICTL_SET_TIMING_PARMS_CMD:
>> 	{
>> 		struct ipmi_timing_parms parms;
>>
>>    
>>
>
>Be aware that this function will use more stack space than it needs to: gcc
>will create a separate stack slot for all the above locals.
>
>Hence it would be better to declare them all at the start of the function. 
>Faster, too - less dcache footprint.
>
>Maybe not as nice from a purist point of view, but it does allow you to
>lose those braces in the switch statement...
>  
>
Hmm, I assumed that gcc would optimize and allocate the stack as it 
needed it without waste.  Ok, easy enough to fix.

Thanks,

-Corey
