Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbTBHTNu>; Sat, 8 Feb 2003 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTBHTNu>; Sat, 8 Feb 2003 14:13:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64974 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267057AbTBHTNt>; Sat, 8 Feb 2003 14:13:49 -0500
Date: Sat, 08 Feb 2003 11:23:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: gone@us.ibm.com, linux-kernel@vger.kernel.org
cc: chandra.sekharan@us.ibm.com, cleverdj@us.ibm.com, johnstul@us.ibm.com
Subject: Re: [PATCH][RFC] Discontigmem support for the x440 
Message-ID: <15810000.1044732203@[10.10.2.4]>
In-Reply-To: <200302060710.h167Alf02508@w-gaughen.beaverton.ibm.com>
References: <200302060710.h167Alf02508@w-gaughen.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Identify which cnode a physical address resides on */
> +int pfn_to_nid(unsigned long pfn)
> +{
> +	int	i;
> +	struct node_memory_chunk_s *nmcp;
> +
> +	/* We've got a sorted list.  Binary search here?  Do we care?? */
> +	nmcp = node_memory_chunk;
> +	for (i = num_memory_chunks; --i >= 0; nmcp++)
> +		if (pfn >= nmcp->start_pfn && pfn <= nmcp->end_pfn)
> +			return (int)nmcp->nid;
> +
> +	return -1;
> +}

This is called a lot, and it's large and inefficient. Can you turn it 
into an array lookup like the NUMA-Q implementation, and inline it? 

All the clumps and chunks stuff can go, I think.

> diff -Nru a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
> --- a/drivers/acpi/events/evevent.c	Wed Feb  5 19:15:58 2003
> +++ b/drivers/acpi/events/evevent.c	Wed Feb  5 19:15:58 2003
> @@ -104,6 +104,7 @@
>  
>  	ACPI_FUNCTION_TRACE ("ev_handler_initialize");
>  
> +	return_ACPI_STATUS (0);
>  
>  	/* Install the SCI handler */

That used to be wrapped in ifdef CONFIG_SUMMIT, which seems much safer
to me ... any reason for the change?

And all the kludge stuff needs to go, but you know that already ;-)

M.

