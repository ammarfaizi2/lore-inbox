Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUBYQSL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUBYQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:17:32 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:29687 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261393AbUBYQPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:15:54 -0500
Message-ID: <403CCA36.3090606@acm.org>
Date: Wed, 25 Feb 2004 10:15:50 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver updates, part 1b
References: <403B57B8.2000008@acm.org>	<403BE39D.2080207@acm.org> <20040224170024.4e75a85c.akpm@osdl.org>
In-Reply-To: <20040224170024.4e75a85c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>It helps to actually attach the code.
>>    
>>
>
>Got there eventually.
>
>Patches seem reasonable, thanks.  I'm not sure how to judge the suitability
>of the socket interface but it only touches your code..
>
Actually, since you already have it in, just leave it in.  It's easy to 
pull out.

>
>- There's a locking bug in ipmi_recvmsg(): it can unlock i_lock when it
>  isn't held.   I added this:
>
>diff -puN net/ipmi/af_ipmi.c~af_ipmi-locking-fix net/ipmi/af_ipmi.c
>--- 25/net/ipmi/af_ipmi.c~af_ipmi-locking-fix	Tue Feb 24 16:56:36 2004
>+++ 25-akpm/net/ipmi/af_ipmi.c	Tue Feb 24 16:57:00 2004
>@@ -336,6 +336,7 @@ static int ipmi_recvmsg(struct kiocb *io
> 		}
> 
> 		timeo = ipmi_wait_for_queue(i, timeo);
>+		spin_lock_irqsave(&i->lock, flags);
> 	}
> 
> 	rcvmsg = list_entry(i->msg_list.next, struct ipmi_recv_msg, link);
>
>
> which may or may not be correct.
>
Actually, I believe the code is correct, and your change will break it.  
This is in a "while (1)" loop, and the only way to get out of this loop 
is to return with the lock not held or to break out of the loop with the 
lock held (and later code will unlock it).  Am I correct here?

-Corey

