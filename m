Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbTDAQ1i>; Tue, 1 Apr 2003 11:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbTDAQ1i>; Tue, 1 Apr 2003 11:27:38 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:14089 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id <S262684AbTDAQ1d>;
	Tue, 1 Apr 2003 11:27:33 -0500
Message-ID: <3E89C095.1080603@kn.vutbr.cz>
Date: Tue, 01 Apr 2003 18:38:45 +0200
From: Michal Schmidt <schmidt@kn.vutbr.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: cs, en
MIME-Version: 1.0
To: akpm@digeo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm2
References: <20030401081012$4c1b@gated-at.bofh.it>
In-Reply-To: <20030401081012$4c1b@gated-at.bofh.it>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
 >
 >   There is a small patch from Ingo here against the CPU scheduler 
which we
 >   hope will fix the new starvation problems which people have been 
reporting.
 >   I this is you, please test and report.


I patched 2.5.66 with:
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.66-mm2-1.gz

I can still easily reproduce my starvation problem with:

cat cedo.iso | bzip2 > /tmp/cedo.iso.bz2
(cedo.iso is a 700MB CD image)

On another virtual console, I run the following script to demonstrate
the starvation:

#!/bin/sh
while true; do
   sleep 30
   date
   ps x
   date
   echo -----
done


At first, everything is OK:

Tue Apr  1 18:00:03 CEST 2003
   PID TTY      STAT   TIME COMMAND
   301 tty1     S      0:00 -bash
   302 tty2     S      0:00 -bash
   647 tty1     S      0:00 cat cedo.iso
   648 tty1     R      0:54 bzip2
   651 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   652 tty2     S      0:00 tee inter-2.5.66mm2.potreti
   655 tty2     R      0:00 ps x
Tue Apr  1 18:00:03 CEST 2003
-----
Tue Apr  1 18:00:33 CEST 2003
   PID TTY      STAT   TIME COMMAND
   301 tty1     S      0:00 -bash
   302 tty2     S      0:00 -bash
   647 tty1     S      0:00 cat cedo.iso
   648 tty1     R      1:24 bzip2
   651 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   652 tty2     S      0:00 tee inter-2.5.66mm2.potreti
   659 tty2     R      0:00 ps x
Tue Apr  1 18:00:33 CEST 2003
-----


But after a while the problem appears:

-----
Tue Apr  1 18:05:09 CEST 2003
   PID TTY      STAT   TIME COMMAND
   301 tty1     S      0:00 -bash
   302 tty2     S      0:00 -bash
   647 tty1     D      0:01 cat cedo.iso
   648 tty1     S      5:55 bzip2
   651 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   652 tty2     S      0:00 tee inter-2.5.66mm2.potreti
  1043 tty2     R      0:00 ps x
Tue Apr  1 18:05:11 CEST 2003
-----
Tue Apr  1 18:05:49 CEST 2003
   PID TTY      STAT   TIME COMMAND
   301 tty1     S      0:00 -bash
   302 tty2     S      0:00 -bash
   647 tty1     S      0:01 cat cedo.iso
   648 tty1     R      6:37 bzip2
   651 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   652 tty2     S      0:00 tee inter-2.5.66mm2.potreti
  1047 tty2     R      0:00 ps x
Tue Apr  1 18:05:51 CEST 2003
-----
Tue Apr  1 18:06:21 CEST 2003
   PID TTY      STAT   TIME COMMAND
   301 tty1     S      0:00 -bash
   302 tty2     S      0:00 -bash
   647 tty1     D      0:01 cat cedo.iso
   648 tty1     S      7:23 bzip2
   651 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   652 tty2     S      0:00 tee inter-2.5.66mm2.potreti
  1051 tty2     R      0:00 ps x
Tue Apr  1 18:06:38 CEST 2003
-----
Tue Apr  1 18:07:08 CEST 2003
   PID TTY      STAT   TIME COMMAND
   301 tty1     S      0:00 -bash
   302 tty2     S      0:00 -bash
   647 tty1     D      0:01 cat cedo.iso
   648 tty1     S      7:59 bzip2
   651 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   652 tty2     S      0:00 tee inter-2.5.66mm2.potreti
  1055 tty2     R      0:00 ps x
Tue Apr  1 18:07:14 CEST 2003
-----
Tue Apr  1 18:07:53 CEST 2003
   PID TTY      STAT   TIME COMMAND
   301 tty1     S      0:00 -bash
   302 tty2     S      0:00 -bash
   647 tty1     S      0:01 cat cedo.iso
   648 tty1     R      8:37 bzip2
   651 tty2     R      0:00 /bin/sh ./test-interactivity.sh
   652 tty2     S      0:00 tee inter-2.5.66mm2.potreti
  1059 tty2     R      0:00 ps x
Tue Apr  1 18:08:03 CEST 2003
-----
Tue Apr  1 18:08:33 CEST 2003
   PID TTY      STAT   TIME COMMAND
   301 tty1     S      0:00 -bash
   302 tty2     S      0:00 -bash
   647 tty1     D      0:01 cat cedo.iso
   648 tty1     S      9:38 bzip2
   651 tty2     S      0:00 /bin/sh ./test-interactivity.sh
   652 tty2     S      0:00 tee inter-2.5.66mm2.potreti
  1066 tty2     R      0:00 ps x
Tue Apr  1 18:08:54 CEST 2003
-----

I use Debian Woody on Athlon 800MHz, Asus A7V, 384MB RAM, disk WDC
WD800JB-00CRA1, nVidia Geforce2 MX, Realtek RTL-8139C, SB Live.
GCC is 2.95.4.

Michal

