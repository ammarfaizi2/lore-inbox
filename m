Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRCIJtk>; Fri, 9 Mar 2001 04:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRCIJta>; Fri, 9 Mar 2001 04:49:30 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:7943 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130466AbRCIJtU>;
	Fri, 9 Mar 2001 04:49:20 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103090948.f299mPS401032@saturn.cs.uml.edu>
Subject: Re: Process vs. Threads
To: hlein@progressive-comp.com
Date: Fri, 9 Mar 2001 04:48:25 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103080017.TAA24960@mailer.progressive-comp.com> from "Hank Leininger" at Mar 07, 2001 07:17:17 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hank Leininger writes:
> On 2001-03-07, "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

>> Then for proper ps and top output, you need a reasonably efficient
>> way to grab all threads as a group. This could be as simple as
>> ensuring that /proc directory reads return related tasks together.
>> This works too:   /proc/42/threads/98 -> ../../98
>
> For this (but not for other "proper thread support" things
> you mention) would it be enough to have /proc publish some token
> that represent unique ->fs, ->mm, etc pointers?  (The kernel-space
> address of each would work, though that might be leaking too much
> info; the least userspace must treat such values as opaque canary
> tokens.)  This does not give you the most efficient "ps --threads 231"
> but it does let ps, top, (fuser?), etc group processes with the
> same vm, files, etc, no?

You've identified the problem yourself.

When I wrote the new ps, I made a rule for myself: the default
output would not require sorting of any kind. Output would be
produced as soon as possible. This is for performance, and to
help tolerate kernel bugs that cause a hang.

So far I've resisted using threads myself to work around the
hang problem.

It won't be "ps --threads 231". It will be one of the following
options if you do want to see individual threads: m -m -T -L
(the options are in use on Tru64, AIX, IRIX, Solaris, UnixWare...)

So think of a way to wrap tasks together, preferably in a
way that is impossible for a non-POSIX thread to escape from.
Taking a guess at it:

Have an inherited task-group-ID that gets set equal to the task ID
whenever a task breaks away from other tasks. This includes fork(),
execve(), and any unshare() call that might be implemented. Note that
this does not, and indeed _must_ not, enforce POSIX signal behavior.
(the leader of a new and empty group might be able to request the
POSIX behavior for his group, but it can not be the default)
