Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUCLVBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCLVAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:00:42 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:63436 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S262206AbUCLU7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:59:22 -0500
Date: Fri, 12 Mar 2004 12:58:15 -0800
From: Tim Hockin <thockin@sun.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: calling flush_scheduled_work()
Message-ID: <20040312205814.GY1333@sun.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've recently bumped into an issue, and I'm not sure which is the real bug.

In short we have a case where mntput() is called from the kevetd workqueue.
When that mntput() hit an NFS mount, we got a deadlock.  It turns out that
deep in the RPC code, someone calls flush_scheduled_work().  Deadlock.

So what is the real bug?

Is it verboten to call mntput() from keventd?  What other things might lead
to a flush_scheduled_work() and must therefore be avoided?

Should callers of flush_scheduled_work() be changed to use private
workqueues?  There are 31 calls that I got from grep.  25 are in drivers/, 1
in ncpfs, 3 in nfs4, 2 in sunrpc.  The drivers/ are *probably* ok. Should
those other 6 be changed?

Either way, it seems like there should maybe be a check and a badness
warning if flush_workqueue is called from that workqueue.

Which avenue should we follow?  Our own problem can be fixed differently,
but I didn't want to just ignore this unstated assumption that it is safe to
call flush_scheduled_work() anywhere.

Tim

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
