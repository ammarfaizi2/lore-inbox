Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVBOJ0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVBOJ0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVBOJ0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:26:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38226
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261658AbVBOJZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:25:41 -0500
Date: Tue, 15 Feb 2005 10:25:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050215092539.GT13712@opteron.random>
References: <20050121100606.GB8042@dualathlon.random> <20050121093902.O469@build.pdx.osdl.net> <csrje8$bsn$1@abraham.cs.berkeley.edu> <20050121111700.Q469@build.pdx.osdl.net> <csvk20$6qa$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csvk20$6qa$1@abraham.cs.berkeley.edu>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 07:34:24AM +0000, David Wagner wrote:
> What if 6 months from now we discover that we really should have enabled
> one more syscall in seccomp to accomodate other applications?

This is why there's a seccomp mode number, and you've to choose it, I
only implemented mode 0 so far.

If I'll need poll too, I'll add poll(2) to seccom mode 1, with a few
bytes of code. Until I'll need poll there's no point for me to add it
and I don't plan to use it in the short term. In the short term my only
object is to bootstrap the system with the minimum of functionality that
makes it useful and seccomp is the simplest and most reliably way to
make the sell client secure.

You can't start with the final thing, or you'll never have a chance to
bootstrap it. Plus if Cpushare doesn't work, there's no point to invest
so much work into it.

I'll use buffering in the twisted layer of the client, so that blocking
time will be reduced. So if you can compute asynchronously with the new
data coming, lack of select shouldn't be noticeable and I'm avoiding
everything that I can avoid.

Now I added a -EINVAL retval to the write too (previously you had to
read it back to see if the write went through, and that's what my client
code has been doing so far to verify the seccomp mode got enabled). It's
still good idea to keep reading it back as a double check, but the
-EINVAL now makes it even simpler:

	if (seccomp_mode && seccomp_mode <= NR_SECCOMP_MODES) {
		tsk->seccomp.mode = seccomp_mode;
		set_tsk_thread_flag(tsk, TIF_SECCOMP);
	} else
		return -EINVAL;

x:~ # cat /proc/self/seccomp
0
x:~ # echo 2 > /proc/self/seccomp
x:~ # echo $?
1
x:~ # echo 1 > /proc/self/seccomp 
Connection to x closed.


> At the same time, I truly empathize Andrea's position that something
> like seccomp ought to be a lot easier to verify correct than ptrace().
> I think several people here are underestimating the importance of
> clean design.  ptrace() is, frankly, a godawful mess, and I don't
> know about this thinking that you can take a godawful mess and then
> audit it carefully and call it secure -- well, that seems unlikely to
> ever lead to the same level of assurance that you can get with a much
> cleaner design.  (This business of overloading as a means of sending

Yep.

I strongly prefer to leave ptrace for debugging purposes and not to
depend on ptrace for production usage.

Think how much time I spent implementing seccomp and to adapt the sell
client to use it, how much code I've written, and then compared to a
ptrace (or Xen) solution.

I'll switch to an hypervisor only when there will be an advantage for me to
do so (i.e. after trusted computing will hit the hardware market).
Nothing will change for the buyers, I'll try as hard as possible to
allow the same buy client to buy trusted computing clients and seccomp
clients without even being able to notice the difference (except for the
price that I expect will be higher for trusted computing clients for
obvious reasons).

You can run the sell client in a virtualized environment already with
seccomp if you want to stack more jails one on top of the other (even in
virtualized linux environment from other OS) but you've to trust the
virtualization technology if you want to do that.  I've currently no
resource to guarantee anything more than seccomp on top of bare hardware
will be rock solid. 

Renzo (my ex prof of Operative Systems at University), is currently
working himself on a generic syscall trapping layer using ptrace for his
research, and he was indipendently asking me in the weekend why he has
to duplicate all those syscall numbers for every arch (he's doing only
x86 and ppc for a start), and I told him there's no way around it with
ptrace, and that's one of the reasons for me using seccomp is so much
easier for me. Renzo doesn't require the level of security that I
require with Cpushare and he requires much more flexibility than I do,
so for him ptrace is the simplest (just like uml).

There's no point for me do wait on all that work to be finished to
attempt to bootstrap Cpushare (the generic syscall trapping layer is
clearly a project in itself, on the same lines of uml) when what I want
to do is to define a "secure" model, that only allows message passing
through filedescriptors as the only means of interacting with other
processes and that solves issues with ptracer getting killed by oom or
stuff like that.

I promise that if Cpushare will go under (and it can really happen, no
way for me to know what will happen to it for sure), I'll spend the 5
minutes to drop seccomp from the kernel to remove unnecessary bloat ;).
Anybody should be able to drop seccomp from the kernel anytime (only
make sure that if you drop it, the /proc/<pid>/seccomp file will go away
too at the same time ;).

> Perhaps there is a compromise position.  What if one started from seccomp,
> but then extended it so the set of allowed syscalls can be specified by
> user level?  This would push policy to user level, while retaining the
> attractive simplicity and ease-of-audit properties of the seccomp design.
> Does something like this make sense?
> 
> architecture' for jails.  The jailed process inherit an open file
> descriptor to its jailor, and is only allowed to call read(), write(),
> sendmsg(), and recvmsg().  If the jailed process wants to interact

Why to call sendmsg/recvmsg when you can call read/write anyway? Note
also that all networking for me will be handled by twisted, no point to
attach raw sockets to the seccomp task, that would be a very bad idea, I
do both SSL encryption and huge buffering with multiplexing at the
twisted layer with the LGPL'd Cpushare protocol. The seccomp task only
see demultiplexed cleartext instead.

All sockets will implement SSL with verification of the certificate to
be sure they connect to cpushare.cpushare.com for real (JP had to fix a
bug in core twisted to allow me to catch the exception if a man gets in
the middle, this is fixed in SVN and future 2.0 and that's the only
reason I don't allow 1.3.0), and I don't want to create unnecessary
sockets, nor to have the seccomp task handle SSL, to avoid worthless
overloading of my server epoll and SSL handshakes.  Cpushare handles
everything with a single encrypted TCP connection per sell client.
Really you'll have to make two connections sometime so I can move you to
a Cpushare-gateway closer to your IP, but in the short term I've a
single server in Italy, so for now it's really only a single TCP
connection. In the long run you'll even be able to open new CPUs on
remote systems from a client bytecode so the workload can spread
exponentially (short term the protocol only allows the buyer client to
open new encrypted sockets).  After I will allow that in the Cpushare
protocol, you won't even notice about all the
SSL/connect/accept/sendmsg/readmsg details (I won't even deal with that
myself since twisted will do it for me without any C/java/C# annoyance).
I don't exclude in the long run I'll have to extend and rewrite it in
C++ for performance reasons, but for now it'd be just an unnecessary
delay (twisted saturates a 100mbit, and I won't have a 100mbit
connection to internet ;).

There's no need of allowing connect/accept/sendmsg/recvmsg, you've only
to implement a protocol like I'm doing.

The idea is to close the untrusted stuff in the smallest possible place,
and to validate everything it asks with full flexibility with twisted.
And all the verification stuff will be implemented with an interpreted
language and it won't be performance critical, so no buffer overflows
and the like.

The only thing I wonder about is poll(2), opening the pipes in
noblocking mode is trivial for the seccomp loader, but without poll
it'll never be able to sleep if I set the pipe in nonblocking mode. But
I don't care right now, and I'll leave it in blocking mode (the
buffering will take care of it), but I don't exclude there will be a
seccomp mode 1 with poll added to the allowed syscall list (that takes
*30* seconds to implement).

> So this is one example of an application that is enabled by adding
> recvmsg() to the set of allowed syscalls.  When it comes to the broader
> question of seccomp vs ptrace(), I don't know what strategy makes most
> sense for the Linux kernel, but I hope these ideas help give you some
> idea of what might be possible and how these mechanisms could be used.

The idea of seccomp is to close the task in a jail, and to do all other
risky operations with a task outside (LGPL'd sell client in my case with
Cpushare), the task outside will have to validate all the requests
coming from the untrusted bytcode, just like the kernel validates the
parameters of the syscalls, no difference. Everything you get from the
network will have to be validate anyways, so it's not a big news. With
seccomp it's like if the seccomp task wasn't running on your computer
but on a remote server and in turn you can't trust the message it sends
to you. Except you won't need SSL between the sell client and the
seccomp task since nobody will be able to sniff the pipe ;)

All the sell client does is to provide an API between the buy client and
the untrusted bytecode that runs remotely. Both the buy client and the
sell clients will be library code for people to use.

Luckily to use it you won't have to understand a thing of the above ;)
