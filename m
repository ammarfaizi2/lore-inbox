Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSJZPFK>; Sat, 26 Oct 2002 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSJZPFK>; Sat, 26 Oct 2002 11:05:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57907 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262215AbSJZPFJ>; Sat, 26 Oct 2002 11:05:09 -0400
To: landley@trommello.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
References: <200210251557.55202.landley@trommello.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Oct 2002 09:09:25 -0600
In-Reply-To: <200210251557.55202.landley@trommello.org>
Message-ID: <m1adl1kziy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:

> I'm also looking for other things that can similarly be removed from
> this list and pushed for integration during the next stable series.
> Criteria for this: no API changes, and no impact on people who don't
> actually try to use the thing.
> 
> If people familiar with these features can suggest stuff that's
> deferrable, please let me know.  I've been trying very hard not to make
> judgement calls on these patches (not my job), but I'm certainly open
> to advice.

> 11) Kexec, luanch new linux kernel from Linux (Eric W. Biederman)
> 
> Announcement with links:
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html
> 
> And this thread is just too brazen not to include:
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/7952.html

sys_kexec introduces no new APIs to the rest of the kernel and is
fairly self contained.  Making it non intrusive enough that by that
criterion it may be deferred.

Currently the device driver support is lacking.  sys_kexec calls the
reboot notifier call chain, and device_shutdown to shut devices down
cleanly.  Due to a bug fix/cleanup that went into of 2.5.44
device_shutdown is neutered, and does nothing.  

So far with all of the review sys_kexec has gotten not one bug has
been found in it's core.  However actually using it is problematic.  
In the 2.5.44 kexec to 2.5.44 case quite a few devices cannot
reinitialize when the new kernel comes up.

The proof of concept of what sys_kexec can do is etherboot.
http://www.etherboot.org.  Etherboot contains real hardware drivers often
adapted from the linux kernel drivers.  It is quite possible to boot
DOS from etherboot, and I can quite definitely run all of setup.S.
However when I attempt this from sys_kexec in a number of significant
cases I cannot even reliably execute the BIOS calls in setup.S after
the kernel has run.  Though most of them can reliably be executed.

So the remaining work with sys_kexec is to track down why it is less
reliable than etherboot.  A few cases like being loaded from loadlin
and the BIOS interrupt table has hooks to code that is not longer
running is quite explainable.    The rest of the failures need more
investigation.

All of the hardware driver stabilization work for sys_kexec can be
postponed until after the feature freeze.  And on that note I plan
on removing the few driver fixes in my current patch and posting a
stripped down version later today.

Having sys_kexec in the kernel makes what I am doing more explainable,
and makes people think a little differently about device_shutdown, and
the reboot notifier call chain.  And with sys_kexec in the kernel
people mutating the internal kernel interfaces will be encouraged to
take sys_kexec into account.  

My point is that while the sys_kexec patch is not especially intrusive
in and of itself, I am fairly certain usage of it can be stabilized
easier in the kernel than outside of it.

Unless something comes up the plan for today is to incorporate the
very minor changes that have been suggested (Makefile, Config.in,
Config.help type), to split out the driver fixes I currently have
into separate patches, and post just a bare bones sys_kexec patch,
ready for inclusion in 2.5.

After the feature freeze I have on the todo list to look at porting
sys_kexec to the Itanium and Hammer.  As well as building debugging
tools, and in general debugging sys_kexec so it is generally useful.

Eric
