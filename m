Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTJDUJL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 16:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbTJDUJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 16:09:11 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50157 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262721AbTJDUJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 16:09:05 -0400
Date: Sat, 4 Oct 2003 22:08:05 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Matt Mackall <mpm@selenic.com>, Erlend Aasland <erlend-a@ux.his.no>,
       Steven French <sfrench@us.ibm.com>,
       James Morris <jmorris@intercode.com.au>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031004220805.A22185@electric-eye.fr.zoreil.com>
References: <OF9C1504BB.5FB00D5A-ON87256DB3.0015672E-86256DB3.001798AE@us.ibm.com> <20031002113759.GA19824@badne3.ux.his.no> <Pine.LNX.4.58.0310041058000.5954@twinlark.arctic.org> <20031004182417.GC13573@waste.org> <Pine.LNX.4.58.0310041127020.5954@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0310041127020.5954@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Sat, Oct 04, 2003 at 11:51:57AM -0700
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet <dean-list-linux-kernel@arctic.org> :
[...]
> this really sounds like two steps backwards and one step forward.
> 
> this CIFS patch alone replaces 89 lines with 250 lines of code!  the new

It could factor this sequence for example:
       xxx.page = virt_to_page(key);
       xxx.offset = offset_in_page(key);
       xxx.length = foo;
(appears 19 times in the patch)

Btw, the patch add things like this (fs/cifs/connect.c::cifs_mount):

@@ -917,7 +918,18 @@
                        sprintf(pSesInfo->serverName, "%u.%u.%u.%u",
                                NIPQUAD(sin_server.sin_addr.s_addr));
                }
-
+               if (!rc) {
+                       pSesInfo->md5_tfm = crypto_alloc_tfm("md5", 0);
+                       if (unlikely(pSesInfo->md5_tfm == NULL)) {
+                               printk(KERN_WARNING "failed to load transform
for md5\n");
+                               rc = -ENOMEM;
+                       }
+                       pSesInfo->md4_tfm = crypto_alloc_tfm("md4", 0);
+                       if (unlikely(pSesInfo->md4_tfm == NULL)) {
+                               printk(KERN_WARNING "failed to load transform
for md4\n");
+                               rc = -ENOMEM;
+                       }
+               }
                if (!rc){
                        if (volume_info.password)
                                strncpy(pSesInfo->password_with_pad,
@@ -999,6 +1011,14 @@

 /* on error free sesinfo and tcon struct if needed */
        if (rc) {
+               if (pSesInfo->md5_tfm != NULL) {
+                       crypto_free_tfm(pSesInfo->md5_tfm);
+                       pSesInfo->md5_tfm = NULL;
+               }
+               if (pSesInfo->md4_tfm != NULL) {
+                       crypto_free_tfm(pSesInfo->md4_tfm);
+                       pSesInfo->md4_tfm = NULL;
+               }
                           /* If find_unc succeeded then rc == 0 so we can not
end */
                if (tcon)  /* up here accidently freeing someone elses tcon
struct */
                        tconInfoFree(tcon);
@@ -2422,6 +2442,14 @@

The code doesn't remember what failed and must do extra checks. This adds
lines of code rather fast. Not a surprise in a function with a pile of 
"if (rc)" and multiple exit paths.

> code does not look anywhere near as readable as the original.  but perhaps

fs/cifs/connect.c::CIFSNTLMSSPNegotiateSessSetup):
[...]
                                                        ses-> 
                                                            serverDomain[1
                                                                         +
                                                                         (2
                                                                          *
                                                                          len)]
                                                            = 0;

              Imho
CryptoAPI
                      is
not
         the                                   biggest
                 problem
               here

--
Ueimor
