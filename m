Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTKWWYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTKWWYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:24:35 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:16005 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263490AbTKWWYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:24:34 -0500
Message-ID: <3FC13382.3060701@colorfullife.com>
Date: Sun, 23 Nov 2003 23:24:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Fix locking in input
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:

>Pavel Machek writes:
>
>> input uses "volatile signed char" as a shared variable between normal
>> and interrupt threads (look at _sendbyte()). Thats bad idea, this
>> switches it to atomic_t.
>
>This change looks unnecessary to me - we aren't trying to increment or
>decrement the variable, just set it and read it.  Reading and writing
>individual bytes is atomic on any platform we care about.
>  
>
I think one platform (early ARM?) cannot access bytes directly, and 
implement the access with read 16-bit, change 8-bit, write back 16 bit. 
Reading/writing pointers or longs is atomic.

Pavel: Do you know that atomic_set and atomic_read aren't memory barriers?
I.e.

-	psmouse->ack = 0;
+	atomic_set(&psmouse->ack, 0);
 	psmouse->acking = 1;

It's not guaranteed that all cpus will see psmouse->ack=0 before psmouse->acking=1. And adding the required memory barriers usually makes the code completely unreadable, thus I usually give up and switch to a spinlock.

--
	Manfred




