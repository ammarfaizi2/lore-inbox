Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVHaNN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVHaNN6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVHaNN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:13:58 -0400
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:44411 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S964791AbVHaNN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:13:57 -0400
X-SBRSScore: None
Message-ID: <4315AD07.2020500@fujitsu-siemens.com>
Date: Wed, 31 Aug 2005 15:13:43 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de>
In-Reply-To: <p73pssj2xdz.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi, hi everyone,

>>The MP_valid_apicid() function [arch/i386/kernel/mpparse.c] checks
>>whether the APIC version field is >=20 in order to determine whether
>>the CPU supports 8-bit physical APIC ids.
> 
> Yes, it's broken. ... . Also it's only
> a sanity check for broken BIOS, and in this case it causes more problems
> than it solves.

We have another issue with the APIC IDs: the GET_APIC_ID and 
APIC_ID_MASK macros from the subarch code. In all subarchs except summit 
and es7000, these macros use a hard-coded mask 0x0F for the APIC ID. 
Thus, any APIC ID >15 will be truncated, leading to obscure errors.

We are wondering why these masks are there in the subarch code at all. 
After all, whether or not 8-bit APIC IDs are supported depends mainly on 
the CPU type used. Why wouldn't it possible to have a "default" 
architecture with APIC IDs > 15, if the CPUs allow it?

In other words: What would be broken if we just used an APIC ID mask of 
0xFF everywhere?

The current situation with MP_valid_apicid() on the one hand (masking 
the APIC ID as a function of local APIC version) and APIC_ID_MASK 
(masking the APIC as a function of subarch) on the other hand is 
inconsistent. A correct approach must take both CPU and architecture 
constraints into account, and use a CPU-type-dependent variable mask in 
the subarch code.

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
