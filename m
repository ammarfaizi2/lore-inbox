Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTDYEqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 00:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTDYEqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 00:46:53 -0400
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:37000 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP id S262984AbTDYEqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 00:46:52 -0400
Date: Fri, 25 Apr 2003 01:57:30 -0300
From: Christian Reis <kiko@async.com.br>
To: NFS@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client locking hangs for period 
Message-ID: <20030425015730.A29574@blackjesus.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, since I've more or less moved on from my original problems, I
should probably post a summary of what was going on, and what I did to
work around it.

Details can be read out from [1]: after a certain amount of time a
number diskless clients, which were mounting everything from the same
NFS server, started getting hung lock requests from the server. The
server ran 2.4.20, reiserfs over RAID-1 mounted with 2 SCSI disks on an
Adaptec 29160. The clients were debian woodys running 2.4.20.

Our diskless setup is a bit unusual: all the clients mount the same root
partition. I tried to be very careful to make sure no files were written
to on /, but I never got to the point where the clients could mount the
directory read-only. I used devfs to make sure that the /dev directories
were `localized' and syslog/console ownership and permissions kept sane.

The locking problem, however, was not related to the root filesystem --
it seems to have happened with files on the /var/log mount, which is
separate for each box (but still coming from a shared filesystem
/export/root on the server, which contains all the client directories).
If I mounted /var/log with the nolock option, they ran fine. This took
me a very long time to figure out, and I'd advise anyone with locking
problems to give it a go.

I should point out that this *does* seem to be a bug in the NFS server
code. I think it is associated with reiserfs, being that I haven't seen
it happen on other partition types. Rebooting the server cleared up the
problem. Erasing or changing files in /var/lib/nfs did not. While I was
initially using a volatile /var/lib/nfs directory on the *clients*, I
changed this on Trond's suggestion [2]. It did not fix the problem.

However, since I know little about the code itself, and it's not very
clear how one should debug, I was unable to pinpoint the exact source of
the problem, which very much saddens me.  The workaround, however, was
quite effective.

[1] http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&th=9db70994c3458f46&rnum=1
[2] http://groups.google.com/groups?q=christian+reis+nfs+locking&hl=en&lr=&ie=UTF-8&scoring=d&selm=20030126231006%246e11%40gated-at.bofh.it&rnum=3

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
