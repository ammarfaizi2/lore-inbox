Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUIVUQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUIVUQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUIVUQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:16:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:7314 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267164AbUIVUOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:14:23 -0400
Date: Wed, 22 Sep 2004 15:14:01 -0500
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org
Subject: Hotplug: crash in sys_clone()/do_fork()
Message-ID: <20040922201401.GA18954@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm tripping over a race condition involving file handling.  
I can consistently crash here:

TASK: c0000000fd6dc040[10448] 'ifdown' THREAD: c0000000f3310000
Call Trace: Sep 22 14:29:21 marulp1 kernel: [c0000000f3313b10] [c0000000000506c4] .copy_files+0x400/0x414 (unreliable)
[c0000000f3313bd0] [c00000000005161c] .copy_process+0x660/0x12bc
[c0000000f3313ce0] [c000000000052318] .do_fork+0xa0/0x25c
[c0000000f3313dc0] [c0000000000159c8] .sys_clone+0x5c/0x74
[c0000000f3313e30] [c000000000010a88] .ppc_clone+0x8/0xc

The problem seems to be that one of the file pointers is breifly
set to (int32)-1 even on a 64-bit machine.  The part of copy_process()
that gets mashed by this is:

   for (i = open_files; i != 0; i--) {
      struct file *f = *old_fds++;
      if (f)
         get_file(f);  <==  derefs f, which is -1
      *new_fds++ = f;
   }

By inserting if(f==(void*)0xffffffffUL) printk ...
I can find out that i=230 is the one with the problem and open_files=256!
I haven't yet found who set struct file * to a -1.

I'm generting this behaviour with a hotplug event that is causing ifdown 
and ifup to run simultaneously.  (The device driver was shut down and 
restarted, causing simultaneous hotplug events).  Although the above 
stack shows ifdown getting clobbered, I've also seen pci.agent be
the process that suffers.

The problem goes away if I insert a sleep of about half-a-second or more
between the device driver shutdown and startup.

Affected machine is a ppc64 power4 box.  I've seen the problem 
for a long time (months?), including monday's bk clone of 
bkbits of 2.6.9-rc2; waiting for this bug "to fix itself" doesn't 
seem to  be working.  

--linas

p.s. am I supposed to be using the OSDL bugzilla to report & track bugs
like this?
