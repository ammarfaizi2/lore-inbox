Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTLFNEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTLFNEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:04:51 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:21264 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S265151AbTLFNEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:04:48 -0500
Message-ID: <3FD1D4F6.7000106@kolumbus.fi>
Date: Sat, 06 Dec 2003 15:09:10 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Numaq in 2.4 and 2.6
References: <3FD1A54F.101@kolumbus.fi> <20031206112348.GP8039@holomorphy.com> <3FD1C94C.1020104@kolumbus.fi> <20031206123622.GQ8039@holomorphy.com>
In-Reply-To: <20031206123622.GQ8039@holomorphy.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 06.12.2003 15:06:47,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 06.12.2003 15:05:57,
	Serialize complete at 06.12.2003 15:05:57
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Sat, Dec 06, 2003 at 02:19:24PM +0200, Mika Penttil? wrote:
>  
>
>>Ok...the only thing that still confuses is the apicid to actually used 
>>to start the cpu. In NUMA-Q case we don't program the LDRs in either 2.4 
>>or 2.6, the bios does this. So the NMI IPI must have the same 
>>destinations in both 2.4 and 2.6 in order to lauch the same cpus.
>>    
>>
>
>On Sat, Dec 06, 2003 at 02:19:24PM +0200, Mika Penttil? wrote:
>  
>
>>In 2.4, the mpc_apicids are used as such as NMI IPI destinations. In 
>>2.6, the mangled ones (by generate_logical_apicid()) are used as NMI IPI 
>>destinations. If the mpc_apicid is already in sort of (cluster, cpu) 
>>format (and used in 2.4 NMI IPI), it can't be the same after mangling?
>>    
>>
>
>The mangled physical APIC ID used as an index into phys_cpu_present_map
>happens to determine the clustered hierarchical logical APIC ID, and so
>wakeup_secondary_cpu() (switched via #ifdef) gets the right number.
>There is a correspondence between (node, physical APIC ID) pairs and
>logical APIC ID's that's part of the BIOS's bootstrap protocol. The
>calculations you're looking at are based on that, and the logical APIC
>ID's are encoded in that paired format by the BIOS, and in the mangled
>format as indices into phys_cpu_present_map.
>
>Both 2.4 and 2.6 use cpu_present_to_apicid() to do that translation on
>the fly given an index into phys_cpu_present_map().
>
>
>-- wli
>  
>
Thanks, I understand what's happening in 2.6. So I think there might be 
a problem with 2.4.23 then. In mpparse.c :

void __init MP_processor_info (struct mpc_config_processor *m)
{
int ver, quad, logical_apicid;

if (!(m->mpc_cpuflag & CPU_ENABLED))
return;

logical_apicid = m->mpc_apicid;
if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
quad = translation_table[mpc_record]->trans_quad;
logical_apicid = (quad << 4) +
(m->mpc_apicid ? m->mpc_apicid << 1 : 1);
printk("Processor #%d %s APIC version %d (quad %d, apic %d)\n",
m->mpc_apicid,
mpc_family((m->mpc_cpufeature & CPU_FAMILY_MASK)>>8 ,
(m->mpc_cpufeature & CPU_MODEL_MASK)>>4),
m->mpc_apicver, quad, logical_apicid);
.....
and later in same function :

phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);

but _not_

phys_cpu_present_map |= apicid_to_phys_cpu_present(logical_apicid);

as one would expect (and would make it identical to 2.6 behaviour).... A 
bug?


--Mika








