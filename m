Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUJINPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUJINPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 09:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUJINPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 09:15:33 -0400
Received: from main.gmane.org ([80.91.229.2]:18135 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266805AbUJINP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 09:15:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Sat, 09 Oct 2004 15:15:13 +0200
Message-ID: <yw1xk6u0hw2m.fsf@mru.ath.cx>
References: <41677E4D.1030403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 197.80-202-92.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:xkmejeLN051YtGZYekuoX7wIosM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got this thing to build by adding a few EXPORT_SYMBOL, patch below.
Now it seems to be running quite well.  I am, however, getting
occasional "bad: scheduling while atomic!" messages, all alike:

bad: scheduling while atomic!
 [<c02ef301>] schedule+0x4e5/0x4ea
 [<c0114cbe>] try_to_wake_up+0x99/0xa8
 [<c01332e2>] __p_mutex_down+0xfe/0x190
 [<c029e238>] alloc_skb+0x32/0xc3
 [<c01335e0>] kmutex_is_locked+0x1f/0x33
 [<c029fa63>] skb_queue_tail+0x1c/0x45
 [<c02eb43e>] unix_stream_sendmsg+0x22c/0x38c
 [<c029ab03>] sock_sendmsg+0xc9/0xe3
 [<c029f95a>] skb_dequeue+0x4a/0x5b
 [<c02eb9e6>] unix_stream_recvmsg+0x119/0x430
 [<c0137f06>] __alloc_pages+0x1cc/0x33f
 [<c01168ca>] autoremove_wake_function+0x0/0x43
 [<c029af4b>] sock_readv_writev+0x6e/0x97
 [<c029afec>] sock_writev+0x37/0x3e
 [<c029afb5>] sock_writev+0x0/0x3e
 [<c014ebb8>] do_readv_writev+0x1db/0x21f
 [<c01168ca>] autoremove_wake_function+0x0/0x43
 [<c014e5ca>] vfs_read+0xd0/0xf5
 [<c014ec94>] vfs_writev+0x49/0x52
 [<c014ed5a>] sys_writev+0x47/0x76
 [<c0103f09>] sysenter_past_esp+0x52/0x71

USB, sound and wireless are all working nicely.

Now the patch:

--- kernel/kmutex.c~	2004-10-09 12:51:37 +02:00
+++ kernel/kmutex.c	2004-10-09 13:50:43 +02:00
@@ -20,6 +20,7 @@
 #include <linux/config.h>
 #include <linux/kmutex.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 
 # if defined CONFIG_PMUTEX
 #   include <linux/pmutex.h>
@@ -40,11 +41,14 @@
         return p_mutex_trylock(&(lock->kmtx));
 }
 
+EXPORT_SYMBOL(kmutex_trylock);
 
 inline int kmutex_is_locked(struct kmutex *lock)
 {
 	return p_mutex_is_locked(&(lock->kmtx));
 }
+
+EXPORT_SYMBOL(kmutex_is_locked);
 # endif
 
 
@@ -60,6 +64,7 @@
 #endif
 } 
 
+EXPORT_SYMBOL(kmutex_init);
 
 /*
  * print warning is case kmutex_lock is called while preempt count is
@@ -88,6 +93,8 @@
 #endif
 } 
 
+EXPORT_SYMBOL(kmutex_lock);
+
 void kmutex_unlock(struct kmutex *lock) 
 { 
 #if defined CONFIG_KMUTEX_DEBUG
@@ -102,6 +109,7 @@
 #endif
 }
 
+EXPORT_SYMBOL(kmutex_unlock);
 
 void kmutex_unlock_wait(struct kmutex * lock)
 { 
@@ -111,4 +119,4 @@
                 }  
 }
 
-
+EXPORT_SYMBOL(kmutex_unlock_wait);


-- 
Måns Rullgård
mru@mru.ath.cx

