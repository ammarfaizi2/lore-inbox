Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289178AbSAMNjL>; Sun, 13 Jan 2002 08:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288010AbSAMNjC>; Sun, 13 Jan 2002 08:39:02 -0500
Received: from chiark.greenend.org.uk ([212.22.195.2]:8201 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S289178AbSAMNiw>; Sun, 13 Jan 2002 08:38:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Unauthorized connection blocking withing socket
In-Reply-To: <3C40B526.D960AC26@nbnet.nb.ca>
In-Reply-To: <3C40B526.D960AC26@nbnet.nb.ca>
Organization: Linux Unlimited
Message-Id: <E16PkqZ-00085N-00@chiark.greenend.org.uk>
From: Peter Benie <peterb@chiark.greenend.org.uk>
Date: Sun, 13 Jan 2002 13:38:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C40B526.D960AC26@nbnet.nb.ca> you write:
>Hi,
>
>Currently I am working on a project which intends to stop unauthorized
>processes sending emails or messages to the internet. The goal of the
>project  is to tackle  the Distributed Service Denial problem.
>
>From the experience on telecommunication at socket level,  it is natural
>for me to look at sys_connect().
>My idea is that: every time when a process tries to make a connection,
>the kernel checks whether the process has the permission to make such
>connection. It requires:
>1. The identification of the process.  I chose the absolute path since
>it is unique, can't be tempted.

Identification of processes is hard. Even if you identify which
program was execed (eg. via /proc/<pid>/exe), that doesn't help
you. For example, if I set LD_PRELOAD or LD_LIBRARY_PATH to cause the
program to link with a library that I control, then I have complete
control over what code gets run. Alternatively, I can control the
process by attaching to it with ptrace. 

If you're going to stick with something approximating unix, then you
can prevent tampering by making the program privileged (eg. by making
the program setuid). Having done that, you're in a much better
position to enforce policy. You can use netfilter to firewall out
connections to port 25 from your users, and to enable the privileged
user (ie. the uid used by your MTA during remote deliveries) to make
connections.

>2. A config file which contains connection rules for processes.
>Currently, there are  only two fields in a connection rule: <cmd path>
>and  <ip mask> e.g.
>    # <cmdpath>     <mask>
>    /home/stao/test1        192.168.2.2
>    /usr/bin/ftp    255.255.255.255
>
>where test1 can connect any port on local host 192.168.2.2 and ftp can
>connect to ports of any ip address.

Access control based on program filenames in unix is in the class of
problems where you "don't start from here." The mechanisms used by
unix for access control are almost entirely based on uids and gids,
and you are much better off working within this constraint. If you
don't, you may end up with code that's very hard to check for
correctness. 

Peter
