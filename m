Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbUDPW2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbUDPWZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:25:41 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:38067 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263907AbUDPWYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:24:18 -0400
Date: Fri, 16 Apr 2004 18:24:16 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
cc: rusty@rustcorp.com.au
Subject: module_param() doesn't seem to work in 2.6.6-rc1
Message-ID: <Pine.LNX.4.58.0404161735560.5025@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I know that module_param is supposed to obsolete MODULE_PARM in 2.6
kernels.  However, module_param doesn't seem to work in Linux 2.6.6-rc1 (I
didn't test older kernels, so I don't know if it's a new bug).

I don't see any way to supply description with the new interface described
in moduleparam.h.  I see that some drivers (e.g. drivers/net/e100.c) use
MODULE_PARM_DESC together with module_param.  This seems wrong to me.
Shouldn't a new interface provide a new way to describe the parameters?

If MODULE_PARM or module_param is used without MODULE_PARM_DESC, modinfo
(module-init-tools version 3.0) fails to list the parameter.  It would be
great if the parameter was listed, even without description.

A bigger problem is that the new parameters cannot be used on the modprobe
command line.  I added this to orinoco.c:

static int parmtest1, parmtest2;
MODULE_PARM(parmtest1, "i");
module_param(parmtest2, int, 644);

After compiling and installing the module I tried this:

# modprobe orinoco parmtest1=1 parmtest2=2
FATAL: Error inserting orinoco
(/lib/modules/2.6.6-rc1/kernel/drivers/net/wireless/orinoco.ko): Unknown
symbol in module, or unknown parameter (see dmesg)

Kernel log shows:
orinoco: Unknown parameter `parmtest2'

Search for module_param in the Linux Documentation directory yielded
nothing.  I did notice, however, that the rate of adoption of module_param
is very low in the drivers directory.  Most drivers still use MODULE_PARM.
Isn't it because module_param is totally undocumented?

$ find drivers -name '*.c' | xargs grep '\<module_param\>' | wc -l
    244
$ find drivers -name '*.c' | xargs grep '\<MODULE_PARM\>' | wc -l
   1731

module_param is not mentioned in the sources of module-init-tools-3.0.  I
found this document that mentions "Optional viewing and control through
sysfs":

http://www.kernel.org/pub/linux/kernel/people/rusty/2.4_module_param_Forward_Compatibility_Macros.html

But even when I loaded the "orinoco" module without parameters.  I tried
this:

# find /sys | grep par
# find /sys | xargs grep -i par 2>/dev/null
#

Relevant settings from .config:

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

i686, non-SMP, Fedora Core 1.

-- 
Regards,
Pavel Roskin
