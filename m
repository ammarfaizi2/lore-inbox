Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUDTJIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUDTJIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 05:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUDTJIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 05:08:25 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:32917 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262244AbUDTJGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 05:06:40 -0400
Message-ID: <4084E85E.4722BFC6@nospam.org>
Date: Tue, 20 Apr 2004 11:07:42 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Dynamic System Calls & System Call Hijacking
Content-Type: multipart/mixed;
 boundary="------------5B056287665FBF3E35854637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B056287665FBF3E35854637
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

- Disappointed, 'cause they don't wanna take your brand new syscall into the
  kernel ?

  + No problem, I'll do it for you.

- Can't recompile the kernel, otherwise you gonna lose RedHat guarantee ?
  Or some ISVs like whose name starts with an "O" and terminates with "racle"
  ain't gonna support it ?

  + No problem, I'll load your syscall in a module.

- Got a syscall number conflict 'cause of an exotic patch slipped in before
  your one ?

  + No problem, I'll find a free syscall number for you dynamically.

- Wanna try your own version of a syscall without recompiling the kernel or
  rebooting it ?

  + No problem, I'll hijack the syscall for you.

- Fed up with the infinite number of different kernel configurations ?
  Can't follow any more what .config you've done for which of your clients ?

  + No problem, make a minimal kernel with almost nothing in it and load
    dynamically the syscalls actually needed.

My loadable kernel module "dyn_syscall.ko" provides for
registering / unregistering or hijacking / restoring system calls.

Sure, it's a loadable kernel module, who wants to modify the kernel ? :-)

My patch is against the version 2.6.4. As there is not much in the way of
direct dependency on the kernel, it should work with more recent versions, too.

Playing with the system call mechanism is very much architecture dependent.
Its key element is written in assembly.
I've got an IA64 version only.


How can it be used ?
--------------------

Assuming you've got a system call like "asmlinkage long sys_foo(...)" in a
loadable kernel module.
You can register it with an unused system call number:

        const char name[] = "foo";
        rc = dyn_syscall_reg(name, syscall_no, (dyn_syscall_t) sys_foo);

If "syscall_no" is zero, I'll find a free system call number for you.
(Do check the return code. On success, it's your system call number.)
Or you can register your system call over an existing one:

        rc = hijack_syscall(name, syscall_no, (dyn_syscall_t) sys_foo);

Having fully initialized your system call, you can make it available:

        rc = syscall_unlock(name, syscall_no);

This sequence is usually included in the "module_init(...)" function.

User applications can find out what your system call number is by consulting
"/proc/sys/kernel/dynamic_syscalls/foo" or
"/proc/sys/kernel/hijacked_syscalls/foo", respectively.

Having played enough with your system call, you can launch the module unload
procedure, without worrying about the "living calls" which may be "part way"
through your module:

        rc = prep_restore_syscall(name, syscall_no);

This function locks out further calls to the "syscall_no" (they will be refused
with the return code "-ENOSYS"). It returns "-EAGAIN" if there is still someone
inside your system call.
In this latter case you can wait until your last client leaves:

        while((rc = syscall_trylock(name, syscall)) == -EAGAIN)
                schedule();

If you have a blocking system call, then instead of busy waiting, wake up the
waiting tasks and go to sleep a bit in the mean time.
Finally, you can invoke:

        rc = dyn_syscall_unreg(name, syscall_no);

or

        rc = restore_syscall(name, syscall_no);

to remove completely your registered or hijacked system call, respectively.

This sequence is usually included in the "module_exit(...)" function.

The function prototypes are in "asm/dyn_syscall.h".

In order to configure this module, say "m" in:

        Processor type and features:
                Support for dynamic system calls

The patch & the demos arrive in the next mails.

Your remarks will be appreciated.

Zoltán Menyhárt
--------------5B056287665FBF3E35854637
Content-Type: text/plain; charset=us-ascii;
 name="dyn_syscall_man.txt"
Content-Disposition: inline;
 filename="dyn_syscall_man.txt"
Content-Transfer-Encoding: 7bit



NAME

	dyn_syscall_reg, hijack_syscall - Register a system call

SYNOPSIS

	#include <asm/dyn_syscall.h>

	int
	dyn_syscall_reg(const char *name,
			const unsigned int syscall_no,
			const dyn_syscall_t fp);
	int
	hijack_syscall(const char *name,
			const unsigned int syscall_no,
			const dyn_syscall_t fp);

DESCRIPTION

	"dyn_syscall_reg()" and "hijack_syscall()" are exported services
	available for loadable kernel modules.

	"dyn_syscall_reg()" registers a new, dynamic system call.
	If "syscall_no" is zero, then an otherwise unused system call number
	will be assigned.

	"hijack_syscall()" registers a system call which overloads an
	existing one.

	"name" points to a string that shall persist while the system call is
	alive.

	"syscall_no" should be in the range of
	[__NR_ni_syscall + 1... __NR_ni_syscall + NR_syscalls).

	"fp" refers to the new system call.
	For the IA64 architecture, the function descriptor "dyn_syscall_t"
	refers to a structure containing the program counter and the global
	pointer.

	User applications can find this system call number in
	"/proc/sys/kernel/dynamic_syscalls/<name>" or in
	"/proc/sys/kernel/hijacked_syscalls/<name>", respectively.
	On read, each of these files contains a 4 digit decimal number
	terminated with a '\n' character.

RETURN VALUE

	On success, the system call number accepted / assigned is returned.

	On error, the following codes may be returned:

	-ENOENT:	No more free system call is available -
			"dyn_syscall_reg()" only
	-EINVAL:	Illegal system call number - both
	-EBUSY:		System call is already in use - "dyn_syscall_reg()" only
	-ENOMEM:	Cannot create "/proc/..." - both

SEE ALSO

	syscall_unlock, prep_restore_syscall, syscall_trylock,
	dyn_syscall_unreg, restore_syscall


--------------------------------------------------------------------------------


NAME

	syscall_unlock, syscall_trylock - Unlock / try to lock a system call
	prep_restore_syscall - Prepare to unregister a system call

SYNOPSIS

	#include <asm/dyn_syscall.h>

	int
	syscall_unlock(const char *name,
			const unsigned int syscall_no);
	int
	syscall_trylock(const char *name,
			const unsigned int syscall_no);

	int
	prep_restore_syscall(const char *name,
			const unsigned int syscall_no);

DESCRIPTION

	"syscall_unlock()", "syscall_trylock()" and "prep_restore_syscall()"
	are exported services available for loadable kernel modules.

	Each system call is protected by a semaphore.

	When a new system call is added, it is locked for write.
	Regular system call invocation tries to take the semaphore for read.
	Unless it is "syscall_unlock()"-ed, any attempt to use the system call
         will be refused and "-ENOSYS" will be reported.

	Before undoing a system call registration, it is necessary to lock out
	any further invocation of the system call by re-locking it for write.
	(They will be refused by returning "-ENOSYS".)
	Apart from some small administration task, "prep_restore_syscall()"
	attempts to do it. If it fails (indicated by "-EAGAIN" returned), then
	there is at least one "living call" which may be "part way" through
	the system call code.

	"syscall_trylock()" should be invoked repeatedly while it returns
	"-EAGAIN". In order not to over penalise other tasks, "schedule()"
	should be invoked at each iteration. If the system call is blocking,
         i.e. there can be tasks sleeping inside the system call, then they have
         to be woke up. In such a case, it is recommended to sleep a bit
         between two iterations of "syscall_trylock()".

	"name" should be the same as that was used during the registration.

	"syscall_no" should be in the range of
	[__NR_ni_syscall + 1... __NR_ni_syscall + NR_syscalls).

RETURN VALUE

	On success, zero is returned.

	"syscall_trylock()" and "prep_restore_syscall()" return "-EAGAIN" if
         they have failed to take the semaphore for write.
	
	On error, the following codes can be returned:

	-EBADF:		Name or system call number does not match the parameters
			which was used during the system call registration
	-EINVAL:	Illegal system call number

SEE ALSO

	dyn_syscall_reg, hijack_syscall, dyn_syscall_unreg, restore_syscall


--------------------------------------------------------------------------------


NAME

	dyn_syscall_unreg, restore_syscall - Unregister a system call

SYNOPSIS

	#include <asm/dyn_syscall.h>

	int
	dyn_syscall_unreg(const char *name,
			const unsigned int syscall_no);
	int
	restore_syscall(const char *name,
			const unsigned int syscall_no);

DESCRIPTION

	"dyn_syscall_unreg()" and "restore_syscall()" are exported services
	available for loadable kernel modules.

	"dyn_syscall_unreg()" unregisters a dynamic system call.

	"restore_syscall()" restores a hijacked system call.

	"name" should be the same as that was used during the registration.

	"syscall_no" should be in the range of
	[__NR_ni_syscall + 1... __NR_ni_syscall + NR_syscalls).

RETURN VALUE

	On success, zero is returned.

	On error, the following codes can be returned:

	-EBADF:		Name or system call number does not match the parameters
			which was used during the system call registration
	-EINVAL:	Illegal system call number

SEE ALSO

	dyn_syscall_reg, hijack_syscall,
	syscall_unlock, syscall_trylock,  prep_restore_syscall



--------------5B056287665FBF3E35854637--

