Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVJ0QGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVJ0QGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVJ0QGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:06:20 -0400
Received: from ns.sevcity.net ([193.47.166.213]:9629 "EHLO mail.sevcity.net")
	by vger.kernel.org with ESMTP id S1751135AbVJ0QGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:06:19 -0400
Subject: Re: [PATCH] [KDUMP] pending interrupts problem
From: Alex Lyashkov <umka@sevcity.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: OBATA Noboru <noboru.obata.ar@hitachi.com>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1y84farz7.fsf@ebiederm.dsl.xmission.com>
References: <20051027.165027.97297370.noboru.obata.ar@hitachi.com>
	 <m1y84farz7.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SevcityNet
Message-Id: <1130429164.3360.1.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-16) 
Date: Thu, 27 Oct 2005 19:06:04 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seems to bad patch. you dereference pointer (1) before check to NULL(2).

> ---
> 
>  arch/i386/kernel/smp.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> applies-to: e6a6c8ed12ba1ef7fa376fa3993e3c329e9f294a
> 195ab3620ba410697ad78957226c5493d55dd2ee
> diff --git a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
> index 218d725..3d33125 100644
> --- a/arch/i386/kernel/smp.c
> +++ b/arch/i386/kernel/smp.c
> @@ -560,6 +560,7 @@ int smp_call_function (void (*func) (voi
>  	if (wait)
>  		while (atomic_read(&data.finished) != cpus)
>  			cpu_relax();
> +	call_data = NULL;
>  	spin_unlock(&call_lock);
>  
>  	return 0;
> @@ -609,6 +610,14 @@ fastcall void smp_call_function_interrup
>  	int wait = call_data->wait;
(1) ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  	ack_APIC_irq();
> +
> +	/* Ignore spurious IPIs */
> +	if (!call_data)
> +		return;
(2) ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

