Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWBCMqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWBCMqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWBCMqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:46:55 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:55466 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750731AbWBCMqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:46:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=Yty+EPvkDEz5KbOR/wdyjchGLeDiq6h+bVBBhQoyw7A7B8/8m+qtlxaQ2TfcHSJ0qUJaXoRZC/Lej7AENl8MFiP/+b2ahulQsB6pvCpH0hgmOks32vn+5frpcY3W8IkxupvdrKYAU7WaRP3nKXPf5eRrbb+/NLdVC8Rt1ZEwdMs=;
Date: Fri, 3 Feb 2006 15:45:58 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com, arjan@infradead.org,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH] VPIDs: Virtualization of PIDs (OpenVZ approach)
Message-ID: <20060203124558.GA4464@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <20060203030143.GC1075@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203030143.GC1075@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  - hierarchical structure (it's flat, only one level)

Er... if I understand the question correctly, it is not flat,
it is rather universal.

The main idea of the VPID approach is that it _preserves_ existing
logic completely, all the references, interprocess linkage and process
grouping are made using usual unique pids.

Virtual pids are just the numbers, which user level applications see.
Of course, they depend on the point where you view from.


>  - a proper administration scheme

There is nothing to administrate. pids are generated and assigned
automatically.

Virtual pids come to the game only when you move a process from
one host to another, new process is created with do_fork_pid(),
which assignes the same virtual pid and generates brand new global pid,
unique for destination host.


>  - a 'view' into the child pid spaces

In order to access a virtual pid space the process must enter
the corresponding container. You are not going to add the whole set
of syscalls, which use not only pid but also a container identifier, right?

For purpose of debugging, vpids are shown /proc/*/status, it is enough.


>  - handling of inter context signalling

Not an issue. All the inter-container communication is made using
global pids.

It is necessary to emphasize again, VPID patch _preserves_ currently
existing capabilities: all the processes in all the containers
can be accessed by global pids. F.e. plain "ps axf" executed in "initial
container" shows the whole process tree.

It is one of main points: "virtual" pids are not used to _limit_ access,
is not a "no go" thing, it allows to go on when we have to reinstate
VPS at another host. Access checks are not based on some pids, they
are defined by policy rules, which are checked after corresponding
objects (tasks in our case) are found.


> and, more important, it does not deal with the existing
> issues and error cases, where references to pids, tasks,
> task groups and sessions aren't handled properly ...

I am sorry, I am not aware about such bugs (expect for a few well-known
cases, when someone holds a pid, which can remain stray and be recycled.
But it is apparently orthogonal to the problem under duscussion).
If they do exist they apparently must be fixed asap not depending
on anything else.

Alexey
