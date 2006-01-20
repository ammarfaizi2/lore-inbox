Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWATUBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWATUBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWATUBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:01:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:25307 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932076AbWATUBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:01:31 -0500
Date: Fri, 20 Jan 2006 14:01:24 -0600 (CST)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, jes@sgi.com,
       tony.luck@intel.com
Subject: Re: [PATCH] SN2 user-MMIO CPU migration
In-Reply-To: <200601200936.21111.jbarnes@virtuousgeek.org>
Message-ID: <20060120134424.E91550@chenjesu.americas.sgi.com>
References: <20060118163305.Y42462@chenjesu.americas.sgi.com>
 <200601191818.43157.jbarnes@virtuousgeek.org> <20060120003303.O81637@chenjesu.americas.sgi.com>
 <200601200936.21111.jbarnes@virtuousgeek.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, Jesse Barnes wrote:

> Of course, the other option is just to require tasks that do MMIO 
> accesses from userspace to be pinned to particular CPU or node. :)

One idea I had was to add a counter into the mm struct that gets
bumped if the process performs any MMIO mappings, so that only
affected processes pay the penalty.  However, the added complexity
in the drivers (e.g. handling partial unmaps, etc.) doesn't seem worth
it.  On average this code adds 800ns to the task migration path, which
is relatively infrequent and already a bit expensive (what with cold
caches and the like).

Regarding the direction Ingo sent me down, and considering what Jack
said about needing a hook for a future platform, I'm thinking of grabbing
a bit in task->thread.flags that IA64_HAS_EXTRA_STATE() could detect and
let ia64_{save,load}_extra() call new machvecs to perform this
chipset-specific context management.  It's a bit overengineered for
my particular case, but would allow Jack to plug in his work very
cleanly.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
