Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUELNo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUELNo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUELNo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:44:58 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:45471 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265087AbUELNoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:44:00 -0400
Subject: [2.6.6-BK] x86_64 has buggy ffs() implementation
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, yuri@acronis.com,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>
Content-Type: text/plain
Organization: University of Cambridge Computing Service
Message-Id: <1084369416.16624.53.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 14:43:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi, Andrew, Linus,

x86_64 has incorrect include/asm-x86_64/bitops.h::ffs() implementation. 
It uses "g" instead of "rm" in the insline assembled bsfl instruction. 
(This was spotted by Yuri Per.)

bsfl does not accept constant values but only memory ones.  On i386 the
correct "rm" is used.

This causes NTFS build to fail as gcc optimizes a variable into a
constant and ffs() then fails to assemble.

Please apply below patch.  Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/

--- bklinux-2.6/include/asm-x86_64/bitops.h.old	2004-05-12
14:40:32.524022336 +0100
+++ bklinux-2.6/include/asm-x86_64/bitops.h	2004-05-12
14:41:22.595410328 +0100
@@ -458,7 +458,7 @@ static __inline__ int ffs(int x)
 
 	__asm__("bsfl %1,%0\n\t"
 		"cmovzl %2,%0" 
-		: "=r" (r) : "g" (x), "r" (-1));
+		: "=r" (r) : "rm" (x), "r" (-1));
 	return r+1;
 }
 


