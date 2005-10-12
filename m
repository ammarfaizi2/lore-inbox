Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVJLAEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVJLAEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVJLAEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:04:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932380AbVJLAEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:04:06 -0400
Date: Tue, 11 Oct 2005 17:03:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
Message-Id: <20051011170358.2684347a.akpm@osdl.org>
In-Reply-To: <1128404215.31063.32.camel@gaston>
References: <1128404215.31063.32.camel@gaston>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> +int wf_register_client(struct notifier_block *nb)
> +{
> +	int rc;
> +	struct wf_control *ct;
> +	struct wf_sensor *sr;
> +
> +	down(&wf_lock);
> +	rc = notifier_chain_register(&wf_client_list, nb);
> +	if (rc != 0)
> +		goto bail;
> +	wf_client_count++;
> +	list_for_each_entry(ct, &wf_controls, link)
> +		wf_notify(WF_EVENT_NEW_CONTROL, ct);
> +	list_for_each_entry(sr, &wf_sensors, link)
> +		wf_notify(WF_EVENT_NEW_SENSOR, sr);
> +	if (wf_client_count == 1)
> +		wf_start_thread();
> +	up(&wf_lock);
> + bail:
> +	return rc;
> +}

This will leave wf_lock held on error.
