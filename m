Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132596AbRDEJ7o>; Thu, 5 Apr 2001 05:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132592AbRDEJ7f>; Thu, 5 Apr 2001 05:59:35 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:52320 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S132587AbRDEJ7R>; Thu, 5 Apr 2001 05:59:17 -0400
Message-ID: <3ACC41C9.4BE4DD0A@stud.uni-saarland.de>
Date: Thu, 05 Apr 2001 09:58:33 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: f.v.heusden@ftr.nl
CC: linux-kernel@vger.kernel.org
Subject: RE: random PIDs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> M> IIRC get_pid will loop forever if it doesn't find a free pid, and in the 
> M> worst case you can trigger that with ~11000 running threads. 
> 
> Ah, ok. But why would you have 11.000 running threads? 

Denial of Service attack. 11000 processes and the kernel locks up hard,
regardless of the amount of memory.(sane ulimits prevent that)

> M> And the current code can create multiple threads with the same pid (I 
> M> never tried to trigger that bug, but it seems to be possible) 
>
> mine will do that too: 
> 
>         if (flags & CLONE_PID) 
>                 return current->pid; 
> 
CLONE_PID is a special flag for the boot process, normal processes can't
set that flag. (first line of do_fork() returns -EPERM)

Even without CLONE_PID two threads can get the same pid:
get_pid searches for a new pid by scanning though the task list.
But the caller of get_pid doesn't atomically add the new value to the
task list.
If copy_fs, copy_files, copy_mm sleep, then a second thread could get
the same pid.
It's only possible if nearly all pid values are used up, so it's not a
problem that must be fixed immediately.

--
	Manfred
