Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUJBU3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUJBU3U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 16:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUJBU3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 16:29:20 -0400
Received: from serio.al.rim.or.jp ([202.247.191.123]:49378 "EHLO
	serio.al.rim.or.jp") by vger.kernel.org with ESMTP id S267536AbUJBU3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 16:29:09 -0400
Message-ID: <415F0F89.6080605@yk.rim.or.jp>
Date: Sun, 03 Oct 2004 05:28:57 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Chiaki <ishikawa@yk.rim.or.jp>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Subject: Re: FSCK message suppressed during booting? (2.6.9-rc2)
References: <E1CCtxn-00075V-00@calista.eckenfels.6bone.ka-ip.net> <415C2B6C.6050401@yk.rim.or.jp> <415C6E30.1020705@yk.rim.or.jp> <415C84AB.4060808@yk.rim.or.jp>
In-Reply-To: <415C84AB.4060808@yk.rim.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I will wait the response from Debian package
> maintainer.

Dear all,

Thanks to the investigative work of
Debian sysvinit package maintainer, Miquel van Smoorenburg,
we have found that I had an incorrect major and minor
number for /dev/console on my PC under 2.6.9-rc2!

When I re-created /dev/console with correct major and minor number,
fsck message appears without a problem during booting
together with other formerly invisible kernel messages.

Why did my PC work *FLAWLESSLY* under 2.4.2x series?
I have been using this setup at least for a few years now.
(I can't remember the exact history. CPU, motherboard have
changed during the life time of my computer now.)

So I investigated a little.

Under 2.6.9-rc2 : Incorrect major, minor number for console on my PC.

     Under 2.6.9-rc2, I had the following major, minor for /dev/console.

         ls -l /dev/console
     crw-------  2 root root 4, 64 2004-10-02 01:46 /dev/console

     This turned out to be the culprit for my problem.

     Then WHY ON EARTH did my PC log fsck messages to
     the console under 2.4.2x?

Rebooting into 2.4.2x: correct major and minor number!

     To check this, I rebooted into 2.4.25 *with devfsd running* and
     found the correct /dev/console (major/minor) number under it.

     ls -l /dev/console
     crw-------  1 root tty 5, 1 2004-10-03 04:15 /dev/console

     Aha, correct /dev/console major and minor number!

     It seems that devfsd saved me from the underlying incorrect setting.

     I usually boot 2.4.25 with devfsd from the boot command line.  The
     devfsd function in the kernel presumably re-created /dev/console
     with the correct major and minor number at boot time(?).
     Thus fsck output was visible.

     My boot command line for booting 2.4.xx was like this.
     Kernel command line: mem=nopentium devfs=mount drm=debug 
root=/dev/sda6 ro scsihosts=sym53c8xx:tmscsim BOOT_IMAGE=2425

     Under 2.4.25, I get these devfs messages in dmesg output.

         "dmesg | egrep devfs" output.
     devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
     devfs: devfs_debug: 0x0
     devfs: boot_options: 0x1
     Mounted devfs on /dev
     usb.c: registered new driver usbdevfs


Rebooted into 2.6.9-rc2: Recreated /dev/console manually.

I rebooted into 2.6.9-rc2 to manually re-create /dev/console with
correct major and minor number.  I had installed udev for a day,
but it doesn't seem to try to re-create /dev/console and,
for that matter, invocation of udev would be too late
for me to see fsck output during booting
even if it re-created /dev/console with correct major and minor numbers.

     duron:/home/ishikawa# rm /dev/console
     duron:/home/ishikawa# cd /dev
     duron:/dev# ./MAKEDEV console
     duron:/dev# ls -l /dev/console
     crw-------  1 root tty 5, 1 2004-10-03 04:27 /dev/console
     duron:/dev#

After I recreated and "touch /forcefsck; reboot", I saw
the fsck message now without a problem!

Morale of the story:

        Commercial distribution makers  and maybe udev package
        maintainers (since udev is only meant for 2.6.y kernels
        and later,) might want to include a simple checker for
        the correct permissions, major and number settings
        of a few key devices to save time for support calls
        from those who have been saved by devfsd under previous
     2.4.x kernel up until that time.
        (Once the cause is known, the fix is easy. But knowing
        the cause takes time.)

        I have no idea how many percentage of linux users have strange
        permissions and/or major/minor numbers for a few important
        devices, but when majority of them would move into 2.6.y series
        kernel in the next year or so, some users who have been saved
        by devfsd will see certain things no longer work.
        Majority of installed linux users are 2.4.x series kernels
        but they certainly would tinker with 2.6.2y kernels when
        they become available :-)

cf.

I have no idea why I had incorrect major and minor number for console
*in the first place*.  Current MAKEDEV has correct (major, minor) for
"console".

     # cd /dev
     # egrep console MAKEDEV
         $0 $opts console
         $0 $opts console
         $0 $opts console
         $0 $opts console
         $0 $opts console
         $0 $opts console
         $0 $opts console
         $0 $opts console
         $0 $opts console
         $0 $opts consoleonly
         $0 $opts console
         $0 $opts console
      consoleonly)
             makedev console c 5 1 $cons
                 makedev console c 5 1 $cons
                 symlink console tty0
      console)
         $0 $opts consoleonly


      Hmm... Was there a transition of major/minor numbers
      somewhere between 2.2.y -> 2.4.z  ?

-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
