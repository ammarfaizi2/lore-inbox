Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945923AbWGOAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945923AbWGOAFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945927AbWGOAFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:05:15 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:35334 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1945923AbWGOAFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:05:13 -0400
Date: Sat, 15 Jul 2006 10:04:58 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
Message-ID: <20060715000458.GB9334@gondor.apana.org.au>
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <44B73FEE.6040908@reub.net> <20060714000551.649ca455.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714000551.649ca455.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 12:05:51AM -0700, Andrew Morton wrote:
>
> > Call Trace:
> >   [<ffffffff8026963e>] show_trace+0xae/0x265
> >   [<ffffffff8026980a>] dump_stack+0x15/0x1b
> >   [<ffffffff8043ba7b>] skb_checksum_help+0x61/0x126
> >   [<ffffffff8802f35f>] :iptable_nat:ip_nat_fn+0x5f/0x1d2

This is tell you that there is a bug in ip_nat_fn in that it completes
the partial checksum even for TSO packets which will cause them to go
out with bogus checksums.

The warning also indicates that the system has detected this and has
worked around it by recomputing the partial checksum after NAT.

The warning is here so someone can fix NAT to not trash the partial
checksum.  It would also tell us if anyone else breaks checksums in
this way.

I've already made the warning appear only once per-boot so I'd really
like to keep it in until

1) NAT is fixed.
2) We're reasonably sure there's nothing else doing this.

Prior to this change your TSO packets would've gone out with corrupted
checksums silently.  Essentially TSO would only slow your machine down
since every transmission it makes has to be retransmitted as non-TSO.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
