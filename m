Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSFJPmz>; Mon, 10 Jun 2002 11:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSFJPmy>; Mon, 10 Jun 2002 11:42:54 -0400
Received: from ns1.ptt.yu ([212.62.32.1]:64700 "EHLO ns1.ptt.yu")
	by vger.kernel.org with ESMTP id <S315463AbSFJPmx>;
	Mon, 10 Jun 2002 11:42:53 -0400
Subject: Re: Process-Shared Mutex (futex) - What is it good for ?
From: Vladimir Zidar <vladimir@mindnever.org>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3D0324B1.614BD9D4@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/1.0.2 
Date: 10 Jun 2002 17:43:10 +0200
Message-Id: <1023723807.1491.56.camel@server1>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by ns1.ptt.yu id g5AFgUE30635
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 11:49, Peter Wächtler wrote:

> Just for *that*?
> Do you write programs that reveal from sigsegv with sigsetjmp(3)?

 No, I do not. But killing the process sounds much like abnormal
programm termination. Can you feel the word 'abnormal' ? It is opposite
of normal - be it simple as error condition on file descriptor.


> Hmh, you don't know what's expected but you like record locks?
> Perhaps you mean the silly semantics that all locks are deleted if one
> FD is closed?

 Yes, it is silly, and just because of that, I cannot implement
two-level file locking within threads and processes. 

> Well, fcntl is always a system call. The main design goal for futexes 
> is: if the lock is free, don't enter the kernel. This shows
> great performance benefits on uncontended locks where only a smaller 
> number of threads block because the lock is held.
> 
> Also with posix mutexes they are designed to work in user space with
> PTHREAD_SCOPE_PROCESS. And they are unnamed so that you don't *have* to
> provide them in kernel space or use a "lock manager". 


 Great for them. They are lucky little bastards, futexes. So what ? I
need locking to work nicely between both threads AND processes, and I
don't wanna kill any process when something goes wrong. Performance is
not *that* much important. More important is clean implementation of
healthy idea.
 Also, I need them to have *names*, so that separate programs can find
each-others.


> The drawback is really: what happens when something went wrong?
> Your system of cooperating threads or processes is skrewed up.
> Are the programs prepared to deal with that? How could they?
> Reminds me of databases where you would rollback a transaction... but
> there the database can track what is happening

 When something goes wrong, it is handled in the same way you handle
error condition from socket, or from file -- you do check for return
value of read(), do you ?

> 
> SysV semaphores *do* provide cleanup.

 But they persist in kernel space until deleted explicity, am I wrong ?

> Posix semaphores *are* named. 
> sem_t *sem_open(const char *name, int oflag, ...);

 And not implemented under Linux (process shared), and also they have
problem in case where terminated process was holding them down.


> 
> >  So I had to invent (or at least to pick idea from other OS-es (-: )
> > myself:
> > 
> 
> >From which OS do you have your nutex idea?

 CreateMutex()/WaitForSingleObject()/ReleaseMutex()/CloseHandle() from
win32.
 Also I tend to like the idea of named public semaphores in AmigaOS.


> >  Nutex connection to execution context is over one single file
> > descriptor ( "/dev/nutex" ), which is opened once from each context, at
> > first access and stored for example, in static variable for processes,
> > and for threads with pthread_set/getspecific().
> > 
> 
> Threads share the FDs.
> How do unrelated processes access the same nutex?
> Do you pass a name via iotcl()?

 Yes. And there is small library built on top of these few ioctl-s, so
it basicaly looks like this:

int id;

id = nutex_open(name, flags..);

if(nutex_lock(id, nutex_read_lock) < 0) {
   perror("nutex_lock");
 } else {
   /* read ... */
   nutex_unlock(id);
 }

nutex_close(id);



> >  1. If process was holding READ lock, nothing special happens.
> >  2. If process was holding WRITE lock, nutex is marked as 'damaged', and
> > every subsequent Lock() from other processes on that nutex will result
> > with error EPIPE.
> >  3. If process was *creator* of this nutex, it is marked as REMOVED, and
> > all subsequent Lock() attempts from other processes on that nutex will
> > result with error EIDRM.
> > 
> >  Nice eh ?
> > 
> 
> Don't know yet. What's the error message: Something went wrong with the 
> lock - ask your sysadmin? ;-)

 At least you get a chance to print message on terminal, and/or to log
something before you die.


> So what should a process do, when it encounters that a lock is broken?
> Analyse the data and repair it or giving up?
> I think the only sensible way is to give up - with a clear
> error message that something severly went wrong. I don't like programs
> that do proceed in the hope that it will heal itself. Often these 
> programs tend to fail in such obscure ways that nobody knows what
> was going on.
> 
> I'm not sure if that offers any advantages over fcntl record locking.
> Can you clarify above issues?

 Adventage is that it works okay with threads, that it doesn't use
filesystem namespace, and that it understands how important is to report
an error condition in case of broken write lock.


-- 
Bye,

 and have a very nice day !



