Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTFUP3S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 11:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTFUP3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 11:29:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10952 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264873AbTFUP3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 11:29:17 -0400
Message-ID: <3EF47D0C.100@pobox.com>
Date: Sat, 21 Jun 2003 11:43:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: rusty@rustcorp.com.au, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] workqueue.c subtle fix and core extraction
References: <200306210622.h5L6MRcb011620@hera.kernel.org>
In-Reply-To: <200306210622.h5L6MRcb011620@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1384, 2003/06/20 22:14:56-07:00, akpm@digeo.com
> 
> 	[PATCH] workqueue.c subtle fix and core extraction
> 	
> 	From: Rusty Russell <rusty@rustcorp.com.au>
> 	
> 	A barrier is needed on workqueue shutdown: there's a chance that the thead
> 	could see the wq->thread set to NULL before the completion is initialized.

Look at the larger problem.

The completion initialization should be done before you call 
kernel_thread to start the worker.

Otherwise, there is a still the general problem:  if any event occurs to 
cause worker_thread to exit its main loop, you hit an uninitialized 
completion.

Just initialize it before you start the kernel thread -- like all the 
other driver kernel thread code does -- and forget about barriers :) 
Needing a barrier here just signals you need further changes.


> 	Also extracts functions which actually create and destroy workqueues, for
> 	use by hotplug CPU patch.

Please do this in separate patches next time.  I'm looking into the 
above change, and including this second change just obfuscated matters 
and slowed down analysis of the first change.

	Jeff



