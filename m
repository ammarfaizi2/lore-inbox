Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261540AbSKCA7k>; Sat, 2 Nov 2002 19:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSKCA7k>; Sat, 2 Nov 2002 19:59:40 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:13639 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261540AbSKCA7e>; Sat, 2 Nov 2002 19:59:34 -0500
Date: Sat, 2 Nov 2002 17:14:10 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over. 
In-Reply-To: <200211022344.gA2NiEgo002637@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.44.0211021655340.28078-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure I understand your point, Horst.  There are four
primary mechanisms which would invoke a dump:

	die() (or die_if_kernel())
	panic()
	interrupt-driven dumps
	sysrq()

Assuming you call these functions, there is a single dump()
call that will perform dumping, the the dump_function_ptr
(which is assigned when the dump module is loaded) is set.
dump() is a simple function that basically says:

static inline void dump(char * str, struct pt_regs * regs)
{
	if (dump_function_ptr) {
		dump_function_ptr((char *)str, regs);
	}
}

str is for the panic() string, and regs are so you can create
a proper stack trace for the failing task on the correct CPU.

I don't see how that can can attributed to bloating the kernel.
If you don't panic(), the code is never invoked.  If you don't load
the dump module, dump_function_ptr isn't assigned.  It's meant
to be non-invasive, off to the side and called when required
(or requested).

There is some additional code put in the kernel to disable
interrupts, quiesce the system, and I think there are a few projects
that can probably use the same code base (such as the suspend-to-ram
project, which I was just informed about).  All of that is called
within the dump driver itself, otherwise it sits quietly off to
the side, never getting called.

Using the dump driver infrastructure is like writing any plain-jane
driver.  You set up the _open(), _close(), etc., functions,
assigning the ops table based on the dump method you want to use
(disk, network, mini-oopser, etc.)  This isn't that difficult,
and it should only be loaded for those customer systems that want
a specific dump style.

--Matt

Standard disclaimer:  I'm not trying anymore to get this into the
kernel at this time (via Linus).  This is purely for educating
those that aren't familiar with crash dumping for Linux.

On Sat, 2 Nov 2002, Horst von Brand wrote:
|>"Matt D. Robinson" <yakker@aparity.com> dijo:
|>
|>[...]
|>
|>> This isn't bloat.  If you want, it can be built as a module, and
|>> not as part of your kernel.  How can that be bloat?  People who
|>> build kernels can optionally build it in, but we're not asking
|>> that it be turned on by default, rather, built as a module so
|>> people can load it if they want to.  We made it into a module
|>> because 18 months ago you complained about it being bloat.  We
|>> addressed your concerns.
|>
|>Bloat is not just RAM/CPU/... usage when in use, it is much more about
|>developers who have to understand, work with, and consider how to use or
|>interface with the new code. Even more so when it is not builtin, as this
|>creates _two_ scenarios to consider.
|>
|>This is the sense of "bloat" that Linus is most worried about (and very
|>rightly so, IMVHO). At lesat that is my observation over the years.
|>

-- 

