Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbTIKUc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbTIKUc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:32:56 -0400
Received: from palrel10.hp.com ([156.153.255.245]:17081 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261525AbTIKUcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:32:51 -0400
Date: Thu, 11 Sep 2003 13:32:49 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] BlueTooth socket busted in 2.6.0-test5
Message-ID: <20030911203249.GA15575@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030910225810.GA7712@bougret.hpl.hp.com> <1063237174.28890.6.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063237174.28890.6.camel@pegasus>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 01:39:28AM +0200, Marcel Holtmann wrote:
> 
> yesterday David Woodhouse sent a patch which should fix this.
> 
> Regards
> 
> Marcel

	My testing was too light :
------------------------------------------------------
kernel BUG at include/linux/module.h:296!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<d087b72d>]    Not tainted
EFLAGS: 00010246
EIP is at bnep_sock_create+0x69/0xb2 [bnep]
eax: 00000000   ebx: cf46cd00   ecx: 00000020   edx: d087d860
esi: ceac3120   edi: 00000004   ebp: ffffffa3   esp: c4031f2c
ds: 007b   es: 007b   ss: 0068
Process pand (pid: 1945, threadinfo=c4030000 task=ccee20a0)
Stack: 00000010 d08ac544 d08a10f4 ceac3120 00000004 ceac3120 0000007c c033ecc0 
       ffffff9f c01e1236 ceac3120 00000004 0000001f bffff934 c4031fa8 00000001 
       c01e1325 0000001f 00000003 00000004 c4031f84 00000000 c4031fa8 c01e216c 
Call Trace:
 [<d08a10f4>] bt_sock_create+0x8c/0xd0 [bluetooth]
 [<c01e1236>] sock_create+0x12e/0x200
 [<c01e1325>] sys_socket+0x1d/0x50
 [<c01e216c>] sys_socketcall+0xbc/0x260
 [<c010973d>] error_code+0x2d/0x38
 [<c0108cd3>] syscall_call+0x7/0xb

Code: 0f 0b 28 01 7c bf 87 d0 b8 00 e0 ff ff 21 e0 8b 40 10 c1 e0 
 
------------------------------------------------------

	On top of the previous patch, I've now added :
--------------------------------------------
diff -u -p linux/net/bluetooth/bnep/sock.m1.c linux/net/blueto
oth/bnep/sock.c 
--- linux/net/bluetooth/bnep/sock.m1.c  Thu Sep 11 13:12:02 2003
+++ linux/net/bluetooth/bnep/sock.c     Thu Sep 11 13:22:23 2003
@@ -173,6 +173,13 @@ static int bnep_sock_create(struct socke
        if (sock->type != SOCK_RAW)
                return -ESOCKTNOSUPPORT;
 
+       /* sk_set_owner() will use __module_get(), that require
+        * the module to have *some* refcount... I would have though the
+        * code in bt_sock_create() would do that, but it seems to
+        * increase the refcount of bluetooth.o. Jean II */
+       if(!try_module_get(THIS_MODULE))
+               return -EPROTONOSUPPORT;
+
        if (!(sk = bt_sock_alloc(sock, PF_BLUETOOTH, 0, GFP_KERNEL)))
                return -ENOMEM;
 
@@ -184,6 +191,7 @@ static int bnep_sock_create(struct socke
 
        sk->sk_destruct = NULL;
        sk->sk_protocol = protocol;
+       module_put(THIS_MODULE);
        return 0;
 }
 
--------------------------------------------
	This is of course a very gross hack, but with both patches I
now can use BNEP properly. Well, you get the idea...

	Have fun...

	Jean

