Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311945AbSCOHDD>; Fri, 15 Mar 2002 02:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311947AbSCOHCy>; Fri, 15 Mar 2002 02:02:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311945AbSCOHCp>;
	Fri, 15 Mar 2002 02:02:45 -0500
Message-ID: <3C919C27.CA5558AF@zip.com.au>
Date: Thu, 14 Mar 2002 23:00:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Maas <dmaas@dcine.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: unwanted disk access by the kernel?
In-Reply-To: <20020315013644.A26891@morpheus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:
> 
> I've been trying to set up my laptop for mobile use. I'm having a
> problem with unwanted disk activity - even when the system is
> completely idle, there is still an occasional trickle of disk writes
> (which prevents the poor hard drive from ever spinning down).
> 
> Yes, I thought this was a user-space issue too - but even booting into
> a bare-bones root environment does not stop the occasional disk
> access! Here is everything that's left:

Are all filesystems mounted with the `noatime' mount option?

>  PID USER       VSZ  RSS     TIME STAT COMMAND          WCHAN
>     7 root         0    0 00:00:00 SW   [kupdated]       kupdate
>     6 root         0    0 00:00:00 SW   [bdflush]        bdflush
>     5 root         0    0 00:00:00 SW   [kswapd]         kswapd
>     4 root         0    0 00:00:00 SWN  [ksoftirqd_CPU0] ksoftirqd
>     1 root      1316  524 00:00:05 S    init [S]         select
>     2 root         0    0 00:00:00 SW   [keventd]        context_thread
>     3 root         0    0 00:00:00 SW   [kapmd]          apm_mainloop
>     8 root         0    0 00:00:00 Z    [khubd <defunct> exit

eww.  Does khubd always do that?  Does this patch make it behave?




--- linux-2.4.19-pre3/drivers/usb/hub.c	Mon Mar 11 14:53:21 2002
+++ linux-akpm/drivers/usb/hub.c	Thu Mar 14 22:59:17 2002
@@ -908,6 +908,7 @@ static int usb_hub_thread(void *__hub)
 	 */
 
 	daemonize();
+	reparent_to_init();
 
 	/* Setup a nice name */
 	strcpy(current->comm, "khubd");

-
