Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313469AbSDGUZv>; Sun, 7 Apr 2002 16:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313470AbSDGUZv>; Sun, 7 Apr 2002 16:25:51 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:62214 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S313469AbSDGUZu>; Sun, 7 Apr 2002 16:25:50 -0400
Date: Sun, 7 Apr 2002 23:23:40 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Levon <movement@marcelothewonderpenguin.com>,
        "Steven N. Hirsch" <shirsch@adelphia.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407232339.B10733@actcom.co.il>
In-Reply-To: <20020407225504.Z10733@actcom.co.il> <E16uJHZ-0006eO-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 09:29:01PM +0100, Alan Cox wrote:
> > hijacks syscall entries in the sys_call_table as well, because we
> > want it to work as a module and not require patching the kernel. Our
> > solution to the module unload race on syscall de-hijacking is simple,
> > splitting the system call hijacking code into a single small module
> > which once loaded cannot be unloaded.
> 
> So your small module can export a function called 
> 	patch_syscall(NR_foo, function);
> 
> Now you can put the arch specific syscall patching code into your small
> common module and its cleaner anyway ?

Right, this module (syscall_hijack.o) currently has the interface:

int hijack_syscall_before(int syscall_id, func_ptr func); 
int hijack_syscall_after(int syscall_id, func_ptr func); 

int release_syscall_before(int syscall_id);
int release_syscall_after(int syscall_id);

where 'before' and 'after' correspond to a hook which should run
before the original system call is invoked (allowing it to specify
that the original system call should not be executed) or after the
original system call is invoked (allowing it access to its return
value). 

We only support i386 (and uml) at the moment, because of the problems
with hijacking system calls on other architectures and because none of
us have access to other architectures to test the code on.

I recall reading in the archives that linus objected to modules
hijacking system calls on the grounds that it allows binary only
modules to completely subvert the way the kernel behaves towards
userspace. What if such a mechanism existed, however, and was only
exported to modules with a suitable license (modules which don't taint
the kernel). Would that be feasible?
-- 
The ill-formed Orange
Fails to satisfy the eye:       http://vipe.technion.ac.il/~mulix/
Segmentation fault.             http://syscalltrack.sf.net/
