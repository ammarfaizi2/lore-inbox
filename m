Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbSJVCZn>; Mon, 21 Oct 2002 22:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSJVCZn>; Mon, 21 Oct 2002 22:25:43 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:14 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261867AbSJVCZm>;
	Mon, 21 Oct 2002 22:25:42 -0400
Message-ID: <3DB4B8A7.5060807@mvista.com>
Date: Mon, 21 Oct 2002 21:32:07 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>On Mon, Oct 21, 2002 at 08:32:47PM -0500, Corey Minyard wrote:
>
>>The attached patch implements a way to request to receive an NMI if it 
>>comes from an otherwise unknown source.  I needed this for handling NMIs 
>>with the IPMI watchdog.  This function was discussed a little a while 
>>    
>>
>Then NMI watchdog and oprofile should be changed to use this too.
>
Maybe so.  If we get the infrastructure into place, we can change that 
afterwards.

> We
>also need priority and/or equivalent of NOTIFY_STOP_MASK so we can break
>out of calling all the handlers. Actually, why do you continue if one
>of the handlers returns 1 anyway ?
>
What if there's an NMI from multiple things?  Not that it's likely, but 
it's possible, right?  I could easily add priority and sort the list by 
it, and add a NOTIFY_STOP_MASK, if there is some benefit.

>>+	atomic_inc(&calling_nmi_handlers);
>>    
>>
>Isn't this going to cause cacheline ping pong ?
>
This is an NMI, does it really matter?  And is there another way to do 
this without locks?

>>+	curr = nmi_handler_list;
>>+	while (curr) {
>>+		handled |= curr->handler(curr->dev_id, regs);
>>    
>>
>dev_name is never used at all. What is it for ? Also, would be nice
>to do an smp_processor_id() just once and pass that in to prevent
>multiple calls to get_current().
>
dev_name could be removed, although it would be nice for reporting 
later.  Basically, for the same reason it's there for interrupts.  And 
again, this is an NMI, I don't think performance really matters (unless 
we perhaps add the NMI watchdog to this).

>Couldn't you modify the notifier code to do the xchg()s (though that's
>not available on all CPU types ...)
>
I don't understand.  The xchg()s are for atomicity between the 
request/release code and the NMI handler.  How could the notifier code 
do it?

>>+#define HAVE_NMI_HANDLER	1
>>    
>>
>What uses this ?
>
This is so the user code can know if it's available or not.

>>+	volatile struct nmi_handler *next;
>>    
>>
>Hmm ...
>
>Is it not possible to use linux/rcupdate.h for this stuff ?
>
I'm not sure.  It looks possible, but remember, this is an NMI, normal 
rules may not apply.  Particularly, you cannot block or spin waiting for 
something else, the NMI code has to run.  An NMI can happen at ANY time. 
 If the rcu code can handle this, I could use it, but I have not looked 
to see if it can.

Thanks,

-Corey

