Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317891AbSGRCYI>; Wed, 17 Jul 2002 22:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSGRCYI>; Wed, 17 Jul 2002 22:24:08 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:16261 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S317891AbSGRCYE>;
	Wed, 17 Jul 2002 22:24:04 -0400
Subject: more thoughts on a new jail() system call
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jul 2002 22:26:09 -0400
Message-Id: <1026959170.14737.102.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, I've gone through each syscall (for x86/2.4.18) I've divided the
processes into sections, saying if I think they should be fine (with
reason I think).  

P  - [Process] - Allow the system call to operate as normal, as it only
affects the processes's individual state, and doesnt change how the OS
relates to the process.

F  - [File descriptor] - The system call depends on a file descriptor.
Since every process in a jail would have been started in the jail, all
the file descriptor's should be safe.

C  - [Chroot] - w/ proper chroot should be fine (as operates on
filename, and therefore will be confined to the jail)

J  - [Jail] - system calls that need to be "caught" when run in a jail.

^J - Works normally b/c jails are 100% sandboxed off from everything

Different things have to be thought about, such as how processes running
on the reguler system interact with jailed processes.  A jailed process
can't send signals (ex. kill() ) to processes outside its jail, but what
about processes outside the jails, can they send send signals to
processes inside a jail?  I can imagine that bad things could possibly
occur if jail'd processes could communicate w/ normal processes (or vice
versa)

anyways, this is just to get the ball rolling on discussion, below is my
list of all the syscalls and how I sort them out (and some I dont know
much about), so please comment.

thanks,

shaya potter

--------

sys_exit) P

sys_fork) P (would create a new process in the same jail)

sys_read) F

sys_write) F

sys_open) C

sys_close) F

sys_waitpid) P

sys_creat) C

sys_link) C

sys_unlink) C

sys_execve) P

sys_chdir) C

sys_time) J

sys_mknod) J - Need FIFO ability, everything else not.

sys_chmod) C

sys_lchown16) C

sys_stat) C

sys_lseek) C

sys_getpid) P

sys_mount) J - Not able to mount inside a jail.

sys_oldumount) J - Not able to unmount inside a jail.

sys_setuid16) ^J - since jail is secure, can setuid all you want.

sys_getuid16) P

sys_stime) J - can't set system time from jail.

sys_ptrace) J - Either disable totally, or filter to only processes in
same jail.

sys_alarm) P

sys_fstat) F

sys_pause) P (works w/ alarm)

sys_utime) C

sys_access) C

sys_nice) J - a process as root inside a jail shouldn't be able to -19
itself consuming all cpu. 

sys_sync) Affects the system, but in a non destructive way.  regular
users can run sync, so shouldn't be a problem?

sys_kill) J - Can only kill processes inside your own jail.

sys_rename) C

sys_mkdir) C

sys_rmdir) C

sys_dup) F/P

sys_pipe) P

sys_times) P

sys_brk) allow as normal (this is for malloc, right?)

sys_setgid16) ^J - assuming jail is secure.

sys_getgid16) P

sys_signal) P 

sys_geteuid16) P 

sys_getegid16) P

sys_acct) J - no seperate process accounting for jail, so doesnt make
sense

sys_umount) J - not allowed

sys_ioctl) J - disallowed, but perhaps if devices recognize jails and
filter commands based on that... 

sys_fcntl) F

sys_setpgid) ^J 

sys_olduname) - P

sys_umask) P

sys_chroot) J - Jail depends on this being strong.  So either revoke,
or figure out a way to decide that a chroot is safe (i.e. below jail's
root) and force a chdir into the new chroot.

sys_ustat) J - Do we want a jailed process getting this info?

sys_dup2) F/P

sys_getppid) P

sys_getpgrp) P

sys_setsid) NOT SURE - no clue what this really does

sys_sigaction) P

sys_sgetmask) P

sys_ssetmask) P

sys_setreuid16) ^J - assuming jail is secure....

sys_setregid16) ^J - ......

sys_sigsuspend) P

sys_sigpending) P

sys_sethostname) J - Can't run from jail.

we can either virtualize it or disallow it.

sys_setrlimit) J - can't run from jail.

sys_old_getrlimit) P

sys_getrusage) P (though inaccurate if we move, unless we reset)

sys_gettimeofday) P (though some aspect of machine dependence)

sys_settimeofday) J - Can't run.

sys_getgroups16) P

sys_setgroups16) ^J - assuming jail is secure, doesnt matter.

old_select) P

sys_symlink) C

sys_lstat) C

sys_readlink) NOT SURE - seems fine.

sys_uselib) NOT SURE - seems fine.

sys_swapon) J - cant affect system from jail.

sys_reboot) J - cant affect system from jail (perhaps can be used to
kill jail)

old_readdir) NOT SURE (dont think it should be a problem)

old_mmap) P

sys_munmap) P

sys_truncate) C

sys_ftruncate) F

sys_fchmod) F

sys_fchown16) F

sys_getpriority) P

sys_setpriority) J - jail processes cant play with their priority

sys_statfs) NOT SURE - should a jail process be able to get info on
system?

sys_fstatfs) same as statfs

sys_ioperm) J - jail processes cant play with local io ports

sys_socketcall) J - Bind seems to be the only problem. jail() includes
an ip address, and a jailed process can only bind to that address. so
do we force the addr to be this address, or does one allow INADDR_ANY
and translate that to the jail'd ip address?

sys_syslog) NOT SURE (probably jailed away)

sys_setitimer) P
sys_getitimer) P

sys_newstat) C
sys_newlstat) C
sys_newfstat) F

sys_uname) NOT SURE - giving jailed process info on local system?

sys_iopl) J - lock out, local machine specific.

sys_vhangup) NOT SURE -  Should be fine, right?

sys_vm86old) J - hardware access, not for jails.
 
sys_wait4) V

sys_swapoff) J - jail cant play with swap.

sys_sysinfo) J - local machine info again?

sys_ipc) - needs to be jailed.  Only processes in the same jail can IPC
amongst themselves.

sys_fsync) NOT SURE - same as sync

sys_sigreturn) used by kernel, should never be used elsewhere (acc. to
man page) not sure what to do with it in actuality. 

man page quote
"When  the  Linux  kernel creates the stack frame for a signal
handler, a call to sigreturn is inserted into the stack frame so that
the  the  signal  handler  will call  sigreturn upon return. This
inserted call to sigreturn cleans up the stack so that the process
can restart from where it was interrupted by the signal." 

"The  sigreturn call is used by the kernel to implement signal
handlers. It should never be called directly. Better  yet,  the
specific  use of the __unused argument varies depending on the
architecture." 

sys_clone) P

sys_setdomainname) J - can't change local system info.

sys_newuname) J - getting info on local system again.

sys_modify_ldt) NOT SURE - have no clue.

sys_adjtimex) J - can't change local system.

sys_mprotect) P - process specific

sys_sigprocmask) P

sys_create_module) J - lock out, as local machine affecting
 
sys_init_module) J - lock out

sys_delete_module) J - lock out

sys_get_kernel_syms) NOT SURE, if no module functions, any need?

sys_quotactl) J - lock out, shouldnt be able to manipulate disk quotas.

sys_getpgid) P

sys_fchdir) F

sys_bdflush) J - only root can call it, so jails cant.

sys_sysfs) J - info on local system?

sys_personality) not really applicable as used for running binaries
for other UNIX's (IBCS for instance), would one run them in a jail?

sys_setfsuid16) ^J

sys_setfsgid16) ^J

sys_llseek) F

sys_getdents) F

sys_select) P

sys_flock) F

sys_msync) P (called b4 munmap)

sys_readv) F 

sys_writev) F

sys_getsid) NOT SURE - whats it for?

sys_fdatasync) NOT SURE - probably same as other syncs.

sys_sysctl) J - perhaps jails could have their own sysctls.

sys_mlock) J - jailed process cant lock memory

sys_munlock) J

sys_mlockall) J

sys_munlockall) J

sys_sched_setparam) J - jailed processes cant play with scheduler
sys_sched_getparam) J
sys_sched_setscheduler) J
sys_sched_getscheduler) J

sys_sched_yield) P

sys_sched_get_priority_max) NOT SURE (any point?)
sys_sched_get_priority_min) "
sys_sched_rr_get_interval)  "

sys_nanosleep) P

sys_mremap) P (works on virtual addresses)

sys_setresuid16) ^J

sys_getresuid16) P

sys_vm86) J - lock out, hardware access.

sys_query_module) J - lock out, os access.

sys_poll) P/F

sys_nfsservctl) J - lock out.

sys_setresgid16) ^J
sys_getresgid16) P

sys_prctl) P (seems ok - operates on process and parent)

sys_rt_sigreturn)    no manpage, but similiar to their non rt functions?
sys_rt_sigaction)    "
sys_rt_sigprocmask)  "
sys_rt_sigpending)   "
sys_rt_sigtimedwait) "
sys_rt_sigqueueinfo) "
sys_rt_sigsuspend)   "

sys_pread) F (similiar to read)

sys_pwrite) F (similiar to write)

sys_chown16) C

sys_getcwd) C

sys_capget) NOT SURE, probably disallow

sys_capset) J - as can perhaps get around security

sys_sigaltstack) NOT SURE - no man page have no idea what it is

sys_sendfile) F

sys_vfork) P

sys_getrlimit) P - not sure if any point?

sys_mmap2) NOT SURE (maybe P)

no man page, but if mmap related shouldnt be a problem

sys_truncate64)  F - 64 bit version of equivalent function
sys_ftruncate64) C - "
sys_stat64)      F - "
sys_lstat64)     F - "
sys_fstat64)     C - "

sys_lchown) C

sys_getuid) P
sys_getgid) P
sys_geteuid) P
sys_getegid) P
sys_setreuid) ^J
sys_setregid) ^J
sys_getgroups) P
sys_setgroups) ^J

sys_fchown) C

sys_setresuid) ^J
sys_getresuid) P
sys_setresgid) ^J
sys_getresgid) P

sys_chown) F

sys_setuid) ^J
sys_setgid) ^J
sys_setfsuid) ^J
sys_setfsgid) J

sys_pivot_root) J - local machine specific.

sys_mincore) NOT SURE

sys_madvise) NOT SURE

sys_getdents64) F 64 bit call of same name
sys_fcntl64)    F "

sys_gettid) P (not exactly sure what it is) no man page

sys_readahead) NOT SURE - no man page



