Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUEUXr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUEUXr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUEUXqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:46:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47802 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264592AbUEUX2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:28:40 -0400
Date: Thu, 20 May 2004 00:21:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: overlaping printk
Message-Id: <20040520002131.0afeceb9.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.33.0405191110380.14297-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0405191110380.14297-100000@sweetums.bluetronic.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam <jfbeam@bluetronic.net> wrote:
>
> Can anyone explain why the kernel does this on a serial console:
> 
>  C<PU0 >C2P:U M 3a:ch Mianech iCnhee cCk heExckc epEtxcieopnt: i0o0n0: 0000000000
>  0000000000000040

<looks>

<after three years, penny finally drops>

We bust the spinlock for *every* printk call.  No wonder.


diff -puN kernel/printk.c~printk-mangling-fix kernel/printk.c
--- 25/kernel/printk.c~printk-mangling-fix	2004-05-20 00:20:06.388725128 -0700
+++ 25-akpm/kernel/printk.c	2004-05-20 00:20:27.228556992 -0700
@@ -492,8 +492,10 @@ asmlinkage int printk(const char *fmt, .
 	char *p;
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
+	static int once;
 
-	if (oops_in_progress) {
+	if (oops_in_progress && !once) {
+		once = 1;
 		/* If a crash is occurring, make sure we can't deadlock */
 		spin_lock_init(&logbuf_lock);
 		/* And make sure that we print immediately */

_

