Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132568AbRDQJQF>; Tue, 17 Apr 2001 05:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132557AbRDQJPz>; Tue, 17 Apr 2001 05:15:55 -0400
Received: from nef.ens.fr ([129.199.96.32]:16910 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S132406AbRDQJPp>;
	Tue, 17 Apr 2001 05:15:45 -0400
Date: Tue, 17 Apr 2001 11:15:35 +0200
From: =?ISO-8859-1?Q?=C9ric?= Brunet <ebrunet@quatramaran.ens.fr>
Message-Id: <200104170915.LAA00596@quatramaran.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <200104121238.f3CCcZHQ030519@pincoya.inf.utfsm.cl>
In-Reply-To: <200104121238.f3CCcZHQ030519@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Adam J. Richter" <adam@yggdrasil.com> said:
>
>> 	I suppose that running the child first also has a minor
>> advantage for clone() in that it should make programs that spawn lots
>> of threads to do little bits of work behave better on machines with a

There is another issue with this proposition. I have begun to write (free
time, slow pace) an userland sandbox which allows me to prevent a process
and its childs to perform some given actions, like removing files or
writing in some directories. This works by ptrace-ing the process,
modifying system calls and faking return values. It also needs,
obviously, to ptrace-attach childs of the sandboxed process. When the
parent in a fork runs first, the sandbox program has time to
ptrace-attach the child before it does any system call. Obviously, if the
child runs first, this is no longer the case.

If it is decided that the child should run first in a fork, there should
be a way to reliably ptrace-attach it before it can do anything.

By the way, I tried to solve this problem in my sandbox program by
masqerading any fork call into a clone system call with the flag
CLONE_PTRACE. I had hoped that the child would in this way start already
ptraced. However, this didn't work as expected. The child did start in a
ptraced state, but the owner of the trace was its parent (which issued
the fork), and not my sandbox process which was ptracing this parent. I
find that this behaviour is really weird and useless. I could simulate
the current behaviour simply by calling ptrace(TRACE_ME,..) in the child.
What is the real use of the CLONE_PTRACE flag ?

Éric Brunet
