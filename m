Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbTG3Jyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 05:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbTG3Jyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 05:54:53 -0400
Received: from camus.xss.co.at ([194.152.162.19]:35077 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S269578AbTG3Jys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 05:54:48 -0400
Message-ID: <3F2795DE.5020306@xss.co.at>
Date: Wed, 30 Jul 2003 11:54:38 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: herbert@13thfloor.at
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.22-pre4: devfs on initrd stays busy after pivot_root
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva> <3F267FD7.4040400@xss.co.at> <20030729145421.GA24395@www.13thfloor.at>
In-Reply-To: <20030729145421.GA24395@www.13thfloor.at>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Thanks for your reply!

Herbert Pötzl wrote:
> On Tue, Jul 29, 2003 at 04:08:23PM +0200, Andreas Haumer wrote:
>
[...]
>>
>>Beginning with 2.4.22-pre4 I can't unmount devfs on my
>>initial ramdisk anymore because of EBUSY
>>
[...]
>
> there is an update of devfs available since 2.4.20 or
> so, but it hasn't made it in the marcelo tree yet
>
> I don't remember the original path, but it was in
> one of Richard Goochs directories on kernel.org,
> anyway, you can grab it from the following url:
>
I know. The location of Richard's latest devfs patch
for linux 2.4 is
<http://www.kernel.org/pub/linux/kernel/people/rgooch/v2.4/>

But this patch doesn't solve the problem.
In fact, it's not a problem with devfs itself.

I just reproduced it for linux-2.4.22-pre4 with an initial
ramdisk and legacy device files. I created the necessary
device files on the initrd fs, booted with "devfs=nomount"
and mounted devfs after pivot_root

root@install:~ {501} $ mount
rootfs on / type rootfs (rw)
/dev/root on /initrd type romfs (ro)
/dev/hda3 on / type ext2 (rw)
devfs on /dev type devfs (rw)
proc on /proc type proc (rw)

root@install:~ {502} $ umount /initrd
umount: /initrd: device is busy

Now look at this:

root@install:~ {514} $ find /initrd/ -exec fuser -v {} \;

                     USER        PID ACCESS COMMAND
/initrd/             root       1883 ..c..  find
                     root     kernel mount  /initrd

                     USER        PID ACCESS COMMAND
/initrd/dev/console  root          2 f....  keventd
                     root          3 f....  ksoftirqd_CPU0
                     root          4 f....  kswapd
                     root          5 f....  bdflush
                     root          6 f....  kupdated
                     root        259 f....  kjournald
                     root        260 f....  kjournald
                     root        261 f....  kjournald
                     root        262 f....  kjournald
                     root        404 f....  khubd
                     root        776 f....  rpciod
                     root        780 f....  lockd
                     root        855 f....  nfsd
                     root        856 f....  nfsd
                     root        857 f....  nfsd
                     root        858 f....  nfsd
                     root        859 f....  nfsd
                     root        860 f....  nfsd
                     root        861 f....  nfsd
                     root        862 f....  nfsd


root@install:~ {515} $ fuser -v /dev/console

                     USER        PID ACCESS COMMAND
/dev/console         root        381 f....  syslogd

root@install:~ {522} $ lsof /initrd/dev/console
COMMAND   PID USER   FD   TYPE DEVICE SIZE   NODE NAME
keventd     2 root    0u   CHR    5,1      681424 /initrd/dev/console
keventd     2 root    1u   CHR    5,1      681424 /initrd/dev/console
keventd     2 root    2u   CHR    5,1      681424 /initrd/dev/console
ksoftirqd   3 root    0u   CHR    5,1      681424 /initrd/dev/console
ksoftirqd   3 root    1u   CHR    5,1      681424 /initrd/dev/console
ksoftirqd   3 root    2u   CHR    5,1      681424 /initrd/dev/console
kswapd      4 root    0u   CHR    5,1      681424 /initrd/dev/console
kswapd      4 root    1u   CHR    5,1      681424 /initrd/dev/console
kswapd      4 root    2u   CHR    5,1      681424 /initrd/dev/console
bdflush     5 root    0u   CHR    5,1      681424 /initrd/dev/console
bdflush     5 root    1u   CHR    5,1      681424 /initrd/dev/console
bdflush     5 root    2u   CHR    5,1      681424 /initrd/dev/console
kupdated    6 root    0u   CHR    5,1      681424 /initrd/dev/console
kupdated    6 root    1u   CHR    5,1      681424 /initrd/dev/console
kupdated    6 root    2u   CHR    5,1      681424 /initrd/dev/console
kjournald 259 root    0u   CHR    5,1      681424 /initrd/dev/console
kjournald 259 root    1u   CHR    5,1      681424 /initrd/dev/console
kjournald 259 root    2u   CHR    5,1      681424 /initrd/dev/console
kjournald 260 root    0u   CHR    5,1      681424 /initrd/dev/console
kjournald 260 root    1u   CHR    5,1      681424 /initrd/dev/console
kjournald 260 root    2u   CHR    5,1      681424 /initrd/dev/console
kjournald 261 root    0u   CHR    5,1      681424 /initrd/dev/console
kjournald 261 root    1u   CHR    5,1      681424 /initrd/dev/console
kjournald 261 root    2u   CHR    5,1      681424 /initrd/dev/console
kjournald 262 root    0u   CHR    5,1      681424 /initrd/dev/console
kjournald 262 root    1u   CHR    5,1      681424 /initrd/dev/console
kjournald 262 root    2u   CHR    5,1      681424 /initrd/dev/console
khubd     404 root    0u   CHR    5,1      681424 /initrd/dev/console
khubd     404 root    1u   CHR    5,1      681424 /initrd/dev/console
khubd     404 root    2u   CHR    5,1      681424 /initrd/dev/console
rpciod    776 root    0u   CHR    5,1      681424 /initrd/dev/console
rpciod    776 root    1u   CHR    5,1      681424 /initrd/dev/console
rpciod    776 root    2u   CHR    5,1      681424 /initrd/dev/console
lockd     780 root    0u   CHR    5,1      681424 /initrd/dev/console
lockd     780 root    1u   CHR    5,1      681424 /initrd/dev/console
lockd     780 root    2u   CHR    5,1      681424 /initrd/dev/console
nfsd      855 root    0u   CHR    5,1      681424 /initrd/dev/console
nfsd      855 root    1u   CHR    5,1      681424 /initrd/dev/console
nfsd      855 root    2u   CHR    5,1      681424 /initrd/dev/console
nfsd      856 root    0u   CHR    5,1      681424 /initrd/dev/console
nfsd      856 root    1u   CHR    5,1      681424 /initrd/dev/console
nfsd      856 root    2u   CHR    5,1      681424 /initrd/dev/console
nfsd      857 root    0u   CHR    5,1      681424 /initrd/dev/console
nfsd      857 root    1u   CHR    5,1      681424 /initrd/dev/console
nfsd      857 root    2u   CHR    5,1      681424 /initrd/dev/console
nfsd      858 root    0u   CHR    5,1      681424 /initrd/dev/console
nfsd      858 root    1u   CHR    5,1      681424 /initrd/dev/console
nfsd      858 root    2u   CHR    5,1      681424 /initrd/dev/console
nfsd      859 root    0u   CHR    5,1      681424 /initrd/dev/console
nfsd      859 root    1u   CHR    5,1      681424 /initrd/dev/console
nfsd      859 root    2u   CHR    5,1      681424 /initrd/dev/console
nfsd      860 root    0u   CHR    5,1      681424 /initrd/dev/console
nfsd      860 root    1u   CHR    5,1      681424 /initrd/dev/console
nfsd      860 root    2u   CHR    5,1      681424 /initrd/dev/console
nfsd      861 root    0u   CHR    5,1      681424 /initrd/dev/console
nfsd      861 root    1u   CHR    5,1      681424 /initrd/dev/console
nfsd      861 root    2u   CHR    5,1      681424 /initrd/dev/console
nfsd      862 root    0u   CHR    5,1      681424 /initrd/dev/console
nfsd      862 root    1u   CHR    5,1      681424 /initrd/dev/console
nfsd      862 root    2u   CHR    5,1      681424 /initrd/dev/console

Those processes accessing /initrd/dev/console are all kernel threads.
Processes with PID>100 were even started _after_ the call to pivot_root

It looks like it's not just the kernel init thread which isn't
giving up its console device...

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/J5XbxJmyeGcXPhERAny8AJ49TI0MNeQsZOPChraBjWskpybRPQCgsGoh
zHIKP5qoQ3dxlwXsUXWR3Hg=
=SiEn
-----END PGP SIGNATURE-----

