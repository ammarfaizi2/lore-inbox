Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWBXWnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWBXWnm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWBXWnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:43:42 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:21030 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932624AbWBXWnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:43:42 -0500
In-Reply-To: <200602250927.36954.michael@ellerman.id.au>
References: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org> <200602250927.36954.michael@ellerman.id.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
X-Gpgmail-State: !signed
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <815A460C-BAB0-4770-8357-68136D31EDC3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for !MULTIPLATFORM
Date: Fri, 24 Feb 2006 16:43:50 -0600
To: michael@ellerman.id.au
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 24, 2006, at 4:27 PM, Michael Ellerman wrote:

> Hi Kumar,
>
> On Sat, 25 Feb 2006 03:54, Kumar Gala wrote:
>> mem= command line option was being ignored in arch/powerpc if we  
>> were not
>> a CONFIG_MULTIPLATFORM (which is handled via prom_init stub). The  
>> initial
>> command line extraction and parsing needed to be moved earlier in  
>> the boot
>> process and have code to actual parse mem= and do something about it.
>
>> @@ -1004,6 +991,41 @@ static int __init early_init_dt_scan_cho
>>                 crashk_res.end = crashk_res.start + *lprop - 1;
>>  #endif
>>
>> +	/* Retreive command line */
>> + 	p = of_get_flat_dt_prop(node, "bootargs", &l);
>> +	if (p != NULL && l > 0)
>> +		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
>> +
>> +#ifdef CONFIG_CMDLINE
>> +	if (l == 0 || (l == 1 && (*p) == 0))
>> +		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>> +#endif /* CONFIG_CMDLINE */
>> +
>> +	DBG("Command line is: %s\n", cmd_line);
>> +
>> +	if (strstr(cmd_line, "mem=")) {
>> +		char *p, *q;
>> +		unsigned long maxmem = 0;
>> +
>> +		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
>> +			q = p + 4;
>> +			if (p > cmd_line && p[-1] != ' ')
>> +				continue;
>> +			maxmem = simple_strtoul(q, &q, 0);
>> +			if (*q == 'k' || *q == 'K') {
>> +				maxmem <<= 10;
>> +				++q;
>> +			} else if (*q == 'm' || *q == 'M') {
>> +				maxmem <<= 20;
>> +				++q;
>> +			} else if (*q == 'g' || *q == 'G') {
>> +				maxmem <<= 30;
>> +				++q;
>> +			}
>> +		}
>> +		memory_limit = maxmem;
>> +	}
>> +
>
> Why not make the mem= parsing an early_param() handler and then call
> parse_early_param() here?

This would put constraints on the early_param()'s that I dont think  
we should impose.

> And I think a switch would be easier to read for the K/M/G handling.

I should probably use memparse() now that I've found it :)

- k
