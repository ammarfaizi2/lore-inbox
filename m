Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132798AbRDIQve>; Mon, 9 Apr 2001 12:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132799AbRDIQvP>; Mon, 9 Apr 2001 12:51:15 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:65028 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132798AbRDIQvG>;
	Mon, 9 Apr 2001 12:51:06 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wade Hampton <whampton@staffnet.com>
Date: Mon, 9 Apr 2001 18:50:08 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.3, VMWare, 2 VMs
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <47CA75C62D7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Apr 01 at 12:03, Wade Hampton wrote:

> Is anyone having problems with running more than
> 1 VM on 2.4.3.  I have crashed my host O/S several
> times when I try to start two VMs.  Currently,
> I don't have an oops or other info to report, but
> I did see a post on the vmware list about 2.4.3 SMP
> and VMWARE.

As I already answered on VMware newsgroups:

VMware's 2.0.3 vmmon module uses save_flags() + cli()
in poll() fops, and after this cli() it calls
spin_lock() :-( It is not safest thing to do.
But it should not cause reboot. You should get

/dev/vmmon: 11 wait for global VM lock XX

and now dead machine with disabled interrupts...

As all other callers of HostIF_GlobalVMLock() hold
big kernel lock, easiest thing to do is to add
lock_kernel()/unlock_kernel() around LinuxDriver_Poll()
body.

Removing whole save_flags/cli is for sure much better,
but it is still in my queue (if you are looking into vmmon
driver, then whole poll mess is there to get wakeup on 
next jiffy, and not on next + one...).
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
