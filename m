Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267468AbUG2WPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267468AbUG2WPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUG2WPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:15:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:51357 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267468AbUG2WPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:15:14 -0400
Subject: Re: [patch] IRQ threads
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Scott Wood <scott@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
In-Reply-To: <20040729202100.GA28507@yoda.timesys>
References: <20040727225040.GA4370@yoda.timesys>
	 <20040728081005.GA20100@elte.hu> <20040728231241.GE6685@yoda.timesys>
	 <20040729193341.GA27057@elte.hu>  <20040729202100.GA28507@yoda.timesys>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091135558.1453.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 22:12:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-07-29 at 21:21, Scott Wood wrote:
> The intent is to make enable_irq() robust against calls while the
> thread is still running/pending (such as if the thread has lower
> priority than the task that calls enable_irq()).  This implies that
> the preceding disable was of the _nosync() variety.
> 
> I believe we saw drivers/net/8390.c doing this, and it was causing an

8390 does a disable_irq_nosync having previously cleared the IRQ on the
controller. This is neccessary because IRQ arrival on PC hardware is
asynchronous to all other busses and can take incredibly long times on
SMP hardware prior to PIV.  Thus it happens now and then that the
controller emits an IRQ, we clear the source, the clear is done and
later the IRQ arrives that has already been cleared down on the original
IRQ source. Most drivers just use spinlocks but the 8390 is
so slow that is has to pull other stunts or even things like serial
ports and the 1Khz clock slide.

Alan

