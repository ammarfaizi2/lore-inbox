Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWA1B3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWA1B3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWA1B3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:29:19 -0500
Received: from pop-altamira.atl.sa.earthlink.net ([207.69.195.62]:19692 "EHLO
	pop-altamira.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1422773AbWA1B3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:29:19 -0500
Message-ID: <28705905.1138411758814.JavaMail.root@elwamui-sweet.atl.sa.earthlink.net>
Date: Fri, 27 Jan 2006 17:29:18 -0800 (GMT-08:00)
From: betonava@earthlink.net
Reply-To: betonava@earthlink.net
To: linux-kernel@vger.kernel.org
Subject: 25ms latency for msleep() and NAPI rx_schedule()/poll()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: EarthLink Zoo Mail 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

After migrating from 2.6.12 to 2.6.13/2.6.14 we have started seeing sporadic ~25ms scheduling delays after a process is woken up from a msleep(), and ~25ms latency for a NAPI rx_schedule()/poll()  to be schedule.

Has anybody experience anything like this?

Here is more background information:

APPLICATION:

The application is a media streaming server which pushes video data onto multiple gigabit Ethernet interfaces. The software consists of two main components. One of them push data onto the Ethernet layer, while the other polls for notification of when data has been transmitted.

The data is push on top the Ethernet drivers and is queued to the NICs by using the NAPI poll() mechanisms.

The polling for completion is very simple. The process checks for completion and then it goes to sleep for 2ms and rechecks.

LONG LATENCIES:

We have some basic instrumentation to see how the system performs. We measure the longest time a msleep() takes to be re-schedule (include sleep time + scheduling time). We also measure the time the NAPI poll() took to be schedule from the time its requested during the first interrupt (rx_schedule) to the time it's executed (netdev->poll())

While running on 2.6.12 the longest sleep was 5ms, and the longest poll scheduling was 2ms.

The same application running on 2.6.13 or 2.6.14 shows ~25ms msleep() delays, and ~25ms latencies for scheduling NAPI poll(). These big delays are not common, but they do happen once every 10min.

I tried a few combination to see if I could get some light on these. We tried

    * Intel 32 vs x86_64

    * Hyper threading on and off

    * different CPU affinity settings

In all cases we saw these long latencies.

While we run our tests the machines are not very  busy. The min idle time is about 80%, system time is not more than 7% and soft-irq is about 4%.

Any suggestion of what's causing this long delays?

Thanks

Beto

 
