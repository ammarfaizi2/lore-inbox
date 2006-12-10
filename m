Return-Path: <linux-kernel-owner+w=401wt.eu-S933046AbWLJVXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWLJVXy (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762624AbWLJVXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:23:54 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:1224 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762616AbWLJVXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:23:54 -0500
Date: Sun, 10 Dec 2006 22:23:51 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: optimalisation for strlcpy (lib/string.c)
Message-ID: <20061210212350.GC30197@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi,

Like the other patch (by that other person), I think it is faster to not
do a strlen first.
E.g. replace this:
ize_t strlcpy(char *dest, const char *src, size_t size)
{
        size_t ret = strlen(src);

        if (size) {
                size_t len = (ret >= size) ? size - 1 : ret;
                memcpy(dest, src, len);
                dest[len] = '\0';
        }
        return ret;
}
by this:
size_t strlcpy(char *dest, const char *src, size_t size)
{
        char *tmp = dest;

        for(;;)
        {
                *dest = *src;
                if (!*src)
                        break;

                if (--size == 0)
                        break;

                dest++;
                src++;
        }

        *dest = 0x00;

        return dest - tmp;
}
patch:
diff -uNrBbd lib/string.c string-new.c
--- lib/string.c        2006-11-04 02:33:58.000000000 +0100
+++ string-new.c        2006-12-10 22:22:08.000000000 +0100
@@ -121,14 +121,24 @@
  */
 size_t strlcpy(char *dest, const char *src, size_t size)
 {
-       size_t ret = strlen(src);
+        char *tmp = dest;

-       if (size) {
-               size_t len = (ret >= size) ? size - 1 : ret;
-               memcpy(dest, src, len);
-               dest[len] = '\0';
+        for(;;)
+        {
+                *dest = *src;
+                if (!*src)
+                        break;
+
+                if (--size == 0)
+                        break;
+
+                dest++;
+                src++;
        }
-       return ret;
+
+        *dest = 0x00;
+
+        return dest - tmp;
 }
 EXPORT_SYMBOL(strlcpy);
 #endif


I've tested the speed difference with this:
http://www.vanheusden.com/misc/kernel-strlcpy-opt-test.c
and the speed difference is quite a bit on a P4: 28% faster.


Signed-off by: Folkert van Heusden <folkert@vanheusden.com>


Folkert van Heusden

-- 
www.vanheusden.com/multitail - multitail is tail on steroids. multiple
               windows, filtering, coloring, anything you can think of
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
