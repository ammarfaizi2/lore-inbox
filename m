Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWJ3TCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWJ3TCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbWJ3TCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:02:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161398AbWJ3TCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:02:20 -0500
Date: Mon, 30 Oct 2006 11:00:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       Stefan Schmidt <stefan@datenfreihafen.org>, dm-devel@redhat.com,
       dm-crypt@saout.de, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] dmsetup table output changed from 2.6.18 to 2.6.19-rc3
 and breaks yaird.
In-Reply-To: <20061030184331.GY3928@agk.surrey.redhat.com>
Message-ID: <Pine.LNX.4.64.0610301053010.25218@g5.osdl.org>
References: <20061030151930.GQ27337@susi> <20061030184331.GY3928@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2006, Alasdair G Kergon wrote:
>  
> It cannot have been intentional as there was no mention of the change to the
> userspace interface in the git changelog (and the interface version number
> was not changed).
> 
> A new patch is needed to revert the part of the patch that changed the
> userspace interface.
> 
> Please don't forget to copy in the appropriate maintainers when you send
> messages like this one:
>   http://marc.theaimsgroup.com/?l=linux-netdev&m=115547174417490&w=2
> so they can provide acks:-)

Yeah.

Herbert, the breakage _seems_ to be due to the STATUSTYPE_TABLE case 
change:

-		cipher = crypto_tfm_alg_name(cc->tfm);
+		cipher = crypto_blkcipher_name(cc->tfm);

which effectively changes "aes" into "cbc(aes)", which is wrong, since we 
show the chainmode separately.

Please, somebody who knows this area, send me a fix,

		Linus

----
(maybe something like this trivial one? Totally untested, but it would 
seem to be the sane approach)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index a625576..645e3ce 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -925,8 +925,7 @@ static int crypt_status(struct dm_target
 		break;
 
 	case STATUSTYPE_TABLE:
-		cipher = crypto_blkcipher_name(cc->tfm);
-
+		cipher = cc->cipher;
 		chainmode = cc->chainmode;
 
 		if (cc->iv_mode)


