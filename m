Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVHDKvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVHDKvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVHDKvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:51:46 -0400
Received: from colin.muc.de ([193.149.48.1]:44045 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262474AbVHDKvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:51:08 -0400
Date: 4 Aug 2005 12:51:07 +0200
Date: Thu, 4 Aug 2005 12:51:07 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 5/8] x86_64:Dont do broadcast IPIs when hotplug is enabled in flat mode.
Message-ID: <20050804105107.GD97893@muc.de>
References: <20050801202017.043754000@araj-em64t> <20050801203011.403184000@araj-em64t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801203011.403184000@araj-em64t>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static void flat_send_IPI_allbutself(int vector)
>  {
> +#ifndef CONFIG_HOTPLUG_CPU
>  	if (((num_online_cpus()) - 1) >= 1)
>  		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector,APIC_DEST_LOGICAL);
> +#else
> +	cpumask_t allbutme = cpu_online_map;
> +	int me = get_cpu(); /* Ensure we are not preempted when we clear */
> +	cpu_clear(me, allbutme);
> +	flat_send_IPI_mask(allbutme, vector);
> +	put_cpu();

This still needs the num_online_cpus()s check.

-Andi
