Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269172AbUIHO0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269172AbUIHO0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUIHOWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:22:50 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:40323 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S269161AbUIHOSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:18:51 -0400
Date: Wed, 8 Sep 2004 10:18:48 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: proc stalls
Message-ID: <20040908141848.GB21729@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040908054101.GR2966@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908054101.GR2966@washoe.rutgers.edu>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I suspected yesterday but didn't report because it seemed like not very
reasonable idea:

that problem was linked to the fact that nfs-mounted directory became
unavailable... I have a host (belka) which exports a couple of
directories and it is nfs-mounted using am-utils:

ravana[0] ~>mount | grep belka
belka:/home/yoh.m on /amd/belka/root/home/yoh.m type nfs (rw,proto=tcp)

last evening belka halted for some reason and that directory became
unavailable:
multiple error messages:
nfs_stat_to_errno: bad nfs status return value: 11
nfs_stat_to_errno: bad nfs status return value: 11
nfs_statfs: statfs error = 5
RPC: error 5 connecting to server belka

I've tried to unmount it but it didn't work...

This morning I saw that hanged fuser processes which I've tried to kill,
finally died, but new ones still didn't work correctly.
When I arrived at work and rebooted belka, ravana became fine again -
fuser/df/etc works fine.

Under Debian I'm running vanilla 2.6.8-rc3-bk3 kernel and
ii  nfs-common     1.0.6-3        NFS support files common to client and server
ii  nfs-kernel-ser 1.0.6-3        Kernel NFS server support

I think that problems with NFS have to not influence the work of the
system that much... May be I should switch to user space nfs server...
Any ideas on how to further debug this situation to avoid future
problems?

--
Yarik


On Wed, Sep 08, 2004 at 01:41:01AM -0400, Yaroslav Halchenko wrote:
> Dear All,

> Please give me some hints on where to look and what possibly to do to
> bring system back to usable without rebooting, or at least to catch what
> can be a problem.

> I've discroverd that mozilla-firefox didn't want to start - just hanged
> during start... well - I've found that 'fuser -m /dev/dsp' causes it to
> stall... well - I've fount that any fuser process stalls... well... I've
> found using strace that they stall around next point:
> getdents64(4, /* 0 entries */, 1024)    = 0
> close(4)                                = 0
> chdir("/proc/26336")                    = 0
> stat64("root", {st_mode=S_IFDIR|0755, st_size=720, ...}) = 0
> lstat64("root", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> stat64("cwd", 

> well.. I've tried to cd to /proc/26336 and my bash got frozen as well...


> now my sytem load is around 20 probably due to all the unkillable fuser
> processes I've ran so far... They look like:
> yoh      29083  0.0  0.0  1532  560 ?        D    00:48   0:00 fuser -m
> /dev/dsp

> no abnormal logs are reported in syslog... 


> What can I do to find the cause or to resolve the situation somehow
> without reboot? Which else hints can I provide? I'm reporting main
> system params and linux kernel config on

> http://www.onerussian.com/Linux/bugs/bug.proc/

> (Many other tools like df stall as well)

> Thank you in advance
-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

