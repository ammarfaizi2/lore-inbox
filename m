Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWBVMnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWBVMnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWBVMnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:43:47 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:2054
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751262AbWBVMnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:43:46 -0500
Date: Wed, 22 Feb 2006 23:43:40 +1100
To: Michael Heyse <mhk@designassembly.de>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [SOLVED] Re: which one is broken: VIA padlock aes or aes_i586?
Message-ID: <20060222124340.GA15724@gondor.apana.org.au>
References: <43FB0746.5010200@designassembly.de> <20060222013137.GA844@gondor.apana.org.au> <20060222114531.GA4170@gondor.apana.org.au> <43FC59D4.2090208@designassembly.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <43FC59D4.2090208@designassembly.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2006 at 01:32:20PM +0100, Michael Heyse wrote:
> 
> but it should be
> 
> E_KEY[4] = le32_to_cpu(key[4]);
> E_KEY[5] = le32_to_cpu(key[5]);
> E_KEY[6] = le32_to_cpu(key[6]);
> t = E_KEY[7] = le32_to_cpu(key[7]);
> 
> Now it's working!

Well spotted.  I've cooked up a patch from your description:

[CRYPTO] padlock: Fix typo that broke 256-bit keys

A typo crept into the le32_to_cpu patch which broke 256-bit keys
in the padlock driver.  The following patch based on observations
by Michael Heyse fixes the problem.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks Michael,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="padlock-256.patch"

diff --git a/drivers/crypto/padlock-aes.c b/drivers/crypto/padlock-aes.c
--- a/drivers/crypto/padlock-aes.c
+++ b/drivers/crypto/padlock-aes.c
@@ -348,10 +348,10 @@ aes_set_key(void *ctx_arg, const uint8_t
 		break;
 
 	case 32:
-		E_KEY[4] = le32_to_cpu(in_key[4]);
-		E_KEY[5] = le32_to_cpu(in_key[5]);
-		E_KEY[6] = le32_to_cpu(in_key[6]);
-		t = E_KEY[7] = le32_to_cpu(in_key[7]);
+		E_KEY[4] = le32_to_cpu(key[4]);
+		E_KEY[5] = le32_to_cpu(key[5]);
+		E_KEY[6] = le32_to_cpu(key[6]);
+		t = E_KEY[7] = le32_to_cpu(key[7]);
 		for (i = 0; i < 7; ++i)
 			loop8 (i);
 		break;

--k1lZvvs/B4yU6o8G--
