Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWJVRyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWJVRyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWJVRyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:54:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:22510 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751790AbWJVRyJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:54:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Sun, 22 Oct 2006 19:53:58 +0200
User-Agent: KMail/1.9.5
Cc: Avi Kivity <avi@qumranet.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4537818D.4060204@qumranet.com> <453B2DDB.3010303@qumranet.com> <453BACEF.9010106@us.ibm.com>
In-Reply-To: <453BACEF.9010106@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610221953.58979.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 19:39, Anthony Liguori wrote:
> I like the idea of a filesystem.  In particular, if you exposed the CPU
> state as a mmap()'able file, you could read/write from userspace without
> any syscall overhead.

Right. It's a little tricky though regarding what happens when you
write to the register mapping of a running guest, without stopping
it first.

> There are some clever ways that you could get around need that many
> syscalls.  For instance, you could have a "paused" file that you could
> write a "1" into in order to run the guest (assuming that the memory/CPU
> state is setup properly).

what for? writing 1, then 0 to that file is two full syscalls.
Calling kvm_run and returning from it is just one.

You can also just send SIGSTOP/SIGCONT to the task to stop it.

> You could then have an "event" file that you could select() for read
> on.  When "event" became readable, you could read the exit reason, do
> whatever is needed, and then write a "1" into "paused" again.

It's very handy to stay inside of a single process context for both
the hypervisor and the guest, and to simply block in a kvm_run syscall
for the time the guest executes.

This syscall can then simply return the exit reason as its return
value so you don't need another syscall to read it.

> Perhaps an ioctl is better for pausing/unpausing but I do think it's
> necessary to select() on something to wait for the next exit reason to
> occur.

I would not mix ioctls with a new file system. ioctl is fine on
a character device, but with a new file system, you should be able
to express everything as read/write, or one of the new syscalls.

	Arnd <><
