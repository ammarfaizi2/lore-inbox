Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268548AbTGRQzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270255AbTGRQzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:55:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6068 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S268548AbTGRQyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:54:03 -0400
Message-ID: <3F182907.30EA5922@us.ibm.com>
Date: Fri, 18 Jul 2003 10:06:15 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
CC: Andrew Morton <akpm@osdl.org>, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk, rddunlap@osdl.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] [1/2] kernel error reporting (revised)
References: <Mutt.LNX.4.44.0307181148340.5813-100000@excalibur.intercode.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> 
> On Thu, 17 Jul 2003, Jim Keniston wrote:
> 
> > 3. Given the above, what should the evlog.c caller do when
> > kernel_error_event_iov() returns -EINPROGRESS?
> > a. Nothing.  Figure the packet will probably get logged.
> > b. Just to be safe, report it via printk, the same way we report dropped
> > packets.
> > We currently do (a).  (b) would mean that every event logged from IRQ
> > context would be cc-ed to printk.
> 
> I don't think this irq detection logic should be added at all here, let
> the caller reschedule its logging if running in irq context.
> 
> - James
> --
> James Morris
> <jmorris@intercode.com.au>

Yes, this makes sense.  At the kerror.c level, just return -EDEADLK if in_irq().
Delay packet delivery (via a tasklet, as before) at the evlog.c level instead.
That way, we know at the evlog.c level (in the tasklet) whether the event packet
was delivered to anybody, and can paraphrase it to printk if it wasn't.

Is this the sort of thing you had in mind?
Jim K
