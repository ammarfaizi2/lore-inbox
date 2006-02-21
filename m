Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161440AbWBUItE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161440AbWBUItE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161444AbWBUIsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:48:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:2735 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161440AbWBUIsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:48:36 -0500
Date: Tue, 21 Feb 2006 09:46:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Paul Jackson <pj@sgi.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 3/6] lightweight robust futexes: docs
Message-ID: <20060221084648.GD5506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add robust-futex documentation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 Documentation/robust-futex-ABI.txt |  184 +++++++++++++++++++++++++++++++
 Documentation/robust-futexes.txt   |  218 +++++++++++++++++++++++++++++++++++++
 2 files changed, 402 insertions(+)

Index: linux/Documentation/robust-futex-ABI.txt
===================================================================
--- /dev/null
+++ linux/Documentation/robust-futex-ABI.txt
@@ -0,0 +1,184 @@
+Started by Paul Jackson <pj@sgi.com>
+
+The robust futex ABI
+--------------------
+
+Robust_futexes provide a mechanism that is used in addition to normal
+futexes, for kernel assist of cleanup of held locks on task exit.
+
+The interesting data as to what futexes a thread is holding is kept on a
+linked list in user space, where it can be updated efficiently as locks
+are taken and dropped, without kernel intervention.  The only additional
+kernel intervention required for robust_futexes above and beyond what is
+required for futexes is:
+
+ 1) a one time call, per thread, to tell the kernel where its list of
+    held robust_futexes begins, and
+ 2) internal kernel code at exit, to handle any listed locks held
+    by the exiting thread.
+
+The existing normal futexes already provide a "Fast Userspace Locking"
+mechanism, which handles uncontested locking without needing a system
+call, and handles contested locking by maintaining a list of waiting
+threads in the kernel.  Options on the sys_futex(2) system call support
+waiting on a particular futex, and waking up the next waiter on a
+particular futex.
+
+For robust_futexes to work, the user code (typically in a library such
+as glibc linked with the application) has to manage and place the
+necessary list elements exactly as the kernel expects them.  If it fails
+to do so, then improperly listed locks will not be cleaned up on exit,
+probably causing deadlock or other such failure of the other threads
+waiting on the same locks.
+
+A thread that anticipates possibly using robust_futexes should first
+issue the system call:
+
+    asmlinkage long
+    sys_set_robust_list(struct robust_list_head __user *head, size_t len);
+
+The pointer 'head' points to a structure in the threads address space
+consisting of three words.  Each word is 32 bits on 32 bit arch's, or 64
+bits on 64 bit arch's, and local byte order.  Each thread should have
+its own thread private 'head'.
+
+If a thread is running in 32 bit compatibility mode on a 64 native arch
+kernel, then it can actually have two such structures - one using 32 bit
+words for 32 bit compatibility mode, and one using 64 bit words for 64
+bit native mode.  The kernel, if it is a 64 bit kernel supporting 32 bit
+compatibility mode, will attempt to process both lists on each task
+exit, if the corresponding sys_set_robust_list() call has been made to
+setup that list.
+
+  The first word in the memory structure at 'head' contains a
+  pointer to a single linked list of 'lock entries', one per lock,
+  as described below.  If the list is empty, the pointer will point
+  to itself, 'head'.  The last 'lock entry' points back to the 'head'.
+
+  The second word, called 'offset', specifies the offset from the
+  address of the associated 'lock entry', plus or minus, of what will
+  be called the 'lock word', from that 'lock entry'.  The 'lock word'
+  is always a 32 bit word, unlike the other words above.  The 'lock
+  word' holds 3 flag bits in the upper 3 bits, and the thread id (TID)
+  of the thread holding the lock in the bottom 29 bits.  See further
+  below for a description of the flag bits.
+
+  The third word, called 'list_op_pending', contains transient copy of
+  the address of the 'lock entry', during list insertion and removal,
+  and is needed to correctly resolve races should a thread exit while
+  in the middle of a locking or unlocking operation.
+
+Each 'lock entry' on the single linked list starting at 'head' consists
+of just a single word, pointing to the next 'lock entry', or back to
+'head' if there are no more entries.  In addition, nearby to each 'lock
+entry', at an offset from the 'lock entry' specified by the 'offset'
+word, is one 'lock word'.
+
+The 'lock word' is always 32 bits, and is intended to be the same 32 bit
+lock variable used by the futex mechanism, in conjunction with
+robust_futexes.  The kernel will only be able to wakeup the next thread
+waiting for a lock on a threads exit if that next thread used the futex
+mechanism to register the address of that 'lock word' with the kernel.
+
+For each futex lock currently held by a thread, if it wants this
+robust_futex support for exit cleanup of that lock, it should have one
+'lock entry' on this list, with its associated 'lock word' at the
+specified 'offset'.  Should a thread die while holding any such locks,
+the kernel will walk this list, mark any such locks with a bit
+indicating their holder died, and wakeup the next thread waiting for
+that lock using the futex mechanism.
+
+When a thread has invoked the above system call to indicate it
+anticipates using robust_futexes, the kernel stores the passed in 'head'
+pointer for that task.  The task may retrieve that value later on by
+using the system call:
+
+    asmlinkage long
+    sys_get_robust_list(int pid, struct robust_list_head __user **head_ptr,
+                        size_t __user *len_ptr);
+
+It is anticipated that threads will use robust_futexes embedded in
+larger, user level locking structures, one per lock.  The kernel
+robust_futex mechanism doesn't care what else is in that structure, so
+long as the 'offset' to the 'lock word' is the same for all
+robust_futexes used by that thread.  The thread should link those locks
+it currently holds using the 'lock entry' pointers.  It may also have
+other links between the locks, such as the reverse side of a double
+linked list, but that doesn't matter to the kernel.
+
+By keeping its locks linked this way, on a list starting with a 'head'
+pointer known to the kernel, the kernel can provide to a thread the
+essential service available for robust_futexes, which is to help clean
+up locks held at the time of (a perhaps unexpectedly) exit.
+
+Actual locking and unlocking, during normal operations, is handled
+entirely by user level code in the contending threads, and by the
+existing futex mechanism to wait for, and wakeup, locks.  The kernels
+only essential involvement in robust_futexes is to remember where the
+list 'head' is, and to walk the list on thread exit, handling locks
+still held by the departing thread, as described below.
+
+There may exist thousands of futex lock structures in a threads shared
+memory, on various data structures, at a given point in time. Only those
+lock structures for locks currently held by that thread should be on
+that thread's robust_futex linked lock list a given time.
+
+A given futex lock structure in a user shared memory region may be held
+at different times by any of the threads with access to that region. The
+thread currently holding such a lock, if any, is marked with the threads
+TID in the lower 29 bits of the 'lock word'.
+
+When adding or removing a lock from its list of held locks, in order for
+the kernel to correctly handle lock cleanup regardless of when the task
+exits (perhaps it gets an unexpected signal 9 in the middle of
+manipulating this list), the user code must observe the following
+protocol on 'lock entry' insertion and removal:
+
+On insertion:
+ 1) set the 'list_op_pending' word to the address of the 'lock word'
+    to be inserted,
+ 2) acquire the futex lock,
+ 3) add the lock entry, with its thread id (TID) in the bottom 29 bits
+    of the 'lock word', to the linked list starting at 'head', and
+ 4) clear the 'list_op_pending' word.
+
+	XXX I am particularly unsure of the following -pj XXX
+
+On removal:
+ 1) set the 'list_op_pending' word to the address of the 'lock word'
+    to be removed,
+ 2) remove the lock entry for this lock from the 'head' list,
+ 2) release the futex lock, and
+ 2) clear the 'lock_op_pending' word.
+
+On exit, the kernel will consider the address stored in
+'list_op_pending' and the address of each 'lock word' found by walking
+the list starting at 'head'.  For each such address, if the bottom 29
+bits of the 'lock word' at offset 'offset' from that address equals the
+exiting threads TID, then the kernel will do two things:
+
+ 1) if bit 31 (0x80000000) is set in that word, then attempt a futex
+    wakeup on that address, which will waken the next thread that has
+    used to the futex mechanism to wait on that address, and
+ 2) atomically set  bit 30 (0x40000000) in the 'lock word'.
+
+In the above, bit 31 was set by futex waiters on that lock to indicate
+they were waiting, and bit 30 is set by the kernel to indicate that the
+lock owner died holding the lock.
+
+The kernel exit code will silently stop scanning the list further if at
+any point:
+
+ 1) the 'head' pointer or an subsequent linked list pointer
+    is not a valid address of a user space word
+ 2) the calculated location of the 'lock word' (address plus
+    'offset') is not the valud address of a 32 bit user space
+    word
+ 3) if the list contains more than 1 million (subject to
+    future kernel configuration changes) elements.
+
+When the kernel sees a list entry whose 'lock word' doesn't have the
+current threads TID in the lower 29 bits, it does nothing with that
+entry, and goes on to the next entry.
+
+Bit 29 (0x20000000) of the 'lock word' is reserved for future use.
Index: linux/Documentation/robust-futexes.txt
===================================================================
--- /dev/null
+++ linux/Documentation/robust-futexes.txt
@@ -0,0 +1,218 @@
+Started by: Ingo Molnar <mingo@redhat.com>
+
+Background
+----------
+
+what are robust futexes? To answer that, we first need to understand
+what futexes are: normal futexes are special types of locks that in the
+noncontended case can be acquired/released from userspace without having
+to enter the kernel.
+
+A futex is in essence a user-space address, e.g. a 32-bit lock variable
+field. If userspace notices contention (the lock is already owned and
+someone else wants to grab it too) then the lock is marked with a value
+that says "there's a waiter pending", and the sys_futex(FUTEX_WAIT)
+syscall is used to wait for the other guy to release it. The kernel
+creates a 'futex queue' internally, so that it can later on match up the
+waiter with the waker - without them having to know about each other.
+When the owner thread releases the futex, it notices (via the variable
+value) that there were waiter(s) pending, and does the
+sys_futex(FUTEX_WAKE) syscall to wake them up.  Once all waiters have
+taken and released the lock, the futex is again back to 'uncontended'
+state, and there's no in-kernel state associated with it. The kernel
+completely forgets that there ever was a futex at that address. This
+method makes futexes very lightweight and scalable.
+
+"Robustness" is about dealing with crashes while holding a lock: if a
+process exits prematurely while holding a pthread_mutex_t lock that is
+also shared with some other process (e.g. yum segfaults while holding a
+pthread_mutex_t, or yum is kill -9-ed), then waiters for that lock need
+to be notified that the last owner of the lock exited in some irregular
+way.
+
+To solve such types of problems, "robust mutex" userspace APIs were
+created: pthread_mutex_lock() returns an error value if the owner exits
+prematurely - and the new owner can decide whether the data protected by
+the lock can be recovered safely.
+
+There is a big conceptual problem with futex based mutexes though: it is
+the kernel that destroys the owner task (e.g. due to a SEGFAULT), but
+the kernel cannot help with the cleanup: if there is no 'futex queue'
+(and in most cases there is none, futexes being fast lightweight locks)
+then the kernel has no information to clean up after the held lock!
+Userspace has no chance to clean up after the lock either - userspace is
+the one that crashes, so it has no opportunity to clean up. Catch-22.
+
+In practice, when e.g. yum is kill -9-ed (or segfaults), a system reboot
+is needed to release that futex based lock. This is one of the leading
+bugreports against yum.
+
+To solve this problem, the traditional approach was to extend the vma
+(virtual memory area descriptor) concept to have a notion of 'pending
+robust futexes attached to this area'. This approach requires 3 new
+syscall variants to sys_futex(): FUTEX_REGISTER, FUTEX_DEREGISTER and
+FUTEX_RECOVER. At do_exit() time, all vmas are searched to see whether
+they have a robust_head set. This approach has two fundamental problems
+left:
+
+ - it has quite complex locking and race scenarios. The vma-based
+   approach had been pending for years, but they are still not completely
+   reliable.
+
+ - they have to scan _every_ vma at sys_exit() time, per thread!
+
+The second disadvantage is a real killer: pthread_exit() takes around 1
+microsecond on Linux, but with thousands (or tens of thousands) of vmas
+every pthread_exit() takes a millisecond or more, also totally
+destroying the CPU's L1 and L2 caches!
+
+This is very much noticeable even for normal process sys_exit_group()
+calls: the kernel has to do the vma scanning unconditionally! (this is
+because the kernel has no knowledge about how many robust futexes there
+are to be cleaned up, because a robust futex might have been registered
+in another task, and the futex variable might have been simply mmap()-ed
+into this process's address space).
+
+This huge overhead forced the creation of CONFIG_FUTEX_ROBUST so that
+normal kernels can turn it off, but worse than that: the overhead makes
+robust futexes impractical for any type of generic Linux distribution.
+
+So something had to be done.
+
+New approach to robust futexes
+------------------------------
+
+At the heart of this new approach there is a per-thread private list of
+robust locks that userspace is holding (maintained by glibc) - which
+userspace list is registered with the kernel via a new syscall [this
+registration happens at most once per thread lifetime]. At do_exit()
+time, the kernel checks this user-space list: are there any robust futex
+locks to be cleaned up?
+
+In the common case, at do_exit() time, there is no list registered, so
+the cost of robust futexes is just a simple current->robust_list != NULL
+comparison. If the thread has registered a list, then normally the list
+is empty. If the thread/process crashed or terminated in some incorrect
+way then the list might be non-empty: in this case the kernel carefully
+walks the list [not trusting it], and marks all locks that are owned by
+this thread with the FUTEX_OWNER_DEAD bit, and wakes up one waiter (if
+any).
+
+The list is guaranteed to be private and per-thread at do_exit() time,
+so it can be accessed by the kernel in a lockless way.
+
+There is one race possible though: since adding to and removing from the
+list is done after the futex is acquired by glibc, there is a few
+instructions window for the thread (or process) to die there, leaving
+the futex hung. To protect against this possibility, userspace (glibc)
+also maintains a simple per-thread 'list_op_pending' field, to allow the
+kernel to clean up if the thread dies after acquiring the lock, but just
+before it could have added itself to the list. Glibc sets this
+list_op_pending field before it tries to acquire the futex, and clears
+it after the list-add (or list-remove) has finished.
+
+That's all that is needed - all the rest of robust-futex cleanup is done
+in userspace [just like with the previous patches].
+
+Ulrich Drepper has implemented the necessary glibc support for this new
+mechanism, which fully enables robust mutexes.
+
+Key differences of this userspace-list based approach, compared to the
+vma based method:
+
+ - it's much, much faster: at thread exit time, there's no need to loop
+   over every vma (!), which the VM-based method has to do. Only a very
+   simple 'is the list empty' op is done.
+
+ - no VM changes are needed - 'struct address_space' is left alone.
+
+ - no registration of individual locks is needed: robust mutexes dont
+   need any extra per-lock syscalls. Robust mutexes thus become a very
+   lightweight primitive - so they dont force the application designer
+   to do a hard choice between performance and robustness - robust
+   mutexes are just as fast.
+
+ - no per-lock kernel allocation happens.
+
+ - no resource limits are needed.
+
+ - no kernel-space recovery call (FUTEX_RECOVER) is needed.
+
+ - the implementation and the locking is "obvious", and there are no
+   interactions with the VM.
+
+Performance
+-----------
+
+I have benchmarked the time needed for the kernel to process a list of 1
+million (!) held locks, using the new method [on a 2GHz CPU]:
+
+ - with FUTEX_WAIT set [contended mutex]: 130 msecs
+ - without FUTEX_WAIT set [uncontended mutex]: 30 msecs
+
+I have also measured an approach where glibc does the lock notification
+[which it currently does for !pshared robust mutexes], and that took 256
+msecs - clearly slower, due to the 1 million FUTEX_WAKE syscalls
+userspace had to do.
+
+(1 million held locks are unheard of - we expect at most a handful of
+locks to be held at a time. Nevertheless it's nice to know that this
+approach scales nicely.)
+
+Implementation details
+----------------------
+
+The patch adds two new syscalls: one to register the userspace list, and
+one to query the registered list pointer:
+
+ asmlinkage long
+ sys_set_robust_list(struct robust_list_head __user *head,
+                     size_t len);
+
+ asmlinkage long
+ sys_get_robust_list(int pid, struct robust_list_head __user **head_ptr,
+                     size_t __user *len_ptr);
+
+List registration is very fast: the pointer is simply stored in
+current->robust_list. [Note that in the future, if robust futexes become
+widespread, we could extend sys_clone() to register a robust-list head
+for new threads, without the need of another syscall.]
+
+So there is virtually zero overhead for tasks not using robust futexes,
+and even for robust futex users, there is only one extra syscall per
+thread lifetime, and the cleanup operation, if it happens, is fast and
+straightforward. The kernel doesnt have any internal distinction between
+robust and normal futexes.
+
+If a futex is found to be held at exit time, the kernel sets the
+following bit of the futex word:
+
+	#define FUTEX_OWNER_DIED        0x40000000
+
+and wakes up the next futex waiter (if any). User-space does the rest of
+the cleanup.
+
+Otherwise, robust futexes are acquired by glibc by putting the TID into
+the futex field atomically. Waiters set the FUTEX_WAITERS bit:
+
+	#define FUTEX_WAITERS           0x80000000
+
+and the remaining bits are for the TID.
+
+Testing, architecture support
+-----------------------------
+
+i've tested the new syscalls on x86 and x86_64, and have made sure the
+parsing of the userspace list is robust [ ;-) ] even if the list is
+deliberately corrupted.
+
+i386 and x86_64 syscalls are wired up at the moment, and Ulrich has
+tested the new glibc code (on x86_64 and i386), and it works for his
+robust-mutex testcases.
+
+All other architectures should build just fine too - but they wont have
+the new syscalls yet.
+
+Architectures need to implement the new futex_atomic_cmpxchg_inuser()
+inline function before writing up the syscalls (that function returns
+-ENOSYS right now).
