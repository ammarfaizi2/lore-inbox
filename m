Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbQKGQB0>; Tue, 7 Nov 2000 11:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130543AbQKGQBP>; Tue, 7 Nov 2000 11:01:15 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:36946 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130024AbQKGQBE>; Tue, 7 Nov 2000 11:01:04 -0500
Date: Tue, 7 Nov 2000 10:01:02 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011071601.KAA328608@tomcat.admin.navo.hpc.mil>
To: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> Enough people have asked for persistent module storage to at least
> justify me writing the code.  The design is simple.
> 
> MODULE_PARM(var,type) currently defines type as [min[-max]]{b,h,i,l,s}.
> For persistent data support, type is now [min[-max]]{b,h,i,l,s}{p}, the
> trailing 'p' for persistent is optional.  Existing modutils only checks
> one character after [min[-max]] so this is backwards compatible, no
> need to upgrade modutils unless you want persistent data.
>
> insmod takes parameters from modules.conf, from the saved persistent
> data (see below) and from the command line, in that order.  The last
> value for a parameter takes precedence.
> 
> rmmod locates the object for the module using the __insmod_xxx_O ksyms
> entry.  If the object cannot be found or its timestamp has changed
> since it was loaded then rmmod silently skips the persistent data.
> Otherwise rmmod uses the .modinfo data in that object to determine the
> address and type of the persistent parameters.  Each persistent
> parameter is extracted from the module being unloaded, formatted as a
> module parameter (e.g.  "irq=17") and written to /somewhere/module_name
> which is a text file (vi is the ultimate configuration tool).

How about including the posibility for some binary data. If something
like devfs were to store permanent data, then it would likely contain
a list of security labels (rwx/owner/group/(future mac)). This could
be a sizable block to store in ascii (but hex might be reasonable).

Some of this data (resource allocation control) would have no reason
to exist on a boot command line, as well as being too large.

This would shift the "MODULE_PARM" definition to something like:
	MODULE_PARM(var,type,size)
where size is only used when the type would be binary.

This could hold a lot of data, as well as allow for parameters that
are configured in user space, but don't take effect until next device
load or boot (buffer size settings, kernel scheduling options, memory
resource controls...). An additional option would be an IOCTL (or something)
on the resource file to indicate a userspace update had been made (including
the parameter identifier) so that the appropriate driver/module could
be requested to perform an update. This would be most usefull for being
able to atomicly change kernel parameters (scheduling or resource controls).


> Almost all support is in user space.  The only kernel change is to add
> 'p' to the end of module parameters that are to be persistent.  Module
> variables that are to be persistent and are not currently module
> parameters need to be defined as MODULE_PARM().  The same kernel code
> should work on 2.2 and 2.4 kernels, it should even work with modutils
> 2.1.121.
> 
> I have not decided where to save the persistent module parameters.  It
> could be under /lib/modules/<version>/persist or it could be under
> /var/log or /var/run.  I am tending towards /var/run/module_persist, in
> any case it will be a modules.conf parameter.


-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
