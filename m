Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267800AbUGWPkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267800AbUGWPkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUGWPkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:40:31 -0400
Received: from fmr06.intel.com ([134.134.136.7]:53634 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267800AbUGWPkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:40:21 -0400
Date: Fri, 23 Jul 2004 08:48:43 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux try 2.2
Message-ID: <0407230848.MbqdacIducKdwdzdmcQdXdcdPbadodqb17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

This is a new release of the code for providing a user and kernel
space synchronization infrastructure that provides real-time friendly
behavior, priority inversion protection (through serialized unlocks,
priority inheritance and protection), deadlock detection and
robustness [as in it doesn't fry when a mutex owner dies].

It builds upon the design of futexes and its usage model as NPTL does.

Please look at the first patch, containing the documentation for
information on how is it implemented. Kind of outdated, but useful
anyway. As well, the OLS 2004 paper is available on the web site.

High level changelog since release 2.2:

- Requeue-like support implemented for fuqueues and fulocks, to
speed up conditional variable broadcast.

- auto detection of the best unlock mode (based on an idea by
Jamie Lokier).

- Improve the taking of timeouts from user space by creating a
'struct timeout' that can take an absolute or relative
specification. POSIX uses absolute, so it is dumb to go to the
kernel twice, once to ask for the current time and then
compute a relative sleep and another one to do the actual
sleep.

- Added the ability to selectively compile out some parts of the
code via CONFIG_ options. Could add some more grain.

- Pages are no longer pinned while waiting.

- Fixed a big bunch of race conditions and bugs.

- priority lists are now fully O(140) ~= O(1) [except for
splice, which is still a hack that needs polishing].

Still to-do:

- Finally finish implementing priority protection; the core is
there, only the glue to use it is needed.

- Wipe out debug stuff

- Call fuqueue_waiter_cancel() into try_to_wake_up?

The patch is split in the following parts:


1/11: documentation files
2/11: priority based O(1) lists
3/11: kernel fuqueues
4/11: kernel fulocks
5/11: user space/kernel space tracker
6/11: user space fuqueues
7/11: user space fulocks
8/11: Arch-specific support
9/11: Modifications to the core: basic
10/11: Modifications to the core: struct timeout
11/11: Modifications to the core: scheduler

We have a site at http://developer.osdl.org/dev/robustmutexes
with references to all the releases, test code and NPTL
modifications (rtnptl) to use this code. As well, the patch
is there in a single file, in case you don't want to paste
them manually.


