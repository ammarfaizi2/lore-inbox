Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTFFBzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 21:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTFFBzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 21:55:55 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:42141 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264336AbTFFBzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 21:55:53 -0400
Date: Thu, 05 Jun 2003 22:03:49 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: Re: reading links in proc - permission denied
To: linux-kernel <linux-kernel@vger.kernel.org>, lkml@tlinx.org
Message-id: <1054865029.22103.6995.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm misunderstanding something about links in proc.
>
> I thought 'ps', 'top' et al used /proc to display
> processes, command lines, etc.
>
> Since neither ps nor top are suid root, they are
> running with my uid permissions.
>
> However, if I do "ls -l" on /proc/<number>/exe, I get a
>
> "ls: cannot read symbolic link /proc/16714/exe: Permission denied"
>
> message.

All true, but you're assuming /proc/*/exe is used.
Nope. There is a parser for /proc/*/status and
/proc/*/stat, plus /proc/*/cmdline for args.

Please don't try this yourself. I can spot bugs
in almost any parser for these files. Consider
processes with names like these:

"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
":-) 1 2 3 4 5 6"
"foo Pid: 42"
"x State: Z (z)"

> Now the process is owned by 'named', but the entries in
> diriectory are owned by root (is that right/logical?), thus:

It makes sense in general. An app running on behalf
of a user (with a non-root UID) may still contain
secret data gained via the prior UID.

It would be nice if the app could declare itself
free of this problem.

The restricted permission on /proc/*/exe is kind of
dumb though, considering that /proc/*/maps is wide open.
Ability to follow the link might need to be restricted,
since the link is (was?) magic. It acts somewhat like
a hard link, bypassing permissions along the path.

> Purely from a 'cleanliness' standpoint, is the
> environment owned by the user-id, or is it a common
> piece of public, kernel (root) owned data?

It's swappable. The process can muck with it.

> So why can't I follow the link of 'exe' to see what image the
> process is executing?  Programs like 'ps' and 'top' seem to not
> have this difficulty.

I wish.

> Thanks for any insights...I'm trying to write a simple script
> looking for a running process (by looking at what 'exe' is   
> pointing to).  I would find it kludgey to achieve the objective
> by running 'ps' and doing appropriate filtering. 

There's nothing wrong with parsing ps output. Be sure to split
on whitespace, and not by character position. You can also use
pgrep or pidof. For example:

ps -C foo -opid=
pgrep -u root sshd
pidof something


