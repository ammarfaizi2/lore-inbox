Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264924AbSKEV1H>; Tue, 5 Nov 2002 16:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSKEV1H>; Tue, 5 Nov 2002 16:27:07 -0500
Received: from codepoet.org ([166.70.99.138]:37592 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S264924AbSKEV1G>;
	Tue, 5 Nov 2002 16:27:06 -0500
Date: Tue, 5 Nov 2002 14:33:43 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021105213342.GA23168@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1118170000.1036458859@flay> <8$GqvaL1w-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8$GqvaL1w-B@khms.westfalen.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 05, 2002 at 09:57:00PM +0200, Kai Henningsen wrote:
> mbligh@aracnet.com (Martin J. Bligh)  wrote on 04.11.02 in <1118170000.1036458859@flay>:
> 
> > I had a very brief think about this at the weekend, seeing
> > if I could make a big melting pot /proc/psinfo file that did
> > seqfile and read everything out in one go, using seq_file
> > internally to interate over the tasklist. The most obvious
> > problem that sprung to mind seems to be the tasklist locking -
> > you obviously can't just hold a lock over the whole thing.
> 
> Well, one thing i to make certain you can actually do it with one or two  
> system calls. Say, one system call to figure out how big a buffer is  
> necessary (essentially, #tasks*size), then one read with a suitably-sized  
> buffer. Then have a loop in the kernel that drops the lock as often as  
> necessary, and otherwise puts it all in the buffer in one go. (If the  
> #tasks grows too fast so it overruns the buffer even with some slack given  
> in advance, tough, have a useful return code to indicate that and let ps  
> retry.)
> 
> I briefly thought about mmap, but I don't think that actually buys  
> anything.

Once again, reminds me of my /dev/ps driver, which had the
following ioctls:

#define DEVPS_GET_NUM_PIDS     0xeba1 /* Get a list of all PIDs */ 
#define DEVPS_GET_PID_LIST     0xeba2 /* Get a list of all PIDs */ 
#define DEVPS_GET_PID_INFO     0xeba3 /* Get info about a specific PID */
#define DEVPS_GET_CURRENT_PID  0xeba4 /* Get the current PID */

So a user spave ps app would call DEVPS_GET_NUM_PIDS to find out
how many processes there are, then it would allocate some memory
(and would allocate a some extra just in case some new processes 
were to start up, the kernel would truncate things if we gave it
too little space) .  Then ps would grab the pid list by calling 
the DEVPS_GET_PID_LIST ioctl, and then for each item in the list
it would call DEVPS_GET_PID_INFO.  Assuming that call was
successful, ps would print out a line of output and move on to
the next pid in the list.

The idea need not be implemented without using ioctl and without
using binary structures (which were the things Linus objected to)

The same thing could be easily done using flat ascii...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
