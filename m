Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbSJNUly>; Mon, 14 Oct 2002 16:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbSJNUly>; Mon, 14 Oct 2002 16:41:54 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:54123 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S262334AbSJNUls>;
	Mon, 14 Oct 2002 16:41:48 -0400
Message-ID: <3DAB2D7E.4000503@mvista.com>
Date: Mon, 14 Oct 2002 15:47:58 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver for Linux, version 6
References: <3DAA1899.1030909@mvista.com> <1034587536.3038.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Mon, 2002-10-14 at 03:06, Corey Minyard wrote:
>  
>
>>Yet one more update, mostly fixes for stylistic things that Randy Dunlap 
>>pointed out, and a bug fix that lets the KCS state machine get out of 
>>the "hosed" state on the next message (buggy hardware can sometimes be 
>>useful :-).  As usual, on my home page at  http://home.attbi.com/~minyard.
>>
>>-Corey
>>    
>>
>+static int ipmi_open(struct inode *inode, struct file *file)
>..
>+	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
>..
>+	MOD_INC_USE_COUNT;
>
>hmm. Ok so you either need the MOD_INC_USE_COUNT or you don't, but if
>you do it should go before the sleeping kmalloc ;)
>
Ok, it will be fixed in the next release.

>
>+static int ipmi_ioctl(struct inode  *inode,
>...
>+		if (copy_from_user(&req, (void *) data, sizeof(req))) {
>+			rv = -EFAULT;
>+			break;
>+		}
>+
>+		if (req.addr_len > sizeof(struct ipmi_addr))
>+		{
>+			rv = -EINVAL;
>+			break;
>+		}
>+
>+		if (copy_from_user(&addr, req.addr, req.addr_len)) {
>
>since addr_len is a signed value, a user that passes -1 will get a
>LOOOONG copy_from_user scribbling all over kernel memory...same for
>data_len a few lines onwards
>
Ok, I changed the numbers to unsigned ones, like they should have been.

>
>+static void sender(void                *send_info,
>..
>+	if (kcs_info->run_to_completion) {
>+		/* If we are running to completion, then throw it in
>+		   the list and run transactions until everything is
>+		   clear.  Priority doesn't matter here. */
>+		list_add_tail(&(msg->link), &(kcs_info->xmit_msgs));
>+		result = kcs_event_handler(kcs_info, 0);
>+		while (result != KCS_SM_IDLE) {
>+			udelay(500);
>+			result = kcs_event_handler(kcs_info, 500);
>+		}
>
>is that unconditional udelay with interrupts off really needed? 
>
This only happens in run-to-completion mode, which only happens at panic 
time, so that shouldn't be a big deal.  This is a special mode that 
allows things like watchdog messages and IPMI panic events to go out 
without having working timers.

>
>+/* The locking for these for a write lock is done by two locks, first
>+   the "outside" lock then the normal lock.  This way, the interfaces
>+   lock can be converted to a read lock without allowing a new write
>+   locker to come in.  Note that at interrupt level, this can only be
>+   claimed read, so there is no reason for read lock to save
>+   interrupts.  Write locks must still save interrupts because they
>+   can block an interrupt. */
>
>I get the feeling this locking is fishy. A double r/w lock smells bad.
>really. Either you always take both the same way (eg both for read or
>both for write) and then the inner lock could be a normal spinlock; or
>you will deadlock in new and surprising ways....
>
This is a little wierd, but I wanted to be able to release the write 
lock, but not allow another write locker in until some other things were 
done.  The r/w locks in the kernel do not have a way to convert directly 
from a write lock to a read lock, so I used this to do that.  The 
outside lock is a normal lock and is only claimed immediately before 
grabbing the write lock, and is only released after releasing the write 
lock, so it should not deadlock.

In effect, the outside lock is really the write lock, the normal lock is 
used so that readers can block it.  A way to convert a write lock 
directly to a read lock without releasing the lock would make this 
wierdness go away.

> 
>+	spin_lock_irqsave(&interfaces_outside_lock, flags);
>+	write_lock(&interfaces_lock);
>+	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
>+		if (ipmi_interfaces[i] == NULL) {
>+			new_intf = kmalloc(sizeof(*new_intf), GFP_KERNEL);
>
>ehm ehm didn't just take TWO spinlocks 3 lines above this sleeping
>function ?
>
Oops.  I'll re-work that (and a couple of others I found).

Thanks,

-Corey

