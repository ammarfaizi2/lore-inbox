Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbUASJb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 04:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbUASJb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 04:31:58 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:26531 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264472AbUASJby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 04:31:54 -0500
Date: Mon, 19 Jan 2004 18:31:42 +0900
From: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: Re: [PATCH] readX_relaxed interface
To: Grant Grundler <iod00d@hp.com>, Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       jeremy@sgi.com
Message-id: <023b01c3de6f$10276820$2987110a@lsd.css.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="ISO-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <20040115204913.GA8172@sgi.com> <20040116003224.GF23253@kroah.com>
 <20040116050059.GA13222@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Grant Grundler" <iod00d@hp.com>


> On Thu, Jan 15, 2004 at 04:32:25PM -0800, Greg KH wrote:
> > It looks ok, but it would really be good if we could indicate if the
> > read actually was successful.  Right now some platforms can detect
> > faults and do not have a way to get that error back to the driver in a
> > sane manner.  If we were to change the read* functions to look something
> > like:
> > int readb(void *addr, u8 *data);
> > it would be a world easier.
> 
> I've worked on systems with that kind of an interface and it
> really makes a mess of the code. And many of the drivers just
> ignored the read return value.

I've also worked on such system.
I understand it's difficult all drivers use that kind of an interface.
But if some common drivers like scsi, FC and LAN drivers use such interface,
it's usefull for most users.

> 
> > Now I'm not saying I want to change the existing interfaces to support
> > this, that's too much code to change for even me (and is a 2.7 thing.)
> 
> I think you'll find it's extremely invasive if it's going to be useful.
> The drivers have to be rewritten to check each PIO return value
> and then do something intelligent at that point. HPUX had drivers
> that did this for "Host Power Fail" support 10 years ago but
> it's *very* difficult to get all the error handling right in
> each of the code pathes.
> 
> My preference is the driver register a "clean up all pending IO and
> free related data structures" so it's back to a state as if it hadn't
> been started. Then when a PIO read (or write) fails, the mechanism for
> detecting the read failure doesn't depend on synchronous errors being
> reported/checked by software on each read. ie the mechanism for
> detecting the failure *can* be in the PIO read code path but
> doesn't have to be if HW has facilities to detect failures.
> (I'm thinking of parisc HPMC and ia64 MCA handling).

But, when the read thread continues without noticing the error
(before the error is asynchronously notified),
the thread runs based on wrong data and may panic.
So I think PIO read error must be notified synchronously.

On the other hand, PIO write error can be notified asynchronously,
because software does not use it.

Hironobu Ishii
