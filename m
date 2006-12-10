Return-Path: <linux-kernel-owner+w=401wt.eu-S935096AbWLJWEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935096AbWLJWEX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 17:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935217AbWLJWEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 17:04:23 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4511 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935096AbWLJWEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 17:04:22 -0500
Date: Sun, 10 Dec 2006 23:03:27 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: optimalisation for strlcpy (lib/string.c)
Message-ID: <20061210220326.GH30197@vanheusden.com>
References: <20061210212350.GC30197@vanheusden.com>
	<457C80F0.2080902@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457C80F0.2080902@eyal.emu.id.au>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Dec 11 21:32:58 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > by this:
> > size_t strlcpy(char *dest, const char *src, size_t size)
> > {
> >         char *tmp = dest;
> > 
> >         for(;;)
> >         {
> >                 *dest = *src;
> >                 if (!*src)
> >                         break;
> > 
> >                 if (--size == 0)
> >                         break;
> > 
> >                 dest++;
> >                 src++;
> >         }
> > 
> >         *dest = 0x00;
> > 
> >         return dest - tmp;
> > }
> > 
> > I've tested the speed difference with this:
> > http://www.vanheusden.com/misc/kernel-strlcpy-opt-test.c
> > and the speed difference is quite a bit on a P4: 28% faster.
> 
> The two do not do exactly the same. The first one handles 'size == 0'
> (should not happen?) safely while the other does not.

Ok, small change:
diff -uNrBbd lib/string.c string-new.c
--- lib/string.c        2006-11-04 02:33:58.000000000 +0100
+++ string-new.c        2006-12-10 23:02:26.000000000 +0100
@@ -121,14 +122,27 @@
  */
 size_t strlcpy(char *dest, const char *src, size_t size)
 {
-       size_t ret = strlen(src);
+        char *tmp = dest;

-       if (size) {
-               size_t len = (ret >= size) ? size - 1 : ret;
-               memcpy(dest, src, len);
-               dest[len] = '\0';
+       if (likeley(size > 0))
+       {
+               for(;;)
+               {
+                       *dest = *src;
+                       if (unlikely(!*src))
+                               break;
+
+                       if (unlikely(--size == 0))
+                               break;
+
+                       dest++;
+                       src++;
        }
-       return ret;
+       }
+
+       *dest = 0x00;
+
+       return dest - tmp;
 }
 EXPORT_SYMBOL(strlcpy);
 #endif


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
