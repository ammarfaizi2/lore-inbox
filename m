Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270615AbRICOyX>; Mon, 3 Sep 2001 10:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271656AbRICOyN>; Mon, 3 Sep 2001 10:54:13 -0400
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:25062 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S270615AbRICOyE>; Mon, 3 Sep 2001 10:54:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Phillip Susi <psusi@cfl.rr.com>
Reply-To: psusi@cfl.rr.com
To: linux-kernel@vger.kernel.org
Subject: [bug report] NFS and uninterruptable wait states
Date: Mon, 3 Sep 2001 10:48:31 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01090310483100.26387@faldara>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other day I was trying to set up an NFS mount to my room mate's system, 
and ran into what I at least, call a bug.  When I tried to mount his NFS 
export, the mount command locked up, and would not die.  Not even a SIGKILL 
would do any good.  According to ps, the mount process was in the 'D' - 
uninterruptable wait state.  It also looked like the WCHAN was rpc_ 
something.  I think it was waiting for an rpc call to return in the D state, 
and it never did return.  The bug here is that it should NOT be waiting in 
the D state for something that could never happen.  For that matter, why 
should anything ever need to wait in an uninterruptable state?  Whenever you 
wait, you should expect the possibility of being interrupted, check for that 
when you wake up, and if you were, clean up and return so the signal can be 
processed.

Anyhow, about an hour later ( the mount process still stuck ) I figured out 
that the other machine was not running rpc.nfsd, though it was running 
rpc.mountd.  Once I started rpc.nfsd on the machine, the mount on my box 
finally returned ( and was terminated by the SIGKILL that I sent it an hour 
before ).

Could someone confirm that this is a bug, and explain why anything should 
ever need to wait in that state?

