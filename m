Return-Path: <linux-kernel-owner+w=401wt.eu-S932113AbXACUxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbXACUxH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbXACUxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:53:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:41133 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113AbXACUxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:53:05 -0500
Subject: Re: [PATCH] ppc: pic pmacpic_find_viaint cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <200701022020.04174.m.kozlowski@tuxland.pl>
References: <200701022020.04174.m.kozlowski@tuxland.pl>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 07:52:52 +1100
Message-Id: <1167857572.6165.157.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 20:20 +0100, Mariusz Kozlowski wrote:
> Hello,
> 
> 	Litte rework to supress this warning:
> 
> arch/powerpc/platforms/powermac/pic.c: In function 'pmacpic_find_viaint':
> arch/powerpc/platforms/powermac/pic.c:625: warning: label 'not_found' defined but not used
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

It's actually bogus (though the old code was too) now that we have
refcounting of device-nodes. We should do an of_node_put() on the result
of of_find_node_by_name() after we are done with it.

Can you respin with that fix ?

Ben.

>  arch/powerpc/platforms/powermac/pic.c |   13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> --- linux-2.6.20-rc2-mm1-a/arch/powerpc/platforms/powermac/pic.c	2006-12-24 05:00:32.000000000 +0100
> +++ linux-2.6.20-rc2-mm1-b/arch/powerpc/platforms/powermac/pic.c	2007-01-02 16:49:05.000000000 +0100
> @@ -609,21 +609,18 @@ unsigned long sleep_save_mask[2];
>   */
>  static int pmacpic_find_viaint(void)
>  {
> -	int viaint = -1;
> -
>  #ifdef CONFIG_ADB_PMU
>  	struct device_node *np;
>  
>  	if (pmu_get_model() != PMU_OHARE_BASED)
> -		goto not_found;
> +		return -1;
>  	np = of_find_node_by_name(NULL, "via-pmu");
>  	if (np == NULL)
> -		goto not_found;
> -	viaint = irq_of_parse_and_map(np, 0);;
> +		return -1;
> +	return irq_of_parse_and_map(np, 0);
> +#else
> +	return -1;
>  #endif /* CONFIG_ADB_PMU */
> -
> -not_found:
> -	return viaint;
>  }
>  
>  static int pmacpic_suspend(struct sys_device *sysdev, pm_message_t state)
> 
> 

