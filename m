Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUH0VnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUH0VnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUH0VmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:42:16 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:33667 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268339AbUH0Vj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:39:57 -0400
Subject: [PATCH] interrupt driven hvc_console as vio device (final)
From: Ryan Arnold <rsa@us.ibm.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1093599644.3402.123.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 04:40:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here is the revised hvc_console patch which fixes the issues you were
concerned with in the previous patch.  Your two concerns were:

1. Yielding in hvc_close().  This was replaced with
tty_wait_until_sent() which seem to be built for this exact scenario.  I
also restructured hvc_close() to be more elegant and less confusing than
in the previous patch.

2. Spinlocks in hvc_chars_in_buffer() and hvc_write_room() which simply
protected values read from hvc_struct instances.  I removed the
spinlocks and didn't put in memory barriers because they really weren't
needed.

Paul MacKerras approved the architecture portions of the previous
incarnation of this patch and I have touched the arch code in this
revision.  Ben Herrenschmidt, who contributed a portion of the orignal
code this patch was based on has signed off on this patch.

Changelog:

This is an hvc_console patch which provides driver and ppc64
architecture fixes to enable the hvc_console driver to register itself
as a vio device with the vio bus, provide hotplug add/remove for vty
adapters, and act as an interrupt driven driver on Power-5 hardware or
remain as a polling driver on Power-4 hardware. 

arch/ppc64/kernel/hvconsole.c
-----------------------------------------------------------------------
-Changed hvc_get_chars() and hvc_put_chars() api to take vtermno rather
than index number.

-Added hvc_find_vtys() function which walks the bus looking for
vterm/vty devices to callback to the hvc_console driver.  This provides
console output functionality prior to early console init (pre mem init
and pre device probe).

include/asm-ppc64/hvconsole.h
-----------------------------------------------------------------------

-Changed hvc_get_chars() and hvc_put_chars() api to take vtermno rather
than index number.

-Added hvc_find_vtys() function.

-Added hvc_instantiate() function which is implemented by a console
driver wanting to receive a callback of and early console init.

drivers/char/hvc_console.c
-----------------------------------------------------------------------

-Switch khvcd from kernel_threads to kthreads which got rid of
deprecated daemonize().

-Added module exit clause to be thorough (not terribly necessary with a
console driver of course)

-Added early discovery of vterm/vty adapters by doing a bus walk on
early console init which results in hvc_instantiate() callback and
addition of the vtermno into a static array of vtermnos supported as
console adapters (meaning the console api's work against these vtermnos
prior to full console initialization).

-This driver is now registered as a vio driver which means that vty
adapters are now managed via probe/remove.  This means hvc_console
supports hotplug vty adapters.

-Driver now requests more device nodes than what was found on the
initial bus walk when registered as a tty driver to make room for
hotplug vty adapters.  These secondary vty adapters provide a tty tunnel
between partitions.

-Removed static hvc_struct array and replaced with a linux list that has
elements (hvc_struct instances) added/removed on probe/remove AFTER
early console init.  This is important because kmalloc can't be done at
early console init.

-Driver now either runs in interrupt driven mode or in polling mode on
older hardware.  The khvcd is smart enough to not 'schedule()' when
there are no interrupts.

-kobjects are now used for ref counting on the hvc_struct instances.

-This driver puts the tty layer to sleep on hvc_close() if there are
pending data writes being blocked by firmware.

-Removed useless spinlocks in hvc_chars_in_buffer() and hvc_write_room.

Thanks,

Ryan S. Arnold
IBM Linux Technology Center

