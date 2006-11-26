Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935334AbWKZLBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935334AbWKZLBE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 06:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935335AbWKZLBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 06:01:04 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:40896 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S935334AbWKZLBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 06:01:02 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/2] Introduce mutex_lock_timeout
Date: Sun, 26 Nov 2006 12:00:50 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org, linux-driver@qlogic.com
References: <20061109182721.GN16952@parisc-linux.org> <200611251700.39806.ioe-lkml@rameria.de> <20061125163242.GH14076@parisc-linux.org>
In-Reply-To: <20061125163242.GH14076@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611261200.52297.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Saturday, 25. November 2006 17:32, Matthew Wilcox wrote:
> In the qla case, the mutex can be acquired by a thread which then waits
> for the hardware to do something.  If the hardware locks up, it is
> preferable that the system not hang.

Ok, I looked at it (drivers/scsi/qla2xxx/qla_mbx.c) 
and the solution seems simple:
- Introduce an busy flag, check that BEFORE this mutex_lock()
  and don't protect it by that mutex.
- return -EBUSY to the  upper layers, if mailbox still busy
- upper layers can either queue the command or use a retry mechanism

There are many examples for this in the kernel. NICs have the same problems
(transmitter busy or stuck) and have no problem handling that gracefully
since ages.

> I assumed that he'd spent enough time thinking about it that fixing it
> really wasn't feasible.

That doesn't depend on time, just whether you get the right idea or not.

Anyway I CCed the current maintainers.

So my point still stands: Timeout based locking is evil and hides bugs.

In this case the bugs are: 
1. That mutex protects a code path (mailbox command submission 
    and retrieve) instead of data.
2. "Mailbox is free" is an event, so you should use wait_event_timout() 
    for that


Regards

Ingo Oeser
