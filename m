Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUCCEHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUCCEHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:07:33 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:63381 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262351AbUCCEHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:07:25 -0500
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, hpa@zytor.com
Content-Type: text/plain
Organization: 
Message-Id: <1078287119.2255.403.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Mar 2004 23:12:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> The (untested) first-fit patch I proposed uses
> a radix tree, so it should in fact be faster
> than the old code.
>
> Are you now thinking that we might need to
> change the pty allocator?

I just re-read Edgar Toernig's comment... oh yeah.
Contemplate BOTH parts of the utmp quote:

: char ut_id[4];     /* init id or abbrev. ttyname */
: ...
: xterm(1) and other terminal emulators directly create
: a USER_PROCESS record and generate the ut_id by using
: the last two letters of /dev/ttyp%c or by using p%d
: for /dev/pts/%d. If they find a DEAD_PROCESS for this
: id, they recycle it, otherwise they create a new entry.

The utmp or utmpx record is about 1/2 a kilobyte.
The records get added to a file. They only get
recycled when the tty is recycled.

So that's a 20 bit minor, 9 bits of utmpx record size...
and thus a file that grows to half a gigabyte.

The reasons are adding up quickly:

1. half-gigabyte utmp,wtmp,wtmpx,utmpx file
2. breaks ut_id, even if 1000 ptys not used
3. a pain to type ("ps -t 1018493")
4. screws up column widths (ps, w, top...)
5. breaks old dev_t, even if 256 ttys not used


