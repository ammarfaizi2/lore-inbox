Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbUKDXub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbUKDXub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUKDXub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:50:31 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:15313 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262504AbUKDXuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:50:10 -0500
Date: Fri, 5 Nov 2004 00:50:01 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-net@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps
Message-ID: <20041104235001.GB30029@merlin.emma.line.org>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, linux-net@vger.kernel.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <418A7B0B.7040803@trash.net> <E1CPoUT-0000sk-00@gondolin.me.apana.org.au> <20041104130028.099fc130.davem@davemloft.net> <418AA4C7.2030909@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418AA4C7.2030909@trash.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004, Patrick McHardy wrote:

> -	data = amp;
> -	data_limit = amp + skb->len - dataoff;
> +	skb_copy_bits(skb, dataoff, amanda_buffer, skb->len - dataoff);
> +	data = amanda_buffer;
> +	data_limit = amanda_buffer + skb->len - dataoff;

Does this mean the whole buffer is still copied?

If so: Making a local copy of the packet just to be able to stuff NUL
bytes to suit or "optimize" strstr functions is plain nonsense - amanda
pipes several GByte through the kernel at each run, and copying
gazillions of bits around, wasting millions of CPU cycles, just because
someone is too lazy to spell a more decent search function, is
bad design.

Same consideration applies to FTP connection tracking.

I wrote a memstr function for bogofilter (GPL v2) that we could use
inside the kernel, as a length-limited strstr replacement, as in "search
the first buffer_size bytes starting with buffer_base for the first
occurrence of const char *needle". That avoids all buffer modifications
in ip_conntrack_amanda.c AFAICS. It's also slow because it does a linear
search and not an optimized search as the sophisticated KMP and other
search algorithms would be able to do, but then again the generic strstr
inside the kernel is linear, too.

-- 
Matthias Andree
