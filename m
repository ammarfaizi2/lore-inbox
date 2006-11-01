Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946205AbWKAAJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946205AbWKAAJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946215AbWKAAJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:09:09 -0500
Received: from md2.t-2.net ([84.255.209.71]:62535 "EHLO md2.t-2.net")
	by vger.kernel.org with ESMTP id S1946205AbWKAAJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:09:08 -0500
Subject: RELAY_RESERVED and LTT for linux-2.6.17.4
From: Samo Pogacnik <samo_pogacnik@t-2.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 01 Nov 2006 01:19:06 +0100
Message-Id: <1162340347.3481.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Junkmail-Status: score=10/50, host=md2.t-2.net
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090202.4547E54D.0006,ss=1,fgs=0,
	ip=84.255.254.67,
	so=2006-03-30 10:46:40,
	dmn=5.2.121/2006-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This version of the LTT and RELAY patchset for linux-2.6.17.4, adds a
new functionality to the kernel relay support. Being named
RELAY_RESERVED, it provides the ability to relay kernel buffers to
userspace after tracing was stopped or after new kernel has been
initialized (if the content of the reserved memory could be preserved
over the new boot - kexec is one possiblity). The RELAY_RESERVED feature
does not depend on this LTT demonstration and could be used for
different relay purposes. 
Changes were made within ltt tools to correctly dump and parse traces
which were produced while tracing has not been running.

Links to patches and tools:
RELAY_RESERVED kernel patch URL:
           http://84.255.254.67/relayr-linux-2.6.17.4.patch
Partial LTT patch URL (just LTT changes because of RELAY_RESERVED):
           http://84.255.254.67/relayr-ltt-linux-2.6.17.4.patch
Cumulative kernel patch URL (complete LTT and RELAY_RESERVED): 
           http://84.255.254.67/ltt-relayr-linux-2.6.17.4.patch
Tools URL: http://84.255.254.67/ltt-0.9.6-pre7.tar.gz


This LTT using RELAY_RESERVED has been tested using one MEG of system
RAM for the reserved memory area and using kexec to start new kernel
initialization during LTT flight recording mode. 

Further work needs to be done to restore traces after kexec on SMP
machines (which i don't have), because crash kernels usually do not run
with all processors enabled (have to store number of processors
somewhere).


Main characteristics of RELAY_RESERVED:
---------------------------------------
- Enabled via kernel configuration option (RELAY_RESERVED, depends on
RELAY).

- Memory for one relay channel and its buffers gets reserved during boot
via boot command option (relayres), the same way as memory for kexec's
crash kernel.

- As indicated in previous item, only one relay user creating one relay
channel may use reserved relay memory. This does not prevent others to
use normal relay support concurently.

- This implementation minimally interferes with original relay code,
sice it only adds parallel functions to the existing ones. The only
place where original code gets changed, if the RELAY_RESERVED option has
been included in kernel configuration, is the __relay_reset() function
(additional if clause).

- Only memory of the target system that is usable directly as its
virtual address acquired through ioremap() call (for example system RAM
or some extra static RAM), could be used for this feature.

- Currently one page size at the end of the reserved memory could be
used for private storage of the relay user (as demonstrated in LTT
patch).

- The relay channel structure and its buffers get allocated at the
beginning of the reserved area.

- The main difference of the relay reserved feature in comparison to the
normal relay functionality is, that the reserved structures do not get
freed (cleared/deleted), when they are not needed anymore.


LTT using RELAY_RESERVED:
-------------------------
- If RELAY_RESERVED option has been enabled, LTT automatically uses it
in flight recording mode as well as in normal mode. Currently only
filght recording data get properly restored (which imho is only needed).

- It is possible to store ltt-relay data after flight recording tracer
has been stopped. This gives the possibility to create TRACER_STOP
events or some other mechanism, which could help us catch explicite
situations.

- It is also possible to store ltt-relay data after the kexec started
new kernel. This could be used to get last sequence of events, which
lead to some unmanagable exception. If extra memory is available, which
preserves its data through SW/HW reset of the system, all reset
situations could be recorded. It is necessary that every kernel
initialization reserve the same memory area for proper restoration of
the relay channel and buffers (for example: relayres=1M@80M).

- Ltt-relay data get restored using the same tracedaemon command as for
normal flight recorder dump (tracedaemon -j foo.trace), also when tracer
is not active.

- The private area of the reserved memory has been used to store tracer
start info and could be used in the future to store definitions of
custom events. Flight recorder would benefit from this in a way, that
custom event definitions could not get overwritten in circular buffers
and still being able to be restored.


regards, Samo

p.s.
Bugs included. 

