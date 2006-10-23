Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWJWMJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWJWMJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWJWMJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:09:43 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:22155 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932150AbWJWMJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:09:42 -0400
Subject: Re: [PATCH] Thaw userspace and kernel space separately.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610231226.03718.rjw@sisk.pl>
References: <1161560896.7438.67.camel@nigel.suspend2.net>
	 <200610231226.03718.rjw@sisk.pl>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 22:00:11 +1000
Message-Id: <1161604811.3315.12.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-10-23 at 12:26 +0200, Rafael J. Wysocki wrote:
> On Monday, 23 October 2006 01:48, Nigel Cunningham wrote:
> > Modify process thawing so that we can thaw kernel space without thawing
> > userspace, and thaw kernelspace first. This will be useful in later
> > patches, where I intend to get swsusp thawing kernel threads only before
> > seeking to free memory.
> 
> Please explain why you think it will be necessary/useful.
> 
> I remember a discussion about it some time ago that didn't indicate
> we would need/want to do this.

This is needed to make suspending faster and more reliable when the
system is in a low memory situation. Imagine that you have a number of
processes trying to allocate memory at the time you're trying to
suspend. They want so much memory that when you come to prepare the
image, you find that you need to free pages. But your swapfile is on
ext3, and you've just frozen all processes, so any attempt to free
memory could result in a deadlock while the vm tries to swap out pages
using the frozen kjournald. So you need to thaw processes to free the
memory. But thawing processes will start the processes allocating memory
again, so you'll be fighting an uphill battle.

If you can only thaw the kernel threads, you can free memory without
restarting userspace or deadlocking against a frozen kjournald.

Regards,

Nigel


