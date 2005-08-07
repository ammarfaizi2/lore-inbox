Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVHGMtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVHGMtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 08:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVHGMtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 08:49:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9366 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751347AbVHGMtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 08:49:49 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@osdl.org,
       =?iso-8859-4?q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>,
       Zlatko Calusic <zlatko.calusic@iskon.hr>,
       =?iso-8859-1?q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@24x7linux.com>,
       Andrew Morton <akpm@osdl.org>, john@illhostit.com, sjordet@gmail.com,
       fastboot@lists.osdl.org, linux-kernel@24x7linux.com,
       ncunningham@cyclades.com, Greg KH <greg@kroah.com>
Subject: FYI: device_suspend(...) in kernel_power_off().
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
	<m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	<20050727224711.GA6671@elf.ucw.cz>
	<20050727155118.6d67d48e.akpm@osdl.org>
	<20050727225442.GD6529@elf.ucw.cz> <1123125850.948.9.camel@localhost>
	<20050804214520.GF1780@elf.ucw.cz>
	<1123193791.9025.77.camel@localhost>
 <m1ackah4r3.fsf@ebiederm.dsl.xmission.com>
	<20050725161548.274d3d67.akpm@osdl.org>	<dnpst4v5px.fsf@magla.zg.iskon.hr>
	<m1oe8o9stl.fsf@ebiederm.dsl.xmission.com>
	<dny87s6oe9.fsf@magla.zg.iskon.hr>
	<m1r7dk82a4.fsf@ebiederm.dsl.xmission.com>
	<42E8439E.9030103@ribosome.natur.cuni.cz>
	<20050727193911.2cb4df88.akpm@osdl.org>
	<42F121CD.5070903@ribosome.natur.cuni.cz>
	<20050803200514.3ddb8195.akpm@osdl.org>	<20050805140837.GA5556@localhost>
	<42F52AC5.1060109@ribosome.natur.cuni.cz>
 <m1hde2xy74.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 07 Aug 2005 06:48:40 -0600
In-Reply-To: <1123193791.9025.77.camel@localhost> (Nigel Cunningham's
 message of "Fri, 05 Aug 2005 08:16:31 +1000")
Message-ID: <m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Early in the 2.6.13 process my kexec related patches were introduced
into the reboot path, and under the rule you touch it you fix it
it I have been involved in tracking quite a few regressions
on the reboot path.

Recently with Benjamin Herrenschmidt's removal of
device_suppend(PMSG_SUPPEND) from kernel_power_off(),
it seems the last of the issues went away.  I asked
for confirmation that reintroducing the patch below 
would break systems and I received it.

The experimental evidence then is that calling 
device_suspend(PMSG_SUSPEND) in kernel_power_off
when performing an acpi_power_off is actively harmful.

There as been a fair amount of consensus that calling
device_suspend(...) in the reboot path was inappropriate now, because
the device suspend code was too immature.   With this latest
piece of evidence it seems to me that introducing device_suspend(...)
in kernel_power_off, kernel_halt, kernel_reboot, or kernel_kexec
can never be appropriate.  I am including as many people as
I can on this so we in our collective wisdom don't forget this
lesson.

What lead us to this situation was a real problem, and a desire
to fix it.  Currently linux has a proliferation of interfaces
to place devices in different states.  The reboot notifiers,
device_suspend(...), device_shutdown+system_state, remove_one,
module_exit, and probably a few I'm not aware of.  Each interface
introduced by a different author wanting to solve a different problem.
Just writing this list of interfaces is confusing.  The implementation
task for device driver writers appears even harder as simultaneously
implementing all of these interfaces correctly seems not to happen.

The lesson: fixing this problem is heavy lifting, and that
device_suspend() in the reboot path is not the answer.

Eric


This is the patch that subtly and mysterously broke things.
> diff --git a/kernel/sys.c b/kernel/sys.c
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -404,6 +404,7 @@ void kernel_halt(void)
>  {
>  	notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
>  	system_state = SYSTEM_HALT;
> +	device_suspend(PMSG_SUSPEND);
>  	device_shutdown();
>  	printk(KERN_EMERG "System halted.\n");
>  	machine_halt();
> @@ -414,6 +415,7 @@ void kernel_power_off(void)
>  {
>  	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
>  	system_state = SYSTEM_POWER_OFF;
> +	device_suspend(PMSG_SUSPEND);
>  	device_shutdown();
>  	printk(KERN_EMERG "Power down.\n");
>  	machine_power_off();
> 
> 






