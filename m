Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292595AbSB0SSB>; Wed, 27 Feb 2002 13:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292860AbSB0SRb>; Wed, 27 Feb 2002 13:17:31 -0500
Received: from ns.caldera.de ([212.34.180.1]:45494 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S292864AbSB0SRP>;
	Wed, 27 Feb 2002 13:17:15 -0500
Date: Wed, 27 Feb 2002 19:17:09 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-kernel@vger.kernel.org
Subject: Suspicious shifting of sempid in try_atomic_semop()
Message-ID: <20020227191709.A8247@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ipc/sem.c:try_atomic_semop() there is the following code:

	for (sop = sops; sop < sops + nsops; sop++) {
		...
		curr->sempid = (curr->sempid << 16) | pid;
		....
	}

it's undone in the error case:

	while (sop >= sops) {
		...
		curr->sempid >>= 16;
		...
	}

the problem is that in some cases we seem to end up with a sempid
of zero which leads to wrong returns of semctl(..., GETPID, ...)
like in

	http://www.freestandards.org/lsb/test/results/index.php?testcaseid=732

Is there a specific reason we use this shift method I have missed?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
