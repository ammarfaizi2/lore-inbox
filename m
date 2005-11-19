Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVKSVDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVKSVDw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbVKSVDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:03:52 -0500
Received: from postel.suug.ch ([195.134.158.23]:36584 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1750841AbVKSVDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:03:51 -0500
Date: Sat, 19 Nov 2005 22:04:11 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: yoshfuji@linux-ipv6.org, yanzheng@21cn.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [DEBUG INFO]IPv6: sleeping function called from invalid context.
Message-ID: <20051119210411.GE20395@postel.suug.ch>
References: <20051118123557.GD20395@postel.suug.ch> <E1EdRCZ-0007uy-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EdRCZ-0007uy-00@gondolin.me.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Xu <herbert@gondor.apana.org.au> 2005-11-19 22:48
> Thomas Graf <tgraf@suug.ch> wrote:
> > 
> > I did. I think it was right, why would an allocation be necessary on
> > the second call to inet6_dump_fib()? The walker allocated in process
> > context on the first call should be reused from cb->args[0].
> 
> Continued dumps are always called under spin lock (see netlink_dump).
> So we need to use GFP_ATOMIC in dumpers.

The continued dumps wouldn't be the problem, the walker is allocated
on the initial dump call. It was a mistake though, nlk->cb_lock spin
lock is always held for cb->dump() even though it should only be
required during the nlk->cb != NULL check. netlink_dump_start()
guarantees to only allow one dumper per socket at a time.
