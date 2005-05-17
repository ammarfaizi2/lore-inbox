Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVEQRPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVEQRPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVEQRGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:06:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261949AbVEQRE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:04:29 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050517165528.GB27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <20050517165528.GB27549@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 17 May 2005 18:04:23 +0100
Message-Id: <1116349464.23972.118.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 09:55 -0700, Chris Wright wrote:
> Here and up we are in netlink code which does netlink_trim to reduce
> the skb data size before queing to socket.  This does skb_clone with
> gfp_any() flag.  We aren't in softirq, so we get GFP_KERNEL flag set
> even though in_atomic() is true (spin_lock held I'm assuming).

netlink_unicast() is only calling skb_clone() because we artificially
increased the refcount on the skb in question. 

As I understand it, we do that in order to prevent the skb from being
lost if netlink_unicast() returns an error -- it normally frees the skb
before returning in that case. Am I alone in thinking that behaviour is
strange?

I'm really not fond of the refcount trick -- I suspect I'd be happier if
we were just to try to keep track of sk_rmem_alloc so we never hit the
condition in netlink_attachskb() which might cause it to fail.

-- 
dwmw2

