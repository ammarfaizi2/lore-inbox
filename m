Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVBGDHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVBGDHp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVBGDHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:07:45 -0500
Received: from alt.aurema.com ([203.217.18.57]:32698 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261348AbVBGDHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:07:17 -0500
Date: Mon, 7 Feb 2005 14:04:44 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] relayfs crash
Message-ID: <20050207030444.GF27268@aurema.com>
Mail-Followup-To: Tom Zanussi <zanussi@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <41EF4E74.2000304@opersys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <41EF4E74.2000304@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tom,

I've been stress testing a module that uses relayfs on a custom built
2.6 kernel with relayfs patches in it.  This test simply loaded and
unloaded the module while a script loaded the system with forks of
'ls' in the background.  It was conducted on a dual 3.00GHz Xeon box
(I couldn't reproduce the bug on slower machines I had) and produced
oopses of the following type:

wembley login: Oops: 0000 [#1]
SMP
CPU:    2
EIP:    0060:[<f9824790>]    Tainted: GF U
EFLAGS: 00010292   (2.6.5-7.97ZP2-smp)
EIP is at relayfs_remove_file+0x10/0xc0 [relayfs]
eax: 00000000   ebx: 00000292   ecx: f0cf3918   edx: c193810c
esi: 00000000   edi: f0cf391c   ebp: f0cf3000   esp: f7fabf4c
ds: 007b   es: 007b   ss: 0068
Process events/2 (pid: 12, threadinfo=f7faa000 task=cdea2730)
Stack: 00000292 c1938100 f0cf391c c0138cc7 00000000 c180c960 c180c960 c1938120
       f9822cb0 f7faa000 c193810c ffffffff ffffffff 00000001 00000000 c0122b10
       00010000 00000000 00fffff0 00000000 00000000 00000000 cdea2730 c0122b10
Call Trace:
 [<c0138cc7>] worker_thread+0x187/0x230
 [<f9822cb0>] remove_rchan_file+0x0/0xb [relayfs]
 [<c0122b10>] default_wake_function+0x0/0x10
 [<c0122b10>] default_wake_function+0x0/0x10
 [<c0138b40>] worker_thread+0x0/0x230
 [<c013c894>] kthread+0xd4/0x118
 [<c013c7c0>] kthread+0x0/0x118
 [<c0107005>] kernel_thread_helper+0x5/0x10

Code: 8b 58 64 b8 ea ff ff ff 85 db 74 5b 8b 46 0c 0f b7 40 20 25

This oops looks like one mentioned in
http://www.listserv.shafik.org/pipermail/ltt/2004-July/000627.html 

It seems to be the same problem where the rchan work queue is
scheduled to run, but rchan has already been destroyed when the tries
it. This still happens in the latest patch against 2.6.10 at
http://www.opersys.com/ftp/pub/relayfs/patch-relayfs-2.6.10-050113

To solve the problem I applied a patch similar to the one you posted
back in July and it fixed the problem.  Could we consider putting this
patch into relayfs? Its similar to the one posted in July 2004, except
it also moves clear_readers() before INIT_WORK in relay_release (is
that acceptable?).

Thanks,
-- 
		Kingsley

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.5-7.97-relayfs-bug.patch"

--- linux-2.6.5-7.97ZP2/fs/relayfs/relay.c.old	2005-02-02 18:43:24.918844376 +1100
+++ linux-2.6.5-7.97ZP2/fs/relayfs/relay.c	2005-02-02 18:44:33.725384192 +1100
@@ -184,6 +184,7 @@
 	struct rchan *rchan = (struct rchan *)private;
 
 	relayfs_remove_file(rchan->dentry);
+	kfree(rchan);
 }
  
 
@@ -212,12 +213,10 @@
 		goto exit;
 
 	rchan_free_id(rchan->id);
+	clear_readers(rchan);
 
 	INIT_WORK(&rchan->work, remove_rchan_file, rchan);
 	schedule_delayed_work(&rchan->work, 1);
-
-	clear_readers(rchan);
-	kfree(rchan);
 exit:
 	return err;
 }

--cmJC7u66zC7hs+87--
