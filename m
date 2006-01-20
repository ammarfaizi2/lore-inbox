Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWATLFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWATLFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWATLFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:05:45 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:37558 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750822AbWATLFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:05:44 -0500
Date: Fri, 20 Jan 2006 14:05:08 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: kus Kusche Klaus <kus@keba.com>
Cc: John Ronciak <john.ronciak@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: My vote against eepro* removal
Message-ID: <20060120110508.GB24815@2ka.mipt.ru>
References: <AAD6DA242BC63C488511C611BD51F367323326@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323326@MAILIT.keba.co.at>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 20 Jan 2006 14:05:08 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 11:51:23AM +0100, kus Kusche Klaus (kus@keba.com) wrote:
> From: Evgeniy Polyakov [mailto:johnpol@2ka.mipt.ru] 
> > Each MDIO read can take upto 2 msecs (!) and at least 20 
> > usecs in e100,
> > and this runs in timer handler.
> > Concider attaching (only compile tested) patch which moves 
> > e100 watchdog
> > into workqueue.
> 
> Tested the patch. Works and has the expected effects:
> 
> Fully preemptible kernel: 
> No change: 500 us delay at rtprio 1, no delay at higher rtprio.
> (you just moved the 500 us piece of code from one rtprio 1 kernel 
> thread to another rtprio 1 kernel thread).
> 
> Kernel with desktop preemption:
> Originally: Threads at any rtprio suffered from 500 us delay.
> With your patch: Only rtprio 1 threads suffer from 500 us delay,
> no delay at higher rtprio.

Just a hack:

--- drivers/net/e100.c.1	2006-01-20 13:39:19.000000000 +0300
+++ drivers/net/e100.c	2006-01-20 14:15:40.000000000 +0300
@@ -879,8 +879,8 @@
 
 	writel((reg << 16) | (addr << 21) | dir | data, &nic->csr->mdi_ctrl);
 
-	for(i = 0; i < 100; i++) {
-		udelay(20);
+	for(i = 0; i < 1000; i++) {
+		udelay(2);
 		if((data_out = readl(&nic->csr->mdi_ctrl)) & mdi_ready)
 			break;
 	}


> -- 
> Klaus Kusche                 (Software Development - Control Systems)
> KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
> Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
> E-Mail: kus@keba.com                                WWW: www.keba.com
>  

-- 
	Evgeniy Polyakov
