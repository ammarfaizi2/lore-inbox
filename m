Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWBBLxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWBBLxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWBBLxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:53:49 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13740 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750738AbWBBLxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:53:49 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: vitaly@namesys.com
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Thu, 2 Feb 2006 13:52:59 +0200
User-Agent: KMail/1.8.2
Cc: reiserfs-dev@namesys.com, Chris Mason <mason@suse.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <200601281613.16199.vda@ilport.com.ua> <200602020925.00863.vda@ilport.com.ua> <200602021242.21512.vitaly@namesys.com>
In-Reply-To: <200602021242.21512.vitaly@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602021352.59635.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 11:42, Vitaly Fertman wrote:
> > > reiserfstune -s 1024 /dev/xxxx
> > 
> > I had reiserfsprogs 3.6.11 and reiserfstune (above command) made my /dev/sdc3
> > unmountable without -t reiserfs. I upgraded reiserfsprogs to 3.6.19 and now
> > reiserfsck /dev/sdc3 reports no problems, but mount problem persists:
> > 
> > # mount -t reiserfs /dev/sdc3 /.3
> > # umount /.3
> > # mount /dev/sdc3 /.3
> > mount: you must specify the filesystem type
> > # dmesg | tail -3
> > br: port 1(ifi) entering forwarding state
> > FAT: bogus number of reserved sectors
> > VFS: Can't find a valid FAT filesystem on dev sdc3.
> > 
> > "chown -Rc <n>:<m> ." now does not OOM kill the box, so this issue
> > is resolved, thanks!
> > 
> > Can I restore sdc3 somehow that I won't need -t reiserfs in mount command?
> > You can find result of
> > 
> > dd if=/dev/sdc3 of=1m bs=1M count=1
> > 
> > at http://195.66.192.167/linux/1m
> 
> the problem seems to be in mount program, which version do you use?
> I still have no problem with your 1m image, mount version is 2.11z, 
> 2.12c.

# mount --version
mount: mount-2.11p

Obviously you are right, mount reads some data in /dev/sdc3 itself
and decides to try specific fs types first instead of just asking
kernel to autodetect:

...
...
stat64("/dev/sdc3", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 35), ...}) = 0
open("/dev/sdc3", O_RDONLY|O_LARGEFILE) = 4
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 576) = 576
_llseek(4, 512, [512], SEEK_SET)        = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
_llseek(4, 1024, [1024], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 228) = 228
_llseek(4, 1024, [1024], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 24) = 24
_llseek(4, 3072, [3072], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1376) = 1376
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
_llseek(4, 8192, [8192], SEEK_SET)      = 0
read(4, "\0\0\0\0\0\0\0\0", 8)          = 8
_llseek(4, 32768, [32768], SEEK_SET)    = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 112) = 112
_llseek(4, 32768, [32768], SEEK_SET)    = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2048) = 2048
_llseek(4, 65536, [65536], SEEK_SET)    = 0
read(4, "\212\365\37\0>\217\17\0\255\200\0\0\22\0\0\0\0\0\0\0\377"..., 64) = 64
_llseek(4, 0, [0], SEEK_SET)            = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
close(4)                                = 0
open("/etc/filesystems", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/proc/filesystems", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f7f000
read(4, "nodev\tsysfs\nnodev\trootfs\nnodev\tb"..., 1024) = 277
mount("/dev/sdc3", "/.3", "msdos", 0xc0ed0000, 0) = -1 EINVAL (Invalid argument)
mount("/dev/sdc3", "/.3", "vfat", 0xc0ed0000, 0) = -1 EINVAL (Invalid argument)
read(4, "", 1024)                       = 0
close(4)                                = 0
munmap(0xb7f7f000, 4096)                = 0
rt_sigprocmask(SIG_UNBLOCK, ~[TRAP SEGV], NULL, 8) = 0
open("/usr/share/locale/ru_RU.KOI8-R/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/ru_RU.koi8r/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/ru_RU/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/ru.KOI8-R/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/ru.koi8r/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/ru/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "mount: you must specify the file"..., 44) = 44

mount from busybox 1.0 works fine:

# strace busybox mount /dev/sdc3 /.3
execve("/sbin/busybox", ["busybox", "mount", "/dev/sdc3", "/.3"], [/* 24 vars */]) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
getuid()                                = 0
getgid()                                = 0
getuid()                                = 0
getgid()                                = 0
setgid(0)                               = 0
setuid(0)                               = 0
brk(0)                                  = 0x80f6000
brk(0x80f7000)                          = 0x80f7000
brk(0x80f8000)                          = 0x80f8000
brk(0x80f9000)                          = 0x80f9000
stat64("/dev/sdc3", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 35), ...}) = 0
open("/etc/filesystems", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/proc/filesystems", O_RDONLY|O_LARGEFILE) = 4
ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbfb32740) = -1 ENOTTY (Inappropriate ioctl for device)
brk(0x80fa000)                          = 0x80fa000
read(4, "nodev\tsysfs\nnodev\trootfs\nnodev\tb"..., 4096) = 277
mount("/dev/sdc3", "/.3", "reiserfs", 0xc0ed0000, 0x80f6008) = 0
close(4)                                = 0
_exit(0)


--
vda
