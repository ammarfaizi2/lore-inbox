Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbTBCL3G>; Mon, 3 Feb 2003 06:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTBCL3G>; Mon, 3 Feb 2003 06:29:06 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:8811
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266200AbTBCL3B>; Mon, 3 Feb 2003 06:29:01 -0500
Date: Mon, 3 Feb 2003 06:37:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: "David S. Miller" <davem@redhat.com>
Subject: [PATCH][4/6] CPU Hotplug net/
Message-ID: <Pine.LNX.4.44.0302030549191.9361-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
	This isn't a patch for inclusion, but a request for a once over.
Thanks,
	Zwane

 dev.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+)

Index: linux-2.5.59-lch2/net/core/dev.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/net/core/dev.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/net/core/dev.c	17 Jan 2003 11:16:28 -0000	1.1.1.1
+++ linux-2.5.59-lch2/net/core/dev.c	20 Jan 2003 13:48:28 -0000	1.1.1.1.2.1
@@ -2945,3 +2945,67 @@
 	return call_usermodehelper(argv [0], argv, envp);
 }
 #endif
+
+static int dev_cpu_callback(struct notifier_block *nfb, unsigned long action, void * ocpu)
+{
+        struct sk_buff *list_sk, *sk_head;
+        struct net_device *list_net, *net_head;
+        struct softnet_data *queue;
+        struct sk_buff *skb;
+        unsigned int  cpu = smp_processor_id();
+	unsigned long oldcpu = (unsigned long) ocpu;
+	unsigned long flags;
+
+	if (action != CPU_OFFLINE)
+		return 0;
+
+	local_irq_save(flags);
+
+        /* Move completion queue */
+
+        list_sk = softnet_data[oldcpu].completion_queue;
+        if (list_sk != NULL) {
+                sk_head = list_sk;
+                while (list_sk->next != NULL)
+                        list_sk = list_sk->next;
+                list_sk->next = softnet_data[cpu].completion_queue;
+                softnet_data[cpu].completion_queue = sk_head;
+                softnet_data[oldcpu].completion_queue = NULL;
+        }
+
+        /* Move output_queue */
+
+        list_net = softnet_data[oldcpu].output_queue;
+        if (list_net != NULL) {
+                net_head = list_net;
+                while (list_net->next != NULL)
+                        list_net = list_net->next_sched;
+                list_net->next_sched = softnet_data[cpu].output_queue;
+                softnet_data[cpu].output_queue = net_head;
+                softnet_data[oldcpu].output_queue = NULL;
+        }
+
+	local_irq_restore(flags);
+        
+        /* Move input_pkt_queue */
+
+	queue = &softnet_data[oldcpu];
+        for (;;) {
+                skb = __skb_dequeue(&queue->input_pkt_queue);
+                if (skb == NULL)
+                        break;
+                netif_rx(skb);
+        }
+
+        return 0;
+}
+
+static struct notifier_block cpu_callback_nfb = {&dev_cpu_callback, NULL, 0 };
+
+static int __init dev_cpu_callback_init(void)
+{
+        register_cpu_notifier(&cpu_callback_nfb);
+        return 0;
+}
+
+__initcall(dev_cpu_callback_init);


