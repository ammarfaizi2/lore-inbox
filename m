Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbRFZLec>; Tue, 26 Jun 2001 07:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264636AbRFZLeX>; Tue, 26 Jun 2001 07:34:23 -0400
Received: from plato.exmail.de ([194.97.6.205]:50069 "HELO plato.exmail.de")
	by vger.kernel.org with SMTP id <S264635AbRFZLeM>;
	Tue, 26 Jun 2001 07:34:12 -0400
From: "Michael Kerrisk" <mtk16@ext.canterbury.ac.nz>
To: linux-kernel@vger.kernel.org
Date: Tue, 26 Jun 2001 13:35:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: New clone(2) and wait(2) man pages for review
Message-ID: <3B388FBE.19842.16ED6EB@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have just been upgrading the clone(2) and wait(2) man pages so that they 
correspond with (my reading of) kernel 2.4.x.  Before these go into 
Andries' manual distribution, I would be happy if people who know better 
could review the changes.  I have included the complete clone(2) man page 
and a section of the wait(2) man page below, with significant changes 
marked by "##".

Changes to the clone(2) page include:

* CLONE_PARENT option added, along with note of impact on signaling on 
child termination.

* CLONE_THREAD options added, with a bief note on the purpose of thread 
groups.  Additions to this description welcome.

* Added CLONE_VFORK, and CLONE_TRACE

 A brief description of sys_clone differences has been included 

* Since clone() is prototyped as "clone()" rather than "__clone()" in 
<sched.h>, the name has been changed to the former.  (Glibc provides a 
weak alias of "clone" for "__clone"

------------
For wait(2):

Added __WCLONE, __WALL, and __WNOTHREAD

Cheers

Michael

-----------------------------------------------

## Complete revised clone(2) man page:

CLONE(2)            Linux Programmer's Manual            CLONE(2)


NAME
       clone - create a child process

SYNOPSIS
       #include <sched.h>

       int  clone(int  (*fn)  (void *arg), void *child_stack, int
       flags, void *arg)

       _syscall2(int, clone, int, flags, void *, child_stack);


DESCRIPTION
       clone creates  a  new  process  in  a  similar  manner  to
       fork(2).   clone  is  a library function layered on top of
       the underlying clone system call, hereinafter referred  to
       as sys_clone.  A description of sys_clone is given towards
       the end of this page.

## Changed:

       Unlike fork(2), these calls allow  the  child  process  to
       share parts of its execution context with the calling pro
       cess, such as the memory space, the table of file descrip
       tors,  and  the  table  of signal handlers.  (Note that on
       this manual page, "calling process"  normally  corresponds
       to   "parent   process".    But  see  the  description  of
       CLONE_PARENT below.)

       The main use of clone is to  implement  threads:  multiple
       threads of control in a program that run concurrently in a
       shared memory space.

       When the child process is created with clone, it  executes
       the  function  application  fn(arg).   (This  differs from
       fork(2), where execution continues in the child  from  the
       point  of the fork(2) call.)  The fn argument is a pointer
       to a function that is called by the child process  at  the
       beginning of its execution.  The arg argument is passed to
       the fn function.

       When the fn(arg) function application returns,  the  child
       process  terminates.   The  integer  returned by fn is the
       exit code for the child process.  The  child  process  may
       also  terminate  explicitely  by  calling exit(2) or after
       receiving a fatal signal.

       The child_stack argument specifies  the  location  of  the
       stack  used  by  the  child  process.  Since the child and
       calling process may share memory, it is not  possible  for
       the  child  process  to  execute  in the same stack as the
       calling process.  The calling process must  therefore  set
       up  memory  space  (in  its  data segment or heap) for the
       child stack and pass a pointer to  this  space  to  clone.
       Stacks  grow  downwards  on  all processors that run Linux
       (except the HP  PA  processors),  so  child_stack  usually
       points  to  the topmost address of the memory space set up
       for the child stack.

       The low byte of flags contains the number  of  the  signal
       sent to the parent when the child dies.  If this signal is
       specified as anything other SIGCHLD, then the parent  pro
       cess  must  specify  the  __WALL  or __WCLONE options when
       waiting for the child with wait(2).  If no signal is spec
       ified,  then  the  parent process is not signaled when the
       child terminates.

       flags may also be bitwise-or'ed with one or several of the
       following  constants,  in  order to specify what is shared
       between the calling process and the child process:

## New:
       CLONE_PARENT
              (Linux 2.4 onwards) If CLONE_PARENT  is  set,  then
              the  parent  of the new child (as returned by getp
              pid(2)) will be the same as  that  of  the  calling
              process.

              If  CLONE_PARENT is not set, then (as with fork(2))
              the child's parent is the calling process.

              Note that it is the parent process, as returned  by
              getppid(2),  which  will be signaled when the child
              terminates.

## For CLONE_THREAD and CLONE_PARENT, I have just put "Linux 2.4 onwards". 
 If someone can supply a 2.3.x version number, I will add that.



       CLONE_FS
              If CLONE_FS is set, the caller and the  child  pro
              cesses  share  the  same  file  system information.
              This includes the root of the file system, the cur
              rent working directory, and the umask.  Any call to
              chroot(2), chdir(2), or umask(2) performed  by  the
              callng  process  or  the  child  process also takes
              effect in the other process.

              If CLONE_FS is not set, the child process works  on
              a  copy of the file system information of the call
              ing process at the time  of  clonecall.   Calls  to
              chroot(2),  chdir(2),  umask(2)  performed later by
              one of the processes does not affect the other.


       CLONE_FILES
              If CLONE_FILES is set, the calling process and  the
              child  processes  share  the  same  file descriptor
              table.  File descriptors always refer to  the  same
              files  in the calling process and in the child pro
              cess.  Any file descriptor created by  the  calling
              process  or  by  the child process is also valid in
              the  other  process.   Similarly,  if  one  of  the
              processes  closes a file descriptor, or changes its
              associated  flags,  the  other  process   is   also
              affected.

              If CLONE_FILES is not set, the child process inher
              its a copy of all file descriptors  opened  in  the
              calling  process  at the time of clone.  Operations
              on file descriptors performed later by  either  the
              calling  process or the child process do not affect
              the other.


       CLONE_SIGHAND
              If CLONE_SIGHAND is set, the  calling  process  and
              the  child processes share the same table of signal
              handlers.  If the calling process or child  process
              calls  sigaction(2)  to change the behavior associ
              ated with a signal, the behavior is also changed in
              the  other  process  as well.  However, the calling
              process and child  processes  still  have  distinct
              signal  masks and sets of pending signals.  So, one
              of them may block or  unblock  some  signals  using
              sigprocmask(2) without affecting the other process.

              If CLONE_SIGHAND is  not  set,  the  child  process
              inherits a copy of the signal handlers of the call
              ing process at the time clone is called.  Calls  to
              sigaction(2)  performed  later  by  one of the pro
              cesses have no effect on the other process.

## New:
       CLONE_PTRACE
              If CLONE_PTRACE is specified, and the calling  pro
              cess  is  being  traced,  then trace the child also
              (see ptrace(2)).


## New:
       CLONE_VFORK
              If CLONE_VFORK s set, the execution of the  calling
              process  is  suspended until the child releases its
              virtual memory resources via a call to execve(2) or
              _exit(2) (as with vfork(2)).

              If  CLONE_VFORK  is  not  set then both the calling
              process and the child  are  schedulable  after  the
              call,  and an application should not rely on execu
              tion occurring in any particular order.


       CLONE_VM
              If CLONE_VM is set, the  calling  process  and  the
              child  processes  run in the same memory space.  In
              particular, memory writes performed by the  calling
              process or by the child process are also visible in
              the other process.  Moreover, any memory mapping or
              unmapping  performed  with  mmap(2) or munmap(2) by
              the child or calling process also affects the other
              process.

              If CLONE_VM is not set, the child process runs in a
              separate copy of the memory space  of  the  calling
              process  at  the  time  of clone.  Memory writes or
              file mappings/unmappings performed by  one  of  the
              processes do not affect the other, as with fork(2).


       CLONE_PID
              If CLONE_PID is set, the child process  is  created
              with the same process ID as the calling process.

              If  CLONE_PID  is  not  set, the child process pos
              sesses a unique process ID, distinct from  that  of
              the calling process.

              This  flag can only be specified by the system boot
              process (PID 0).

## New:
       CLONE_THREAD
              If CLONE_THREAD is set, the child is placed in  the
              same thread group as the calling process.

              If  CLONE_THREAD  is  not  set,  then  the child is
              placed in its own (new) thread group, whose  ID  is
              the same as the process ID.


              (Thread  groups  are  feature added in Linux 2.4 to
              support the  POSIX  threads  notion  of  a  set  of
              threads  sharing a single PID.  In Linux 2.4, calls
              to getpid(2) return the  thread  group  ID  of  the
              caller.)

## A more expanded discussion of thread groups anyone?  (Its's not clear 
to me how much status they enjoy at the moment.  Glibc 2.2.3 linuxthreads 
don't seem to use them.)


## New:

       The  sys_clone  system  call  corresponds  more closely to
       fork(2) in that execution in the child continues from  the
       point of the call.  Thus sys_clone only requires the flags
       and child_stack arguments, which have the same meaning  as
       for  clone.   (Note that the order of these arguments dif
       fers from clone.)

       Another difference for sys_clone is that  the  child_stack
       argument  may  be zero, in which case copy-on-write seman
       tics ensure that the child gets separate copies  of  stack
       pages  when  either  process  modifies the stack.  In this
       case, for correct operation, the  CLONE_VM  option  should
       not be specified.

RETURN VALUE
       On  success,  the  PID of the child process is returned in
       the caller's thread of execution.  On failure, a  -1  will
       be returned in the caller's context, no child process will
       be created, and errno will be set appropriately.


ERRORS
       EAGAIN Too many processes are already running.

       ENOMEM Cannot allocate sufficient  memory  to  allocate  a
              task  structure  for  the  child,  or to copy those
              parts of the  caller's  context  that  need  to  be
              copied.

       EINVAL Returned  by  clone  when a zero value is specified
              for child_stack.

       EPERM  CLONE_PID was specified by a process  with  a  non-
              zero PID.

BUGS
       As  of  version  2.1.97  of the kernel, the CLONE_PID flag
       should not be used, since other parts of  the  kernel  and
       most  system  software  still  assume that process IDs are
       unique.

       There is no entry for clone in libc  version  5.   libc  6
       (a.k.a.  glibc 2) provides clone as described in this man
       ual page.


CONFORMING TO
       The clone  and  sys_clone  calls  are  Linux-specific  and
       should  not  be  used in programs intended to be portable.
       For programming threaded applications (multiple threads of
       control  in  the same memory space), it is better to use a
       library implementing the POSIX 1003.1c thread API, such as
       the   LinuxThreads  library  (included  in  glibc2).   See
       pthread_create(3thr).

       This manual page  corresponds  to  kernels  2.0.x,  2.1.x,
       2.2.x, 2.4.x, and to glibc 2.0.x and 2.1.x.


SEE ALSO
       fork(2), pthread_create(3thr), wait(2)

----------------------------

## The following text is added to wait(2):

       The  following  Linux-specific  options  are  for use with
       children created using clone(2).

       __WCLONE
              which means wait for  "clone"  children  only.   If
              omitted  then  wait  for "non-clone" children only.
              (A "clone" child is one which delivers  no  signal,
              or  a  signal other than SIGCHLD to its parent upon
              termination.)  This option is ignored if __WALL  is
              also specified.

       __WALL (Linux  2.4 onwards) which means wait for all chil
              dren, regardless of type ("clone" or  "non-clone").

       __WNOTHREAD
              (Linux  2.4  onwards)  which  means do not wait for
              other children in the same thread group.

## If someone can tell me the version of 2.3.x which included the last 
two, I will include it.

## I strongly suspect that the following text from wait(2) needs to 
reworded for 2.4.x, and would appreciate any suggestions:

       In  the  Linux  kernel, a kernel-scheduled thread is not a
       distinct construct from a process. Instead,  a  thread  is
       simply  a  process  that is created using the Linux-unique
       clone(2) system call; other routines such as the  portable
       pthread_create(3)  call  are  implemented  using clone(2).
       Thus, if two threads A and B are siblings, then  thread  A
       cannot  wait  on  any  processes forked by thread B or its
       descendents, because an uncle cannot wait on his  nephews.
       In  some  other  Unix-like systems, where multiple threads
       are implemented as belonging to a single process, thread A
       can  wait on any processes forked by sibling thread B; you
       will have to rewrite any code that makes  this  assumption
       for it to work on Linux.

__________________________________________
Michael Kerrisk
mailto: mtk16@ext.canterbury.ac.nz
