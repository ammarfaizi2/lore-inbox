Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUIWGHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUIWGHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 02:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUIWGHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 02:07:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61322 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265697AbUIWGG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 02:06:57 -0400
Message-ID: <415267E4.4080302@redhat.com>
Date: Wed, 22 Sep 2004 23:06:28 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Simplify last lib/idr.c change
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The last change to alloc_layer in lib/idr.c unnecessarily complicates
the code and depending on the definition of spin_unlock will cause worse
code to be generated than necessary.  The following patch should improve
the situation.


Signed-off-by: Ulrich Drepper <drepper@redhat.com>

- --- lib/idr.c-old	2004-09-22 23:02:15.000000000 -0700
+++ lib/idr.c	2004-09-22 23:03:06.000000000 -0700
@@ -39,13 +39,11 @@ static struct idr_layer *alloc_layer(str
 	struct idr_layer *p;

 	spin_lock(&idp->lock);
- -	if (!(p = idp->id_free)) {
- -		spin_unlock(&idp->lock);
- -		return NULL;
+	if ((p = idp->id_free)) {
+		idp->id_free = p->ary[0];
+		idp->id_free_cnt--;
+		p->ary[0] = NULL;
 	}
- -	idp->id_free = p->ary[0];
- -	idp->id_free_cnt--;
- -	p->ary[0] = NULL;
 	spin_unlock(&idp->lock);
 	return(p);
 }


- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBUmfk2ijCOnn/RHQRAvJ4AKCpd1bkrRkcHaDm+mDyfh1tMpj9EgCgqu2N
voeHnNuVH5cpBCDtafFjZoc=
=XUFL
-----END PGP SIGNATURE-----
