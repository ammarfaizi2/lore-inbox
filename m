Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWCXUwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWCXUwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWCXUwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:52:32 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:22791 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751269AbWCXUwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:52:32 -0500
Date: Fri, 24 Mar 2006 21:53:11 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Randy Vinson <rvinson@mvista.com>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH, RFC] Stop using tasklet in ds1374 RTC driver
Message-Id: <20060324215311.8ea42d20.khali@linux-fr.org>
In-Reply-To: <20060323214028.GB21477@mag.az.mvista.com>
References: <20060323201030.ccded642.khali@linux-fr.org>
	<4423084B.1070701@mvista.com>
	<20060323214028.GB21477@mag.az.mvista.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> > I've attached a similar patch that has been tested using the DS1374 on the 
> > Freescale MPC8349MDS reference system. It is patterned after a similar 
> > change made to the m41t00 driver. The changes work, but I am also 
> > unfamiliar with workqueues, so my patch may not be any better.
> 
> I'm no expert in workqueues either; however, after reading
> http://lwn.net/Articles/23634/, I believe that its unnecessary for an
> rtc driver to have its own workqueue since rtc writes aren't particularly
> time-critical.  If I am correct, then Randy's patch uses the proper wq calls.  
> 
> Agree?

I'm not sure. My first try was mostly similar to Randy's, using the
shared workqueue. However, LDD3 (and, for that matter, the article you
pointed to) says to be cautious when using the shared workqueue, not
only because of by what others can do to you, but also because of what
your can do to others.

ds1374_set_tlet triggers many i2c transfers, which may delay or sleep
depending on the underlying i2c implementation, and definitely will
take some time (at least 224 I2C clock cycles if I'm counting properly,
that is 14 ms at 16 kHz.)

So I came to the conclusion that it wouldn't be fair to other users if
ds1374 was using the shared workqueue. Now, I really don't know for
sure, so I'll let workqueue experts decide what should be done here.

Thanks,
-- 
Jean Delvare
