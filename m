Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUIAUe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUIAUe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUIAUcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:32:09 -0400
Received: from cheddar.cendio.se ([193.12.253.77]:9465 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S267594AbUIAUaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:30:25 -0400
Date: Wed, 1 Sep 2004 22:30:19 +0200 (CEST)
From: Peter Astrand <peter@cendio.se>
X-X-Sender: peter@maggie.lkpg.cendio.se
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ncpfs problems
In-Reply-To: <255B8A94A7B@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0409012144490.1095-100000@maggie.lkpg.cendio.se>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > unlink("kdeinit_maggie_2")              = -1 EBUSY (Device or resource busy)

> ncp_unlink closes file on server if there is no read or write
> operation in progress - see ncp_make_open, ncp_inode_close and
> ncp_make_closed: ncp_make_open opens file on server, ncp_inode_close
> marks file as being "closable" and ncp_make_closed closes file unless
> someone is in ncp_make_open - ncp_inode_close region.
> 
> Cannot be kdeinit_maggie_2 opened by someone else?

Not another machine. This server currently allows only one NCP connection. 
I have no idea which KDE processes that are opening this file, though. 


> BTW, ncpfs is "single threaded" because protocol itself is single
> threaded - you can have only one outstanding request. Even with TCP
> transport which could allow more than one outstanding request, leaving
> synchronization on TCP level, if you send data to server while
> it processes another request some server versions return back 9999,
> server busy, instead of leaving received data in the queue until
> previous request is satisfied :-(

I guess it would be possible to use multiple TCP/NCP connections, but this 
might be a bit overkill. 


> Actually with 2.6.x fs/ncpfs/sock.c changing code to not call
> ncp_abort_connection() when something goes wrong should not be that
> hard. Only problem is that ncp_request_reply structure is allocated
> on caller stack, and so you must kill receiver (ncpdgram_rcv_proc/
> ncptcp_rcv_proc) before you release this structure.
> 
> But main question is whether it is really needed... It works this way
> since day #1 (old kernels actually used SIGKILL|SIGSTOP, making
> debugging of processes using ncpfs filesystem almost impossible, yet
> nobody complained).

I can only speak for myself, but I do believe that this is a big problem
for us and our customers. I've filed a bug in the Bugzilla: Bug 3328.

-- 
Peter Åstrand		Chief Developer
Cendio			www.thinlinc.com
Teknikringen 3		www.cendio.se
583 30 Linköping        Phone: +46-13-21 46 00


