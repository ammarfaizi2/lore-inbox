Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTJQMBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTJQMBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:01:04 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:14087 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263411AbTJQMBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:01:02 -0400
Date: Fri, 17 Oct 2003 13:01:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
Subject: Re: [patch][2/3] qlogic: call request_irq() with private data
Message-ID: <20031017130100.B26699@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
	linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
References: <20031016015349.GB1765@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031016015349.GB1765@cathedrallabs.org>; from aris@cathedrallabs.org on Wed, Oct 15, 2003 at 11:53:49PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:53:49PM -0200, Aristeu Sergio Rozanski Filho wrote:
> +	hreg->can_queue = 1;

We already have can_queue set in the host template, so this line is
superflous.

> +#ifdef QL_USE_IRQ
> +	if (qlirq < 0 || request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", hreg))
> +		goto free_scsi_host;
> +#endif

Does the driver work at all with QL_USE_IRQ undefined?  I don't think so
and if I'm right you should probably nuke the ifdef while you're at it.

> +free_scsi_host:
> +	kfree(hreg);

should be

#ifdef PCMCIA
	scsi_host_put(shost);
#else
	scsi_unregister(shost):
#endif

if the reworked version of the previous patch is applied.

>  	if (host->can_queue)

can_queue can't be 0 these days so this one could go away aswell.

