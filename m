Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWCPWXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWCPWXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWCPWXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:23:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13472 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751066AbWCPWXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:23:19 -0500
Date: Thu, 16 Mar 2006 17:23:01 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Joshua Kugler <joshua.kugler@uaf.edu>
cc: linux-kernel@vger.kernel.org, sah@coraid.com
Subject: Re: OOM kiler/load problems with RAID/LVM and AoE
In-Reply-To: <200603131602.03886.joshua.kugler@uaf.edu>
Message-ID: <Pine.LNX.4.63.0603161635330.15712@cuia.boston.redhat.com>
References: <200603131602.03886.joshua.kugler@uaf.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Joshua Kugler wrote:

> RAID or LVM problem? AoE drivers?  Network driver badness (for both of them)?

You could simply be hitting a fundamental problem that's present
on most operating systems.  It happens roughly like this:

1) free memory gets low, so kswapd starts evicting pages
2) in order to write pages out over the network, the kernel
   needs to allocate memory to compose network packets,
   headers, etc...
3) if kswapd writes out a bunch of pages at once, or simply
   if memory was low to begin with when we hit (1), there
   may not be enough free memory left to receive the ACK
   packets from the NAS box that acknowledge that the data
   was received, nor the packets that indicate that the
   data was written to disk and the kernel can complete
   the IO

Locally attached disks do not have this problem because the
kernel keeps a number of reserved buffer heads around to get
us out of this deadlock problem.

Networking will need something similar.  Because this is
slowly turning into an FAQ, I've written down the problem
and a proposed solution:

	http://linux-mm.org/NetworkStorageDeadlock

-- 
All Rights Reversed
