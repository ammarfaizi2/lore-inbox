Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268715AbTCCS7q>; Mon, 3 Mar 2003 13:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268717AbTCCS7q>; Mon, 3 Mar 2003 13:59:46 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:22409 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S268715AbTCCS7m>; Mon, 3 Mar 2003 13:59:42 -0500
Date: Mon, 3 Mar 2003 13:10:06 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.63-bk6 compile error] __crc_page_states__per_cpu not in
 per-cpu section
In-Reply-To: <1046713129.2671.2.camel@vmhack>
Message-ID: <Pine.LNX.4.44.0303031306390.16397-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2003, Rusty Lynch wrote:

> After updating my bk tree this morning, I am getting the 
> following compile error:
> 
> 4d13d7e9 A __crc_page_states__per_cpu not in per-cpu section
> make: *** [vmlinux] Error 1

It's a false positive from the script which checks whether all per-cpu 
variables ended up in the correct section. __crc_page_states__per_cpu ends 
in __per_cpu, that's why the script thinks it's a per-cpu variable, but
it's not, it's just a checksum.

Could you try if this patch fixes it, I don't really speak awk ;)

You should be able to reproduce the error by just doing "rm vmlinux; make 
vmlinux", but not anymore after applying the patch below.

--Kai


===== scripts/per-cpu-check.awk 1.3 vs edited =====
--- 1.3/scripts/per-cpu-check.awk	Fri Jan 24 14:27:01 2003
+++ edited/scripts/per-cpu-check.awk	Mon Mar  3 13:05:48 2003
@@ -6,7 +6,7 @@
 	IN_PER_CPU=0
 }
 
-/__per_cpu$$/ && ! ( / __ksymtab_/ || / __kstrtab_/ || / __kcrctab_/ ) {
+/__per_cpu$$/ && ! ( / __ksymtab_/ || / __kstrtab_/ || / __kcrctab_/ || / __crc_/ ) {
 	if (!IN_PER_CPU) {
 		print $$3 " not in per-cpu section" > "/dev/stderr";
 		FOUND=1;


