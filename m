Return-Path: <linux-kernel-owner+w=401wt.eu-S933010AbWL1SbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbWL1SbI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933021AbWL1SbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:31:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43992 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010AbWL1SbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:31:07 -0500
Date: Thu, 28 Dec 2006 18:31:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Carol Hebert <cah@us.ibm.com>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH] IPMI: fix some RCU problems
Message-ID: <20061228183101.GA2412@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Corey Minyard <minyard@acm.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Carol Hebert <cah@us.ibm.com>,
	OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
References: <20061228182447.GA23730@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228182447.GA23730@localdomain>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (list_empty(&intf->cmd_rcvrs))
> +		INIT_LIST_HEAD(&list);
> +	else {
> +		list.next = intf->cmd_rcvrs.next;
> +		list.prev = intf->cmd_rcvrs.prev;
> +		INIT_LIST_HEAD(&intf->cmd_rcvrs);
> +
> +		/*
> +		 * At this point the list body still points to
> +		 * intf->cmd_rcvrs.  Wait for any readers to finish
> +		 * using the list before we switch the list body over
> +		 * to the new list.
> +		 */
> +		synchronize_rcu();
> +
> +		/* Ready the list for use. */
> +		list.next->prev = &list;
> +		list.prev->next = &list;
> +	}

This kind of thing must not be opencoded in drivers.  Please add
a new list_splice_rcu helper to list.h

