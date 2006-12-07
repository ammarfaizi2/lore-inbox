Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163358AbWLGVHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163358AbWLGVHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163362AbWLGVHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:07:45 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:3131 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163358AbWLGVHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:07:44 -0500
Date: Fri, 8 Dec 2006 08:06:57 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Alan <alan@lxorguk.ukuu.org.uk>,
       Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch] net: dev_watchdog() locking fix
Message-ID: <20061207210657.GA23229@gondor.apana.org.au>
References: <20061206223025.GA17227@elte.hu> <200612061857.30248.len.brown@intel.com> <20061207121135.GA15529@elte.hu> <20061207123011.4b723788@localhost.localdomain> <20061207123836.213c3214.akpm@osdl.org> <20061207204745.GC13327@elte.hu> <20061207204942.GA20524@elte.hu> <20061207205521.GA21329@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207205521.GA21329@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 09:55:22PM +0100, Ingo Molnar wrote:
> 
> fallout of the recent big networking merge i guess. Tested fix below. 
> David, Herbert, do you agree with it, or is it a false positive?

I agree that this is a bug, but the fix is in the wrong spot.  The
dev_watchdog function already runs in softirq context so it doesn't
need to disable BH.

You can almost be guaranteed that if netpoll is involved in a bug
then it should be fixed :)

In this case, it's taking the tx lock in process context which is
not allowed.  So it should disable BH before taking the tx lock.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
