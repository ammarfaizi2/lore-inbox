Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTEaBUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 21:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTEaBUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 21:20:43 -0400
Received: from almesberger.net ([63.105.73.239]:21267 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264105AbTEaBUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 21:20:39 -0400
Date: Fri, 30 May 2003 22:33:55 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Carl Spalletta <cspalletta@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cute kernel trick, or communistic ploy?
Message-ID: <20030530223355.A3639@almesberger.net>
References: <20030530231231.64427.qmail@web41501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530231231.64427.qmail@web41501.mail.yahoo.com>; from cspalletta@yahoo.com on Fri, May 30, 2003 at 04:12:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl Spalletta wrote:
>   This program works fine in the um arch but I was wondering what
> the pitfalls are in an approach like this.

You mean calling functions from a debugger ? By and large, this
should be okay. I'm doing it all the time in umlsim :-)

You have to make sure you're really allowed to call these functions
from the point where you've stopped the kernel, i.e.

 - that they don't change data structures protected by a common
   spinlock (which may be absent on UP)
 - that they don't sleep

Besides that, you may run into problems if gdb doesn't understand
the calling convention. So far, I haven't found a case where this
happens. (But then, I'm working directly from the DWARF2 data, so
I wouldn't notice bugs in gdb, only wrong or incomplete debugging
information. And I haven't tried FASTCALL functions yet.)

Also, you probably can't call inline functions from gdb. You can
probably work around this by adding a file somewhere to the kernel
that includes all the headers with inline functions you want, and
then compile it with -fkeep-inline-functions -Wno-unused-function.
Depending on what you include, you may also need to

void __this_fixmap_does_not_exist(void)
{
        panic("__this_fixmap_does_not_exist called\n");
}

Oh, and when you explore further, be warned that accessing local
variables can be messy, particularly when inline functions are
involved.

I ran your example with umlsim. Here's what it looks like:

#define GFP_ATOMIC 0x20
$uml = $run_uml("A","no-such-script",1);
$page = (char *) kmalloc(4096,GFP_ATOMIC);
$start = (char **) kmalloc(4,GFP_ATOMIC);
$eof = (int *) kmalloc(4,GFP_ATOMIC);
$data = kmalloc(1,GFP_ATOMIC);
uptime_read_proc($page,$start,0,0,$eof,$data);
kfree((void *) $eof);
kfree((void *) $start);
kfree((void *) $data);
printk(*$start);
kfree((void *) $page);

(I shouldn't need to kmalloc $data or the casts in kfree.
Two more things to fix ...)

If you don't like the printk, umlsim could also copy the
data to the simulator and print it from there, but the
syntax is a bit ugly:

print (char ["umlsim_inline.c".strlen(*$start)+1]) *$start;

By the way, it may also matter how you stop your process. I
normally use breakpoints (INT3), and things work fine. I'm
still experimenting with SIGSTOP.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
