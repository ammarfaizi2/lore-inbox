Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267888AbTGHWpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267887AbTGHWpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:45:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267886AbTGHWpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:45:43 -0400
Date: Tue, 8 Jul 2003 16:00:18 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: Race condition between aio_complete and aio_read_evt
Message-Id: <20030708160018.04353f4f.shemminger@osdl.org>
In-Reply-To: <41F331DBE1178346A6F30D7CF124B24B2A4886@fmsmsx409.fm.intel.com>
References: <41F331DBE1178346A6F30D7CF124B24B2A4886@fmsmsx409.fm.intel.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 14:52:28 -0700
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> We hit a memory ordering race condition on AIO ring buffer tail pointer
> between function aio_complete() and aio_read_evt().
> 
> What happens is that on an architecture that has a relaxed memory
> ordering model like IPF(ia64), explicit memory barrier is required in a
> SMP execution environment.  Considering the following case:
> 
> 1 CPU is executing a tight loop of aio_read_evt.  It is pulling event
> off the ring buffer.  During that loop, another CPU is executing
> aio_complete() where it is putting event into the ring buffer and then
> update the tail pointer.  However, due to relaxed memory ordering model,
> the tail pointer can be visible before the actual event is being
> updated.  So the other CPU sees the updated tail pointer but picks up a
> staled event data.
> 
> A memory barrier is required in this case between the event data and
> tail pointer update.  Same is true for the head pointer but the window
> of the race condition is nil.  For function correctness, it is fixed
> here as well.
> 
> By the way, this bug is fixed in the major distributor's kernel on 2.4.x
> kernel series for a while, but somehow hasn't been propagated to 2.5
> kernel yet.
> 
> The patch is relative to 2.5.74.
> 
> - Ken
> 

Make those smp_* memory barrier's because they don't matter on UP.

