Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263999AbUDQR4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 13:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264001AbUDQR4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 13:56:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:65183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263999AbUDQR4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 13:56:16 -0400
Date: Sat, 17 Apr 2004 10:55:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kimmo Sundqvist <musher@mbnet.fi>
Cc: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: modprobe 3c509 segfaults
Message-Id: <20040417105557.55ea8520.akpm@osdl.org>
In-Reply-To: <200404171554.29419.musher@mbnet.fi>
References: <200404171554.29419.musher@mbnet.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kimmo Sundqvist <musher@mbnet.fi> wrote:
>
> Apr 17 01:38:02 shadowgate EIP:    0060:[<c58c2789>]    Not tainted
>  Apr 17 01:38:02 shadowgate EFLAGS: 00010202
>  Apr 17 01:38:02 shadowgate EIP is at el3_init_module+0x49/0x8c [3c509]
>  Apr 17 01:38:02 shadowgate eax: 00000000   ebx: c0297d30   ecx: c0297e9c   
>  edx: 00000005
>  Apr 17 01:38:02 shadowgate esi: c3c8e000   edi: c58ec980   ebp: c0297d18   
>  esp: c3c8ffac
>  Apr 17 01:38:02 shadowgate ds: 007b   es: 007b   ss: 0068
>  Apr 17 01:38:02 shadowgate Process modprobe (pid: 2503, threadinfo=c3c8e000 
>  task=c1124080)
>  Apr 17 01:38:02 shadowgate Stack: c012ed98 0806a5c0 00004487 08057100 c3c8e000 
>  c0108d37 0806a5c0 00004487 
>  Apr 17 01:38:02 shadowgate 08057110 00004487 08057100 bffffa08 00000080 
>  0000007b 0000007b 00000080 
>  Apr 17 01:38:02 shadowgate 400e328e 00000073 00000246 bffff9dc 0000007b 
>  Apr 17 01:38:02 shadowgate Call Trace:
>  Apr 17 01:38:02 shadowgate [<c012ed98>] sys_init_module+0xf8/0x220
>  Apr 17 01:38:02 shadowgate [<c0108d37>] syscall_call+0x7/0xb

Seems that we used to unconditionally link the device into the
el3_root_devchain in el3_common_init(), but that was removed, and we now
conditionally link it, denendent upon sone ifdefs which you presumably have
not set.

Does this fix it up?




---

 25-akpm/drivers/net/3c509.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/net/3c509.c~3c509-oops-fix drivers/net/3c509.c
--- 25/drivers/net/3c509.c~3c509-oops-fix	2004-04-17 10:53:37.298867104 -0700
+++ 25-akpm/drivers/net/3c509.c	2004-04-17 10:54:01.864132616 -0700
@@ -595,10 +595,8 @@ no_pnp:
 #endif
 
 	el3_cards++;
-#if !defined(__ISAPNP__) || defined(CONFIG_X86_PC9800)
 	lp->next_dev = el3_root_dev;
 	el3_root_dev = dev;
-#endif
 	return 0;
 
 out1:

_

