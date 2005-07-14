Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVGNU4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVGNU4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVGNU4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:56:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46496 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261717AbVGNUy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:54:56 -0400
Subject: Re: [RFC][PATCH 1/4] add jiffies_to_nsecs() helper and fix up size
	of usecs
From: Dave Hansen <haveblue@us.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050714202826.GE28100@us.ibm.com>
References: <20050714202629.GD28100@us.ibm.com>
	 <20050714202826.GE28100@us.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 13:54:47 -0700
Message-Id: <1121374488.15263.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 13:28 -0700, Nishanth Aravamudan wrote:
> +static inline u64 jiffies_to_nsecs(const unsigned long j)
> +{
> +#if HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ)
> +	return (NSEC_PER_SEC / HZ) * (u64)j;
> +#elif HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC)
> +	return ((u64)j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
> +#else
> +	return ((u64)j * NSEC_PER_SEC) / HZ;
> +#endif
> +}

That might look a little better something like:

static inline u64 jiffies_to_nsecs(const unsigned long __j)
{
	u64 j = __j;

	if (HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ))
		return (NSEC_PER_SEC / HZ) * j;
	else if (HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC))
		return (j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
	else
		return (j * NSEC_PER_SEC) / HZ;
}

Compilers are smart :)

-- Dave

