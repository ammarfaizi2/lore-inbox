Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUBYWuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbUBYVNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:13:16 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:17318 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261556AbUBYVMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:12:17 -0500
Message-ID: <403D0FAE.7090301@acm.org>
Date: Wed, 25 Feb 2004 15:12:14 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver updates, part 1b
References: <403B57B8.2000008@acm.org>	<403BE39D.2080207@acm.org>	<20040224170024.4e75a85c.akpm@osdl.org>	<403CCA36.3090606@acm.org> <20040225120551.32681515.akpm@osdl.org>
In-Reply-To: <20040225120551.32681515.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>>diff -puN net/ipmi/af_ipmi.c~af_ipmi-locking-fix net/ipmi/af_ipmi.c
>>>      
>>>
>> >--- 25/net/ipmi/af_ipmi.c~af_ipmi-locking-fix	Tue Feb 24 16:56:36 2004
>> >+++ 25-akpm/net/ipmi/af_ipmi.c	Tue Feb 24 16:57:00 2004
>> >@@ -336,6 +336,7 @@ static int ipmi_recvmsg(struct kiocb *io
>> > 		}
>> > 
>> > 		timeo = ipmi_wait_for_queue(i, timeo);
>> >+		spin_lock_irqsave(&i->lock, flags);
>> > 	}
>> > 
>> > 	rcvmsg = list_entry(i->msg_list.next, struct ipmi_recv_msg, link);
>> >
>> >
>> > which may or may not be correct.
>> >
>> Actually, I believe the code is correct, and your change will break it.  
>> This is in a "while (1)" loop, and the only way to get out of this loop 
>> is to return with the lock not held or to break out of the loop with the 
>> lock held (and later code will unlock it).  Am I correct here?
>>    
>>
>
>With a little more context:
>
>+		spin_unlock_irqrestore(&i->lock, flags);
>+		if (!timeo) {
>+			return -EAGAIN;
>+		} else if (signal_pending (current)) {
>+			dbg("Signal pending: %d", 1);
>+			return -EINTR;
>+		}
>+
>+		timeo = ipmi_wait_for_queue(i, timeo);
>+	}
>+
>+	rcvmsg = list_entry(i->msg_list.next, struct ipmi_recv_msg, link);
>+	list_del(&rcvmsg->link);
>+	spin_unlock_irqrestore(&i->lock, flags);
>
>See, there's a direct code path from one spin_unlock() to the other.  And
>ipmi_wait_for_queue() does not retake the lock.
>  
>
With even more context:

    while (1) {
        spin_lock_irqsave(&i->lock, flags);
        if (!list_empty(&i->msg_list))
            break;
        spin_unlock_irqrestore(&i->lock, flags);
        if (!timeo) {
            return -EAGAIN;
        } else if (signal_pending (current)) {
            dbg("Signal pending: %d", 1);
            return -EINTR;
        }
               
        timeo = ipmi_wait_for_queue(i, timeo);
    }

    rcvmsg = list_entry(i->msg_list.next, struct ipmi_recv_msg, link);
    list_del(&rcvmsg->link);   
    spin_unlock_irqrestore(&i->lock, flags);

So it will always go back to the top of the while loop and claim the 
lock again.  It's kind of wierd looking, but I still believe it is 
correct.  It's ugly, true, I can work on rewriting this piece.

-Corey

