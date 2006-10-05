Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWJENPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWJENPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWJENPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:15:18 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:55135 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750713AbWJENPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:15:16 -0400
Date: Thu, 5 Oct 2006 15:15:46 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH] drivers/base: error handling fixes
Message-ID: <20061005151546.31b73ab5@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061005124848.GB6920@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org>
	<20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com>
	<20061005081705.GA6920@osiris.boeblingen.de.ibm.com>
	<4524E983.6010208@garzik.org>
	<20061005124848.GB6920@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 14:48:48 +0200,
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> If sysfs_remove_group() would also work for non-created (-existent) groups
> then the patch below would work. Unfortunately that is not the case. So one
> would have to remember if sysfs_create_group() was done and succeeded before
> calling sysfs_remove_group()...
> There must be an easier way.

<snip>

> @@ -132,11 +135,15 @@ static struct notifier_block __cpuinitda
>  
>  static int __cpuinit topology_sysfs_init(void)
>  {
> -	int i;
> -
> -	for_each_online_cpu(i) {
> -		topology_cpu_callback(&topology_cpu_notifier, CPU_ONLINE,
> -				(void *)(long)i);
> +	struct sys_device *sys_dev;
> +	int cpu;
> +	int rc;
> +
> +	for_each_online_cpu(cpu) {
> +		sys_dev = get_cpu_sysdev(cpu);
> +		rc = topology_add_dev(sys_dev);
> +		if (rc)
> +			return rc;
>  	}
>  
>  	register_hotcpu_notifier(&topology_cpu_notifier);

Shouldn't the added attribute groups be removed again in the failure
case?

Also, it might be a bit overkill to fail the whole initialization
because of one "bad" cpu. (And the "bad" cpu wouldn't matter if we
could safely remove non-existent groups :)
