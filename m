Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRKXTDd>; Sat, 24 Nov 2001 14:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRKXTDM>; Sat, 24 Nov 2001 14:03:12 -0500
Received: from serv02.lahn.de ([195.211.46.202]:39256 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S279105AbRKXTCv>;
	Sat, 24 Nov 2001 14:02:51 -0500
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Sat, 24 Nov 2001 20:02:05 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: pmhahn@titan.lahn.de
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] net/8139too
In-Reply-To: <20011116112614.A725@walker.iti.informatik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.42.0111241951440.30098-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Philipp Matthias Hahn wrote:

> Hello Andrew, Jedd, LKML!
>
> On 2001.11.16 08:17 Andrew Morton wrote:
> > > Since linux-2.4.15-pre[14]+kdb+freeswan I get an oops when stopping my
> > > 8139too network:
> > >
> > > # ifdown eth0
> > > eth0: unable to signal thread
> >
> > Could you please tell us what the return value is from kill_proc()?
> Now running 2.4.15-pre5 with your patch and kill_proc returns -3.

Found it! Here's what happend:

modprobe 8139too:
rtl8139_init_board() zeros "struct rtl8139_private"

ifconfig eth0 up:
rtl8139_open() is called, which starts rtl8139_thread()

ifconfig eth0 down:
rtl8139_close() sets "time_to_die = 1"
rtl8139_thread() exits

ifconfig eth0 up 'again':
rtl8139_open() is called, which starts rtl8139_thread()
time_to_die is still 1
rtl8139_thread() exits immediately

ifconfig eth0 down:
rtl8139_close() tries to signal a nonexistent thread -> ESRCH

rmmod 8139too
OOPS

Resetting time_to_die=0 in rtl8139_open() should fix the problem:

--- linux-2.4.15/drivers/net/8139too.c.orig	Sat Nov 24 19:48:00 2001
+++ linux-2.4.15/drivers/net/8139too.c	Sat Nov 24 19:48:49 2001
@@ -1270,6 +1270,7 @@
 	tp->full_duplex = tp->duplex_lock;
 	tp->tx_flag = (TX_FIFO_THRESH << 11) & 0x003f0000;
 	tp->twistie = 1;
+	tp->time_to_die = 0;

 	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

