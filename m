Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUIQFQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUIQFQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUIQFQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:16:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:59277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268457AbUIQFQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:16:09 -0400
Date: Thu, 16 Sep 2004 22:14:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Li Shaohua <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: hotplug e1000 failed after 32 times
Message-Id: <20040916221406.1f3764e0.akpm@osdl.org>
In-Reply-To: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua <shaohua.li@intel.com> wrote:
>
> I'm testing a hotplug driver. In my test, I will hot add/remove an e1000
>  NIC frequently. The result is my hot add failed after 32 times hotadd.
>  After looking at the code of e1000 driver, I found
>  e1000_adapter->bd_number has maxium limitation of 32, and it increased
>  one every hot add. Looks like the remove driver routine didn't free the
>  'bd_number', so hot add failed after 32 times. Below patch fixes this
>  issue.

Yeah.  I think you'll find that damn near every net driver in the kernel
has this problem.  I think it would be better to create a little suite of
library functions in net/core/dev.c to handle this situation.

Maybe something like

struct net_boards {
	struct idr idr;
	int max_boards;
}

void net_boards_init(struct net_boards *net_boards, int max_boards);
int net_board_alloc(struct net_boards *net_boards);
int net_boards_free(struct net_boards *net_boards, int board_no);

(I wonder where the locking should be performed?)

This is a pretty thin wrapper around the idr code and actually is quite
generic and has nothing to do with networking so you might end up deciding
to rename things and to move the code into idr.c

> -	adapter->bd_number = cards_found;
> +	adapter->bd_number = e1000_alloc_bd_number();;

Extra semicolon.

> +	TxDescriptors[bd_number] = 
> +	RxDescriptors[bd_number] = 
> +	Speed[bd_number] =
> +	Duplex[bd_number] =
> +	AutoNeg[bd_number] =
> +	FlowControl[bd_number] =
> +	XsumRX[bd_number] =
> +	TxIntDelay[bd_number] =
> +	TxAbsIntDelay[bd_number] =
> +	RxIntDelay[bd_number] =
> +	RxAbsIntDelay[bd_number] =
> +	InterruptThrottleRate[bd_number] = OPTION_UNSET;

Unpopular coding style.  Please just do

	RxAbsIntDelay[bd_number] = OPTION_UNSET;
	InterruptThrottleRate[bd_number] = OPTION_UNSET;

etc.
