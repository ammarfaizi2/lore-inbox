Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966909AbWKUIP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966909AbWKUIP0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966920AbWKUIP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:15:26 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:10847 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S966909AbWKUIP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:15:26 -0500
Message-ID: <4562B476.801@sw.ru>
Date: Tue, 21 Nov 2006 11:10:30 +0300
From: Pavel Emelianov <xemul@sw.ru>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vgoyal@in.ibm.com, mingo@redhat.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>
Subject: Re: [RFC] [PATCH] Fix misrouted interrupts deadlocks
References: <455484E4.1020100@openvz.org> <20061120192335.GA11879@in.ibm.com> <20061120195652.GA6141@in.ibm.com>
In-Reply-To: <20061120195652.GA6141@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Pavel,
> 
> If I backout your changes, everything works fine. So it looks like that
> the problem I am facing is because of your patch but I don't have a logical
> explanation yet that why the problem is there. Just realasing a lock
> which is not currently acquired should not hang the system?


Hm... A simple grep over the code showed that note_interrupt
is called w/o desc->lock in all places but __do_IRQ(). And this
looks like an error at least for the following reason:
note_interrupt() calls __report_bad_irq() and __report_bad_irq()
does require desc->lock to be held. So I suppose that we have
to do spin_lock(&desc->lock) before calling note_interrupt().
I'll prepare a patch in a moment.
