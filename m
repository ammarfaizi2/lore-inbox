Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVAEXYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVAEXYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVAEXYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:24:42 -0500
Received: from fmr22.intel.com ([143.183.121.14]:35816 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262656AbVAEXW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:22:56 -0500
Message-ID: <41DC76C0.20408@intel.com>
Date: Wed, 05 Jan 2005 15:22:40 -0800
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mingo@redhat.com
Subject: [PATCH] Remove unnecessary #GP after flush_thread()
Content-Type: multipart/mixed;
 boundary="------------020701050906020601080503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701050906020601080503
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


During execve(), we seem to have a window between flush_thread() and start_thread() where %gs = 0x33, but cpu_gdt_table[cpu][6] == 0. This causes an unnecessary #GP fault on __switch_to() if there is a context switch during the window. But most people are not noticing it because of the fixup in loadsegment().

Specifically, this BUG() was triggered during normal execution.

--- arch/i386/kernel/process.c- 2005-01-05 15:13:51.450321632 -0800
+++ arch/i386/kernel/process.c  2005-01-05 15:13:55.129762272 -0800
@@ -764,6 +764,12 @@
         * Restore %fs and %gs if needed.
         */
        if (unlikely(prev->fs | prev->gs | next->fs | next->gs)) {
+#if 1
+                if ((next->gs == 0x33)
+                        && (cpu_gdt_table[cpu][6].a == 0)
+                        && (cpu_gdt_table[cpu][6].b == 0))
+                        BUG();
+#endif
                loadsegment(fs, next->fs);
                loadsegment(gs, next->gs);


This patch sets %gs = 0 _before_ the thread.tls_array is zeroed.

Signed-off-by: Arun Sharma <arun.sharma@intel.com>


--------------020701050906020601080503
Content-Type: text/plain;
 name="flush_thread_gp.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="flush_thread_gp.patch"

LS0tIGxpbnV4LTIuNi4xMC9hcmNoL2kzODYva2VybmVsL3Byb2Nlc3MuYy0JMjAwNS0wMS0w
NSAxNToxNToyNS40Njk1NDExMzYgLTA4MDAKKysrIGxpbnV4LTIuNi4xMC9hcmNoL2kzODYv
a2VybmVsL3Byb2Nlc3MuYwkyMDA1LTAxLTA1IDE1OjE1OjI2LjkzOTMxNzY5NiAtMDgwMApA
QCAtMzI5LDYgKzMyOSw3IEBACiB7CiAJc3RydWN0IHRhc2tfc3RydWN0ICp0c2sgPSBjdXJy
ZW50OwogCisJX19hc21fXygibW92bCAlMCwlJWdzIjogOiJyIiAoMCkpOwogCW1lbXNldCh0
c2stPnRocmVhZC5kZWJ1Z3JlZywgMCwgc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKjgpOwogCW1l
bXNldCh0c2stPnRocmVhZC50bHNfYXJyYXksIDAsIHNpemVvZih0c2stPnRocmVhZC50bHNf
YXJyYXkpKTsJCiAJLyoK
--------------020701050906020601080503--
