Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWEILJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWEILJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWEILJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:09:05 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:13239
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751760AbWEILJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:09:04 -0400
Date: Tue, 9 May 2006 12:05:05 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>,
       Bob Picco <bob.picco@hp.com>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 0/3] Zone boundry alignment fixes
Message-ID: <exportbomb.1147172704@pinky>
References: <445DF3AB.9000009@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <445DF3AB.9000009@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  Finally got my test bed working and got this lot tested.

To summarise the problem , the buddy allocator currently requires
that the boundries between zones occur at MAX_ORDER boundries.
The specific case where we were tripping up on this was in x86 with
NUMA enabled.  There we try to ensure that each node's stuct pages
are in node local memory, in order to allow them to be virtually
mapped we have to reduce the size of ZONE_NORMAL.  Here we are
rounding the remap space up to a large page size to allow large
page TLB entries to be used.  However, these are smaller than
MAX_ORDER.  This can lead to bad buddy merges.  With VM_DEBUG enabled
we detect the attempts to merge across this boundry and panic.

We have two basic options we can either apply the appropriate
alignment when we make make the NUMA remap space, or we can 'fix'
the assumption in the buddy allocator.  The fix for the buddy
allocator involves adding conditionals to the free fast path and
so it seems reasonable to at least favor realigning the remap space.

Following this email are 3 patches:

zone-init-check-and-report-unaligned-zone-boundries -- introduces
  a zone alignement helper, and uses it to add a check to zone
  initialisation for unaligned zone boundries,

x86-align-highmem-zone-boundries-with-NUMA -- uses the zone alignment
  helper to align the end of ZONE_NORMAL after the remap space has
  been reserved, and

zone-allow-unaligned-zone-boundries -- modifies the buddy allocator
  so that we can allow unaligned zone boundries.  A new configuration
  option is added to enable this functionality.

The first two are the fixes for alignement in x86, these fix the
panics thrown when VM_DEBUG is enabled.

The last is a patch to support unaligned zone boundries.  As this
(re)introduces a zone check into the free hot path it seems
reasonable to only enable this should it be needed; for example
we never need this if we have a single zone.  I have tested the
failing system with this patch enabled and it also fixes the panic.
I am inclined to suggest that it be included as it very clearly
documents the alignment requirements for the buddy allocator.

Comments.

-apw
