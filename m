Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWJJQsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWJJQsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWJJQsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:48:05 -0400
Received: from mail.axxeo.de ([82.100.226.146]:61394 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1030199AbWJJQsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:48:01 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 2/2] round_jiffies users
Date: Tue, 10 Oct 2006 18:47:39 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       akpm@osdl.org, mingo@elte.hu
References: <1160496165.3000.308.camel@laptopd505.fenrus.org> <1160496210.3000.310.camel@laptopd505.fenrus.org> <1160496263.3000.312.camel@laptopd505.fenrus.org>
In-Reply-To: <1160496263.3000.312.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101847.39604.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

Arjan van de Ven wrote:
> Index: linux-2.6.19-rc1-git6/mm/slab.c
> ===================================================================
> --- linux-2.6.19-rc1-git6.orig/mm/slab.c
> +++ linux-2.6.19-rc1-git6/mm/slab.c
> @@ -926,7 +926,7 @@ static void __devinit start_cpu_timer(in
>  	if (keventd_up() && reap_work->func == NULL) {
>  		init_reap_node(cpu);
>  		INIT_WORK(reap_work, cache_reap, NULL);
> -		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
> +		schedule_delayed_work_on(cpu, reap_work, __round_jiffies_relative(HZ, cpu));
>  	}
>  }
>  

Did you changed the behavior by intention?
You seem to miss the factor "3" here. This hunk should read:

--- linux-2.6.19-rc1-git6.orig/mm/slab.c
+++ linux-2.6.19-rc1-git6/mm/slab.c
@@ -926,7 +926,7 @@ static void __devinit start_cpu_timer(in
 	if (keventd_up() && reap_work->func == NULL) {
 		init_reap_node(cpu);
 		INIT_WORK(reap_work, cache_reap, NULL);
-		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
+		schedule_delayed_work_on(cpu, reap_work, __round_jiffies_relative(HZ, 3 * cpu));
 	}
 }
 

In case you apply it:

Signed-off-by: Ingo Oese <netdev@axxeo.de>


Regards

Ingo Oeser
