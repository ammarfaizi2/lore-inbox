Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWDYK2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWDYK2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWDYK2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:28:48 -0400
Received: from mailserv.trstone.com ([12.109.59.11]:59807 "EHLO
	mailserv.trstone.com") by vger.kernel.org with ESMTP
	id S932179AbWDYK2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:28:48 -0400
Message-ID: <444DFA05.2060508@rosettastone.com>
Date: Tue, 25 Apr 2006 11:29:25 +0100
From: Brian Uhrain <buhrain@rosettastone.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060302)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>
CC: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.6 ( - 2.6.16.11 ) compile failure on an alpha
References: <20060425101647.GH4349@vega.lnet.lut.fi>
In-Reply-To: <20060425101647.GH4349@vega.lnet.lut.fi>
Content-Type: multipart/mixed;
 boundary="------------060009080907040804010808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060009080907040804010808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Tomi Lapinlampi wrote:
> When trying to compile 2.6.16.11 on an alpha I encountered a compile
> error in arch/alpha/kernel/setup.c. I found that the problem appears with
> all kernels from 2.6.16.6 up to 2.6.16.11.
> 2.6.16.5 compiles fine, just like all older 2.6.16 -releases.
> I did not test this with 2.6.17-rc -kernels.

The problem is that the version of the patch meant for the 2.6.17-rc 
kernels was merged into 2.6.16.5.  'for_each_possible_cpu' does not 
exist in the 2.6.16.x tree.  Attached is a patch that replaces the usage 
of for_each_possible_cpu with the 2.6.16 equivalent.

  - Brian

--------------060009080907040804010808
Content-Type: text/plain;
 name="2.6.16.11-alpha-compile-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.16.11-alpha-compile-fix.patch"

Signed-off-by: Brian Uhrain <buhrain@rosettastone.com>

---
 arch/alpha/kernel/setup.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.16.11.orig/arch/alpha/kernel/setup.c	2006-04-25 11:21:03.000000000 +0100
+++ linux-2.6.16.11/arch/alpha/kernel/setup.c	2006-04-25 11:22:56.557266608 +0100
@@ -483,11 +483,13 @@ register_cpus(void)
 {
 	int i;
 
-	for_each_possible_cpu(i) {
-		struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-		register_cpu(p, i, NULL);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_possible(i)) {
+			struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
+			if (!p)
+				return -ENOMEM;
+			register_cpu(p, i, NULL);
+		}
 	}
 	return 0;
 }

--------------060009080907040804010808--
