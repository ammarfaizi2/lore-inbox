Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbTFMPxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265425AbTFMPwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:52:13 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:58865 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S265422AbTFMPvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:51:37 -0400
Message-ID: <3EE9F5C7.8070304@mvista.com>
Date: Fri, 13 Jun 2003 09:03:19 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <3EE8D038.7090600@mvista.com> <200306130027.09288.oliver@neukum.org>
In-Reply-To: <200306130027.09288.oliver@neukum.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oliver Neukum wrote:

>>If it works for you or doesn't or you like the idea or don't, I've love
>>to hear about it
>>    
>>
>
>+	default:
>+		result = -EINVAL;
>+		break;
>+	}
>+	return (result);
>
>Must return ENOTTY.
>
>+static int sdeq_open (struct inode *inode, struct file *file)
>+{
>+	MOD_INC_USE_COUNT;
>+
>+	return 0;
>+}
>+
>+static int sdeq_release (struct inode *inode, struct file *file)
>+{
>+	MOD_DEC_USE_COUNT;
>+
>+	return (0);
>+}
>
>Wrong. release does not map to close()
>
>  
>
hmm not sure where I got that from i'll fix thanks.

>Aside from that, what exactly are you trying to do?
>You are not solving the fundamental device node reuse race,
>yet you are making necessary a further demon.
>  
>
For device enumeration, I see a daemon as necessary.  The main goal of 
this work is to solve the out-of-order execution of sbin/hotplug and 
improve performance of the system during device enumeration with 
significant (200 disks, 4 partitions each) amounts of devices.  Boot 
time with this scheme appears, in my rudimentary tests, to be faster on 
the order of 1-2 seconds for bootup for the case of just 12 disks.  I 
would imagine 200 disks (which I don't have a good way to test, as I 
don't have 200 disks:) would provide better speed gains during bootup.  
This compares greg's original udev to this patched udev binary.

>You are not addressing queue limits. The current hotplug
>scheme does so, admittedly crudely by failing to spawn
>a task, but considering the small numbers of events in
>question here, for the time being we can live with that.
>
>You can just as well add load control and error detection
>to the current scheme. You fail to do so in your scheme.
>You cannot queue events forever in unlimited numbers.
>  
>
I agree there should be some way of limiting events.  I'll add this set 
of code.

>As for ordering, this is a real problem, but not fundamental.
>You can make user space locking work. IMHO it will not be
>pretty if done with shell scripts, but it can work.
>There _is_ a basic problem with the kernel 'overtaking'
>user space in its view of the device tree, but you cannot solve
>that _at_ _all_ in user space.
>
>In short, if you feel that the hotplug scheme is inadequate
>for your needs, then write industry strength devfs2.
>  
>
devfs is not appropriate as it does not allow for complex policy with 
external attributes that the kernel is unaware of.  For an example, lets 
take the situation where a policy must access a cluster-wide manager to 
determine some information before it can make a policy decision.  For 
that to occur, there must be sockets, and hopefully libc, which puts the 
entire thing in user space.  Who would want to write policies in the 
kernel?  uck.

>	Regards
>		Oliver
>
>
>  
>
Thanks
-steve

