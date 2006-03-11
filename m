Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWCKBDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWCKBDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWCKBDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:03:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4613 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932352AbWCKBDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:03:41 -0500
Date: Sat, 11 Mar 2006 02:03:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] crypto/aes.c: array overrun
Message-ID: <20060311010339.GF21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following in crypto/aes.c:

<--  snip  -->

...
struct aes_ctx {
        int key_length;
        u32 E[60];
        u32 D[60];
};

#define E_KEY ctx->E
...
#define loop8(i)                                    \
{   t = ror32(t,  8); ; t = ls_box(t) ^ rco_tab[i];  \
    t ^= E_KEY[8 * i];     E_KEY[8 * i + 8] = t;    \
    t ^= E_KEY[8 * i + 1]; E_KEY[8 * i + 9] = t;    \
    t ^= E_KEY[8 * i + 2]; E_KEY[8 * i + 10] = t;   \
    t ^= E_KEY[8 * i + 3]; E_KEY[8 * i + 11] = t;   \
    t  = E_KEY[8 * i + 4] ^ ls_box(t);    \
    E_KEY[8 * i + 12] = t;                \
    t ^= E_KEY[8 * i + 5]; E_KEY[8 * i + 13] = t;   \
    t ^= E_KEY[8 * i + 6]; E_KEY[8 * i + 14] = t;   \
    t ^= E_KEY[8 * i + 7]; E_KEY[8 * i + 15] = t;   \
}

static int
aes_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
{
...
        case 32:
...
                for (i = 0; i < 7; ++i)
                        loop8 (i);
...

<--  snip  -->


The problem is:

  8 * 6 + 15 = 63  >  59


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

