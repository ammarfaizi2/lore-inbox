Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUHVCOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUHVCOW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUHVCOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:14:22 -0400
Received: from [82.154.232.61] ([82.154.232.61]:16000 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S265293AbUHVCNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:13:50 -0400
Message-ID: <41280163.1050508@vgertech.com>
Date: Sun, 22 Aug 2004 03:13:55 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528 Thunderbird/0.6 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
 to become free. Usage count = 1
References: <411BC284.6080807@vgertech.com> <20040813080334.GA13337@tentacle.sectorb.msk.ru> <411D2625.2070908@vgertech.com>
In-Reply-To: <411D2625.2070908@vgertech.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060601080403090305050202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601080403090305050202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nuno Silva wrote:
> Vladimir B. Savkin wrote:
> | On Thu, Aug 12, 2004 at 08:18:28PM +0100, Nuno Silva wrote:
> |
> |>Hi!
> |>
> |>With 2.6.8-rc4-bk1 I get "Aug 12 17:33:10 puma kernel:
> |>unregister_netdevice: waiting for ppp0 to become free. Usage count = 1"
> |>in the logs after pppd exit.
> |>
> |>Also, the box won't reboot and print that message forever in the
> |>console. sysrq-U && sysrq-R did it :-)
> |>
> |>The last version I tried was 2.6.8-rc2-bk11 and, wrt this prob, is
> |>running fine. So, the problem is in that window and the changelog for
> |>rc4 mentions something about ppp:
> |>http://kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.8-rc4
> |>
> |>If someone requires more information or tests feel free to ask!
> |
> |
> | I saw this too, with 2.6.7-rc3-mm1.
> | I have discovered that it happens because of idle TCP socket
> | holds a reference to a network device.
> | After killing associated process, device was freed immediately.
> |
> 
> I waited for 5 mins before sysrq-U && sysrq-R.
> Anyway, if I 'killall pppd' and then issue 'ifconfig -a' the ifconfig
> command will hang.
> 
> This didn't happen with 2.6.8-rc2-bk11 (the one I'm running now), so
> something changed... I'm I the only one with ppp/pppd/pppoe who tried
> 2.6.8-rc4-bk1? :-) Any success reports?
> 

OK, I just tested again and the problem persists. However this time I 
had some spare moments so I rebooted a few times to isolate the problem.

The problem is in the QoS code. If I start ppp whithout the 
/etc/ppp/ip-up.d/wshaper script everything is fine. If I try the 
wshaper.htb it's also fine. So, I'd say that the problem is in the CBQ 
section. This time I waited for 1 hour and got hundreds of 
"unregister_netdevice: waiting for ppp0 to become free. Usage count = 1" 
in the console/syslog. pppd eats 99% CPU. ifconfig freezes. Even reboot 
isn't possible without sysrq's help.

This problem was introduced between 2.6.8-rc2-bk11 and 2.6.8-rc4-bk1 and 
always happens. Right now I'm testing with 2.6.8.1 with a patch from Mr. 
Miller -- "cacheline-align qdisc data in qdisc_create()" (attached).

If someone needs more details feel free to ask!

Regards,
Nuno Silva


--------------060601080403090305050202
Content-Type: text/x-patch;
 name="qdisc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qdisc.diff"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 19:33:16-07:00 kaber@trash.net 
#   [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# net/sched/sch_api.c
#   2004/08/15 19:32:59-07:00 kaber@trash.net +13 -8
#   [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
diff -Nru a/net/sched/sch_api.c b/net/sched/sch_api.c
--- a/net/sched/sch_api.c	2004-08-19 07:33:10 -07:00
+++ b/net/sched/sch_api.c	2004-08-19 07:33:10 -07:00
@@ -389,7 +389,8 @@
 {
 	int err;
 	struct rtattr *kind = tca[TCA_KIND-1];
-	struct Qdisc *sch = NULL;
+	void *p = NULL;
+	struct Qdisc *sch;
 	struct Qdisc_ops *ops;
 	int size;
 
@@ -407,12 +408,18 @@
 	if (ops == NULL)
 		goto err_out;
 
-	size = sizeof(*sch) + ops->priv_size;
+	/* ensure that the Qdisc and the private data are 32-byte aligned */
+	size = ((sizeof(*sch) + QDISC_ALIGN_CONST) & ~QDISC_ALIGN_CONST);
+	size += ops->priv_size + QDISC_ALIGN_CONST;
 
-	sch = kmalloc(size, GFP_KERNEL);
+	p = kmalloc(size, GFP_KERNEL);
 	err = -ENOBUFS;
-	if (!sch)
+	if (!p)
 		goto err_out;
+	memset(p, 0, size);
+	sch = (struct Qdisc *)(((unsigned long)p + QDISC_ALIGN_CONST)
+	                       & ~QDISC_ALIGN_CONST);
+	sch->padded = (char *)sch - (char *)p;
 
 	/* Grrr... Resolve race condition with module unload */
 
@@ -420,8 +427,6 @@
 	if (ops != qdisc_lookup_ops(kind))
 		goto err_out;
 
-	memset(sch, 0, size);
-
 	INIT_LIST_HEAD(&sch->list);
 	skb_queue_head_init(&sch->q);
 
@@ -470,8 +475,8 @@
 
 err_out:
 	*errp = err;
-	if (sch)
-		kfree(sch);
+	if (p)
+		kfree(p);
 	return NULL;
 }
 

--------------060601080403090305050202--
