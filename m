Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTKDAEr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 19:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbTKDAEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 19:04:47 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:64519 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263515AbTKDAEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 19:04:46 -0500
Date: Tue, 4 Nov 2003 00:27:00 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Stian Jordet <liste@jordet.nu>
cc: Andrew Morton <akpm@osdl.org>, Jean Tourrilhes <jt@hpl.hp.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Oops at "NET: Registering protocol family 23" at boot with
 2.6.0t9-bk
In-Reply-To: <1067705386.666.1.camel@chevrolet.hybel>
Message-ID: <Pine.LNX.4.44.0311021020200.29973-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Nov 2003, Stian Jordet wrote:

> NET: Registered protocol family 23
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> EIP is at dev_add_pack+0x4d/0xb0

which is at "next->prev = new" in __list_add_rcu()

> Call Trace:
>  [<c05defad>] irda_init+0x3d/0x60
>  [<c05c094c>] do_initcalls+0x2c/0xa0
>  [<c01359af>] init_workqueues+0xf/0x24
>  [<c01050f6>] init+0x56/0x180
>  [<c01050a0>] init+0x0/0x180
>  [<c01072b9>] kernel_thread_helper+0x5/0xc
 
Looks like irda_init is called before the ptype_base[] list heads are 
initialized. I believe it was triggered by:

>>>>>>>>>>
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Wed Oct 29 15:08:14 2003
+++ b/net/core/dev.c	Wed Oct 29 15:08:14 2003
@@ -3023,7 +3023,7 @@
 	return rc;
 }
 
-subsys_initcall(net_dev_init);
+fs_initcall(net_dev_init);
<<<<<<<<<<
 
from: cset-akpm@osdl.org|ChangeSet|20031029192849|64746.txt

As a workaround you might want to make the irda modular instead of 
build-in. But I'm just wondering why other protocols shouldn't have the 
same problem. Maybe they are not subsys_initcall like af_irda.

Martin

