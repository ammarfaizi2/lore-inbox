Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSAUVZ7>; Mon, 21 Jan 2002 16:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288422AbSAUVZt>; Mon, 21 Jan 2002 16:25:49 -0500
Received: from splat.lanl.gov ([128.165.17.254]:30925 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S288420AbSAUVZe>; Mon, 21 Jan 2002 16:25:34 -0500
Date: Mon, 21 Jan 2002 14:25:33 -0700
From: Eric Weigle <ehw@lanl.gov>
To: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Subject: [BUGLET][PATCH] #includes in asm-i386/checksum.h
Message-ID: <20020121212533.GC6291@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this a while ago, still there in 2.4.17... checksum.h is not
self-consistent. Code which uses the file but does not know to include some
other headers first will get compile errors:

/usr/src/linux-2.4.17include/asm/checksum.h:159: warning: `struct in6_addr' declared inside parameter list
/usr/src/linux-2.4.17include/asm/checksum.h:159: warning: its scope is only this definition or declaration, which is probably not what you want.
/usr/src/linux-2.4.17include/asm/checksum.h: In function `csum_and_copy_to_user':
/usr/src/linux-2.4.17include/asm/checksum.h:188: warning: implicit declaration of function `access_ok'
/usr/src/linux-2.4.17include/asm/checksum.h:188: `VERIFY_WRITE' undeclared (first use in this function)
/usr/src/linux-2.4.17include/asm/checksum.h:188: (Each undeclared identifier is reported only once
/usr/src/linux-2.4.17include/asm/checksum.h:188: for each function it appears in.)

This only happens when one uses checksum.h without previously including the
other given headers, as might be done when people are writing some wack new
networking code (like me :)

Patch follows.

--------------------------------------------------------------------------------
--- checksum.h.original Thu Jul 26 14:41:22 2001
+++ checksum.h  Mon Jan 21 14:17:50 2002
@@ -1,6 +1,11 @@
 #ifndef _I386_CHECKSUM_H
 #define _I386_CHECKSUM_H
 
+/* Required for 'struct in6_addr' */
+#include <net/ipv6.h>
+
+/* Required for 'VERIFY_WRITE' #define */
+#include <asm/uaccess.h>
 
 /*
  * computes the checksum of a memory block at buff, length len,
--------------------------------------------------------------------------------


Thanks,
-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
