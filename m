Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWGYTiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWGYTiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWGYTiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:38:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:59009 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751491AbWGYTis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:38:48 -0400
Message-ID: <44C12740.1040203@slaphack.com>
Date: Fri, 21 Jul 2006 14:13:04 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060530)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: reiserfs-list@namesys.com, LKML <linux-kernel@vger.kernel.org>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>
Subject: Re: reiser4 status (correction)
References: <44BFFCB1.4020009@namesys.com> <44C043B5.3070501@slaphack.com> <44C093D2.1040703@namesys.com>
In-Reply-To: <44C093D2.1040703@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> I am not sure that putting the repacker after fsync is the right choice....

Does the repacker use fsync?  I wouldn't expect it to.

Does fsync benefit from a properly packed FS?  Probably.

Also, while I don't expect anyone else to be so bold, there is a way 
around fsync performance:  Disable it.  Patch the kernel so that any 
fsync call from userspace gets ignored, but lie and tell them it worked. 
  Basically:

  asmlinkage long sys_fsync(unsigned int fd)
  {
-       return do_fsync(fd, 0);
+       return 0;       // do_fsync(fd, 0);
  }

In order to make this sane, you should have backups and an Uninterrupted 
Power Supply.  In the case of a loss of power, the box should notice and 
immediately sync, then either shut down or software suspend.  Any UPS 
battery should be able to handle the amount of time it takes to shut the 
system off.

Since anything mission critical should have backups and a UPS anyway, 
the only problem left is what happens if the system crashes.  But system 
crashes are something you have to plan for anyway.  Disks fail -- stuff 
happens.  RAID won't save you -- the RAID controller itself will 
eventually fail.

So suppose you're running some very critical server -- for now, chances 
are it's running some sort of database.  In this case, what you really 
want is database replication.  Have at least two servers up and running, 
and consider the transaction complete not when it hits the disk, but 
when all running servers acknowledge the transaction.  The RAM of two 
boxes should be safer than the disk of one.

What about a repacker?  The best I can do to hack around that is to 
restore the whole box from backup every now and then, but this requires 
the box to be down for awhile -- it's a repacker, but not an online one. 
  In this case, the solution would be to have the same two servers 
(replicating databases), and bring first one down, and then the other.

That would make me much more nervous than disabling fsync, though, 
because now you only have the one server running, and if it goes down... 
  And depending on the size of the data in question, this may not be 
feasable.  It seems entirely possible that in some setups like this, the 
only backup you'd be able to afford would be in the form of replication.

In my own personal case, I'd prefer the repacker to tuning fsync.  But 
arguments could be made for both.
