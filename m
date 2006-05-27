Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWE0M7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWE0M7z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWE0M7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:59:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:29845 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751503AbWE0M7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:59:54 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 27 May 2006 14:58:57 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.16.18 0/4] sbp2: workaround for buggy iPods
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.b9bf60697156ef7b@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.88) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a firmware bug in several Apple iPods which prevents access to
these iPods under certain conditions. The disk size reported by the iPod
is one sector too big. Once access to the end of the disk is attempted,
the iPod becomes inaccessible. This problem has been known for USB iPods
for some time and has recently been discovered to exist with
FireWire/USB combo iPods too.

The following patchset is the fix as it exists in Linux 2.6.17-rc. Alas
it is rather large, therefore it may be unfit for -stable as it is. If
there are objections, I would appreciate suggestions how to better adapt
this fix for -stable.

The necessary workaround is added this way:

patch 1/4: sbp2: consolidate workarounds, part one
patch 2/4: sbp2: consolidate workarounds, part two
    Infrastructure for existing *unrelated* workarounds is refactored.
    This concerns (a) module load parameters to activate workarounds,
    (b) a hardwired blacklist of known buggy devices, (c) detection of
    known buggy devices, (d) activation of the various workarounds.
    Benefits of the refactoring are better readability, extensibility,
    and finer-grained control.
    This is a single patch in 2.6.17-rc; I split it into two due to its
    size (the essential part and a part affecting comments, log messages
    etc.).

patch 3/4: add read_capacity workaround for iPod
    Extends blacklist and device detection, and adds the actual
    workaround.

patch 4/4: sbp2: add ability to override hardwired blacklist
    As we add more workarounds, potential to adversely affect other
    devices increases. This patch adds a simple feature as a safety
    belt: A new flag for the module load parameter from patch 1/4
    tells sbp2 not to use its hardwired blacklist.

Combined diffstat of patches 1/4...4/4:
 Documentation/feature-removal-schedule.txt |    9 +
 drivers/ieee1394/sbp2.c                    |  206 +++++++++++++++++++----------
 drivers/ieee1394/sbp2.h                    |   18 +-
 3 files changed, 159 insertions(+), 74 deletions(-)

So this is much more than is usually acceptable for -stable. Keeping it
this big has the benefit of minimal deviation from 2.6.17+, concerning
the code as well as sbp2's module load parameters. As I said, I could
try to rework this for minimum patch size if so desired by the -stable
team. But I suppose I would still end up with a rather big patch.

The impact of leaving this iPod workaround out of -stable is limited
because there are a few alternatives:
 - Experienced users of affected hardware may compile 2.6.16 and older
   without support for EFI GUID partition tables. This should make
   access to the end of the disk rather unlikely.
 - Experienced users of affected hardware may switch to 2.6.17+.
 - Experienced users or distributors may apply this patchset or a more
   extensive patchset for the 1394 subsystem on their own. (I am
   maintaining a bunch of rediffs of current 1394 patches for released
   kernels.)
-- 
Stefan Richter
-=====-=-==- -=-= ==-==
http://arcgraph.de/sr/

