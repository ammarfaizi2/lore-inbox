Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUH0Ksm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUH0Ksm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUH0Ksl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:48:41 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:17412 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262071AbUH0KsT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:48:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Greg KH <greg@kroah.com>
Subject: Re: devfs -> udev transition: vcsN are not created
Date: Fri, 27 Aug 2004 13:46:58 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200408251517.31608.vda@port.imtp.ilyichevsk.odessa.ua> <200408271248.59746.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408271248.59746.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408271346.58680.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As you suggested, I tried 2.6.9-rc1-mm1. Sorry. It does not work.
>
> My hotplug is instrumented a bit
> to log invocations to syslog. I did 'cat >/dev/tty13':
>
> hotplug[1196]: cmd: /sbin/hotplug vc
> hotplug[1196]: env: DEVPATH=/class/vc/vcs13
> PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PWD=/ SHLVL=1 HOME=/
> SEQNUM=232 _=/sbin/env
> hotplug[1198]: cmd: /sbin/hotplug vc
> hotplug[1198]: env: DEVPATH=/class/vc/vcsa13
> PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PWD=/ SHLVL=1 HOME=/
> SEQNUM=233 _=/sbin/env
> hotplug[1198]: run: /etc/hotplug.d/default/default.hotplug vc
> hotplug[1196]: run: /etc/hotplug.d/default/default.hotplug vc
> hotplug[1196]: run: /etc/hotplug.d/default/udev.hotplug vc
> hotplug[1198]: run: /etc/hotplug.d/default/udev.hotplug vc
>
> 	/dev/vcs[a]13 did NOT appear.
> 	I waited ~15 secs and ^C'ed cat:
>
> hotplug[1233]: cmd: /sbin/hotplug vc
> hotplug[1233]: env: DEVPATH=/class/vc/vcs13
> PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove PWD=/ SHLVL=1 HOME=/
> SEQNUM=234 _=/sbin/env
> hotplug[1235]: cmd: /sbin/hotplug vc
> hotplug[1235]: env: DEVPATH=/class/vc/vcsa13
> PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove PWD=/ SHLVL=1 HOME=/
> SEQNUM=235 _=/sbin/env
> hotplug[1233]: run: /etc/hotplug.d/default/default.hotplug vc
> hotplug[1235]: run: /etc/hotplug.d/default/default.hotplug vc
> hotplug[1235]: run: /etc/hotplug.d/default/udev.hotplug vc
> hotplug[1233]: run: /etc/hotplug.d/default/udev.hotplug vc
>
> I verified that I do run udevsend:
>
> # ls -l /etc/hotplug.d/default/udev.hotplug
> lrwxrwxrwx    1 root     root           48 Aug 25 10:53
> /etc/hotplug.d/default/udev.hotplug ->
> /app/udev-030/etc/hotplug.d/default/udev.hotplug
>
> # ls -l /app/udev-030/etc/hotplug.d/default/udev.hotplug
> lrwxrwxrwx    1 root     root           14 Jul 27 15:35
> /app/udev-030/etc/hotplug.d/default/udev.hotplug -> /sbin/udevsend
>
> # ls -l /sbin/udevsend
> lrwxrwxrwx    1 root     root           27 Aug 25 10:53 /sbin/udevsend ->
> /app/udev-030/sbin/udevsend
>
> # ls -l /app/udev-030/sbin/udevsend
> -rwxr-xr-x    1 root     root         6696 Aug 25 10:53
> /app/udev-030/sbin/udevsend
>
> Symlink forest may look strange to you, but actually works.
>
> I replaced /app/udev-030/sbin/udevsend with sh script doing
> 'echo "I AM HERE" | logger' and I do see it in syslog.
> I conclude udevsend is being run, but doesn't do it's magic.


I straced udevsend invocation by

#!/bin/sh
exec </dev/null
exec >/dev/null
exec 2>/dev/null
strace -o /tmp/udevsend-$$ /app/udev-030/sbin/udevsend "$@"

It looks very strange:

execve("/app/udev-030/sbin/udevsend", ["/app/udev-030/sbin/udevsend", "vc"], [/* 8 vars */]) = 0
uname({sys="Linux", node="firebird", ...}) = 0
brk(0)                                  = 0x804b000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 0
fstat64(0, {st_mode=S_IFREG|0644, st_size=48875, ...}) = 0
mmap2(NULL, 48875, PROT_READ, MAP_PRIVATE, 0, 0) = 0xb7fe2000
close(0)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 0
read(0, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\\\1"..., 1024) = 1024
fstat64(0, {st_mode=S_IFREG|0755, st_size=29126107, ...}) = 0
mmap2(NULL, 1168804, PROT_READ|PROT_EXEC, MAP_PRIVATE, 0, 0) = 0xb7ec4000
mprotect(0xb7fda000, 30116, PROT_NONE)  = 0
mmap2(0xb7fda000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 0, 0x116) = 0xb7fda000
mmap2(0xb7fdf000, 9636, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fdf000
close(0)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ec3000
munmap(0xb7fe2000, 48875)               = 0
getpid()                                = 13020
socket(PF_UNIX, SOCK_DGRAM, 0)          = 0
sendto(0, "udevd_030\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 356, 0, {sin_family=AF_UNIX, path=@udevd}, 8) = 356
close(0)                                = 0
semget(IPC_PRIVATE, 3086872064, 0

This is all. No segfault. 
I am puzzled 8|
-- 
vda
