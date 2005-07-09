Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVGINOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVGINOX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVGINOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:14:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32658 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261362AbVGINOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:14:21 -0400
Date: Sat, 9 Jul 2005 15:13:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709131340.GA5925@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709124105.GB4665@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (gdb) ####################################
> (gdb) # c02decd6, stack size:  460 bytes #
> (gdb) ####################################
> (gdb) 0xc02decd6 is in ip_getsockopt (net/ipv4/ip_sockglue.c:877).

----
this patch reduces the stack footprint of ip_getsockopt() from 460 bytes 
to 188 bytes. (note: needs review & testing because i did not excercise 
this multicast codepath.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/net/ipv4/ip_sockglue.c
===================================================================
--- linux.orig/net/ipv4/ip_sockglue.c
+++ linux/net/ipv4/ip_sockglue.c
@@ -1006,20 +1024,28 @@ int ip_getsockopt(struct sock *sk, int l
 		}
 		case MCAST_MSFILTER:
 		{
-			struct group_filter gsf;
+			struct group_filter *gsf;
 			int err;
 
+			gsf = kmalloc(sizeof(*gsf), GFP_KERNEL);
+			if (!gsf) {
+				release_sock(sk);
+				return -ENOMEM;
+			}
 			if (len < GROUP_FILTER_SIZE(0)) {
 				release_sock(sk);
+				kfree(gsf);
 				return -EINVAL;
 			}
-			if (copy_from_user(&gsf, optval, GROUP_FILTER_SIZE(0))) {
+			if (copy_from_user(gsf, optval, GROUP_FILTER_SIZE(0))) {
 				release_sock(sk);
+				kfree(gsf);
 				return -EFAULT;
 			}
-			err = ip_mc_gsfget(sk, &gsf,
+			err = ip_mc_gsfget(sk, gsf,
 				(struct group_filter __user *)optval, optlen);
 			release_sock(sk);
+			kfree(gsf);
 			return err;
 		}
 		case IP_PKTOPTIONS:		
