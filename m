Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752094AbWICGVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbWICGVp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 02:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWICGVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 02:21:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53177 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752085AbWICGVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 02:21:43 -0400
X-Sasl-enc: Fp5U3zjoxqdjXYZs/DyjPOrOirZ4MgyNKiatAFw8Khez 1157264499
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060901225853.0171fd29.akpm@osdl.org>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <20060901195009.187af603.akpm@osdl.org>
	 <1157170272.3307.5.camel@raven.themaw.net>
	 <20060901225853.0171fd29.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 03 Sep 2006 14:21:30 +0800
Message-Id: <1157264490.3520.16.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 22:58 -0700, Andrew Morton wrote:
> > > 
> > > It doesn't appear to be related to selinux.

I have a festering suspicion, but no evidence yet, that this is not
always the case.

> > > 
> > > On a stock, mostly-up-to-date FC5 installation:
> > > 
> > > 	echo 0 > /selinux/enforce
> > > 	service autofs stop
> > > 	service nfs stop
> > > 	service nfs start
> > > 	service autofs start

I'm now setup my little system the same.

[root@raven selinux]# uname -a
Linux raven.themaw.net 2.6.18-rc5-mm1 #1 SMP Sat Sep 2 23:11:01 WST 2006
x86_64 x86_64 x86_64 GNU/Linux

[root@raven selinux]# rpm -q autofs
autofs-4.1.4-29

[root@raven selinux]# getenforce
Permissive

[root@raven selinux]# rpm -q selinux-policy
selinux-policy-2.3.7-2.fc5

> > > 
> > > 
> > > sony:/home/akpm> ls -l /net/bix/usr/src
> > > total 0
> > > 
> > > sony:/home/akpm> showmount -e bix
> > > Export list for bix:
> > > /           *
> > > /usr/src    *
> > > /mnt/export *

Almost the same.

[root@raven selinux]# showmount -e budgie
Export list for budgie:
/        *
/usr/src *

> > > 
> > > 
> > > The automounter will mount bix:/ on /net/bix.  But I am unable to get it to
> > > mount bix's /usr/src on /net/bix/usr/src.
> > 
> > Is it the same symptom as before or is it that bix:/usr/src is not also
> > being mounted?

[root@raven selinux]# lsmod|grep autofs
autofs4                40776  1

I guess you haven't got the autofs module loaded instead of autofs4 by
mistake.

[raven@raven ~]$ mount
/dev/hda5 on / type ext3 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/hda6 on /home type ext3 (rw)
/dev/hda7 on /work type ext3 (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
automount(pid3463) on /net type autofs
(rw,fd=5,pgrp=3463,minproto=2,maxproto=4)

[raven@raven ~]$ ls /net/budgie
autofs  cdrom  export71  initrd          lib         opt   sbin  usr
vmlinuz.old
bin     dev    floppy    initrd.img      lost+found  proc  sys   var
boot    etc    home      initrd.img.old  mnt         root  tmp   vmlinuz
[raven@raven ~]$ mount
/dev/hda5 on / type ext3 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/hda6 on /home type ext3 (rw)
/dev/hda7 on /work type ext3 (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
automount(pid3463) on /net type autofs
(rw,fd=5,pgrp=3463,minproto=2,maxproto=4)
budgie:/ on /net/budgie type nfs
(rw,nosuid,nodev,hard,intr,addr=10.49.97.33)
budgie:/usr/src on /net/budgie/usr/src type nfs
(rw,nosuid,nodev,hard,intr,addr=10.49.97.33)

So I wonder what the different is between the setups?

> 
> When this saga first started an `ls -l /net/bix' showed a corrupted dentry
> for /net/bix/usr.  It was determined that this was SELinux-related.  Fixes were
> made and that no longer occurs.
> 
> Now, treading on /net/bix/usr/src does not cause bix:/usr/src to be mounted
> at /net/bix/usr/src.  Without git-nfs that mount does occur.
> 
> The present behaviour is unchanged if /selinux/enforce is set to 0.
> 
> > > Without git-nfs applied, /net/bix/usr/src mounts as expected.
> > > 
> > > iirc, we decided this is related to the fs-cache infrastructure work which
> > > went into git-nfs.  I think David can reproduce this?

Can you reproduce this David?

> > 
> > I'll build the latest mm kernel and try to reproduce it.
> > >From memory I couldn't reproduce it last time I tried.
> > Is there anything I need to add to rc5-mm1 for this?
> 
> Nope.

I'm stumped.

Ian



-- 
VGER BF report: H 0.0277086
