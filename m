Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVDFRSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVDFRSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVDFRSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:18:45 -0400
Received: from webmail.topspin.com ([12.162.17.3]:3016 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262246AbVDFRS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:18:29 -0400
To: <arun.prabha@wipro.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Scheduling tasklets from process context...
X-Message-Flag: Warning: May contain useful information
References: <8F94FD7C111E3D43BA3C7CF89CB50E92012AA7B5@BLR-EC-2K3MSG.wipro.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 06 Apr 2005 09:46:17 -0700
In-Reply-To: <8F94FD7C111E3D43BA3C7CF89CB50E92012AA7B5@BLR-EC-2K3MSG.wipro.com> (arun
 prabha's message of "Wed, 6 Apr 2005 08:20:28 +0530")
Message-ID: <52mzsbam5i.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Apr 2005 16:46:17.0325 (UTC) FILETIME=[271169D0:01C53AC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    arun> Since tasklets are typically used for bottom half
    arun> processing, is it acceptable/recommended that they be
    arun> scheduled from a process context (say an ioctl handler)?

    arun> Should one try to minimize such scheduling and try to do
    arun> things in process context if possible, as tasklets run in
    arun> interrupt context? Or is the driver writer free to use the
    arun> tasklets at will? What is recommended here?

I guess it would work to schedule a tasklet from your ioctl handler, but
I don't see a good reason to do it.  What are you really trying to do?

Your ioctl handler runs in process context so you are free to do
pretty much anything -- allocate with GFP_KERNEL, sleep, etc.  If you
want to return to userspace immediately but defer some work until
later, it would probably make more sense to use something like
schedule_work() instead of a tasklet.

The main point of tasklets is that they run at a high priority, very
soon after they're scheduled, so that an interrupt handler can return
quickly by deferring work to a tasklet but still not add too much
latency.  But in your ioctl handler, if you have some high priority
work, you can just do it immediately without the complication of a tasklet.

 - R.

