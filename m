Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUG1Sic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUG1Sic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUG1Sic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:38:32 -0400
Received: from main.gmane.org ([80.91.224.249]:5290 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262006AbUG1Si2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:38:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alex Galakhov <agalakhov@ifmlrs.uran.ru>
Subject: hotplug/udev and SysV init
Date: Wed, 28 Jul 2004 23:23:25 +0600
Organization: Institute of Metal Physics
Message-ID: <ce8nel$aji$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 195.19.131.68
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello All,

While experimenting with the kernel I found that there  may be races
between /sbin/hotplug and initscripts (I can provide a lot of examples) if
handling cold-plugging. It happens if the initscripts assume the presence
of some device (it is very very hard to avoid such assumptions in a
production system, you know). The other problem is that we need initscript
to run "lost" hotplugs.

There was a patch somewhere (don't remember the topic, sorry) to
have /sbin/hotplug handle all the devices immediately after the kernel
starts (to avoid loss of hotplug events). Its problem was that it fires up
a lot of asynchronous /sbin/hotplugs while the kernel detects your network
cards, disks, mousepads, light bulbs and other hardware. Or, a standard
solution was, to have /etc/init.d/hotplug (and maybe udev) that does all
the job (which has problems as well).

IMHO, the problem is that if /sbin/hotplug is not "ready" (for any reason,
but we assume it may be not ready before something special happens in
system initialization, i.e., some fs is mounted), the hotplug event is
lost. From the other side, assuming that /sbin/hotplug is always "ready"
doesn't seem to be a good idea. It is known that forking a lot of hotplugs
is not good. Serializing helps but is unacceptable in kernel (but
acceptable in initscripts).

Thus, a possible solution is to have the kernel to remember all the hotplug
events that happen at the system boot (before the hotplug subsystem becomes
"ready") and replay the events journal in initscripts. After the journal is
replayed, hotplug continues in usual way. Assume that:
1. If /proc/sys/kernel/hotplug is not set (empty string), the kernel records
the journal of hotplug events. After an 
'echo "/sbin/hotplug" > /proc/sys/kernel/hotplug' (or any other modifying
of /proc/... file) the recording is stopped. (To disable hotplug, use
'/bin/false' or '/bin/true' instead of '/sbin/hotplug').
2. The journal may be read (and deleted) through /proc or /sys.
3. The initscript reads the journal, calls /sbin/hotplug multiple times
(probably serial, no forking), waits for forked hotplugs (if any), flushes
the events journal and then does an echo to /proc/sys/kernel/hotplug.
4. At this point, it is guaranteed that all the coldplug events are
processed and all coldplug devices are initialized. Everything else is
"true" hotplug.

IMHO, this approach solves many problems and should not produce any problems
by itself. What do you think about it?

Regards,
Alex
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBB+EUaA+H7vY+1kURAtweAJ9E/A5i/16xK39nEGfe9PZdGnXLPgCgjV1p
gOdorOVEXr6BeEJ60b7ieS0=
=MKdb
-----END PGP SIGNATURE-----

