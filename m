Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWA2T1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWA2T1V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWA2T1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:27:21 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:29098 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751119AbWA2T1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:27:20 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp vs. modular IDE (or wherever your swap is)
Date: Sun, 29 Jan 2006 22:27:09 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200601061716.31410.arvidjaar@mail.ru> <20060105195030.GA2581@ucw.cz>
In-Reply-To: <20060105195030.GA2581@ucw.cz>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601292227.10094.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 05 January 2006 22:50, Pavel Machek wrote:
> On Fri 06-01-06 17:16:30, Andrey Borzenkov wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Do I understand correctly that swsusp requires drivers for primary swap
> > to be compiled in kernel? It appears that initrd-based implementation is
> > possible (load drivers for resume partition and then attempt to do manual
> > resume via "echo x:y > /sys/power/resume") - are there any issues
> > associated with it?
>
> Except that it eats any mounted filesystems? No. Do mounts after
> echo and you should be fine.

well, this did not work at least naively. It correctly sets resume device and 
I can suspend. But on resume I see "Stopping tasks: ====" after this booting 
continues. I enabled debug but do not see anything at this moment.

Contents of linuxrc up to resume point:

{pts/0}% sudo cat /tmp/rc/linuxrc
#!/bin/nash

echo "Loading ide-core.ko module"
insmod /lib/ide-core.ko
echo "Loading alim15x3.ko module"
insmod /lib/alim15x3.ko
echo "Loading ide-disk.ko module"
insmod /lib/ide-disk.ko
echo "Loading reiserfs.ko module"
insmod /lib/reiserfs.ko
echo Mounting /proc filesystem
mount -t proc /proc /proc
echo Mounting sysfs
mount -t sysfs none /sys
echo Creating device files
mountdev size=32M,mode=0755
echo -n /sbin/hotplug > /proc/sys/kernel/hotplug
mkdir /dev/.udevdb
mkdevices /dev
echo Attempting resume
resume

resume is builtin (on top of RH/Mandriva nash):

int resumeCommand(char * cmd, char * end) {
    char buf[20];
    struct stat statbuf;
    int fd;
    int size;
    char *resume, *rend;

    resume = getKernelArg("resume=");
    if (resume == NULL)
        return 0;
    rend = resume;
    while (*rend && !isspace(*rend)) rend++;
    *rend = '\0';

    if ((stat(resume, &statbuf) == 0)) {
        fd = open("/sys/power/resume", O_RDWR, 0);
        if (fd < 0)
            return 1;
        size = snprintf(buf, sizeof(buf), "%u:%u",
                        major(statbuf.st_rdev), minor(statbuf.st_rdev));
        if (size <= sizeof(buf))
            write(fd, buf, size);
        /* SHOULD NOT REACH HERE */
    }

    close(fd);
    return 1;
}

and I boot with resume=/dev/hda1

Unfortunately, serial console is near to impossible (it is notebook without 
COM port :(

- -andrey

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD3RcNR6LMutpd94wRArkwAJ94fiVsVaOO9INJieJqsjgvnc/DvACgqSR5
6LxKuaVPSzXKaEyMml9cT+4=
=a4Zh
-----END PGP SIGNATURE-----
