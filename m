Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWBISMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWBISMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWBISMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:12:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56748 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932523AbWBISMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:12:43 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
	<m1pslystkz.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 09 Feb 2006 11:11:56 -0700
In-Reply-To: <Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr> (Jan
 Engelhardt's message of "Thu, 9 Feb 2006 17:58:34 +0100 (MET)")
Message-ID: <m1r76c2yhf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>> On Linux, type pid_t is defined as an int if you look
>>> through all the intermediate definitions such as S32_T,
>>> etc. However, it wraps at 32767, the next value being 300.
>
> There is also an aesthetical reason. If pids were allowed to exceed, say, 
> ten million, you would need a quite wide field in `ps` for the process 
> number which is on "normal desktop user" systems just require 5 or 6 
> decimal places. Well, what I mean, just look at this sample ps output:
>
> 17:59 shanghai:../fs/proc # ps
>         PID TTY          TIME CMD
>           1 -        00:00:00 init [3]
>  4215914607 tty2     00:00:00 bash
>  4215914653 tty2     00:00:00 ps
>
> mingw/msys and cygwin already have this "cosmetic problem" since windows 
> "pids" are usually above one million.

Yes.  Although this I'm not I'm not certain how bad the cosmetic problem
is.  Certainly significant enough that we don't want to change a good
thing when we got it.  But if there were real problems a big pid
would solve I don't expect large pid numbers to stop us.

>>> I know the
>>> code "reserves" the first 300 pids.
>
> I cannot confirm that. When I start in "-b" mode and 'use' up all pids by 
> repeatedly executing /bin/noop, I someday get pids as low as 10 
> again, defined by how many kernel threads there are active before /bin/bash 
> started.

Odd.  When the search wraps it starts searching at 300.
Still there are no locks around last_pid.

>>I know for certain that proc assumes it can fit pid in
>>the upper bits of an ino_t taking the low 16bits for itself
>>so that may the entire reason for the limit.
>>
> inode number in /proc/XXX/fd creation currently is, IIRC
>   ino = (pid << 16) | fd
> which limits both pid to 16 bits and the fdtable to 16 bits. See 
> fs/proc/inode-alloc.txt. At best, procfs should start using 64bit inode 
> numbers.

Well it does use 64bit inode numbers but only on 64bit systems.
Internally /proc doesn't care about the inode it is only for keep find
and friends from getting confused.

Figuring out how to use find_inode_number would likely be interesting,
and a random inode allocation scheme would be interesting.

Eric

