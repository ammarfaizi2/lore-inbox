Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTKWA5W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 19:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTKWA5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 19:57:22 -0500
Received: from aneto.able.es ([212.97.163.22]:57479 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262240AbTKWA5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 19:57:19 -0500
Date: Sun, 23 Nov 2003 01:57:17 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-BProc <bproc-users@lists.sourceforge.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BProc] Re: Reading libs fails through NFS
Message-ID: <20031123005717.GA2025@werewolf.able.es>
References: <20031117004539.GA2155@werewolf.able.es> <shsu153okhp.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.17, Trond Myklebust wrote:
> >>>>> " " == J A Magallon <J.A.> writes:
> 
>      > Hi all...  Anybody has any idea about why this fails:
> 
>      >     fd = open("/lib/libnss_files.so.2", O_RDONLY); res =
>      >     read(fd,buf,512);
> 
> No. Nobody else will be able to tell you either until you tell us what
> setup you are using.
> 

I run a small bproc cluster. Nodes are diskless, boot with a custom initrd,
and execute a simple linuxrc (comments and echo's stripped):

PATH=/bin:/sbin:/usr/bin:/usr/sbin
mount -n -o remount,rw /
mount -t proc none /proc
mount -t devpts -omode=0620 none /dev/pts
mount -t tmpfs none /dev/shm
mount -t tmpfs none /tmp
ifconfig lo up 127.0.0.1
modprobe eth0
ifconfig eth0 up
dhcpcd -H -D -R -N eth0
portmap
mount /lib
mount /bin
mount /sbin
mount /usr
mount /opt
mount /home
mount /work/shared
modprobe eth1
ifconfig eth1 up
dhcpcd -R -N eth1
ntpdate -v 192.168.0.1
modprobe bproc
bpslave -v -d -r 192.168.1.1

fstab for nodes (in /etc in initrd) is:

rootfs / rootfs defaults 0 0
none /proc proc defaults 0 0
none /dev/pts devpts mode=0620 0 0
none /dev/shm tmpfs defaults 0 0
none /tmp tmpfs defaults 0 0
192.168.0.1:/lib    /lib            nfs nfsvers=3,ro,noac,suid
192.168.0.1:/bin    /bin            nfs nfsvers=3,ro,noac,suid
192.168.0.1:/sbin   /sbin           nfs nfsvers=3,ro,noac,suid
192.168.0.1:/usr    /usr            nfs nfsvers=3,ro,noac,suid
192.168.0.1:/opt    /opt            nfs nfsvers=3,ro,noac,suid
192.168.0.1:/home   /home           nfs nfsvers=3,rw
192.168.0.1:/work   /work/shared    nfs nfsvers=3,rw

For example, /opt is just the mount point in initrd, so it is empty. It is
ro, just soft to use:

annwn:/opt> pwd
/opt
annwn:/opt> ls
aleph/  coin/  intel/  mpich/
annwn:/opt> bpsh 0 pwd
/opt
annwn:/opt> bpsh 0 ls 
ls: reading directory .: Invalid argument
annwn:~> bpsh 0 ls /opt/*
ls: reading directory /opt/aleph: Invalid argument
/opt/aleph:
ls: reading directory /opt/coin: Invalid argument

/opt/coin:
ls: reading directory /opt/intel: Invalid argument

/opt/intel:
ls: 
/opt/mpich:
reading directory /opt/mpich: Invalid argument

annwn:~> bpsh 0 strace ls /opt
...
stat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/opt", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, 0x8060360, 8192)          = -1 EINVAL (Invalid argument)
close(3)                                = 0
...
annwn:/opt> bpsh 0 strace ls
...
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, 0x8060350, 8192)          = -1 EINVAL (Invalid argument)
close(3)                                = 0
...

It looks like readdir fails (getdents).
Uh ? 
I use a custom kernel, still have to try with plain -rc3 + bproc. But
do you have any ideas about what is going/what am I doing wrong ? This
all worked some time ago with my hacked -jam kernels.

TIA for you attention.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-rc3-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
