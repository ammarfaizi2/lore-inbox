Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129471AbQKGEAl>; Mon, 6 Nov 2000 23:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQKGEAb>; Mon, 6 Nov 2000 23:00:31 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:44554 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129471AbQKGEAR>;
	Mon, 6 Nov 2000 23:00:17 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Persistent module storage - modutils design
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 15:00:11 +1100
Message-ID: <9980.973569611@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enough people have asked for persistent module storage to at least
justify me writing the code.  The design is simple.

MODULE_PARM(var,type) currently defines type as [min[-max]]{b,h,i,l,s}.
For persistent data support, type is now [min[-max]]{b,h,i,l,s}{p}, the
trailing 'p' for persistent is optional.  Existing modutils only checks
one character after [min[-max]] so this is backwards compatible, no
need to upgrade modutils unless you want persistent data.

insmod takes parameters from modules.conf, from the saved persistent
data (see below) and from the command line, in that order.  The last
value for a parameter takes precedence.

rmmod locates the object for the module using the __insmod_xxx_O ksyms
entry.  If the object cannot be found or its timestamp has changed
since it was loaded then rmmod silently skips the persistent data.
Otherwise rmmod uses the .modinfo data in that object to determine the
address and type of the persistent parameters.  Each persistent
parameter is extracted from the module being unloaded, formatted as a
module parameter (e.g.  "irq=17") and written to /somewhere/module_name
which is a text file (vi is the ultimate configuration tool).

Almost all support is in user space.  The only kernel change is to add
'p' to the end of module parameters that are to be persistent.  Module
variables that are to be persistent and are not currently module
parameters need to be defined as MODULE_PARM().  The same kernel code
should work on 2.2 and 2.4 kernels, it should even work with modutils
2.1.121.

I have not decided where to save the persistent module parameters.  It
could be under /lib/modules/<version>/persist or it could be under
/var/log or /var/run.  I am tending towards /var/run/module_persist, in
any case it will be a modules.conf parameter.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
