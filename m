Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUH0JuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUH0JuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUH0JuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:50:15 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:16900 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261451AbUH0Jtr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:49:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Greg KH <greg@kroah.com>
Subject: Re: devfs -> udev transition: vcsN are not created
Date: Fri, 27 Aug 2004 12:48:59 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200408251517.31608.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408251517.31608.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408271248.59746.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wednesday 25 August 2004 15:17, Denis Vlasenko wrote:
> I am migrating my 2.6 systems from devfs to udev.
> Versions:
>
> # uname -a
> Linux firebird 2.6.7-bk20 #6 Mon Jul 12 01:23:31 EEST 2004 i686 unknown
> # ls -d udev* hotplug*
> hotplug-2004_04_01  udev-030
>
> In early boot, when root fs is readonly yet, I start udev this way:
>
> mount -t ramfs none /dev
> env - udevd & sleep 1
> udevstart
>
> and then continue as normal. Things mostly work.
> However, I noticed that vcsN device nodes are missing
> (I tried to start Midnight Commander and it failed).
> This can be due to the fact that I start agettys very
> late in boot sequence, and thus all ttyN's were not
> open at the time of udevstart, only first one was (tty1).
>
> I logged in and did:
>
> # ls -l /udev >before
> # strace -o us.log udevstart
> # ls -l /udev >after
> # diff -u before after >diff
>
> This worked, vcsN's appeared:
[snip]

As you suggested, I tried 2.6.9-rc1-mm1. Sorry. It does not work.

My hotplug is instrumented a bit
to log invocations to syslog. I did 'cat >/dev/tty13':

hotplug[1196]: cmd: /sbin/hotplug vc
hotplug[1196]: env: DEVPATH=/class/vc/vcs13 PATH=/sbin:/bin:/usr/sbin:/usr/bin
ACTION=add PWD=/ SHLVL=1 HOME=/ SEQNUM=232 _=/sbin/env
hotplug[1198]: cmd: /sbin/hotplug vc
hotplug[1198]: env: DEVPATH=/class/vc/vcsa13 PATH=/sbin:/bin:/usr/sbin:/usr/bin
ACTION=add PWD=/ SHLVL=1 HOME=/ SEQNUM=233 _=/sbin/env
hotplug[1198]: run: /etc/hotplug.d/default/default.hotplug vc
hotplug[1196]: run: /etc/hotplug.d/default/default.hotplug vc
hotplug[1196]: run: /etc/hotplug.d/default/udev.hotplug vc
hotplug[1198]: run: /etc/hotplug.d/default/udev.hotplug vc

	/dev/vcs[a]13 did NOT appear.
	I waited ~15 secs and ^C'ed cat:

hotplug[1233]: cmd: /sbin/hotplug vc
hotplug[1233]: env: DEVPATH=/class/vc/vcs13 PATH=/sbin:/bin:/usr/sbin:/usr/bin
ACTION=remove PWD=/ SHLVL=1 HOME=/ SEQNUM=234 _=/sbin/env
hotplug[1235]: cmd: /sbin/hotplug vc
hotplug[1235]: env: DEVPATH=/class/vc/vcsa13 PATH=/sbin:/bin:/usr/sbin:/usr/bin
ACTION=remove PWD=/ SHLVL=1 HOME=/ SEQNUM=235 _=/sbin/env
hotplug[1233]: run: /etc/hotplug.d/default/default.hotplug vc
hotplug[1235]: run: /etc/hotplug.d/default/default.hotplug vc
hotplug[1235]: run: /etc/hotplug.d/default/udev.hotplug vc
hotplug[1233]: run: /etc/hotplug.d/default/udev.hotplug vc

I verified that I do run udevsend:

# ls -l /etc/hotplug.d/default/udev.hotplug
lrwxrwxrwx    1 root     root           48 Aug 25 10:53 /etc/hotplug.d/default/udev.hotplug -> /app/udev-030/etc/hotplug.d/default/udev.hotplug

# ls -l /app/udev-030/etc/hotplug.d/default/udev.hotplug
lrwxrwxrwx    1 root     root           14 Jul 27 15:35 /app/udev-030/etc/hotplug.d/default/udev.hotplug -> /sbin/udevsend

# ls -l /sbin/udevsend
lrwxrwxrwx    1 root     root           27 Aug 25 10:53 /sbin/udevsend -> /app/udev-030/sbin/udevsend

# ls -l /app/udev-030/sbin/udevsend
-rwxr-xr-x    1 root     root         6696 Aug 25 10:53 /app/udev-030/sbin/udevsend

Symlink forest may look strange to you, but actually works.

I replaced /app/udev-030/sbin/udevsend with sh script doing
'echo "I AM HERE" | logger' and I do see it in syslog.
I conclude udevsend is being run, but doesn't do it's magic.
--
vda
