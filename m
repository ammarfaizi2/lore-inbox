Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317045AbSFKNm0>; Tue, 11 Jun 2002 09:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317047AbSFKNmZ>; Tue, 11 Jun 2002 09:42:25 -0400
Received: from fysh.org ([212.47.68.126]:42672 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S317045AbSFKNmY>;
	Tue, 11 Jun 2002 09:42:24 -0400
Date: Tue, 11 Jun 2002 14:42:25 +0100
From: Athanasius <Athanasius@miggy.org.uk>
To: Keith Owens <kaos@ocs.com.au>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel: request_module[net-pf-10]: fork failed, errno 11
Message-ID: <20020611134225.GD13726@miggy.org.uk>
Mail-Followup-To: Athanasius <Athanasius@miggy.org.uk>,
	Keith Owens <kaos@ocs.com.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020608094307.GA6522@miggy.org.uk> <21483.1023531725@ocs3.intra.ocs.com.au> <20020609175414.GB13726@miggy.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 06:54:14PM +0100, Athanasius wrote:
> On Sat, Jun 08, 2002 at 08:22:05PM +1000, Keith Owens wrote:
> > On Sat, 8 Jun 2002 10:43:07 +0100, 
> > Athanasius <link@gurus.tf> wrote:
> > >  I'm seeing a lot of:
> > >
> > >	kernel: request_module[net-pf-10]: fork failed, errno 11
> [snip]
> > 
> > That error is occurring before modprobe has run, long before it gets to
> > modules.conf.  You need to find out why fork() for modprobe on your
> > system is failing with EAGAIN.  Have you reached the limit on the
> > number of tasks?
> 
>    Not as far as I can tell.  It would be easier to tell if 'sa' (BSD
> process accounting) carried useful information like timestamps per
> process or even just their PIDs (to match to a *.* syslog'd file).

  Ok, a little more investigation:

root@bowl:/sbin# cat modprobe-logging 
#!/bin/sh

echo "`date` `ps axh | wc -l`: $@" >> /var/log/modprobe.log
exec /sbin/modprobe $@
root@bowl:/sbin# cat /proc/sys/kernel/modprobe 
/sbin/modprobe-logging

In /var/log/kern.log:
Jun 11 14:36:58 bowl kernel: request_module[net-pf-10]: fork failed, errno 11

And in /var/log/modprobe.log:

Tue Jun 11 14:36:41 BST 2002     229: -s -k -- net-pf-10
Tue Jun 11 14:36:58 BST 2002     228: -s -k -- net-pf-10
Tue Jun 11 14:36:58 BST 2002     227: -s -k -- net-pf-10
Tue Jun 11 14:37:02 BST 2002     227: -s -k -- net-pf-10

/proc/sys/kernel/threads-max is 4095.

  So, nowhere near threads-max (if ps axh is a good test of that),
certainly not processes-wise.  Yet at times the request_module is
failing anyway.  It would seem that an immediate followup attempt works.
Yup, just had another instance:

Jun 11 14:40:11 bowl kernel: request_module[net-pf-10]: fork failed, errno 11
Tue Jun 11 14:40:07 BST 2002     235: -s -k -- net-pf-10
Tue Jun 11 14:40:11 BST 2002     229: -s -k -- net-pf-10
Tue Jun 11 14:40:11 BST 2002     230: -s -k -- net-pf-10
Tue Jun 11 14:40:42 BST 2002     227: -s -k -- net-pf-10

  Note that ulimit -u is 256, but that's per login instance normally and
I'd not have thought a kernel thread goes through PAM anyway...

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org.uk / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
