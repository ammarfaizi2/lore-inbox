Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269604AbUI3Wzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269604AbUI3Wzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269606AbUI3Wzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:55:31 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:47581 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269604AbUI3WzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:55:02 -0400
Date: Fri, 1 Oct 2004 00:56:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Stack traces in 2.6.9-rc2-mm4
Message-ID: <20040930225640.GA6441@elte.hu>
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net> <20040927085744.GA32407@elte.hu> <1096326753l.5222l.2l@werewolf.able.es> <20040928072123.GA15177@elte.hu> <1096581484l.9853l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096581484l.9853l.0l@werewolf.able.es>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* J.A. Magallon <jamagallon@able.es> wrote:

> Sep 30 23:54:41 werewolf pumpd[9843]: intf: broadcast: 255.255.255.255
> Sep 30 23:54:41 werewolf pumpd[9843]: intf: network: 82.198.40.0
> Sep 30 23:54:41 werewolf kernel: using smp_processor_id() in preemptible 
> code: pump/9843
> Sep 30 23:54:41 werewolf kernel:  [smp_processor_id+135/141] 
> smp_processor_id+0x87/0x8d
> Sep 30 23:54:41 werewolf kernel:  [<b011bc8f>] smp_processor_id+0x87/0x8d
> Sep 30 23:54:41 werewolf kernel:  [pg0+1079594592/1337930752] 
> death_by_timeout+0x11/0x65 [ip_conntrack]
> Sep 30 23:54:41 werewolf kernel:  [<f099fe60>] death_by_timeout+0x11/0x65 
> [ip_conntrack]

does the patch below fix these for you?

	Ingo

--- include/linux/netfilter_ipv4/ip_conntrack.h.orig
+++ include/linux/netfilter_ipv4/ip_conntrack.h
@@ -311,7 +311,7 @@ struct ip_conntrack_stat
 	unsigned int expect_delete;
 };
 
-#define CONNTRACK_STAT_INC(count) (__get_cpu_var(ip_conntrack_stat).count++)
+#define CONNTRACK_STAT_INC(count) (per_cpu(ip_conntrack_stat, _smp_processor_id()).count++)
 
 /* eg. PROVIDES_CONNTRACK(ftp); */
 #define PROVIDES_CONNTRACK(name)                        \
