Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUBYUdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUBYUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:33:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:63360 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261395AbUBYUdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:33:01 -0500
Date: Wed, 25 Feb 2004 12:32:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver updates, part 1b
Message-Id: <20040225123211.06a77ec7.akpm@osdl.org>
In-Reply-To: <403CCA36.3090606@acm.org>
References: <403B57B8.2000008@acm.org>
	<403BE39D.2080207@acm.org>
	<20040224170024.4e75a85c.akpm@osdl.org>
	<403CCA36.3090606@acm.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> wrote:
>
> >- There's a locking bug in ipmi_recvmsg(): it can unlock i_lock when it
>  >  isn't held.   I added this:
>  >
>  >diff -puN net/ipmi/af_ipmi.c~af_ipmi-locking-fix net/ipmi/af_ipmi.c
>  >--- 25/net/ipmi/af_ipmi.c~af_ipmi-locking-fix	Tue Feb 24 16:56:36 2004
>  >+++ 25-akpm/net/ipmi/af_ipmi.c	Tue Feb 24 16:57:00 2004
>  >@@ -336,6 +336,7 @@ static int ipmi_recvmsg(struct kiocb *io
>  > 		}
>  > 
>  > 		timeo = ipmi_wait_for_queue(i, timeo);
>  >+		spin_lock_irqsave(&i->lock, flags);
>  > 	}
>  > 
>  > 	rcvmsg = list_entry(i->msg_list.next, struct ipmi_recv_msg, link);
>  >
>  >
>  > which may or may not be correct.
>  >
>  Actually, I believe the code is correct, and your change will break it.  
>  This is in a "while (1)" loop, and the only way to get out of this loop 
>  is to return with the lock not held or to break out of the loop with the 
>  lock held (and later code will unlock it).  Am I correct here?

Ah, you are of course correct.  Consider me thwapped.

