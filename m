Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVDCLTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVDCLTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVDCLTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:19:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62644 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261673AbVDCLTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:19:40 -0400
Subject: Re: [RFC] CryptoAPI & Compression
From: David Woodhouse <dwmw2@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
In-Reply-To: <20050403101752.GA20866@gondor.apana.org.au>
References: <20050401152325.GB4150@gondor.apana.org.au>
	 <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org>
	 <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru>
	 <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru>
	 <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru>
	 <20050403100043.GA20768@gondor.apana.org.au>
	 <1112522762.3899.182.camel@localhost.localdomain>
	 <20050403101752.GA20866@gondor.apana.org.au>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 12:19:17 +0100
Message-Id: <1112527158.3899.213.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 20:17 +1000, Herbert Xu wrote:
> You might be right.  But I'm not sure yet.
> 
> If we use the current code and supply zlib_deflate with 1048576-12
> bytes of (incompressible) input and 1048576 bytes of output buffer,
> wouldn't zlib keep writing incompressible blocks and return when it
> can't do that anymore because the output buffer has been exhausted?
> 
> When it does return it has to finish writing the last block it's on.
> 
> So if the total overhead is 32 bytes then the last block would need
> another 20 bytes of output space which we don't have, no?

Right. We shouldn't feed 1048576-12 bytes into zlib and expect the
output to fit into our 1048576-byte buffer. We could get away with that
kind of thing when we were using Z_SYNC_FLUSH but we can't now.

But now we're not using Z_SYNC_FLUSH it doesn't matter if we feed the
input in smaller chunks. We can calculate a conservative estimate of the
amount we'll fit, and keep feeding it input till the amount of space
left in the output buffer is 12 bytes.
 
-- 
dwmw2

