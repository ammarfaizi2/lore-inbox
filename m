Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVDCKUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVDCKUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 06:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVDCKUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 06:20:07 -0400
Received: from [213.170.72.194] ([213.170.72.194]:20951 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261654AbVDCKTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 06:19:42 -0400
Message-ID: <424FC336.7000902@yandex.ru>
Date: Sun, 03 Apr 2005 14:19:34 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au>
In-Reply-To: <20050403100043.GA20768@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Sun, Apr 03, 2005 at 01:45:58PM +0400, Artem B. Bityuckiy wrote: 
> I think the overhead could be higher.
IIUC, not. But I'll check this in practice.

> But even if it is 2 bytes
Ok, suppose.

> per block, then for 1M of incompressible input the total overhead is
> 
> 2 * 1048576 / 65536 = 32
> 
> bytes.
I've given an example why is this OK.

Shortly, because we need to reserve space only for the EOB marker of the 
*last* block (1 byte) and for the adler32 (4 bytes).

Look closer to the algorithm. It consists of 2 parts.

1. We reserve 12 bytes And compress as much as possible to the output 
buffer with Z_SYNC_FLUSH. Zlib produces:

| stream header | Block 1 (<header, 64 K, EOB>) |  -> more
| Block 2 (<header, 64 K, EOB>) | ... etc ... |    -> more
| Block N (<header, 64 K, EOB>) |                  -> more
| Last block (<header, 25K

Here zlib stops on, say 25 KiB because there is no more room for output.

2. We call zlib_deflate() with Z_FINISH and provide additional 12 bytes. 
  After zlib_deflate() has finished, the output stream is:

| stream header | Block 1 (<header, 64 K, EOB>) |  -> more
| Block 2 (<header, 64 K, EOB>) | ... etc ... |    -> more
| Block N (<header, 64 K, EOB>) |                  -> more
| Last block (<header, 25K, EOB>) | adler32 |

And all is OK.

> Actually there is a limit on that too but that's not relevant to
> this discussion.
Agreed :-)

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
