Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbUKXJrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUKXJrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbUKXJrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:47:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:44201 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262566AbUKXJrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:47:09 -0500
Date: Wed, 24 Nov 2004 01:46:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Campbell <icampbell@arcom.com>
Cc: nico@cam.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: "deadlock" between smc91x driver and link_watch
Message-Id: <20041124014650.47af8ae4.akpm@osdl.org>
In-Reply-To: <1101289309.10841.9.camel@icampbell-debian>
References: <1101230194.14370.12.camel@icampbell-debian>
	<20041123153158.6f20a7d7.akpm@osdl.org>
	<1101289309.10841.9.camel@icampbell-debian>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell <icampbell@arcom.com> wrote:
>
>  On Tue, 2004-11-23 at 15:31 -0800, Andrew Morton wrote:
>  > One possible fix would be to remove that flush_scheduled_work() and to do
>  > refcounting around smc_phy_configure(): dev_hold() when scheduling the work
>  > (if schedule_work() returned true), dev_put() in the handler.
> 
>  Something like the following?

I think so.

>  +static void smc_phy_configure_wq(void *data)
>  +{
>  +	struct net_device *dev = data;
>  +	dev_put(dev);
>  +	smc_phy_configure(data);
>  +}

You'd want to do the dev_put() after the smc_phy_configure() though.  It
may still be a tiny bit racy against module unload.
