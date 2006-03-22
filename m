Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932786AbWCVVaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbWCVVaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWCVVaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:30:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932786AbWCVVaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:30:18 -0500
Date: Wed, 22 Mar 2006 13:26:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/24] s390: channel path measurements.
Message-Id: <20060322132655.79d85b61.akpm@osdl.org>
In-Reply-To: <20060322151539.GC5801@skybase.boeblingen.de.ibm.com>
References: <20060322151539.GC5801@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> [patch 3/24] s390: channel path measurements.
> 
> Gather extended measurements for channel paths from the channel subsystem
> and expose them to userspace via a sysfs attribute.
> 
> ...
>
> +static void
> +chsc_remove_cmg_attr(struct channel_subsystem *css)
> +{
> +	int i;
> +
> +	for (i = 0; i <= __MAX_CHPID; i++) {

hm, it's somewhat unusual for MAX_FOO to be inclusive.  Usually it means
"greatest possible+1".

you have

	struct channel_subsystem {
	 	struct channel_path *chps[__MAX_CHPID + 1];

so I guess it all works..

> +static inline int
> +__chsc_do_secm(struct channel_subsystem *css, int enable, void *page)

This has two callsites.  inlining it probably deoptimises things.

> +	secm_area->request = (struct chsc_header) {
> +		.length = 0x0050,
> +		.code   = 0x0016,
> +	};

gcc tends to generate poor code for this construct.

