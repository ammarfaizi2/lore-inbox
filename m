Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311403AbSDIUZv>; Tue, 9 Apr 2002 16:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSDIUZu>; Tue, 9 Apr 2002 16:25:50 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48835 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S311403AbSDIUZu>; Tue, 9 Apr 2002 16:25:50 -0400
Date: Tue, 9 Apr 2002 16:25:10 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Patch for a leak of anonymous devices
Message-ID: <20020409162510.A21361@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Al:

Arjan used your fix from 2.5 which simply moves the allocation
of the device. Are you going to change in in 2.4 too?
Here's what I did for 2.4.18-pre6 temporarily:

--- linux-2.4.18-pre6/fs/super.c	Tue Apr  9 11:58:25 2002
+++ linux-2.4.18-pre6-p3/fs/super.c	Tue Apr  9 11:53:43 2002
@@ -632,6 +632,9 @@
 			continue;
 		if (!grab_super(old))
 			goto retry;
+		spin_lock(&unnamed_dev_lock);
+		clear_bit(dev, unnamed_dev_in_use);
+		spin_unlock(&unnamed_dev_lock);
 		destroy_super(s);
 		return old;
 	}

Another question: your code allows to allocate device (0,0).
I assume you found it safe; everything works. However, why
is it safe? Do we have no functions that return zero as a
device number to indicate a failure?

My moremounts patch simple pre-sets the first bit of the
unnamed_dev_in_use bitmap to avoid this. But perhaps I am
paranoid here.

-- Pete
