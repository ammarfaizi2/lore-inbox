Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269874AbRHDXCn>; Sat, 4 Aug 2001 19:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269873AbRHDXCX>; Sat, 4 Aug 2001 19:02:23 -0400
Received: from marc1.theaimsgroup.com ([63.238.77.171]:30983 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S269872AbRHDXCN>; Sat, 4 Aug 2001 19:02:13 -0400
Date: Sat, 4 Aug 2001 19:01:55 -0400 (EDT)
From: Hank Leininger <hlein@progressive-comp.com>
X-X-Sender: <hlein@marc1.theaimsgroup.com>
To: <linux-kernel@vger.kernel.org>
cc: Red Phoenix <redph0enix@hotmail.com>
Subject: Linux C2-Style Audit Capability
Message-ID: <010108041858540.11841-100000@marc1.theaimsgroup.com>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-08-04, "Red Phoenix" <redph0enix@hotmail.com> wrote:

[ snip "every syscall can/will be interrupted and it+arguments want to be
  logged somewhere, and a userspace log daemon can't keep up" ]

> What I've considered:
> * Opening the output file directly from the module
>   - I'd prefer to avoid this if at all possible.

While this sounds ugly, it is I suspect the way several commercial UNIXen
handle system call logging[0].  There's some wacky arcane userspace
commands that set the path-to-be-logged-to and tweak what shall be
audited, and then the kernel just goes.  If you think about it, it's the
easiest way to handle the inherent race condition and/or performance hits
of having one userspace process be the "clearing house" for every other
processes's syscalls (each syscall now causes at least 2 extra context
switches).

Also, keep in mind that auditing to a userspace process means it all goes
away if/when someone cracks root.  Doing all of it in kernel space makes
it harder to subvert.  Right now the "root user"<->"kernel" barrier is too
porous, but there are efforts under way/things you can do to make it
better[1] (run around with some chattr +i's, drop privileges early in the
boot process to disable raw memory and raw disk access, etc).  You
shouldn't have to solve that problem, but you do need to keep it in mind
(if nothing else, point these issues out in your first INSTALL doc, caveat
emptor ;).

iif that problem is addressed, an in-kernel audit subsystem with userspace
knobs stands a chance (similar to the old securelevel idea, it should
probably not be possible to "unset" various auditing options once they're
turned on, without a reboot).  A system which relies on a userspace
root-run process (on a conventional UNIXy system) to actually write logs
out isn't going to last two seconds once the system has been compromised;
if the audit trail is stored only locally it will then be targetted
(though the same root<->kernel hardening might make that impossible... but
the logging of new events can certainly be stopped).

The usual log-replication standard of a syslog loghost is worth thinking
about; it'd be pretty easy to have the kernel module spit logs out as
syslog-alike packets (probably stamped with a MAC and possibly
payload-encrypted).  It has some serious shortcomings if you want 100%
guaranteed remote capturing of all logs (in short: it won't happen) but
it's valuable nevertheless; if a box is cracked and its logs wiped,
99.999% complete logs written to another box in real time is better than
0% of the logs being available for analysis[2].

[ Um, after a visit to your project page, I see you're already experienced
  with at least Solaris's audit subsystem, and have things that feed these
  to syslog already.  Heh ;)  Course you know what I'll ask about next:
  a kernel-module version of backlog for Solaris. ]

[0] Not that is necessarily a ringing endorsement.
[1] Note I didn't say "good enough;" that's not possible for all
    definitions of "enough."
[2] Of course, smart attackers will try to make sure they're in the 0.001%

--
Hank Leininger <hlein@progressive-comp.com>

