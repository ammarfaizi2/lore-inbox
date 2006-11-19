Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756578AbWKSLVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbWKSLVE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 06:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756577AbWKSLVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 06:21:04 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:48657 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1756578AbWKSLVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 06:21:01 -0500
Date: Sun, 19 Nov 2006 12:20:59 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Cc: "Kumar Gala" <galak@kernel.crashing.org>,
       "LKML" <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
Subject: Re: RTC , ds1307 I2C driver and NTP does not work.
Message-Id: <20061119122059.e75b2ea7.khali@linux-fr.org>
In-Reply-To: <008801c70b20$fc0fee70$1e67a8c0@Jocke>
References: <20061118151923.6044d956.khali@linux-fr.org>
	<008801c70b20$fc0fee70$1e67a8c0@Jocke>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,

On Sat, 18 Nov 2006 15:51:09 +0100, Joakim Tjernlund wrote:
> > It's OK to schedule or sleep in mpc_xfer. It's not OK to call mpc_xfer
> > from an interrupt context, which is what appears to be happening here.
> > So the ds1307 driver would need to be changed not to directly call
> > i2c_transfer from the interrupt. Using a workqueue should work.
> > 
> > That being said, I wonder why one would want to set the time from an
> > interrupt context in the first place. Maybe that's what needs fixing.
> 
> That's the way kernel NTP code always has done it. Probably to minimize
> latency, ideally you want to set the time when a new second occur since
> that's what most RTC HW expects.
> 
> Will a workqueue run directly after the one return from IRQ context?

There is no guarantee as to when the workqueue will process the request
as far as I know. The actual delay probably depends on the value of HZ.

There is no way around the delay in the case of I2C RTC chips anyway
(at least not with the current implementation), as the underlying I2C
bus driver may sleep as part of the bus transaction, and the RTC chip
driver can virtually be attached to every bus.

Note that the transaction itself will take some time anyway, I2C can be
quite slow.

-- 
Jean Delvare
