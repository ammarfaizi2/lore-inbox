Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423271AbWF1Kml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423271AbWF1Kml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423272AbWF1Kmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:42:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423271AbWF1Kmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:42:40 -0400
Date: Wed, 28 Jun 2006 03:42:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Cc: mbligh@mbligh.org, mbligh@google.com, linux-kernel@vger.kernel.org,
       apw@shadowen.org, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.17-mm2
Message-Id: <20060628034215.c3008299.akpm@osdl.org>
In-Reply-To: <44A150C9.7020809@mbligh.org>
References: <449D5D36.3040102@google.com>
	<449FF3A2.8010907@mbligh.org>
	<44A150C9.7020809@mbligh.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 08:37:45 -0700
"Martin J. Bligh" <mbligh@mbligh.org> wrote:

> SMP NR_CPUS=32 NUMA
> Modules linked in:
> NIP: C0000000000A311C LR: C0000000000A30D4 CTR: C0000000000A3024
> REGS: c0000007725b38d0 TRAP: 0300   Not tainted  (2.6.17-mm3-autokern1)
> MSR: 8000000000001032 <ME,IR,DR>  CR: 28224424  XER: 00000000
> DAR: 000000077BCC6180, DSISR: 0000000040000000
> TASK = c00000002fc74670[29812] 'cp' THREAD: c0000007725b0000 CPU: 2
> GPR00: 0000000000000000 C0000007725B3B50 C00000000063B828 C00000001E303EC0
> GPR04: 0000000000000010 0000000000000000 0000000000000000 FFFFFFFFFFFFFFFD
> GPR08: 0000000000000001 0000000000000000 000000077BCC6180 0000000000000000
> GPR12: 0000000000000000 C00000000051FF80 0000000000000000 0000000000000001
> GPR16: 0000000000000000 0000000000000004 0000000000020000 0000000000000000
> GPR20: 0000000000000000 0000000000000000 C0000007759F9D00 0000000000000000
> GPR24: 0000000000000E42 0000000000000000 000000000000474A C00000001E30F300
> GPR28: 0000000000000000 0000000000000000 C000000000537288 C00000001E303E80
> NIP [C0000000000A311C] .s_show+0xf8/0x364
> LR [C0000000000A30D4] .s_show+0xb0/0x364
> Call Trace:
> [C0000007725B3B50] [C0000000000A3334] .s_show+0x310/0x364 (unreliable)
> [C0000007725B3C20] [C0000000000D5E84] .seq_read+0x2f4/0x450
> [C0000007725B3D00] [C0000000000AADF8] .vfs_read+0xe0/0x1b4
> [C0000007725B3D90] [C0000000000AAFD4] .sys_read+0x54/0x98
> [C0000007725B3E30] [C00000000000871C] syscall_exit+0x0/0x40

This is caused by the vsprintf() changes.  Right now, if you do

	snprintf(buf, 4, "1111111111111");

the memory at `buf' gets [31 31 31 31 00], which is not good.

This'll plug it, but I didn't check very hard whether it still has any
off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's OK..

--- a/lib/vsprintf.c~c
+++ a/lib/vsprintf.c
@@ -259,7 +259,9 @@ int vsnprintf(char *buf, size_t size, co
 	int len;
 	unsigned long long num;
 	int i, base;
-	char *str, *end, c;
+	char *str;		/* Where we're writing to */
+	char *end;		/* The last byte we can write to */
+	char c;
 	const char *s;
 
 	int flags;		/* flags to number() */
@@ -283,12 +285,12 @@ int vsnprintf(char *buf, size_t size, co
 	}
 
 	str = buf;
-	end = buf + size;
+	end = buf + size - 1;
 
 	/* Make sure end is always >= buf */
-	if (end < buf) {
+	if (end < buf - 1) {
 		end = ((void *) ~0ull);
-		size = end - buf;
+		size = end - buf + 1;
 	}
 
 	for (; *fmt ; ++fmt) {
_

