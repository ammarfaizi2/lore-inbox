Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVCOQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVCOQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVCOQp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:45:58 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6245
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261435AbVCOQo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:44:28 -0500
Date: Tue, 15 Mar 2005 17:44:20 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050315164420.GT7699@opteron.random>
References: <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random> <20050315150526.GA14744@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315150526.GA14744@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oe Tue, Mar 15, 2005 at 04:05:26PM +0100, Ingo Molnar wrote:
> ugh? Where do i claim any such thing?

You never said such a thing, but you said you believe it's not provable
that sys_read/write and hardware irq processing is secure in linux, so 
I wanted to get some statistical significance about your claim from you
just in case I was missing something.  I obviously can't have in memory
every single bug since 2.4.0.

> while we are at it, please mention a single ptrace bug in the same
> timeframe that could allow a bytecode 'client' to escape a ptrace
> TRACE_SYSCALL jail at will.

There was this bug around 2.4.10, IIRC a SIGCONT could let the ptraced
task to continue executing. I don't want to depend on other applications
not to send a signal by mistake to the ptraced task.

http://www.ussg.iu.edu/hypermail/linux/kernel/0109.0/1049.html

An oom killer triggering by mistake on a strace -p would have been
enough too. You said if the ptracer is the group leader then the ptraced
task will be killed at the same time, but I doubt many apps depends on
this to be safe, that code is complex and it may break over time during
development if signal handling changes or if the exit code changes.

The interesting point is that no app out there (except uml) becomes
exploitable if you find some hole in TRACE_SYSCALL (at worse strace will
screwup a bit). I don't think an huge amount of research has been done
in those code paths (unlike it happened in mremap and many other kernel
APIs). So even if there are bugs in ptrace they might not being
considered security related. And UML has no other way than to use ptrace
since it needs much more of what I need and UML cannot be arch
indipendent.

While any seccomp security bug is guaranteed to be a major security
linux bug too, so I'm more confortable that more research has been done
in those core code paths than in TRACE_SYSCALL behaviour.

This below is all the code I had to write to secure the remote bytecode
with seccomp, and it's fully arch indipendent (licence is LGPL). Ok,
the seccomp kernel patch is 500 lines, so we should add 500 lines plus
the below ~50 total ~550 lines, but the end result is much nicer and
more secure IMHO. Plus this is simple enough that perhaps Cpushare won't
be the only project using it.

class seccomp_protocol_class(protocol.ProcessProtocol):
	def __init__(self, seccomp, d_start, d_end):
		self.seccomp = seccomp
		self.d_start, self.d_end = d_start, d_end
		self.outReceived = self.enable_seccomp_mode
	def connectionMade(self):
		self.seccomp.cpushare_protocol.seccomp_protocols.append(self)
		self.seccomp.cpushare_protocol.transport.registerProducer(self, 1)
		self.transport.closeChildFD(2) # close stderr right away
		self.transport.writeToChild(0, self.seccomp.header + self.seccomp.text_data)
	def enable_seccomp_mode(self, data):
		assert data == MAGIC_ASK_SECCOMP, "didn't ask seccomp"

		seccomp_file = '/proc/' + str(self.transport.pid) + '/seccomp'

		if file(seccomp_file, 'r').read(1) != '0':
			raise 'seccomp already enabled?'

		file(seccomp_file, 'w').write('1')

		if file(seccomp_file, 'r').read(1) != '1':
			assert self.transport.pid is not None
			print 'Killing the seccomp-loader before it starts the untrusted bytecode'
			self.sigkill()
			raise 'seccomp enable failure'

		self.outReceived = self.send_to_server
		self.transport.writeToChild(0, MAGIC_GOT_SECCOMP)

		self.d_start.callback(None) # now the buyer is connected
	def send_to_server(self, data):
		self.seccomp.cpushare_protocol.sendString(PROTO_SECCOMP_FORWARD + data)
	def recv_from_server(self, data):
		self.transport.writeToChild(0, data)
	def errReceived(self, data):
		raise "shouldn't happen"
	def processEnded(self, status):
		self.seccomp.cpushare_protocol.seccomp_protocols.remove(self)
		self.seccomp.cpushare_protocol.transport.unregisterProducer()
		if status.value.exitCode or status.value.signal:
			if status.value.exitCode == 4:
				print 'Failure in setting the stack size to %d bytes.' % self.seccomp.stack
			if status.value.signal == signal.SIGKILL:
				print 'Seccomp task gracefully killed by seccomp.'
			elif status.value.signal == signal.SIGSEGV:
				print 'Seccomp task gracefully killed by sigsegv.'
			elif status.value.signal == signal.SIGQUIT:
				print 'Seccomp task killed by sigquit - should never happen.'
			self.d_end.errback(status)
		else:
			print 'Seccomp task completed successfully.'
			self.d_end.callback(None)

	def sigquit(self):
		if self.transport.pid is not None:
			os.kill(self.transport.pid, signal.SIGQUIT)
	def sigkill(self):
		if self.transport.pid is not None:
			os.kill(self.transport.pid, signal.SIGKILL)
