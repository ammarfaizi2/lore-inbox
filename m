Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRBYTXe>; Sun, 25 Feb 2001 14:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbRBYTXZ>; Sun, 25 Feb 2001 14:23:25 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:54184 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S129632AbRBYTXH>;
	Sun, 25 Feb 2001 14:23:07 -0500
Date: Sun, 25 Feb 2001 20:22:58 +0100
From: Marc Lehmann <pcg@goof.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux swap freeze STILL in 2.4.x
Message-ID: <20010225202258.A8890@cerebro.laendle>
Mail-Followup-To: Mike Galbraith <mikeg@wen-online.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010225155929.A371@cerebro.laendle> <Pine.LNX.4.33.0102251745360.568-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0102251745360.568-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, Feb 25, 2001 at 05:58:32PM +0100
X-Operating-System: Linux version 2.4.2-ac3 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 05:58:32PM +0100, Mike Galbraith <mikeg@wen-online.de> wrote:
> Signal delivery during oomest does not work (last time I tested).
> Andrea fixed this once.. long time ~problem.

Hmm, here is soemthing that is new: Just now, the machine gets VERY very
sluggish and swaps:

             total       used       free     shared    buffers     cached
Mem:        255296     253708       1588          0      29808     183020
-/+ buffers/cache:      40880     214416
Swap:        99992      99992          0

now, there is plenty of free memory (200megs!) but no spwapsace and the
kernel keeps swapping. The only interesting processes here are:

  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
  112 ?        S      0:00    742  1366 38921 3460  1.3 /opt/mysql//libexec/mysqld --basedir=/opt/mysql/ --datadir=/var/mysql --user=root --pid-
  205 ?        S      2:28  12335  1444 27167 4294966180 6728.9 /usr/bin/X11/X :0 -audit 1 -auth /etc/cfg/Xauthority -a 2 -once -t 5 vt02 -defer
  421 pts/13   TN     1:00    804   707 31552 17444  6.8 /usr/bin/perl ./summarize
  376 pts/10   R      7:07    269   129 22614 1852  0.7 rsync -av . doom cerebro-root/. --delete

when I SIGSTOP the summarize script (which uses mysql very intensively)
the system starts to work again but the memory situation does not
improve. The RSS size of X puzzles me a bit, but this was always the case
under 2.4.2 and 2.4.2ac3 (and maybe before) and didn't cause a problem
before.

Another bug I found is that initializing md on the kernel commandline in
the wrong order (first md1 then md0) keeps the kernel from mounting md0
as root-device. Another problem is that, when I "startraid /dev/md1" (a
two-partition, striped raid without persistent superblock) I get strange
errors in /var/log/kernel (if anybody asks I'll provide them) but it works
fine when I sue md=x on the kernel commandline. It's not a configuration
problem sicne I got the same strange probkems with the mdstart I used
successfully under 2.1 and 2.2.

Another nitpick is kernel-pcmcia: For some unexplainable reason, the
kernel SWITCHES OFF POWER to the pcmcia slots BEFORE notifying apmd, which
then tries to save important data and locks (not the machine, just the
script) since the network is suddenly dead although interface etc.. all
still exist. Under the pcmcia-cs package one could work around this bug by
specifying do_apm=0 for the pcmcia_core module, which has no effect under
2.4.

So I do keep asking me: does anybody actually use 2.4 on production
machines? ;-> (Historically, it seesm that my machines tend to freeze
easily because of sudden OOM and/or reiserfs ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
