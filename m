Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbULRLsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbULRLsj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 06:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbULRLsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 06:48:39 -0500
Received: from europa.telenet-ops.be ([195.130.132.60]:17040 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262862AbULRLsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 06:48:02 -0500
Subject: Re: do_IRQ: stack overflow: 872..
From: Bart De Schuymer <bdschuym@pandora.be>
To: Andi Kleen <ak@suse.de>
Cc: Crazy AMD K7 <snort2004@mail.ru>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20041218111420.GE338@wotan.suse.de>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
	 <p73zn0ccaee.fsf@verdi.suse.de>
	 <1103368330.3566.15.camel@localhost.localdomain>
	 <20041218111420.GE338@wotan.suse.de>
Content-Type: text/plain
Date: Sat, 18 Dec 2004 12:51:30 +0100
Message-Id: <1103370690.3566.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op za, 18-12-2004 te 12:14 +0100, schreef Andi Kleen:
> > The bridge-nf code does not use recursive function calls and there is no
> > long consecutive function calling. Furthermore, there is no function in
> > the bridge-nf code that uses a large part of the stack.
> 
> Just take a look at the backtrace in the original post. It clearly
> shows a problem. And it points strongly towards br-netfilter.

I don't doubt you are a much better reader of such backtraces than me.
However, let's count the number of times a function from
net/bridge/br_netfilter.c is in the backtrace:
1. br_nf*: 6 times
2. *sabotage*: 3 times
Seriously, out of 222 lines, only 9 from bridge-nf.
The function ip_queue_xmit, OTOH, is 8 times in the trace.

Anyway, as I already suspected weeks ago, AMD must be seeing some
incompatibility between ip_queue (he's using snort) and the bridge-nf
patch.

He is using the patch (I gave it to him) below on top of the bridge-nf
patch. Before using that patch he got a kernel panic occasionally.
However he seems not to get a message in his syslog.

Bart


--- linux-2.4.28-ebt-brnf/net/bridge/br_netfilter.c.old 2004-11-27 23:43:18.000000000 +0100
+++ linux-2.4.28-ebt-brnf/net/bridge/br_netfilter.c     2004-11-27
23:52:05.000000000 +0100
@@ -870,6 +870,10 @@ static unsigned int ip_sabotage_out(unsi
 {
        struct sk_buff *skb = *pskb;
 
+if (!skb) {
+       printk("TROUBLE IN IP_SABOTAGE_OUT: skb==NULL\n");
+       goto in_trouble;
+}
 #ifdef CONFIG_SYSCTL
        if (!skb->nf_bridge) {
                struct vlan_ethhdr *hdr =
@@ -884,6 +888,10 @@ static unsigned int ip_sabotage_out(unsi
        }
 #endif
 
+if (!out) {
+       printk("TROUBLE IN IP_SABOTAGE_OUT: out == NULL\n");
+       goto in_trouble;
+}
        if ((out->hard_start_xmit == br_dev_xmit &&
            okfn != br_nf_forward_finish &&
            okfn != br_nf_local_out_finish &&
@@ -920,6 +928,9 @@ static unsigned int ip_sabotage_out(unsi
        }
 
        return NF_ACCEPT;
+in_trouble:
+       dump_stack();
+       return NF_DROP;
 }
 
 /* For br_nf_local_out we need (prio = NF_BR_PRI_FIRST), to insure that
innocent



