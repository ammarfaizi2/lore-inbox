Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVDGUIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVDGUIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVDGUIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:08:34 -0400
Received: from digitalimplant.org ([64.62.235.95]:62144 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262584AbVDGUIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:08:25 -0400
Date: Thu, 7 Apr 2005 13:08:17 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.44L0.0504061535140.1511-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.50.0504071304040.5276-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0504061535140.1511-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Apr 2005, Alan Stern wrote:

> The patch looks good.  But isn't there still a problem with
> device_release_driver()?  It doesn't wait for the klist_node to be removed
> from the klist before unlocking the device and moving on.  As a result, if
> another driver was waiting to bind to the device you would corrupt the
> list pointers, by calling klist_add_tail() for the new driver before
> klist_release() had run for the old driver.
>
> I'll be interested to see how you manage to solve this.  The only way I
> can think of is to avoid using driver_for_each_device() in
> driver_detach().

I had implemented something along the lines of what you suggested in a
previous email:

  - Add flag to klist_node: n_attached.
  - Use that in klist_node_attached()
  - Check during klist_next(), and skip nodes that have been removed.
  - Reset flag during klist_del().

Based on the deadlock that occurs when using klist_remove() during an
iteration over that the list, and the common indirect usage of it (parents
and buses unregistering devices, drivers unbinding devices), I've just
removed klist_remove() and the embedded completion. I'll post updated
patches soon.

Thanks,


	Pat
