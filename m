Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWBSRw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWBSRw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWBSRw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:52:59 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:45033 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932177AbWBSRw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:52:58 -0500
Message-ID: <43F8B05B.4090707@us.ibm.com>
Date: Sun, 19 Feb 2006 12:52:27 -0500
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Kerrisk <mtk-manpages@gmx.net>
CC: torvalds@osdl.org, akpm@osdl.org, ak@muc.de, hch@lst.de, paulus@samba.org,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
Subject: Re: unhare() interface design questions and man page
References: <43F241D3.60404@us.ibm.com> <13416.1140069012@www083.gmx.net>
In-Reply-To: <13416.1140069012@www083.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk wrote:

>Hi Janak,
>
>  
>
>>>>>2. Reading the code and your documentation, I see that CLONE_VM
>>>>> implies CLONE_SIGHAND.  Since CLONE_SIGHAND is not implemented
>>>>> (i.e., results in an EINVAL error), I take it that this means
>>>>> that at the moment CLONE_VM will not work (i.e., will result 
>>>>> in EINVAL).  Is this correct?  If so, I will note this in 
>>>>> the man page.
>>>>>
>>>>>          
>>>>>
>>>>Actually, CLONE_SIGHAND implies CLONE_VM and not the
>>>>otherway around. Currently CLONE_VM is supported, as long as
>>>>singnal handlers are not being shared. That is, if you created the
>>>>process using clone(CLONE_VM), which kept signal handlers
>>>>different, then you can unshare VM using unshare(CLONE_VM).
>>>>        
>>>>
>>>Maybe I'm being dense, and as I said I haven't actually
>>>tested the interface, but your Documentation/unshare.txt 
>>>(7.2) says the opposite:
>>>
>>>   If CLONE_VM is set, force CLONE_SIGHAND.
>>>
>>>and the code in check_unshare_flags() seems to agree:
>>>
>>>       /*
>>>        * If unsharing vm, we must also unshare signal handlers 
>>>        */
>>>       if (*flags_ptr & CLONE_VM)
>>>                *flags_ptr |= CLONE)SIGHAND;
>>>
>>>What am I missing?
>>>
>>>      
>>>
>>Sorry, I think I have caused confusion by my use of "implies" and
>>"forcing of flags". I am easily confused by this as well, so let me see
>>if I can clarify with a picture.  I will double check the documentation
>>file to make sure I am using correct and unambiguous words.
>>
>>Consider the following 4 cases.
>>
>>  (1)        (2)              (3)              (4)
>>
>>     
>>SH1  SH2   SH1   SH2           SH               SH
>> |    |     \     /            ||              /  \
>> |    |      \   /             ||             /    \
>>VM1  VM2       VM              VM            VM1   VM2
>> 
>>     
>>   ok          ok              ok              NOT ok
>>                         
>>     
>>You can achieve (1), (2) or (3) using clone(), but clone()
>>will not let you do (4). What we want to make sure is
>>that we don't endup like (4) using unshare. unshare
>>makes sure that if you are trying to unshare vm, AND
>>you were sharing signal handlers (case 3) before,
>>then it won't allow that operation. However, if you
>>were like (2), then you can unshare vm and end up
>>like (1), which is allowed. So the forcing of sighand
>>flag makes sure that you check for case (2) or (3).
>>    
>>
>
>That all makes sense.  Thanks.  Just returning to my
>original statement though: CLONE_VM *does* imply 
>CLONE_SIGHAND.  But that's okay.  What I had 
>overlooked was that unshare(CLONE_SIGHAND) is 
>permitted, and implemented as a no-op, if the count
>of threads sharing the signal structure is 1.
>In other words, we can do an unshare(CLONE_SIGHAND)
>as long as we did not specifiy CLONE_SIGHAND in the
>previous clone() call.
>
>By the way, I have by now done quite a bit of testing
>of unshare(), and it works as documented for all the 
>cases I've tested.  I have included a fairly
>general (command-line argument driven) program at
>the foot of this message.  It allows you to test
>various flag combinations.  Maybe it is useful
>to you also?
>
>  
>
Thank you for your extensive testing. I have been using the following
program at

http://prdownloads.sourceforge.net/audit/unshare_test.c?download

as new kernels are released. This program was created for arch
maintainers and for eventual inclusion in the LTP.


>>>>>3. The naming of the 'flags' bits is inconsistent.  In your
>>>>> documentation you note:
>>>>>
>>>>>      unshare reverses sharing that was done using clone(2) system 
>>>>>      call, so unshare should have a similar interface as clone(2). 
>>>>>      That is, since flags in clone(int flags, void *stack) 
>>>>>      specifies what should be shared, similar flags in 
>>>>>      unshare(int flags) should specify what should be unshared. 
>>>>>      Unfortunately, this may appear to invert the meaning of the 
>>>>>      flags from the way they are used in clone(2).  However, 
>>>>>      there was no easy solution that was less confusing and that 
>>>>>      allowed incremental context unsharing in future without an 
>>>>>      ABI change.
>>>>> 
>>>>> The problem is that the flags don't simply reverse the meanings
>>>>> of the clone() flags of the same name: they do it inconsistently.
>>>>>
>>>>> That is, CLONE_FS, CLONE_FILES, and CLONE_VM *reverse* the 
>>>>> effects of the clone() flags of the same name, but CLONE_NEWNS 
>>>>> *has the same meaning* as the clone() flag of the same name.
>>>>> If *all* of the flags were simply reversed, that would be 
>>>>> a little strange, but comprehensible; but the fact that one of 
>>>>> them is not reversed is very confusing for users of the 
>>>>> interface.
>>>>>
>>>>> An idea: why not define a new set of flags for unshare()
>>>>> which are synonyms of the clone() flags, but make their
>>>>> purpose more obvious to the user, i.e., something like
>>>>> the following:
>>>>>  
>>>>>       #define UNSHARE_VM     CLONE_VM
>>>>>       #define UNSHARE_FS     CLONE_FS
>>>>>       #define UNSHARE_FILES  CLONE_FILES
>>>>>       #define UNSHARE_NS     CLONE_NEWNS
>>>>>       etc.
>>>>>       
>>>>> This would avoid confusion for the interface user.  
>>>>> (Yes, I realize that this could be done in glibc, but why 
>>>>> make the kernel and glibc definitions differ?)
>>>>>
>>>>>          
>>>>>
>>>>I agree that use of clone flags can be confusing. At least a couple of
>>>>folks pointed that out when I posted the patch. The issues was even
>>>>raised when unshare was proposed few years back on lkml. Some
>>>>source of confusion is the special status of CLONE_NEWNS. Because
>>>>namespaces are shared by default with fork/clone, it is different than
>>>>other CLONE_* flags. That's probably why it was called CLONE_NEWNS
>>>>and not CLONE_NS. 
>>>>        
>>>>
>>>Yes, most likely.
>>>
>>>      
>>>
>>>>In the original discussion in Aug'00, Linus
>>>>said that "it makes sense that a unshare(CLONE_FILES) basically
>>>>_undoes_ the sharing of clone(CLONE_FILES)"
>>>>
>>>>http://www.ussg.iu.edu/hypermail/linux/kernel/0008.3/0662.html
>>>>
>>>>So I decided to follow that as a guidance for unshare interface.
>>>>        
>>>>
>>>Yes, but when Linus made that statement (Aug 2000), there 
>>>was no CLONE_NEWNS (it arrived in 2.4.19, Aug 2002).  So
>>>the inconsistency that I'm highlighting didn't exist back 
>>>then.  As I said above: if *all* of the flags were simply 
>>>reversed, that would be comprehensible; but the fact that 
>>>one of them is not reversed is inconsistent.  This &will*
>>>confuse people in userland, and it seems quite 
>>>unnecessary to do that.  Please consider this point further.
>>>
>>>      
>>>
>>Thanks for clarification. I didn't check that namespaces cames after
>>that original discussion. I still think that the confusion is not acute
>>enough to warrent addition of more flags, but will run it by some
>>folks to see what they think.
>>    
>>
>
>Let me put it this way: if you change things in the manner
>I suggest, then it will cause a few kernel developers
>to have to stop and think for a moment.  If you leave things 
>as they are, then a multitude of userland programmers will be
>condemned to stumble over this confusion for many years to
>come.  
>
>(And yes, I appreciate that the original problem arose 
>with clone(), really there should have been a CLONE_NS 
>flag which was used as the default for fork() and exec(), 
>and omitted to get the CLONE_NEWNS behaviour we now have.
>But extended this problem into unshare() is even
>more confusing, IMHO.)
>
>Just to emphasize this point: while testing the
>various unshare() flags, I found I was myself runnng 
>into confusion when I tested unshare(CLONE_NEWNS).
>That confusion arose precisely because CLONE_NEWNS
>has the same effect in clone() and unshare().  And
>I was still getting confused even though I 
>understood that!
>
>Please consider changing these names.  (I'm a little
>surprised that no-one else has offered an opinion for
>or against this point so far...)
>
>  
>
>>>>>4. Would it not be wise to include a check of the following form
>>>>> at the entry to sys_unshare():
>>>>>
>>>>>      if (flags & ~(CLONE_FS | CLONE_FILES | CLONE_VM | 
>>>>>              CLONE_NEWNS | CLONE_SYSVSEM | CLONE_THREAD))
>>>>>          return -EINVAL;
>>>>>
>>>>> This future-proofs the interface against applications
>>>>> that try to specify extraneous bits in 'flags': if those
>>>>> bits happen to become meaningful in the future, then the
>>>>> application behavior would silently change.  Adding this 
>>>>> check now prevents applications trying to use those bits 
>>>>> until such a time as they have meaning.
>>>>>
>>>>>          
>>>>>
>>>>I did have a similar check in the first incarnation of the patch. It 
>>>>was
>>>>pointed out, correctly, that it is better to allow all flags so we can
>>>>incrementally add new unshare functionality while not making
>>>>any ABI changes. unshare follows clone here, which also does not
>>>>check for extraneous bits in flags.
>>>>        
>>>>
>>>I guess I need educating here.  Several other system calls 
>>>do include such checks:
>>>
>>>mm/mlock.c: mlockall(2):
>>>if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
>>>mm/mprotect.c: mprotect(2):
>>>if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
>>>mm/msync.c: msync(2):
>>>if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
>>>mm/mremap.c: mremap(2):
>>>if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
>>>mm/mempolicy.c:	mbind(2):
>>>if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
>>>mm/mempolicy.c:	get_mempolicy(2):
>>>if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
>>>
>>>What distinguishes unshare() (and clone()) from these?
>>>
>>>      
>>>
>>I haven't looked at your examples in detail, but basically clone and
>>unshare work on pieces of process context. It is quite possible that
>>in future there may be new pieces added to the process context
>>resulting in new flags. You want to make sure that you can
>>incrementally add functionality for sharing and unsharing of
>>new flags.
>>    
>>
>
>Sure -- and I do not see how my suggestion preclused 
>that possibility.
>
>  
>
>>>I guess I'm unclear too about this (requoted) text
>>>
>>>      
>>>
>>>>It was
>>>>pointed out, correctly, that it is better to allow all flags so we can
>>>>incrementally add new unshare functionality while not making
>>>>any ABI changes. 
>>>>        
>>>>
>>>If one restricts the range of flags that are available now
>>>(prevents userland from trying to use them), and then
>>>permits additional flags later, then from the point of
>>>view of the old userland apps, there has been no ABI change.
>>>What am I missing here?
>>>
>>>      
>>>
>>I think the ABI change may occur if the new flag that gets added,
>>somehow interacts with an existing flag (just like signal handlers and
>>vm) or has a different default behavior (like namespace). I think
>>that's why clone and unshare (which mimics the clone interface)
>>do not check for unimplmented flags.
>>    
>>
>
>What you are saying here doesn't make sense to me.  Here is how 
>I see that an ABI change can occur, and it seems to me
>that it is highly undesirable:
>
>1. Under the the current implementation, useland calls 
>   unshare() *accidentally* specifying some additional 
>   bits that currently have no meaning, and do not 
>   cause an EINVAL error.
>
>2. Later, those bits acquire meaning in unshare().
>
>3. As a consequence, the behaviour of the old
>   binary application changes (perhaps crashes,
>   perhaps just does something new and strange)
>
>Does this scenario not seem to be a problem to you?
>If not, why not?
>
>  
>
To me, instead of an application accidently passing extra bits/flags, a more
likely scenario is the incremental addition of new and valid flags. What
I was trying to cover is the possibility that new context flags may get
added to the kernel, but their unsharing may not get added at the same
time. An application developer can appropriately add new flags to their
unshare call and would not have to port their application everytime an
unsharing of a new context flag was supported. A context flag, for
which unsharing is not yet implemented, will result in a no-op. I understand
your concerns and I will run them by a couple of senior kernel developers
to see what they think.

>Cheers,
>
>Michael
>
>
>
>
>/* demo_unshare.c */
>
>#define _GNU_SOURCE
>#include <sys/types.h>
>#include <string.h>
>#include <signal.h>
>#include <sys/stat.h>
>#include <sys/wait.h>
>#include <fcntl.h>
>#include <sched.h>
>#include <stdio.h>
>#include <stdlib.h>
>#include <unistd.h>
>#include <errno.h>
>
>#define errMsg(msg)     do { perror(msg); } while (0)
>
>#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>                        } while (0)
>
>#define fatalExit(msg)  do { fprintf(stderr, "%s\n", msg); \
>                             exit(EXIT_FAILURE); } while (0)
>
>static void
>usageError(char *progName)
>{
>    fprintf(stderr, "Usage: %s [clone-arg [unshare-arg]]\n", progName);
>#define fpe(str) fprintf(stderr, "        " str)
>    fpe("args can contain the following letters:\n");
>    fpe("    d - file descriptors (CLONE_FILES)\n");
>    fpe("    f - file system information (CLONE_FS)\n");
>    fpe("    n - give child separate namespace (CLONE_NEWNS)\n");
>    fpe("    s - signal dispositions (CLONE_SIGHAND)\n");
>    fpe("    e - SV semaphore undo structures (CLONE_SYSVSEM)\n");
>    fpe("    t - place in same thread group (CLONE_THREAD)\n");
>    fpe("    v - signal dispositions (CLONE_VM)\n");
>    exit(EXIT_FAILURE);
>} /* usageError */
>
>volatile int glob = 0;
>
>typedef struct {        /* For passing info to child startup function */
>    int    fd;
>    mode_t umask;
>    int    signal;
>} ChildParams;
>
>static char *unshareFlags = NULL;
>
>#define SYS_unshare 310
>
>static int
>charsToBits(char *flags)
>{
>    char *p;
>    int cloneFlags;
>
>    cloneFlags = 0;
>
>    if (flags != NULL) {
>        for (p = flags; *p != '\0'; p++) {
>            if      (*p == 'd') cloneFlags |= CLONE_FILES;
>            else if (*p == 'f') cloneFlags |= CLONE_FS;
>            else if (*p == 'n') cloneFlags |= CLONE_NEWNS;
>            else if (*p == 's') cloneFlags |= CLONE_SIGHAND;
>            else if (*p == 'e') cloneFlags |= CLONE_SYSVSEM;
>            else if (*p == 't') cloneFlags |= CLONE_THREAD;
>            else if (*p == 'v') cloneFlags |= CLONE_VM;
>            else usageError("Bad flag");
>        } 
>    } 
>
>    return cloneFlags;
>} /* charsToBits */
>
>static int              /* Startup function for cloned child */
>childFunc(void *arg)
>{
>    ChildParams *cp;
>    int cloneFlags;
>
>    cloneFlags = 0;
>
>    printf("Child:  PID=%ld PPID=%ld\n", (long) getpid(),
>            (long) getppid());
>
>#define SYS_unshare 310
>    cloneFlags = charsToBits(unshareFlags);
>
>    printf("Child unsharing 0x%x\n\n", cloneFlags);
>    if (syscall(SYS_unshare, cloneFlags) == -1) errExit("unshare");
>
>    cp = (ChildParams *) arg;   /* Cast arg to true form */
>
>    /* The following changes may affect parent */
>
>    glob++;             /* May change memory shared with parent */
>
>    umask(cp->umask);
>
>    if (close(cp->fd) == -1) errExit("child:close");
>    if (signal(cp->signal, SIG_DFL) == SIG_ERR)
>        errExit("child:signal");
>
>    return 0;
>} /* childFunc */
>
>int
>main(int argc, char *argv[])
>{
>    const int STACK_SIZE = 65536;    /* Stack size for cloned child */
>    char *stack;                     /* Start of stack buffer area */
>    char *stackTop;                  /* End of stack buffer area */
>    int cloneFlags;                  /* Flags for cloning child */
>    ChildParams cp;                  /* Passed to child function */
>    const mode_t START_UMASK = S_IWOTH;  /* Initial umask setting */
>    struct sigaction sa;
>    int status, s;
>    pid_t pid;
>
>    printf("Parent: PID=%ld PPID=%ld\n", (long) getpid(),
>            (long) getppid());
>
>    if (argc > 2)
>        unshareFlags = argv[2];
>
>    /* Set up an argument structure to be passed to cloned child, and
>       set some process attributes that will be modified by child */
>
>    umask(START_UMASK);         /* Initialize umask to some value */
>    cp.umask = S_IWGRP;         /* Child sets umask to this value */
>
>    cp.fd = open("/dev/null", O_RDWR);  /* Child will close this fd */
>    if (cp.fd == -1) errExit("open");
>
>    cp.signal = SIGTERM;        /* Child will change disposition */
>    if (signal(cp.signal, SIG_IGN) == SIG_ERR) errExit("signal");
>
>    /* Initialize clone flags using command-line argument
>       (if supplied) */
>
>    cloneFlags = charsToBits(argv[1]);
>    printf("Parent clone flags 0x%x\n\n", cloneFlags);
>
>    /* Allocate stack for child */
>
>    stack = malloc(STACK_SIZE);
>    if (stack == NULL) errExit("malloc");
>    stackTop = stack + STACK_SIZE;  /* Assume stack grows downwards */
>
>    if (clone(childFunc, stackTop, cloneFlags | SIGCHLD, &cp) == -1)
>        errExit("clone");
>
>    /* Wait for child.  */
>
>    pid = waitpid(-1, &status, 0);
>    if (pid == -1) {    /* Probably because CLONE_THREAD was used */
>        if (! (cloneFlags & CLONE_THREAD))
>            errExit("waitpid");
>        else
>            sleep(1);
>    } 
>
>    if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
>        fatalExit("Child failed");
>
>    printf("\nAfter wait in parent:\n");
>    printf("    Child PID=%ld; status=0x%x\n", (long) pid, status);
>
>    /* Check whether changes made by cloned child have
>       affected parent */
>
>    printf("\nParent - checking process attributes:\n");
>
>    printf("    [VM]      ");
>    printf("glob=%d (%s)\n", glob, glob ? "changed" : "unchanged");
>
>    printf("    [FS]      ");
>    if (umask(0) != START_UMASK)
>        printf("umask has changed\n");
>    else
>        printf("umask is unchanged\n");
>
>    printf("    [FILES]   ");
>    s = write(cp.fd, "Hello world\n", 12);
>    if (s == -1 && errno == EBADF)
>        printf("file descriptor %d has been closed "
>                "(i.e., changed)\n", cp.fd);
>    else if (s == -1)
>        printf("write() on file descriptor %d failed (%s) "
>                "(unexpected!)\n", cp.fd, strerror(errno));
>    else
>        printf("write() on file descriptor %d succeeded"
>                "(i.e., unchanged)\n", cp.fd);
>
>    printf("    [SIGHAND] ");
>    if (sigaction(cp.signal, NULL, &sa) == -1) errExit("sigaction");
>    if (sa.sa_handler != SIG_IGN)
>        printf("signal disposition has changed\n");
>    else
>        printf("signal disposition is unchanged\n");
>
>    exit(EXIT_SUCCESS);
>} /* main */
>
>  
>

