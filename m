Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKNVCO>; Tue, 14 Nov 2000 16:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQKNVCG>; Tue, 14 Nov 2000 16:02:06 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:51123 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129097AbQKNVBv>; Tue, 14 Nov 2000 16:01:51 -0500
Date: Tue, 14 Nov 2000 12:31:41 -0800
From: "Adam J. Richter" <adam@freya.yggdrasil.com>
Message-Id: <200011142031.MAA07179@freya.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: Local root exploit with kmod and modutils > 2.1.121
Cc: linux-kernel@vger.kernel.org, vendor-sec@lst.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The only secure fix I can see is to add SAFEMODE=1 to modprobe's
>environment and change exec_modprobe.

	SAFEMODE may mean other things to other programs, so that
an ordinary user might set that environment variable for some
other reason, and then get weird behavior if he or she has occasion
to su to root.  In general, you only want to use environment variables
if either it is a user interface issue to keep the commands short
(not an issue here, since nobody is typing in the command that
requrest_module generates) or there is some well established
convention that will handled in a particular way by subordinate
child processes (e.g., PATH=....).

	It would be much better to just add a command line option
to modprobe that request_module() would cause it treat the following
argument as the module to load (you do not ever have to force
argument processing to stop at that point, since module will be
fully contained in the next argument, even if it contains space or
linefeed).

	Another possible approach would be to create a separate
/sbin/safe_modprobe.  modprobe already behaves differently
based on whether argv[0] ends in "modprobe", "insmod", "depmod",
or "rmmod".  So this would be in keeping with that convention.
It would also be trivial to retrofit old systems.  Just have
some system boot script do:

		echo /sbin/safe_modprobe > /proc/sys/kernel/modprobe

	The issue of the kernel doing request_module() on arbitrary
strings is not just a security problem.  It is also a namespace
collision problem, which this security concern will give us the
opportunity to fix.  I have just been glad that no company has
shipped a networking device called, say, "ext2".  The non-constant
module names that are loaded by request_module should have names like:

		fs-msdos
		fs-ext2
		netif-eth0
		netif-wvlan0
		etc.

	That way, a malicious user cannot cause a denial of service
by identifying one module with a loading bug (our kernels have 774 modules)
and doing, "ifconfig <modulename>".

	The extra work of doing the snprintf() into a buffer
before invoking request_module will resolve the buffer overrun
issues too.

	I would be happy to assist in coding this up.  The 50 lines of
text that I have written in this email probably only translate into
20 lines of code.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
