Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUBURqV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUBURqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:46:21 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:25736 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261590AbUBURqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:46:15 -0500
Date: Sat, 21 Feb 2004 12:36:57 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
Message-ID: <20040221173657.GB14873@certainkey.com>
References: <20040220172237.GA9918@certainkey.com> <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com> <20040221164821.GA14723@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221164821.GA14723@certainkey.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 11:48:21AM -0500, Jean-Luc Cooke wrote:
> > Please focus your recommendations on security, not backward compatibility
> > with something that is new to the kernel tree, broken and maintainerless.
 
> I'll start writing OMAC now.

FYI OMAC spec:
  http://crypt.cis.ibaraki.ac.jp/omac/omac.html

As you can see, there is a fixed output no matter how large the input it, the
output is always 128 bits.

So how will this fit into the cipher.c interface?

        case CRYPTO_TFM_MODE_CTR:
                ops->cit_encrypt = omac_compute;
                ops->cit_decrypt = nocrypt;
                ops->cit_encrypt_iv = nocrypt_iv;
                ops->cit_decrypt_iv = nocrypt_iv;
                break;


But now the user will have to call cit_encrypt(tfm, dst[0], src[i], nbytes);
Notice how dest will always have to be dst[0].  Unless we use the hash interface.

Thoughts?

static int omac_encrypt(struct crypto_tfm *tfm,
                       struct scatterlist *dst,
                       struct scatterlist *src,
                       unsigned int nbytes)
{
        return crypt(tfm, dst, src, nbytes,
                     tfm->__crt_alg->cra_cipher.cia_encrypt,
                     omac_process, 1, tfm->crt_cipher.cit_iv);
}

JLC - has CTR mode implemented and will post once he has OMAC done as well.

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
