Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbUKIGWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUKIGWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUKIGTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 01:19:21 -0500
Received: from [62.206.217.67] ([62.206.217.67]:60124 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261385AbUKIFzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:55:42 -0500
Message-ID: <41905BDA.4090804@trash.net>
Date: Tue, 09 Nov 2004 06:55:38 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: atomic counter underflow when running "rmmod tg3" on 2.6.10-rc1-mm3
References: <200411090333.36550.bero@arklinux.org>
In-Reply-To: <200411090333.36550.bero@arklinux.org>
Content-Type: multipart/mixed;
 boundary="------------080901050702010506040507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080901050702010506040507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Already fixed by this patch.

Regards
Patrick

Bernhard Rosenkraenzer wrote:

>BUG: atomic counter underflow at:
> [<c02882f6>] qdisc_destroy+0x66/0x80
> [<c02885e2>] dev_shutdown+0x32/0x90
> [<c02d796f>] __down_failed_trylock+0x7/0xc
> [<c027b6b2>] unregister_netdevice+0x142/0x29e
> [<c014c171>] handle_mm_fault+0xf1/0x510
> [<c0240a95>] unregister_netdev+0x15/0x20
> [<e0d3a2b5>] tg3_remove_one+0x25/0x70 [tg3]
> [<c01db4e9>] pci_device_remove+0x69/0x70
> [<c0232646>] device_release_driver+0x86/0x90
> [<c0232a2b>] bus_remove_driver+0x5b/0x100
> [<e0d3a780>] tg3_cleanup+0x0/0x13 [tg3]
> [<c0232fc0>] driver_unregister+0x10/0x20
> [<c01db234>] pci_unregister_driver+0x14/0xa0
> [<e0d3a78f>] tg3_cleanup+0xf/0x13 [tg3]
> [<c013462b>] sys_delete_module+0x17b/0x1e0
> [<c0104ff1>] sysenter_past_esp+0x52/0x71
>divert: freeing divert_blk for eth0
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


--------------080901050702010506040507
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/05 16:30:34-08:00 tgraf@suug.ch 
#   [PKT_SCHED]: Builtin qdiscs should avoid all qdisc_destroy() processing.
#   
#   None of the code in __qdisc_destroy should be applied to a builtin qdisc
#   or am I missing something?
#   
#   The patch below prevents builtin qdiscs from being destroyed and
#   fixes a refcnt underflow whould lead to a bogus list unlinking
#   and dev_put.
#   
#   Signed-off-by: Thomas Graf <tgraf@suug.ch>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/sched/sch_generic.c
#   2004/11/05 16:30:14-08:00 tgraf@suug.ch +3 -3
#   [PKT_SCHED]: Builtin qdiscs should avoid all qdisc_destroy() processing.
#   
#   None of the code in __qdisc_destroy should be applied to a builtin qdisc
#   or am I missing something?
#   
#   The patch below prevents builtin qdiscs from being destroyed and
#   fixes a refcnt underflow whould lead to a bogus list unlinking
#   and dev_put.
#   
#   Signed-off-by: Thomas Graf <tgraf@suug.ch>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/sched/sch_generic.c b/net/sched/sch_generic.c
--- a/net/sched/sch_generic.c	2004-11-09 06:50:10 +01:00
+++ b/net/sched/sch_generic.c	2004-11-09 06:50:10 +01:00
@@ -479,15 +479,15 @@
 	module_put(ops->owner);
 
 	dev_put(qdisc->dev);
-	if (!(qdisc->flags&TCQ_F_BUILTIN))
-		kfree((char *) qdisc - qdisc->padded);
+	kfree((char *) qdisc - qdisc->padded);
 }
 
 /* Under dev->queue_lock and BH! */
 
 void qdisc_destroy(struct Qdisc *qdisc)
 {
-	if (!atomic_dec_and_test(&qdisc->refcnt))
+	if (qdisc->flags & TCQ_F_BUILTIN ||
+		!atomic_dec_and_test(&qdisc->refcnt))
 		return;
 	list_del(&qdisc->list);
 	call_rcu(&qdisc->q_rcu, __qdisc_destroy);

--------------080901050702010506040507--
