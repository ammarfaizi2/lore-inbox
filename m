Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVJITp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVJITp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbVJITme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:42:34 -0400
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]:23960 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750974AbVJITmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:42:25 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/6] uml: restore include breakage, breaking binary format of COW driver
Date: Sun, 09 Oct 2005 21:37:35 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051009193734.26019.44043.stgit@zion.home.lan>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
References: <200510092118.21032.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Commit 44456d37b59d8e541936ed26d8b6e08d27e88ac1, between 2.6.13-rc3 and -rc4,
was a "nice cleanup" which broke something. Revert the offending part.

It broke because:
a) because this part doesn't fall under the description
b) the author didn't know what he was doing here
c) the author didn't try to compile the existing code and see that it worked
   perfectly.
d) the author didn't ask us what was happening
e) you didn't either, and somebody there should have learned that UML is a bit
   different.

In fact, UML is special in linking to host libc and using its includes.

In particular, since host includes always define both __BIG_ENDIAN and
__LITTLE_ENDIAN, ntohll() macros started thinking to be in a big-endian world;
and on-disk compatibility was broken.

Many thanks go to Nix for reporting the problem and correctly diagnosing an
endianness problem.

Btw, this patch restores the previous code, which worked; but the definitions
would be uncorrect if used in kernelspace files.

Next patch addresses that.

Cc: Nix <nix@esperi.org.uk>, Olaf Hering <olh@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -3,10 +3,10 @@
 
 #include <asm/types.h>
 
-#if defined(__BIG_ENDIAN)
+#if __BYTE_ORDER == __BIG_ENDIAN
 # define ntohll(x) (x)
 # define htonll(x) (x)
-#elif defined(__LITTLE_ENDIAN)
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
 # define ntohll(x)  bswap_64(x)
 # define htonll(x)  bswap_64(x)
 #else

