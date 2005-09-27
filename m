Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVI0Una@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVI0Una (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVI0Una
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:43:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54712 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965056AbVI0Un3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:43:29 -0400
Date: Tue, 27 Sep 2005 13:42:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Solar Designer <solar@openwall.com>, Sergey Vlasov <vsu@altlinux.ru>,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org,
       security@linux.kernel.org
Subject: Re: PID reuse safety for userspace apps (Re: [linux-usb-devel] Re:
 [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via
 usbdevio)
In-Reply-To: <1127853252.10674.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509271335530.3308@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> 
 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>  <20050927160029.GA20466@master.mivlgu.local>
  <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>  <20050927165206.GB20466@master.mivlgu.local>
  <20050927172048.GA3423@openwall.com> <1127853252.10674.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Alan Cox wrote:
>
> On Maw, 2005-09-27 at 21:20 +0400, Solar Designer wrote:
> > The idea is to introduce a kernel call (it can be a prctl(2) setting,
> > although my pseudo-code "defines" an entire syscall for simplicity)
> > which would "lock" the invoking process' view of a given PID (while
> > letting the PID get reused - so there's no added risk of DoS).  The
> > original posting and subsequent thread can be seen here:
> 
> You can solve it just as well in kernel space without application
> changes.

Note that for at least signal sending, the security aspect is _not_ about 
whether the pid has been re-used, but about whether the _user_ matches.

This is most trivially seen by thinking about just a suid exec.

Sending a signal to a suid process should be disallowed even _if_ the
"struct task_struct" is still the same, which is why the oops fix
discussed in this thread is totally pointless - it has almost nothing to
do with security. Doing "get_task_struct()" may remove the oops, but it 
doesn't remove the security issues (pid wrapping is a total red herring: 
with get_task_struct you don't need to wrap pids at all, you just do a 
single exec on a suid executable, and off you go).

Now, the fasync interfaces are a bit inconvenient because they require the 
"struct file" to be around, since that's what also contains the owner 
information. That means that you have to track file lifetime in the urb 
submission.

I don't know the code, but if that's inconvenient, then the real solution 
ends up being to just do the permission checks by hand. Remember the 
uid/euid/pid at the time of the submission, and use them at completion.

I don't even think it's worth any general helper infrastructure: I suspect 
the interfaces are pretty broken as designed, and we should _not_ 
encourage them further. But it's not like the security check is more than 
three lines of code, so..

			Linus
