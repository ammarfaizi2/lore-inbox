Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSAUTZE>; Mon, 21 Jan 2002 14:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287933AbSAUTYy>; Mon, 21 Jan 2002 14:24:54 -0500
Received: from web13305.mail.yahoo.com ([216.136.175.41]:11533 "HELO
	web13305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287908AbSAUTYj>; Mon, 21 Jan 2002 14:24:39 -0500
Message-ID: <20020121192438.544.qmail@web13305.mail.yahoo.com>
Date: Mon, 21 Jan 2002 11:24:38 -0800 (PST)
From: Carl Spalletta <cspalletta@nectarsystems.com>
Subject: VM design: Linus' exec-argsize implies abolition of env_start?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I hate to stick my neck out, but here goes.
On Thu Sep 27 2001 at 10:34:29 EST, Linus Torvalds wrote:

> Re: exec-argsize-2_4_10-A3
...
> I'd actually much rather see the argument size limit go away _completely_, 
> and keep the arguments in the original VM instead of copying them over one 
> page at a time etc. 
...
> Leaving the data in the original VM and populating a _new_ VM has many 
> advantages: if you have both VM's on the mm_list, you can automatically 
> let the page-out logic handle the DoS case for you, and the pages aren't 
> pinned any more (you'd keep just _one_ page pinned in the new VM: the page 
>that you're currently copying into) 

But this implies that arg_start==env_start and arg_end==env_end (!)

WHY?
Because it follows from the concept that all userspace pages
containing any string in the argument or environment lists must be
preserved, lifted out, and reassigned to the new VM in the _same_
order as the original linear addresses.

WHY AGAIN?
Under the old way it does not matter that there is no guarantee of
ordering of the linear address pointers contained in *argv and *envp;
we are copying and can reorder the new locations at will.

However, consider the following:

OLD VM:
userspace:
     		        STARTS	 ENDS
any addr:	   arg1	page N	 page N	 
any addr:	   arg2 page M	 page M
any addr:	   arg3 page N	 page N+1

If we reassign pages to the new VM in the same order as they occur
in the args list, the vm_area containing arg_start..env_end+1 will
look like this:

NEW_VM:
vm_area struct:

pageX:		   omitted
...
page2:	  	   old page ?  // corresponds to arg 3
page1:	  	   old page M  // corresponds to arg 2
page0: 	  	   old page N  // corresponds to arg 1

Clearly under this scheme we have a problem when we try to access
arg3 since it spans two pages (N,N+1) and one of those has already been
assigned; and the linear address following page N has been preempted
as well.

If and only if we have reassigned all the old pages to the new VM in
the same order as their original linear addresses can we avoid this
problem, and at the same time avoid copying.

The same argument applies to mixing of environment strings and
args - there is no guarantee that they do not appear on the same
userspace page, that they are ordered relative to each other, or
that they do not span multiple pages.

Therefore I claim that to _avoid_ copying, we cannot maintain exclusive
intervals [arg_start..arg_end] and [env_start..env_end], and that they
must in fact be merged.

__
C. Spalletta
On irc.openprojects.net: aka KirthGersen, HowardAlanTreesong, et al.
_


__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
