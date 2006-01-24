Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWAXEuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWAXEuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 23:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWAXEuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 23:50:08 -0500
Received: from ns.suse.de ([195.135.220.2]:40870 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030316AbWAXEuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 23:50:06 -0500
From: Neil Brown <neilb@suse.de>
To: Stefan Rompf <stefan@loplof.de>, Clemens Fruhwirth <clemens@endorphin.org>
Date: Tue, 24 Jan 2006 15:49:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17365.45558.820747.408425@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 2.6] dm-crypt: zero key before freeing it
X-Mailer: VM 7.19 under Emacs 21.4.1
References: <200601042108.04544.stefan@loplof.de>
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>Hi Andrew,
>
>dm-crypt does not clear struct crypt_config before freeing it. Thus, 
>information on the key could leak f.e. to a swsusp image even after the 
>encrypted device has been removed. The attached patch against 2.6.14 / 2.6.15 
>fixes it.
>
>Signed-off-by: Stefan Rompf <stefan@loplof.de>
>Acked-by: Clemens Fruhwirth <clemens@endorphin.org>
>
>--- linux-2.6.14.4/drivers/md/dm-crypt.c.old	2005-12-16 18:27:05.000000000 +0100
>+++ linux-2.6.14.4/drivers/md/dm-crypt.c	2005-12-28 12:49:13.000000000 +0100
>@@ -694,6 +694,7 @@ bad3:
> bad2:
> 	crypto_free_tfm(tfm);
> bad1:
>+	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
> 	kfree(cc);
> 	return -EINVAL;
> }

There is a small problem with this patch.
If the 'goto bad1' branch is taken, then 'cc->key_size' will not be
defined.
I think you need the following patch on top.

(Is that "sizeof(u8)" *really* necessary?? :-)

NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/dm-crypt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/dm-crypt.c~current~ ./drivers/md/dm-crypt.c
--- ./drivers/md/dm-crypt.c~current~	2006-01-24 15:42:52.000000000 +1100
+++ ./drivers/md/dm-crypt.c	2006-01-24 15:43:07.000000000 +1100
@@ -691,7 +691,7 @@ bad2:
 	crypto_free_tfm(tfm);
 bad1:
 	/* Must zero key material before freeing */
-	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
+	memset(cc, 0, sizeof(*cc) + key_size * sizeof(u8));
 	kfree(cc);
 	return -EINVAL;
 }
