Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289885AbSBFAoW>; Tue, 5 Feb 2002 19:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289886AbSBFAoD>; Tue, 5 Feb 2002 19:44:03 -0500
Received: from ua0d5hel.dial.kolumbus.fi ([62.248.132.0]:52237 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S289885AbSBFAnz>; Tue, 5 Feb 2002 19:43:55 -0500
Message-ID: <3C607C43.92262E82@kolumbus.fi>
Date: Wed, 06 Feb 2002 02:43:47 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <Pine.LNX.4.33.0202050235360.21544-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> > I can renice this only for testing purposes. Normally these are not
> > run as root so I can't do negative renice.
> 
> but you can run the audio tasks as SCHED_FIFO?

Yes, two server processes (input and distributor) are running all the time
transferring data, the actual CPU time taking calculation processes (which
connect to the distributor) are spawned dynamically as requested by ui
clients from inetd-kind of server running at normal user privileges.

> (you do not have to run the tasks as root, you only have to do the renice
> as root.)
> > > is it more important to run these CPU hogs than to run interactive 
> > > tasks? If yes then renice them to -11.

I tried to renice many of the processes with different combinations and
didn't make any difference.

> How much of a CPU hog is your task? What does 'top' show while you are
> using your app? (pasting top output here will show the situation.)

This looks like some kind of resonance, as it works better with some
specific loads and worse with others. Is it possible this has something to
do with longer timeslices?

Here's top screens of two badly behaving load combinations:

Data path is

1) soundsrv2
2) streamdist
3) spectrum
4) guispect

--- 8< ---

  5:01am  up 6 min,  2 users,  load average: 0.44, 0.47, 0.22
75 processes: 72 sleeping, 3 running, 0 zombie, 0 stopped
CPU states: 14.3% user, 11.9% system,  0.0% nice, 73.6% idle
Mem:   257040K av,  155588K used,  101452K free,       0K shrd,   39632K
buff
Swap:  257032K av,       0K used,  257032K free                   46024K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  809 root      15   0 58312  14M  3744 S    11.8  5.7   1:12 X
  946 visitor   15   0  9572 9572  3584 S     8.0  3.7   0:26 guispect
  999 visitor   15   0  1616 1616  1324 S     2.2  0.6   0:01 spectrum
  944 visitor   15   0  1184 1184   984 S     1.5  0.4   0:03 soundsrv2
  939 visitor   15   0  1184 1184   984 R     1.4  0.4   0:06 soundsrv2
 1000 visitor   15   0  1236 1236  1024 S     0.7  0.4   0:00 streamdist
  943 visitor   15   0  1236 1236  1024 S     0.5  0.4   0:02 streamdist
  912 visitor   15   0  4564 4564  3544 R     0.2  1.7   0:00 gnome-terminal
 1006 visitor   15   0  1076 1076   856 R     0.1  0.4   0:00 top
    1 root      15   0   532  532   464 S     0.0  0.2   0:04 init
    2 root      15   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      15   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled
    4 root      15   0     0    0     0 SW    0.0  0.0   0:00 kswapd
    5 root      25   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    6 root      15   0     0    0     0 SW    0.0  0.0   0:00 kupdated
    7 root      15   0     0    0     0 SW    0.0  0.0   0:00 kjournald
  105 root      15   0     0    0     0 SW    0.0  0.0   0:00 kjournald

--- 8< ---

  5:01am  up 6 min,  2 users,  load average: 0.35, 0.44, 0.22
75 processes: 71 sleeping, 4 running, 0 zombie, 0 stopped
CPU states: 19.4% user, 27.7% system,  0.0% nice, 52.7% idle
Mem:   257040K av,  155648K used,  101392K free,       0K shrd,   39664K
buff
Swap:  257032K av,       0K used,  257032K free                   46032K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  809 root      15   0 58328  14M  3744 S    27.9  5.7   1:19 X
  946 visitor   15   0  9572 9572  3584 R    11.3  3.7   0:29 guispect
  939 visitor   15   0  1184 1184   984 R     2.4  0.4   0:07 soundsrv2
 1014 visitor   15   0  1612 1612  1324 S     2.4  0.6   0:00 spectrum
  944 visitor   15   0  1184 1184   984 S     1.0  0.4   0:03 soundsrv2
 1015 visitor   15   0  1236 1236  1024 S     0.5  0.4   0:00 streamdist
  943 visitor   15   0  1236 1236  1024 S     0.4  0.4   0:02 streamdist
  862 visitor   15   0  5416 5416  4012 S     0.1  2.1   0:00 panel
  891 visitor   15   0  4348 4348  3552 S     0.1  1.6   0:00
tasklist_applet
    1 root      15   0   532  532   464 S     0.0  0.2   0:04 init
    2 root      15   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      15   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled
    4 root      15   0     0    0     0 SW    0.0  0.0   0:00 kswapd
    5 root      25   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    6 root      15   0     0    0     0 SW    0.0  0.0   0:00 kupdated
    7 root      15   0     0    0     0 SW    0.0  0.0   0:00 kjournald
  105 root      15   0     0    0     0 SW    0.0  0.0   0:00 kjournald

--- 8< ---


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

