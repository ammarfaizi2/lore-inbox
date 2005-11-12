Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVKLU1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVKLU1L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVKLU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:27:10 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:55955 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964777AbVKLU1I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:27:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFT][PATCH 0/3] swsusp: improve freeing of memory
Date: Sat, 12 Nov 2005 21:13:21 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511122113.22177.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently swsusp frees as much memory as possible during suspend.  This slows
down the suspend and causes the system to be slow after resume due to
the swapping-in activity.  The following series of patches is designed to
change this behavior so that swsusp will free only as much memory as necessary
to complete the suspend.

The essential changes are in the last patch.  However, to make it work
properly on x86-64 it is necessary to get rid of the suspend image size limit
imposed by the size of the swsusp_info structure.  Of course this can be done
in many different ways, but I think it is reasonable to do this in a way which
will allow us to further separate the image-handling and swap-handling
functionalities of swsusp in the future.  Thus I propose to introduce a
separate data structure for handling the swap and to remove the swap-related
fields from the PBEs, which is done in the second patch.

The proposed approach yields some additional benefits, like the following:
1) the amount memory needed to store the list of PBEs (aka pagedir) is
reduced by 1/4,
2) the amount of swap needed to store the image metadata is reduced by 1/2,
3) there's more memory available during suspend (the data structure used
for keepeng track of the data pages written to the swap need not be loaded
into memory during suspend),
4) the size of swsusp_info structure is reduced so it can be merged with the
swsusp_header structure in the future,
5) the swap-handling part need not use any global variables related to the
snapshot data structure,
6) the use of __nosavedata variables is reduced significantly.

The first patch removes the image encryption from swsusp so that
the second patch can be simpler.  Encryption is only used in swsusp instead
of zeroing the image after resume in order to prevent someone from
reading some confidential data from it in the future and it does not protect
the image from being read by an unauthorized person before resume.
In principle the encryption code need not be removed to make the other
changes, but then it would have to be modified and tested.  Moreover,
the functionality it provides should really belong to the user space,
so we (ie. Pavel and me) decided to remove it for now and possibly
reimplement it after the swap-handling functionality of swsusp is
moved to the user space.

The changes made by the patches are substantial, so they have to be
tested thoroughly before they can be merged.  If you can, please test them
and tell me what are your opinions.  I will very much appreciate any
feedback, negative as well as positive.

The patches are against 2.6.14-mm2.  They have been tested on x86-64
and compile tested on i386.  The previous iteration of the patches was
also stress-tested by Pavel on i386.

Greetings,
Rafael

