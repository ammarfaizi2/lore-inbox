Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUJ0GgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUJ0GgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbUJ0Gds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:33:48 -0400
Received: from [211.58.254.17] ([211.58.254.17]:51420 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262256AbUJ0GcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:32:14 -0400
Date: Wed, 27 Oct 2004 15:32:04 +0900
From: Tejun Heo <tj@home-tj.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Per-device parameter new interface and issues to be resolved
Message-ID: <20041027063204.GA11887@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

 I've made some changes to devparam.

 1. dev_paramset and aux_paramsets are merged.  So, there are now only
two categories of paramesets bus paramsets and dev paramsets.  Because
bus paramset is used before a driver's probe() function is invoked and
there's no function call to pass bus paramset, merging bus paramset
into dev paramsets wouldn't work very well.  This merging also
simplified devparam implementation a bit.

 2. There's no need to explicitly initialize/release setdefs anymore;
therefore, devparam_bus_init/release(), devparam_setdef_init/release()
aren't needed anymore.

 3. devparm related fields in struct bus_type, device and
device_driver are renamed.  They're simpler now.

 4. sysfs directory "params" renamed to "parameters"

 The updated document and dptest modules are available at the
following URLs.

 http://home-tj.org/devparam/devparam.txt
 http://home-tj.org/devparam/dptest.tar.gz

 And here are my opinions about issues to be resolved.  Mostly they
are repeatitions from my previous mails but I tried to add some more
support for my opinions. :-) As soon as the following issues are
resolved in one way or the other, I'll post the updated patches.

 1. vector

 I've grepped kernel source and found a few constants which can be
removed if converted to use vector.  The first one is ACPI_MAX_HANDLES
defined and used in include/acpi/acpi_bus.h.  The second one is
USB_MAXINTERFACES in include/linux/usb.h and the last one
CONFIG_DLCI_MAX in drivers/net/wan/sdla.c.

 Constructor/destructor and expanding/shrinking in the middle can be
chopped out if the current implementation of vector is too chunky, but
devparam implementation needs some form of dynamically expandable data
structure which can be indexed and hard coding it into devparam
doesn't look very attractive.  And dynamically expandable vectors are
useful, really!

 2. module_param_*_ranged() stuff

 I've looked at a number of places where module param is used, and
most parameters need range checking.  Only a few parameters actually
accept full range of the designated type.  For example, maxbatch in
kernel/rcupdate.c is currently of type int but values smaller than 1
doesn't make much sense.  All ports array parameter in
net/ipv4/netfilter/*.c should be in the range of 0-65535 and most
device driver parameters need range-checking too.  I think
incorporating range into moduleparam can reduce duplicate codes and
improve consistency regarding handling of out-of-range parameters.

 Yes, the number of functions in module/devparam is increased but
they're straightforward and it's not like actual code is bloated.

 3. In array parameters, discarding the number of set array elements
instead of using param_array's max field to store it when nump isn't
supplied.

 I think that it's fair and clear to require the user to supply nump
field to param_array() when the number of set array element matters
either to the driver or the user space reading the value off sysfs
node.  If nump is there, number of set elements is recorded and thus
reflected in the sysfs node.  If nump is NULL, number of set element
isn't recorded and sysfs node just shows all the elements.

 Also, it's impossible to maintain the same semantics in devparam.
Wrapping arguments are transient in devparam and cannot carry/maintain
any dynamic information.

 4. param_array/arr()

 I also think using NULL is fine.  But the problem is that currently
there's no way to specify NULL in the same field in
DEVICE_PARAM_ARRAY().  I think it's better to maintain interface
consistency between moduleparam and devparam than to be more compact
in moduleparam.

 Except for param_array/arr(), currently the only difference in
interface is module_param_string() and
DEVICE_PARAM_STRING_NAMED()/DEVICE_PARAM_STRING().  I think
module_param_array() is a bit weird in that it differs from all other
module_param_*() macros, but they can be coerced either way, either
moduleparam or devparam part can be changed.

 Also, if it's decided that the number of set array elements is thrown
away, the different macros should make the distinction clearer.

 Thanks.

-- 
tejun
