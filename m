Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129526AbRBGTnX>; Wed, 7 Feb 2001 14:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130015AbRBGTnN>; Wed, 7 Feb 2001 14:43:13 -0500
Received: from Cantor.suse.de ([213.95.15.193]:29968 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129526AbRBGTnF>;
	Wed, 7 Feb 2001 14:43:05 -0500
Date: Wed, 7 Feb 2001 20:43:04 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: changed proc permissions in 2.4
Message-ID: <20010207204304.C457@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there seems to be a bug in the /proc permissions handling. What I need
is a proc mount in a build chroot. This build chroot should not change
the settings on the build host, therefore its mounted read only. This
was ok with 2.2 kernels.
The 2.4 kernel has appearently only one "handler" for the proc
permissions:

fig:~/lsof # cat /proc/mounts | grep proc
proc /proc proc ro 0 0
/proc/bus/usb /proc/bus/usb usbdevfs rw 0 0

fig:~/lsof # remount rw /proc/

fig:~/lsof # cat /proc/mounts | grep proc
proc /proc proc rw 0 0
/proc/bus/usb /proc/bus/usb usbdevfs rw 0 0

fig:~/lsof # mount -oro -n -tproc none proc 

fig:~/lsof # cat /proc/mounts | grep proc
proc /proc proc ro 0 0
/proc/bus/usb /proc/bus/usb usbdevfs rw 0 0
none /root/lsof/proc proc ro 0 0

fig:~/lsof # remount rw /proc/

fig:~/lsof # cat /proc/mounts | grep proc
proc /proc proc rw 0 0
/proc/bus/usb /proc/bus/usb usbdevfs rw 0 0
none /root/lsof/proc proc rw 0 0

fig:~/lsof # umount proc/

fig:~/lsof # mount -oro -n -tproc proc proc 

fig:~/lsof # cat /proc/mounts | grep proc
proc /proc proc ro 0 0
/proc/bus/usb /proc/bus/usb usbdevfs rw 0 0
proc /root/lsof/proc proc ro 0 0

fig:~/lsof # cat /proc/version 
Linux version 2.4.1-olaf-loop-nohighmem (root@mandarine) (gcc version
2.95.2 19991024 (release)) #1 Tue Feb 6 13:35:53 GMT 2001

this is the 2.2 test:
grapefruit:~ # mkdir blah
grapefruit:~ # cd blah/
grapefruit:~/blah # mkdir proc
grapefruit:~/blah # cat /proc/mounts | grep proc
proc /proc proc rw 0 0
grapefruit:~/blah # mount -oro -n -tproc none proc
grapefruit:~/blah # cat /proc/mounts | grep proc
proc /proc proc rw 0 0
none proc proc ro 0 0

grapefruit:~/blah # cat /proc/version 
Linux version 2.2.16 (root@PReP.suse.de) (gcc version 2.95.3 19991030
(prerelease/franzo/20000625)) #1 Thu Sep 28 08:48:06 GMT 2000


Is this the way it should be? 
The real problem is X, it tries to open /proc/bus/pci/*/* rw, that
fails, no devices detected. Its all on ppc, just in case that matters.



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
