Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTL3E4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbTL3E4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:56:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47306 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264452AbTL3E42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:56:28 -0500
Date: Mon, 29 Dec 2003 20:51:57 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
Message-Id: <20031229205157.4c631f28.davem@redhat.com>
In-Reply-To: <3FF0FA6A.8000904@pobox.com>
References: <1072567054.4112.14.camel@gaston>
	<20031227170755.4990419b.davem@redhat.com>
	<3FF0FA6A.8000904@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003 23:09:14 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Not really...  pretty much _all_ TX queue packet freeing occurs inside 
> an irq handler and inside the driver spinlock.  Further, we don't want 
> to reinvent some sort of "queue skb for freeing" code in every driver.

There is one important detail not mentioned.

If we let the TX free occur in cpu IRQ disabled context, the
BH to actually do the work will occur as some indeterminate
time in the future after the top level IRQ spinlock release
occurs.

Unlike local_bh_enable(), local_irq_enable() does not run
softirq work.  Similarly when comparing IRQ handler return
(which also runs softirq work if pending).

This is the most important reason why the suggested change is wrong.
