Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267152AbUBMSXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267153AbUBMSXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:23:49 -0500
Received: from gaia.cela.pl ([213.134.162.11]:7438 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S267152AbUBMSXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:23:06 -0500
Date: Fri, 13 Feb 2004 19:22:52 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Valdis.Kletnieks@vt.edu
Cc: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: why are capabilities disabled? 
In-Reply-To: <200402131808.i1DI8vfA020145@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0402131914280.12513-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As long as you're staying in the same domain of capabilities, there's no
> really big issue.  The problem starts when you use fork(), exec(), and friends
> to launch something that may have a different set of capabilities (either more
> or less). Also note that exploited code can cause an exec() in a program that
> doesn't even have a call to exec() in it....

Obviously a program without exec in it should not have the 
right/priviledge/capability to call exec period.

We should provide some sort of way for each process directly after 
start-up (or later on, after it's done ssetting up whatever) to declare 
which syscalls (subfunctions for networking) it will 
never use so that they can be quickly and efficiently disabled to ENOSYS 
or EDISABLED or whatever.  Such 'capabilities' should be per pid per 
syscall/subfunction and should be inherited over fork/exec and should only 
be allowed to be set (no enabling by self - only by a process with that 
syscall only enabled for another process with it disabled).

I have a half-hack patch working here at home and my dns server starts up 
with full uid/gid 0 0 on root filesystem and proceeds to initialize 
everything it needs, dropping priveledges when no longer needed.
It ends up as a nobody/nobody chroot'ed daemon with 1 open udp domain 
port, no open file descripters (besides the socket) and no rights to 
perform any syscall except recvfrom and sendto and poll or select (can't 
remember something like 6 or 7 syscalls out of the 280 in the kernel).
Even if a buffer overflow exists in the code at worst the code is capable 
of spewing data out of udp port 53 - no mem allocations, no file opens, no 
syncs, no setuid/setgids, no chroot, no cds, no readdir, no write, no 
read, no bind/listen, etc...  [It's also djbdns so it's pretty secure even 
without that :)]

We should really standardize and mainline include some sort of solution 
like this - a sort of finer grained capability list - we'd need approx 
around 300 bits/switches per process at least.

Cheers,
MaZe.


