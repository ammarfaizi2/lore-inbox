Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268695AbUJDWGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268695AbUJDWGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268686AbUJDWFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:05:45 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:53053 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S268698AbUJDWC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:02:56 -0400
X-BrightmailFiltered: true
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <gww@btinternet.com>, <s.rivoir@gts.it>,
       <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9-rc3-mm2
Date: Mon, 4 Oct 2004 15:02:52 -0700
Organization: Cisco Systems
Message-ID: <00b301c4aa5d$e4f61730$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20041004143953.10e6d764.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andrew Morton
> Sent: Monday, October 04, 2004 2:40 PM
> To: gww@btinternet.com; s.rivoir@gts.it; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.9-rc3-mm2
> 
> 
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Could you try this patch?  It'll locate the bug for us.
> 
> Don't worry about this - Ingo found it.
> 
> You could try these instead:
> 
> --- 
> 25/include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preem
> pt-safety-fix	Mon Oct  4 14:36:19 2004
> +++ 25-akpm/include/linux/netfilter_ipv4/ip_conntrack.h	
> Mon Oct  4 14:37:02 2004
> @@ -311,10 +311,11 @@ struct ip_conntrack_stat
>  	unsigned int expect_delete;
>  };
>  
> -#define CONNTRACK_STAT_INC(count)				\
> -	do {							\
> -		per_cpu(ip_conntrack_stat, get_cpu()).count++;	\
> -		put_cpu();					\
> +#define CONNTRACK_STAT_INC(count)				
> 	\
> +	do {							
> 	\
> +		preempt_disable();				
> 	\
> +		per_cpu(ip_conntrack_stat, 
> smp_processor_id()).count++;	\
> +		preempt_disable();				

I guess it should be "preempt_enable()"? :)

> 	\
>  	} while (0)
>  
>  /* eg. PROVIDES_CONNTRACK(ftp); */
> _
> 
> 
> --- 25/include/net/neighbour.h~neigh_stat-preempt-fix-fix	
> Mon Oct  4 14:39:22 2004
> +++ 25-akpm/include/net/neighbour.h	Mon Oct  4 14:39:22 2004
> @@ -113,8 +113,9 @@ struct neigh_statistics
>  
>  #define NEIGH_CACHE_STAT_INC(tbl, field)			
> 	\
>  	do {							
> 	\
> -		(per_cpu_ptr((tbl)->stats, 
> get_cpu())->field)++;	\
> -		put_cpu();					
> 	\
> +		preempt_disable();				
> 	\
> +		(per_cpu_ptr((tbl)->stats, 
> smp_processor_id())->field)++; \
> +		preempt_enable();				
> 	\
>  	} while (0)
>  
>  struct neighbour
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

