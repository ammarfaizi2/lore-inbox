Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbQKGWbX>; Tue, 7 Nov 2000 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbQKGWbD>; Tue, 7 Nov 2000 17:31:03 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:41044 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129957AbQKGWac>; Tue, 7 Nov 2000 17:30:32 -0500
Date: Tue, 7 Nov 2000 16:30:22 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011072230.QAA304551@tomcat.admin.navo.hpc.mil>
To: kaos@ocs.com.au
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From: Keith Owens <kaos@ocs.com.au> 
> On Tue, 7 Nov 2000 10:01:02 -0600 (CST), 
> Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> wrote:
> >Keith Owens <kaos@ocs.com.au>:
> >> Enough people have asked for persistent module storage to at least
> >> justify me writing the code.  The design is simple.
> >> 
> >> MODULE_PARM(var,type) currently defines type as [min[-max]]{b,h,i,l,s}.
> >> For persistent data support, type is now [min[-max]]{b,h,i,l,s}{p}, the
> >
> >How about including the posibility for some binary data. If something
> >like devfs were to store permanent data, then it would likely contain
> >a list of security labels (rwx/owner/group/(future mac)). This could
> >be a sizable block to store in ascii (but hex might be reasonable).
> >
> >This would shift the "MODULE_PARM" definition to something like:
> >	MODULE_PARM(var,type,size)
> >where size is only used when the type would be binary.
> 
> #define MAX_PERSIST 100
> int mode[MAX_PERSIST];
> int owner[MAX_PERSIST];
> int group[MAX_PERSIST];
> MODULE_PARM(mode, "1-" __MODULE_STRING(MAX_PERSIST) "ip");
> MODULE_PARM(owner, "1-" __MODULE_STRING(MAX_PERSIST) "ip");
> MODULE_PARM(group, "1-" __MODULE_STRING(MAX_PERSIST) "ip");
> 
> Resulting data looks like this, trailing all zero values are removed.
> 
> mode=420,420,493
> owner=0,0,1
> group=0,0,2
> 
> No need for a separate size field.  Note that MODULE_PARM is built at
> compile time so all persistent data must have a fixed compile time
> size.

I'll buy that - but it does mean that if there are 300 items then it
will get LONG... but then, that can be handled. I was thinking of the
"parameter" to possibly being a full data structure that could be updated
in an atomic manner, with a minimum of overhead (no number conversions
in the kernel).

> Pure binary immediately runs into kernel version skew problems.  If the
> data in kernel 2.4.n is
>
> struct { int mode; int owner; int group; } persistent[MAX_PERSIST];
> 
> but kernel 2.4.n+1 has
> 
> struct { int mode; int owner; int group; long acl; } persistent[MAX_PERSIST];
> 
> Then saving binary data from kernel 2.4.n and loading it into 2.4.n+1
> or vice versa results in garbage because the structure format has
> changed.  Separating individual fields and treating them as text has no
> such problem.  I have already decided that persistent data will not be
> passed to insmod on the command line, instead insmod will read directly
> from the saved data file, that removes any worries about command line
> limitations.

The identification of data version should be left up to the userspace
utility that retrieves the data. That way different versions wouldn't have
a skew. If the utility used a file format like "ar", then the access key
could contain the kernel version, the module, and the parameter. If not the
kernel version, then the module version - with the kernel version represented
by a file identifier (/var/persist/`uname -r` ?).

> >This could hold a lot of data, as well as allow for parameters that
> >are configured in user space, but don't take effect until next device
> >load or boot (buffer size settings, kernel scheduling options, memory
> >resource controls...).
> 
> If the values are implemented via modules then make them persistent.
> OTOH if they are implemented via code that is built into the kernel
> then insmod is far too late.

For some things, yes. I was thinking of things like automatically changing
the scheduling priorities for batch+interactive use. Also things like
fair-share scheduler parameters, resident set size/swap resource control,
(other large system capabilities, I admit).

The only large (data sized) thing I can think of right now would be
re-loading default sounds into a audio devices wave table. The other
things are closer to having only 20-30 values at a time.

> 
> >An additional option would be an IOCTL (or something)
> >on the resource file to indicate a userspace update had been made (including
> >the parameter identifier) so that the appropriate driver/module could
> >be requested to perform an update. This would be most usefull for being
> >able to atomicly change kernel parameters (scheduling or resource controls).
> 
> Now you are getting into the area of configuration utilities and the
> interface between such utilities and the kernel as a whole, not just
> modules.  That is a seperate problem and is best left to the
> configuration tools that already exist.  Module persistent data is
> intended for values in individual modules that the user changes daily
> or even hourly (volume, TV tuner), not for overall system control.

It looked to be closely related.

I know it wasn't considered, but batch schedulers may have their parameters
changed hourly. My site currently works with one that has parameters changed
to reflect available resources for future scheduling cycles that use updated
job priorities to determine how the system should respond.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
