Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264151AbUDWLrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbUDWLrB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 07:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264783AbUDWLrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 07:47:01 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:24251 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264151AbUDWLqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 07:46:49 -0400
Message-ID: <40890279.BA40B912@nospam.org>
Date: Fri, 23 Apr 2004 13:48:09 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Dynamic System Calls & System Call Hijacking
References: <4084E85E.4722BFC6@nospam.org> <20040420194016.GF1413@openzaurus.ucw.cz>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Well, by forcing syscall in, you loose your guarantee, too.

Strictly speaking, you are right.

Let me give you an example how we are going to use this dynamic syscall feature:

Assuming a client of ours has a big application running on an "official" kernel.
We load our performance enhancement tool with my dynamic syscall stuff.
If the client observes better performance, then s/he loads this tool at each
re-boot.
Should the kernel crash, s/he does not load it and checks to see if the problem
happens...

Another example is using it as a development tool.
Our performance enhancement tool includes a syscall. It is 100 times quicker to
load it for testing as a module and not be obliged to recompile the kernel, re-
boot it.

> I hope it at least taints the kernel.

As this dynamic syscall feature is intended to be transparent, it does not do.
If someone wants to taint the kernel, it's just one line more of the code.

I checked: RedHat's AS 3.0 does not taint the kernel for 3rd party modules,
(it only does for the sii6512 software raid module).

Note that my patch is against 2.6.4. If you need to play with a 2.4.*, then
at least "kallsyms" should be changed onto "ksyms".

> And you did test on smp kernel, trying to race syscall calling against
> your module load/unload, right?

"dyn_syscall.ko" can be unloaded but it is unsafe.
Here is the window:

- A CPU picks up the address of my syscall link code from "sys_call_table"
  then it is pre-empted for a while
- Another CPU patches back the old address of "sys_ni_syscall" into
  "sys_call_table" and unloads "dyn_syscall.ko"
- The first CPU is back to jump at my link code in "dyn_syscall.ko"

On a client's machine, it is loaded once (e.g. at boot time).
You can try to unload it (as I did) during the development, you do not risk
much, but it is recommended to keep it loaded at the clients.

On the other hand, unloading modules which have correctly unregistered their
system calls is 100% safe.

I did test it on machine with 16 CPUs, but testing cannot prove that there is
no window. I'm going to summarize how the synchronization mechanism works.
There are two cases to consider:
- race among multiple syscall register / unregister operations
- race between unloading a syscall and its clients

Let's start with the first one.
My dynamic syscall feature includes a shadow system call table.
A table entry consists of:

- Name of the system call
- The saved syscall address from "sys_call_table" (atomic variable)
- A semaphore (initialized as if it were taken for write)
- Function descriptor of the new system call
- etc.

The synchronization mechanism is based on the atomic variable in each
entry of the shadow syscall table, that saves the old syscall address from
"sys_call_table":
- 0 means not in use
- 1 means reserved (going to be used)
- original "sys_call_table" entry | 1 means preparing to undo
- Otherwise saves the original "sys_call_table" entry (not an odd value)

For dynamic system call assignment:
- Atomically check & decrement number of the free syscall entries.

Dynamically assigned and hijacked system call entries form two distinct sets.
A dynamically assigned syscall cannot be hijacked. No nested hijacking.
(Therefore hijacking does not care for the number of the free syscall entries.)

For both the dynamically assigned and hijacked system calls:

- Reserve the corresponding shadow syscall table entry by use of a
  compare & swap atomic operation (see above)
- Do the other initialization and save the syscall address from "sys_call_table"
- Patch the address of my linkage code into the corresponding entry in
  "sys_call_table"
- Unlock the semaphore

- Undo operations work in the reverse order

Race between unloading a syscall and its clients:

- When a new system call is added, it is locked for write.
- Regular system call invocation tries to take the semaphore for read.
- Unless the semaphore is unlocked, any attempt to use the system call
  will be refused and "-ENOSYS" will be reported.

- Before undoing a system call registration, it is necessary to lock out
  any further invocation of the system call by re-locking it for write.
  If it fails, then there is at least one "living call" which may be "part way"
  through the system call code.
  "syscall_trylock()" should be invoked repeatedly while it returns "-EAGAIN".

I hope I have not missed anything :-)

Thanks,

Zoltán
