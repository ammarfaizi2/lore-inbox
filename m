Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbTLFMQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 07:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbTLFMQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 07:16:10 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:35084 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S265124AbTLFMQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 07:16:04 -0500
Message-ID: <3FD1C989.3050603@kolumbus.fi>
Date: Sat, 06 Dec 2003 14:20:25 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Numaq in 2.4 and 2.6
References: <3FD1A54F.101@kolumbus.fi> <20031206112348.GP8039@holomorphy.com>
In-Reply-To: <20031206112348.GP8039@holomorphy.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 06.12.2003 14:18:03,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 06.12.2003 14:17:13,
	Serialize complete at 06.12.2003 14:17:13
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


William Lee Irwin III wrote:

>On Sat, Dec 06, 2003 at 11:45:51AM +0200, Mika Penttil? wrote:
>  
>
>>While comparing numaq support in 2.4.23 and 2.6.0-test11 came accross 
>>following...
>>In 2.4.23 mpparse.c we do :
>>   phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);
>>and then launch the cpus using NMI and logical addressing in the order 
>>phys_cpu_present_map indicates.
>>In 2.6.0-test11mpparse.c we do :
>>   tmp = apicid_to_cpu_present(apicid);
>>   physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
>>where apicid is the result of :
>>   static inline int generate_logical_apicid(int quad, int phys_apicid)
>>   {
>>       return (quad << 4) + (phys_apicid ? phys_apicid << 1 : 1);
>>   }
>>and phys_apicid == m->mpc_apicid
>>Again we lauch the cpus using NMI and logical addressing.
>>    
>>
>
>The sole purposes of this (AFAICT) are for reassigning physical ID's of
>the IO-APIC's, and cpu wakeup. You're noticing the first of several
>inconsistencies:
>
>(a) The NUMA-Q BIOS stores logical (clustered hierarchical) APIC ID's
>	in the MP table instead of physical APIC ID's. This confuses
>	various things.
>(b) NUMA-Q's are P-III -based, i.e. serial APIC. The global
>	phys_cpu_present_map does not suffice to represent the things,
>	though some sort of mangled physical APIC ID's are kept in it.
>	To properly describe serial APIC systems of its kind, there
>	needs to be one analogue of phys_cpu_present_map per-node, as
>	each node has a separate APIC bus with its own domain for
>	physical APIC ID's. This explains (a) as it's impossible to
>	have distinct physical APIC ID's for > 15 cpus on serial APIC
>	-based systems.
>(c) The 2.6 code actually decodes the logical APIC ID to generate a
>	fake xAPIC-like physical APIC ID and uses that as an index
>	into the phys_cpu_present_map. This is used essentially for
>	cpu enumeration.
>(d) The rest of the setup phys_cpu_present_map is used for is already
>	done by the BIOS. The code cheats by ignoring the IO-APIC
>	renumbering phase entirely for NUMA_Q. Granted, it's supposed
>	to be there to doublecheck the BIOS.
>
>
>On Sat, Dec 06, 2003 at 11:45:51AM +0200, Mika Penttil? wrote:
>  
>
>>So the the set of apicids fed to do_boot_cpu() in 2.4 and 2.6 must be 
>>different using the same mp table. And both use logical addressing. 
>>Seems that 2.4 expects mpc_apicid to be something like (quad | cpu) and 
>>2.6 only cpu, the quad comes from the translation table.
>>The conclusion is that the same mp table can't work in 2.4 and 2.6? No?
>>    
>>
>
>It's all okay, albeit ugly and obfuscated as the code doesn't truly
>describe the hardware.
>
>
>-- wli
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

Ok...the only thing that still confuses is the apicid to actually used 
to start the cpu. In NUMA-Q case we don't program the LDRs in either 2.4 
or 2.6, the bios does this. So the NMI IPI must have the same 
destinations in both 2.4 and 2.6 in order to lauch the same cpus.

In 2.4, the mpc_apicids are used as such as NMI IPI destinations. In 
2.6, the mangled ones (by generate_logical_apicid()) are used as NMI IPI 
destinations. If the mpc_apicid is already in sort of (cluster, cpu) 
format (and used in 2.4 NMI IPI), it can't be the same after mangling?

--Mika



