Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVE0BjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVE0BjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVE0Bhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:37:32 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:17165 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261410AbVE0Bcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:32:35 -0400
Message-ID: <429678B0.7000009@rtr.ca>
Date: Thu, 26 May 2005 21:32:32 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] libata: fix use-after-free during driver unload/unplug
References: <42962379.5000206@pobox.com> <42964099.6000207@pobox.com> <42967601.7080003@pobox.com>
In-Reply-To: <42967601.7080003@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>
> qstor's ->host_stop() disables global interrupts, and I didn't know if 
> you really wanted to do that prior to ->port_stop().
> 
> I would much prefer to eliminate the ->host_stop_prewalk() hook, and 
> simply call ->host_stop after all ->port_stop() calls complete, if qstor 
> doesn't need the pre-walk.

Ahh.. of course.  I must have misread your original.

Yes, sata_qstor generally assumes that host_stop should completely
stop the host from operating.. and thereby expects any port_stop()
calls to happen before host_stop().  So, yup, the changes you have
seem to be useful here.

If we didn't want to have a prewalk() method, then we could hack
sata_qstor to keep a count of active ("non stopped") ports,
and automatically do the global (chip) interrupt disable from
port_stop() whenever the count hits zero.

Cheers
