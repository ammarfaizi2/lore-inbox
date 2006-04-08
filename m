Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWDHHmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWDHHmL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 03:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWDHHmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 03:42:11 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:40373
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1751396AbWDHHmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 03:42:10 -0400
Date: Sat, 8 Apr 2006 10:41:31 +0300
From: edwin@gurde.com
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net,
       sds@tycho.nsa.gov
Subject: Re: [RFC][PATCH 0/7] fireflier LSM for labeling sockets based on its creator (owner)
Message-ID: <20060408074131.GA5797@gurde.com>
References: <200604021240.21290.edwin@gurde.com> <1144249591.25790.56.camel@moss-spartans.epoch.ncsc.mil> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com> <20060407194545.GA15997@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407194545.GA15997@sorel.sous-sol.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 12:45:45PM -0700, Chris Wright wrote:
> 
> > Summary of how fireflier LSM works:
> > - each program is associated a sid, depending on its mountpoint+inode, i.e. 2 
> > processes launched from the same program have the same sid
> 
> That sounds like a problem.  Ptrace can undermine that really easily.
I forgot to mention, if a process gets ptraced, it is getting a different sid.
> Also bind mounts will give you a different sid for same exectuable, with
> a possible way to get into interesting 'group' situation.
I should use something else instead of the mountpoint to make sure inodes are unique.
Maybe I should use the device, instead of the mountpoint.
>  
> > - each socket created by a processis labeled with the process's sid
> > - if 2 or more programs have access to the socket, it is labeled with a "group 
> > sid". A group sid contains a list of the sids of programs having access
> > - userspace, or iptables module can match packets on this "fireflier context"
> 
> How do you keep from joining the group?
New processes aren't added to a group, instead a new group is created.
So if A, and B are in group 1; and C would have to be added, then a new group (2) is created, that
contains all what the previous contained (A,B), and the newly added sid (C)
When you create rules for group A, and B; any socket labeled with that group sid will be accessed only by A and B.

> what do you do about ptrace,
As stated above, ptracing means a new sid (I used the unsafe flag passed to certain function by the kernel, maybe I
should also implement the ptrace hook)
 /proc/[pid]/mem, 
Restricting access to /proc/[pid]/mem can be done properly by SELinux.
Is it worth to implement access restriction to /proc/self/mem in fireflier lsm?
If so, should I restrict access to it for all programs except the process itself?
> fd passing,
 I implemented the file_receive hook. Is there any other way to pass a fd? (besides fork+execve which is covered)
>  bind mounts,
using the device instead of mountpoint? But are devices named consistently between boots? what if somebody adds/removes
a harddisk/usb stick? will that change the device naming? 
> /proc/self/mem,
Why is this a security risk? Can a child process access the parent's data through /proc/self/mem?
> etc.
You made me curious, what other ways are there to gain access to the "data" and open files held by another process?
(Of course if somebody wants "full" security, he should use SELinux.)
> 
> > - how do I generate an SELinux policy, that does what this LSM module does?
> 
> Sounds like the best solution.
Yes, but writing such a policy will take time, that is why it is planned for version 2.1, or 2.2.
I will try to write a policy module generator userspace program, but I don't know how to create
"group labels". How do I label a socket, in such a way, that I'll be able to determine all the programs having access
to it? Can an inode have multiple labels (contexts)?

Having a fireflier lsm in 2.0 (although with reduced security compared to SELinux) is better than having no lsm at all.
FYI fireflier 1.x, and 1.99beta accepted a packet if the first (!) program found to have access to a socket was
 in its list of rules. (finding this was done searching /proc for an open socket having the proper inode, 
 determined from /proc/net/tcp|udp|tcp6|udp6)


Thanks in advance,
Edwin
