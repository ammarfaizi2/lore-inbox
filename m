Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030647AbWHIKQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030647AbWHIKQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030641AbWHIKQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:16:55 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:27614 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030642AbWHIKQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:16:28 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm 0/5] swsusp: Fix handling of highmem
Date: Wed, 9 Aug 2006 11:52:49 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608091152.49094.rjw@sisk.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently swsusp handles highmem in a simplistic way, by trying to store a
copy of each saveable highmem page in the "normal" memory before creating
the suspend image.  These copies are then copied once again before saving,
because they are treated as any other non-highmem pages with data.  For this
reason, to save one highmem page swsusp needs two free pages in the "normal"
memory, so on a system with high memory it is practically impossible to create
a suspend image above 400 kilobytes.  Moreover, if there's much more highmem
than the "normal" memory in the system, it may be impossible to suspend at all
due to the lack of space for saving non-freeable highmem pages.

This limitation may be overcome in a satisfactory way if swsusp does its best
to store the copies of saveable highmem pages in the highmem itself.  However,
for this purpose swsusp has to be taught to use pfns, or (struct page *)
pointers, instead of kernel virtual addresses to identify memory pages.
Yet, if this is to be implemented, we can also attack the minor problem that
the current swsusp's internal data structure, the list of page backup entries
(aka PBEs), is not very efficient as far as the memory usage is concerned.

This issue can be addressed by replacing the list of PBEs with a pair of
memory bitmaps.  Still, to remove the list of PBEs completely, we would
have to make some complicated modifications to the architecture-dependent
parts of the code which would be quite undesirable.  However, we can use
the observation that memory is only a limiting resource during the suspend
phase of the suspend-resume cycle, because during the resume phase
many image pages may be loaded directly to their "original" page frames, so
we don't need to keep a copy of each of them in the memory.  Thus the list of
PBEs may be used safely in the last part of the resume phase without limitting
the amount of memory we can use.

The following series of patches introduces the memory bitmap data structure,
makes swsusp use it to store its internal information and implements the
improved handling of saveable highmem pages.

Comments welcome.

Greetings,
Rafael

