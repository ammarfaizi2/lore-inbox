Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVANAQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVANAQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVAMVto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:49:44 -0500
Received: from gw.goop.org ([64.81.55.164]:18324 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261737AbVAMVrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:47:06 -0500
Subject: /proc/self/maps still not right in 2.6.10-mm3
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: pmeda@akamai.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-T6jFW5GpQbR0zLxYn9i6"
Date: Thu, 13 Jan 2005 13:43:12 -0800
Message-Id: <1105652592.1208.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-0.mozer.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T6jFW5GpQbR0zLxYn9i6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Looks like there's another problem.  If you read /proc/self/maps with
>4k chunks, the reads are always truncated to < 4k.  However, at those
points, it misses an entry.  If you read in smaller chunks, the results
look good.

For example (tm.c is attached):
$ ./tm &
$ dd bs=80 < /proc/$!/maps > 1
$ dd bs=100k < /proc/$!/maps > 2
$ diff -u 1 2
@@ -96,7 +96,6 @@
 b7b43000-b7b44000 ---p b7b43000 00:00 0
 b7b44000-b7b45000 r-xp b7b44000 00:00 0
 b7b45000-b7b46000 ---p b7b45000 00:00 0
-b7b46000-b7b47000 r-xp b7b46000 00:00 0
 b7b47000-b7b48000 ---p b7b47000 00:00 0
 b7b48000-b7b49000 r-xp b7b48000 00:00 0
 b7b49000-b7b4a000 ---p b7b49000 00:00 0
@@ -196,7 +195,6 @@
 b7ba7000-b7ba8000 ---p b7ba7000 00:00 0
 b7ba8000-b7ba9000 r-xp b7ba8000 00:00 0
 b7ba9000-b7baa000 ---p b7ba9000 00:00 0
-b7baa000-b7bab000 r-xp b7baa000 00:00 0
 b7bab000-b7bac000 ---p b7bab000 00:00 0
 b7bac000-b7bad000 r-xp b7bac000 00:00 0
 b7bad000-b7bae000 ---p b7bad000 00:00 0
[...]

Strace shows that the mapping at 0xb7b46000 is skipped because it
straddles the read boundary:
[...]
b7b3f000-b7b40000 ---p b7b3f000 00:00 0 \n
b7b40000-b7b41000 r-xp b7b40000 00:00 0 \n
b7b41000-b7b42000 ---p b7b41000 00:00 0 \n
b7b42000-b7b43000 r-xp b7b42000 00:00 0 \n
b7b43000-b7b44000 ---p b7b43000 00:00 0 \n
b7b44000-b7b45000 r-xp b7b44000 00:00 0 \n
b7b45000-b7b46000 ---p b7b45000 00:00 0 \n", 102400) = 4092
         ^^^^^^^^
read(0, "b7b47000-b7b48000 ---p b7b47000 00:00 0 \n
         ^^^^^^^^
b7b48000-b7b49000 r-xp b7b48000 00:00 0 \n
b7b49000-b7b4a000 ---p b7b49000 00:00 0 \n
b7b4a000-b7b4b000 r-xp b7b4a000 00:00 0 \n
[...]

	J

--=-T6jFW5GpQbR0zLxYn9i6
Content-Disposition: attachment; filename=tm.c
Content-Type: text/x-csrc; name=tm.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <sys/mman.h>
#include <unistd.h>
int main()
{
	int i;
	char *m = mmap(0, 1000*4096, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	char *p = m;

	for(i = 0; i < 1000; i+=2) {
		mprotect(p, 4096, PROT_READ);
		p += 8192;
	}

	pause();

	return 0;
}

--=-T6jFW5GpQbR0zLxYn9i6--

