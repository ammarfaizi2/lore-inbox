Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129722AbQKGVwE>; Tue, 7 Nov 2000 16:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129769AbQKGVvy>; Tue, 7 Nov 2000 16:51:54 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:35080 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129722AbQKGVvn>;
	Tue, 7 Nov 2000 16:51:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "Tue, 07 Nov 2000 10:01:02 MDT."
             <200011071601.KAA328608@tomcat.admin.navo.hpc.mil> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 08:51:37 +1100
Message-ID: <16457.973633897@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000 10:01:02 -0600 (CST), 
Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> wrote:
>Keith Owens <kaos@ocs.com.au>:
>> Enough people have asked for persistent module storage to at least
>> justify me writing the code.  The design is simple.
>> 
>> MODULE_PARM(var,type) currently defines type as [min[-max]]{b,h,i,l,s}.
>> For persistent data support, type is now [min[-max]]{b,h,i,l,s}{p}, the
>
>How about including the posibility for some binary data. If something
>like devfs were to store permanent data, then it would likely contain
>a list of security labels (rwx/owner/group/(future mac)). This could
>be a sizable block to store in ascii (but hex might be reasonable).
>
>This would shift the "MODULE_PARM" definition to something like:
>	MODULE_PARM(var,type,size)
>where size is only used when the type would be binary.

#define MAX_PERSIST 100
int mode[MAX_PERSIST];
int owner[MAX_PERSIST];
int group[MAX_PERSIST];
MODULE_PARM(mode, "1-" __MODULE_STRING(MAX_PERSIST) "ip");
MODULE_PARM(owner, "1-" __MODULE_STRING(MAX_PERSIST) "ip");
MODULE_PARM(group, "1-" __MODULE_STRING(MAX_PERSIST) "ip");

Resulting data looks like this, trailing all zero values are removed.

mode=420,420,493
owner=0,0,1
group=0,0,2

No need for a separate size field.  Note that MODULE_PARM is built at
compile time so all persistent data must have a fixed compile time
size.

Pure binary immediately runs into kernel version skew problems.  If the
data in kernel 2.4.n is

struct { int mode; int owner; int group; } persistent[MAX_PERSIST];

but kernel 2.4.n+1 has

struct { int mode; int owner; int group; long acl; } persistent[MAX_PERSIST];

Then saving binary data from kernel 2.4.n and loading it into 2.4.n+1
or vice versa results in garbage because the structure format has
changed.  Separating individual fields and treating them as text has no
such problem.  I have already decided that persistent data will not be
passed to insmod on the command line, instead insmod will read directly
from the saved data file, that removes any worries about command line
limitations.

>This could hold a lot of data, as well as allow for parameters that
>are configured in user space, but don't take effect until next device
>load or boot (buffer size settings, kernel scheduling options, memory
>resource controls...).

If the values are implemented via modules then make them persistent.
OTOH if they are implemented via code that is built into the kernel
then insmod is far too late.

>An additional option would be an IOCTL (or something)
>on the resource file to indicate a userspace update had been made (including
>the parameter identifier) so that the appropriate driver/module could
>be requested to perform an update. This would be most usefull for being
>able to atomicly change kernel parameters (scheduling or resource controls).

Now you are getting into the area of configuration utilities and the
interface between such utilities and the kernel as a whole, not just
modules.  That is a seperate problem and is best left to the
configuration tools that already exist.  Module persistent data is
intended for values in individual modules that the user changes daily
or even hourly (volume, TV tuner), not for overall system control.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
