Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWCADGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWCADGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWCADGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:06:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55680 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932505AbWCADGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:06:11 -0500
Date: Tue, 28 Feb 2006 19:05:35 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060228190535.41a8c697.pj@sgi.com>
In-Reply-To: <20060228162157.0ed55ce6.akpm@osdl.org>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have popped the patch stack back to including:
> trivial-cleanup-to-proc_check_chroot.patch
> proc-fix-the-inode-number-on-proc-pid-fd.patch

but not past that.  It boots now, unlike before with the full patch
stack.

I will continue the hunt.

Meanwhile, on the side,  I have a couple of permission problems to
report to Eric Biederman with apps that are complaining about not being
able to access /proc/<pid>/fd/[0-9]* files when before they could:

 1) Logged in as root, running "/bin/ls -l /proc/*/fd/*"
    causes some complaints.  For example:

    # /bin/ls -l /proc/2868/fd/?
    /bin/ls: cannot read symbolic link /proc/2868/fd/6: Permission denied
    /bin/ls: cannot read symbolic link /proc/2868/fd/7: Permission denied
    lr-x------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/0 -> /dev/null
    lrwx------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/1 -> /dev/pts/10
    lrwx------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/2 -> /dev/pts/10
    lr-x------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/3 -> /proc/sal/cmc/event
    lrwx------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/4 -> /proc/sal/cmc/data
    l-wx------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/6
    lr-x------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/7
  
    I don't recall seeing any similar complaints before.  My first reaction
    is "wtf - I'm root - what's this permission denied error ?!?"

 2) I have an SGI specific application that runs out of init on boot
    that spews out some 50 or so "Permission denied" errors on
    various /proc/<pid>/fd/* files, which it never did before that
    I can recall.

    For example, this app complained:

	Cannot stat file /proc/1688/fd/3: Permission denied
	Cannot stat file /proc/1688/fd/4: Permission denied
	Cannot stat file /proc/1688/fd/5: Permission denied
	Cannot stat file /proc/1688/fd/6: Permission denied
	Cannot stat file /proc/1688/fd/7: Permission denied
	Cannot stat file /proc/2781/fd/3: Permission denied
	Cannot stat file /proc/2802/fd/1: Permission denied
	Cannot stat file /proc/2802/fd/3: Permission denied
	Cannot stat file /proc/2802/fd/4: Permission denied
	Cannot stat file /proc/2878/fd/6: Permission denied
	Cannot stat file /proc/2878/fd/7: Permission denied

    You can see it is not complaining about all the fd's of a task,
    but just some.

    I might be confused in what patches I'm running, but I believe that
    I am getting these permission denied errors with just the patches:

    > trivial-cleanup-to-proc_check_chroot.patch
    > proc-fix-the-inode-number-on-proc-pid-fd.patch

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
