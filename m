Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWDGS6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWDGS6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWDGS6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:58:12 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:38290
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964886AbWDGS6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:58:10 -0400
Message-ID: <42865.86.125.51.175.1144436283.squirrel@www.gurde.com>
In-Reply-To: <E1FRTVC-0000i5-PH@be1.lrz>
References: <5X7nH-7n6-7@gated-at.bofh.it> <E1FRTVC-0000i5-PH@be1.lrz>
Date: Fri, 7 Apr 2006 11:58:03 -0700 (PDT)
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
From: edwin@gurde.com
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32189 501] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: /usr/local/cpanel/3rdparty/bin/php
X-Source-Args: /usr/local/cpanel/3rdparty/bin/php /usr/local/cpanel/base/3rdparty/squirrelmail/src/compose.php 
X-Source-Dir: :/base/3rdparty/squirrelmail/src
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had a very simple idea for doing something like this:
Your idea is interesting. Unfortunately it is not directly applicable, and
is more a "hack", than a solution.
>
> Assign a special semantic to GID $n: Being in group $n allows you to
> listen
> on port $n-$offset. $offset == -1 disables this feature (default).
Modifying gids is not a good idea, the sysadmin might need it for other
purposes.
> If I'd want it to work with iptables, I'd extend the socket struct to
> contain
> the device:inode of the corresponding application (not changing it on
> exec)
and that would require recompiling the kernel
> and stat() the allowed applications on rule setups.
>
> I'd deliberately allow access to these sockets if it's passed to other
> applications since it's the intended behaviour.
It might be intended behaviour, or it might be a file descriptor leak.
If I have a rule in iptables saying to allow only apache (just an example)
access to port 80, I don't want any other program to have access to it.
If apache might leak a file descriptor (it doesn't, just an example), and
give access to other programs, the firewall would restrict those programs.
If I would implicitly trust them, then fireflier rules wouldn't be any
better, than just creating rules to allow any program to listen on port
80.

> (BTW: Your approach isn't
> going to be 100 % reliable, since it will allow other processes to
> illegaly
> receive data if the socket is transfered after filtering, isn't it?)
filtering is done on each packet, how could the socket be transfered
between the time the packet is filtered, and the time it is received by
the program?
A socket transfer can be done via execve, or IPC, both covered (I hope) by
the fireflier lsm.
>
> Downside of both approaches:
>  You'll have to guarantee stable dev:inode pairs.
This could be ensured from userspace, if it becomes an issue.
> NFS?
running a program via NFS, and giving access for it to the network? why
would I want that?
Anyway, if somebody wants that, we could determine the inode of the
program on nfs mount time. We could store the path+hash of the program to
be sure it is the same program.
>umount/mount?
Aren't inodes stored on the disk?
>  Workaround: suid helper setting/deleting the allowed-rule?
No need for suid though, fireflier-server runs as root.
>

Cheers,
Edwin
