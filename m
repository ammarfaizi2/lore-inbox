Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVA0FLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVA0FLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 00:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVA0FLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 00:11:46 -0500
Received: from one.firstfloor.org ([213.235.205.2]:37599 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262436AbVA0FLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 00:11:36 -0500
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@plan9.de
Subject: Re: critical bugs in md raid5
References: <20050127035906.GA7025@schmorp.de>
From: Andi Kleen <ak@muc.de>
Date: Thu, 27 Jan 2005 06:11:34 +0100
In-Reply-To: <20050127035906.GA7025@schmorp.de> (Marc Lehmann's message of
 "Thu, 27 Jan 2005 04:59:07 +0100")
Message-ID: <m1vf9j4fsp.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann <linux-kernel@plan9.de> writes:
>
> The summary seems to be that the linux raid driver only protects your data
> as long as all disks are fine and the machine never crashes.

"as long as the machine never crashes". That's correct. If you think
about how RAID 5 works there is no way around it. When a write to 
a single stripe is interrupted (machine crash) and you lose a disk
during the recovery a lot of data (even unrelated to the data just written)
is lost. That is because there is no way to figure out what part
of the data on the stripe belonged to the old and what part to 
the new write.

But that's nothing inherent in Linux RAID5. It's a generic problem.
Pretty much all Software RAID5 implementations have it.

The only way around it is to journal all writes, to make stripe
updates atomic, but in general that's too slow unless you have a
battery backed up journal device. 

There are some tricks to avoid this (e.g. always write to a new disk
location and update an disk index atomically), but they tend to be
heavily patented and are slower too. They also go far beyond RAID-5
(use disk space less efficiently etc.)  and typically need support
from the file system to be efficient.

RAID-1 helps a bit, because you either get the old or the new data,
but not some corruption. In practice even old data can be a big
problem though (e.g. when file system metadata is affected)

Morale: if you really care about your data backup very often and
use RAID-1 or get an expensive hardware RAID with battery backup
(all the cheap "hardware RAIDs" are equally useless for this) 

-Andi
