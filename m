Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130344AbRBWCss>; Thu, 22 Feb 2001 21:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130291AbRBWCsi>; Thu, 22 Feb 2001 21:48:38 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:57609 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130233AbRBWCs0>; Thu, 22 Feb 2001 21:48:26 -0500
Message-ID: <3A95CF00.4C8A3EBE@sgi.com>
Date: Thu, 22 Feb 2001 18:46:24 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac18 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: odd memory corrupt problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a kernel driver that has a variable (surprise) 'audit_state'.  It's statically
initialized to 0 in the C code.  The only way it can get set on is if the audit modules
are loaded and one makes a system call to enable it.

There is no 'driver' initialization performed.

This code seemed to work in 2.2.17, but not in the 2.4.x series.

Somehow the 'audit_state' variable is being mysteriously set to '1' (which with the
driver not loaded causes less than perfect behavior.  

So I started sprinkling "if (audit_state) BUG();" in various places in the code.
It fails during the pcnet32 driver initialization (compiled in vs. module).  That
in turn calls pci init code which calls net driver code.  That calls 'core/'
register_netdevice, which finally ends up calling run_sbin_hotplug in net/core/dev.c.
That tries to load the program /sbin/hotplug via call_usermodehelper in kmod.c  
That 'schedules' the task and things are still ok, then it goes down on the process sem 
to wait until it has started.  The program it is trying to execute "hotplug" which
doesn't exist on my machine...ok, fine (the network interface seems to function just
fine).  The program doesn't exist, but when it gets back from the down(&sem), the
value of "audit_state" has changed to 1.  

Any ideas why?  Not that I'm whining, but a good debugger with a 'watch' capability
would do wonders at this point.  I'm trying to figure out code that has nothing to
do with my driver -- just happens to be randomly stomping on a key variable.  

I suppose something could be stomping on the checks to see if the module is loaded
and something is randomly calling the system call to turn it on, but that seems like
a less likely path.  Note that the system hasn't even gotten up to the point of calling
the 'boot' script yet.

I get the same behavior in 2.4.0, 2.4.1 and 2.4.2 (was hoping some memory corruption
bug got fixed along the way).  

Meanwhile, guess it's on to more debugging linux style -- insert printk's.  How
quaint.

Linda
-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
p
