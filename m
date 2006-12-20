Return-Path: <linux-kernel-owner+w=401wt.eu-S1030388AbWLTWY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWLTWY2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWLTWY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:24:28 -0500
Received: from web32911.mail.mud.yahoo.com ([209.191.69.111]:47330 "HELO
	web32911.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030388AbWLTWY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:24:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ftqLjmDNF9AKQgdZOzDGRHxVkCytDJvrEBdX1SMm+D2QWJfjZjuHLuITizASyPKYDMdf+rVMobBrt3x7jXoUuomcqR8/twzRBpJnH/JxDtrLAn23tTmbVPseZj79Phid2OE1SX2f7gqw7/t8vLQ0Yhw3nGAaTY1JqmKpeRLV/wo=;
X-YMail-OSG: yYGvvF8VM1mockazqs0kVTyiEF4oOjDuXK_K8DidQEkw.N.XpoID1VWVoksUKJwlfT0mLQtnI7sDSZYv40h0JXXPXgHrp6l2AnPpOaRJLYpBUPXlzbZh9tsKZeibUP1vn7HN3y6Ni4gYl5M-
Date: Wed, 20 Dec 2006 14:24:26 -0800 (PST)
From: J <jhnlmn@yahoo.com>
Subject: Re: Possible race condition in usb-serial.c
To: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200612202143.55778.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <224234.7202.qm@web32911.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please send in a patch for 2.4. It's very important
> to have a
> very reliable ultraconservative tested kernel
> available.

I will try later. I am new to Linux driver development
and never submitted any patches before.
Also I am not yet 100% sure about the correct way
to solve this issue. I will have to study more.

> I suppose the last time I looked at that code, khubd
> still took BKL. Or I overlooked the race. 

Well, as I already mentioned, BKL/lock_kernel appears
to be completely compiled out of my build, so it is
no help for me.
Also, in my opinion, if usb-serial.c depends on
other modules for synchronization, it should have
a big warning in large font about this, otherwise
bugs are doomed to happen. Or, better yet,
it should have it's own proper synchronization
(as we are trying to come up with now).

 
> Look closer. If you build with preemption, taking
> BKL disables preemption.
> BKL is effective only until you schedule. On UP,
> without preemption
> ordinary kernel code will not reenter. You need no
> lock that doesn't guard
> against interrupts unless you schedule under these
> narrow conditions.

In my old 2.4 build CONFIG_SMP is not defined and,
therefore, lock_kernel is compiled out.
I am not sure about the definition of
CONFIG_LOCK_KERNEL in 2.6.
I tried googling for it, but it brings tons of junk.
 
> Could you test the attached patch against 2.6?

Alas, I only have an old 2.4 right now.
May be I will install 2.6 later (in few weeks).
Currently I am just trying to read 2.6 code with my
eyes.

I studied the patch, which you sent.
I don't see obvious errors, but, in my opinion, it is
not completely perfect.

This attempt to mix ref counting and mutex just does
not look right. For example, in few places you
wrap call to usb_serial_put (which decrements ref
count) with the mutex:

 mutex_lock(&table_lock);
 usb_serial_put(port->serial);
 mutex_unlock(&table_lock);

But in other cases it is called without any mutex.

Also there is a theoretical possibility of a deadlock
because some external functions are called when
the mutex is held
(such as serial->type->shutdown, device_unregister,
usb_put_dev, tty_hangup, etc).

What if these functions will call some TTY routines,
which will somehow synchronize with serial_open?
So, for example, usb_serial_disconnect will wait for 
tty_hangup, which will wait for serial_open,
which waits for usb_serial_disconnect.
Now, I see that in the current 2.6 tty_hangup simply
calls schedule_work, but it may change in the future.
And I don't have time to examine what various shutdown
routines in all the driver do.


So, I don't see a quick solution for this.
I guess, a cleaner way would be to modify the code,
which creates and deletes usb_serial structure.
In particular, currently usb_serial_probe is written
as:
create_serial
...
get_free_serial (which inserts serial to serial_table)
...
initializes serial

As the result a partially initialized serial is
inserted into the table. As the result you had to
lock almost the whole body of usb_serial_probe with
table_lock, which may lead to deadlocks.

It would be cleaner to allocate and fully initialize
usb_serial before inserting it into the table in 
one quick call under mutex (or using atomics).

However, I am not very familiar yet with this code,
so I may be wrong.

John


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
