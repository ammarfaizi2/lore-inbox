Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWENKCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWENKCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 06:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWENKCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 06:02:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932370AbWENKCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 06:02:01 -0400
Date: Sun, 14 May 2006 02:58:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [PATCH][resend] fix resource leak in pnp card_probe()
Message-Id: <20060514025838.0a7a846f.akpm@osdl.org>
In-Reply-To: <31862.1147600089@ocs3>
References: <20060514023833.649fde1d.akpm@osdl.org>
	<31862.1147600089@ocs3>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> wrote:
>
> >+	clink = pnp_alloc(sizeof(*clink));
>  >+	if (!clink)
>  >+		return 0;
>  >+	clink->card = card;
>  >+	clink->driver = drv;
>  >+	clink->pm_state = PMSG_ON;
> 
>  Memory leak of clink on next test.
> 
>  >+
>  >+	if (drv->probe(clink, id) >= 0)
>  >+		return 1;
>  >+
>  >+	/* Recovery */
>  >+	card_for_each_dev(card, dev) {
>  >+		if (dev->card_link == clink)
>  >+			pnp_release_card_device(dev);
>  > 	}
>  >+	kfree(clink);
>  > 	return 0;
>  > }

No, if ->probe succeeded, it took over control of the memory at *clink.

It's all rather twisty and quite undocumented.
