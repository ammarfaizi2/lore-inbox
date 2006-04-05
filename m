Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWDEAGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWDEAGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWDEABm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:42 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:33218
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750974AbWDEAB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:29 -0400
Date: Tue, 4 Apr 2006 17:00:45 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Kirill Korotaev <dev@openvz.org>, Pavel Emelianov <xemul@sw.ru>,
       Dmitry Mishin <dim@openvz.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/26] wrong error path in dup_fd() leading to oopses in RCU
Message-ID: <20060405000045.GP27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fw-wrong-error-path-in-dup_fd-leading-to-oopses.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



From: Kirill Korotaev <dev@openvz.org>

[PATCH] wrong error path in dup_fd() leading to oopses in RCU

Wrong error path in dup_fd() - it should return NULL on error,
not an address of already freed memory :/

Triggered by OpenVZ stress test suite.

What is interesting is that it was causing different oopses in RCU like
below:
Call Trace:
   [<c013492c>] rcu_do_batch+0x2c/0x80
   [<c0134bdd>] rcu_process_callbacks+0x3d/0x70
   [<c0126cf3>] tasklet_action+0x73/0xe0
   [<c01269aa>] __do_softirq+0x10a/0x130
   [<c01058ff>] do_softirq+0x4f/0x60
   =======================
   [<c0113817>] smp_apic_timer_interrupt+0x77/0x110
   [<c0103b54>] apic_timer_interrupt+0x1c/0x24
  Code:  Bad EIP value.
   <0>Kernel panic - not syncing: Fatal exception in interrupt

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Dmitry Mishin <dim@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>
Signed-Off-By: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/fork.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.1.orig/kernel/fork.c
+++ linux-2.6.16.1/kernel/fork.c
@@ -720,7 +720,7 @@ out_release:
 	free_fdset (new_fdt->open_fds, new_fdt->max_fdset);
 	free_fd_array(new_fdt->fd, new_fdt->max_fds);
 	kmem_cache_free(files_cachep, newf);
-	goto out;
+	return NULL;
 }
 
 static int copy_files(unsigned long clone_flags, struct task_struct * tsk)

--
