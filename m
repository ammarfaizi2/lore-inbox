Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUBYP7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUBYP7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:59:52 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:26623 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261389AbUBYP7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:59:38 -0500
Message-ID: <403CC667.2000403@acm.org>
Date: Wed, 25 Feb 2004 09:59:35 -0600
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
Let's leave the af_ipmi code out for now.  I'd like to get some opinions 
on it, though.

>
>- Several instances of IPMI_MAX_MSG_LENGTH-sized local arrays.  It's not
>  toooo large, but watch out for the stack space.
>
I will rework these.  These used to be much smaller, but newer hardware 
needed larger sizes.

>
>- You should convert the MODULE_PARMs to module_param() sometime.
>
Will do.

>
>- Be aware that the bitfields in struct seq_table will all fall into the
>  same word and the compiler doesn't access them atomically.  You must
>  provide your own locking to prevent updates to them from scribbling on
>  each other.  Or make them integers.
>
These are only accessed when the sequence number lock is held, so they 
should be ok.

>
>- You misspelt breadcrumbs!
>
Argh!  I'll get that fixed one of these days :)

>
>- This:
>
>	extern struct si_sm_handlers kcs_smi_handlers;
>
>  should be in a header file.
>
ok.

>
>- kcs_event_handler() sets `time = 0;' but never uses it again.
>
Actually, that's not true.  There's an evil goto that goes back to 
"restart:", thus the time needs to be cleared.

>
>- status2txt() should take the caller's char* rather than use a static buffer.
>
Ok, I'll fix that.

>
>- In ipmi_bt_sm.c:
>
>	volatile unsigned char status;
>
>  The volatile is a red flag.   It seems to be unneeded.
>
I'll ask the person who wrote this about it.

>
>- We have #ifdef CONFIG_HIGH_RES_TIMERS code in there?
>
Well, yes.  That's so if people add the high-res timer patch, this 
driver can take advantage of it.  Is that a problem?

>
>- drivers/char/ipmi/ipmi_si.c has lots of
>
>        struct smi_info *smi_info = (struct smi_info *) send_info;
>
>  You don't need to cast a void* and it's actually a harmful thing to do:
>  it suppresses useful warnings if someone goes and changes the type of the
>  rhs.
>
Yes, true.

>
>- ipmi_wait_for_queue() doesn't need set_current_state(TASK_RUNNING);
>  after schedule_timeout() (I removed it)
>
Ok.

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
I'll look at this.

>
>
>Anyway, that's all fairly trivial.  Please retest this code in the next
>-mm, send me any updates against that as appropriate and we'll get this
>merged up, thanks.
>
Ok.

Thank you for your help.

-Corey

