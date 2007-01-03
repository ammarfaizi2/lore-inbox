Return-Path: <linux-kernel-owner+w=401wt.eu-S932145AbXACVWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbXACVWz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbXACVWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:22:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51481 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932145AbXACVWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:22:54 -0500
Date: Wed, 3 Jan 2007 13:22:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Carol Hebert <cah@us.ibm.com>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] IPMI: Fix some RCU problems
Message-Id: <20070103132232.f924227e.akpm@osdl.org>
In-Reply-To: <20070103153130.GB16063@localdomain>
References: <20070103153130.GB16063@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007 09:31:30 -0600
Corey Minyard <minyard@acm.org> wrote:

>   found:
> +	smp_rmb();
>  	/* Note that each existing user holds a refcount to the interface. */
>  	kref_get(&intf->refcount);
>  
> @@ -2761,6 +2763,7 @@
>  		kref_put(&intf->refcount, intf_free);
>  	} else {
>  		/* After this point the interface is legal to use. */
> +		smp_wmb(); /* Keep memory order straight for RCU readers. */
>  		intf->intf_num = i;
>  		mutex_unlock(&ipmi_interfaces_mutex);
>  		call_smi_watchers(i, intf->si_dev);
> @@ -3924,6 +3927,8 @@
>  			/* Interface was not ready yet. */
>  			continue;
>  
> +		smp_rmb();
> +

It's nice to always have a comment explaining the use of open-coded
barriers.  Because often the reader is left wondered what on earth it's
barriering against what on earth else.

