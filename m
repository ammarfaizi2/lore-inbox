Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUDCKHw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 05:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUDCKHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 05:07:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:8354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbUDCKHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 05:07:51 -0500
Date: Sat, 3 Apr 2004 02:07:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: a.nielsen@optushome.com.au, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, degger@tarantel.rz.fh-muenchen.de
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-Id: <20040403020740.33ef375f.akpm@osdl.org>
In-Reply-To: <20040403112755.A19308@electric-eye.fr.zoreil.com>
References: <20040403150229.75ec6b98.a.nielsen@optushome.com.au>
	<20040403112755.A19308@electric-eye.fr.zoreil.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> wrote:
>
> Adam Nielsen <a.nielsen@optushome.com.au> :
> [...]
> > in the Realtek 8169 gigabit ethernet driver.  Due to a logic error,
> > there is a loop in an interrupt handler that often goes infinite, thus
> > locking up the entire computer.  The attached patch fixes the problem.
> 
> - until there is an explanation on _why_ this condition happens, this is a
>   band-aid for an unexplained condition, not a fix for a "logic error" (it
>   may have interesting performance effects though);
> 

The logic is faulty, or at least very odd.

	tx_left = tp->cur_tx - dirty_tx;

	while (tx_left > 0) {
		int entry = dirty_tx % NUM_TX_DESC;

		if (!(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)) {
			...
		}
	}

Why is that `if' test there at all?  If it ever returns false, the box
locks up.  A BUG_ON(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)
might make more sense.
