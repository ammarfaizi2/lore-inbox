Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264721AbTIDGdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTIDGdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:33:37 -0400
Received: from bm-4a.paradise.net.nz ([202.0.58.23]:54269 "EHLO
	linda-4.paradise.net.nz") by vger.kernel.org with ESMTP
	id S264721AbTIDGdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:33:36 -0400
Date: Thu, 04 Sep 2003 18:33:33 +1200 (NZST)
From: Richard Procter <rnp@paradise.net.nz>
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver, take 2
In-reply-to: <3F55EFD1.4020204@terra.com.br>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.21.0309041758250.284-100000@ps2.local>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Felipe, 

Just had a quick look at it. A couple of thoughts:        

* mc32_interrupt doesn't acquire the spinlock, rendering the critical
  sections un-exclusive on SMP. 

* sleep_on's remain in mc32_halt_transceiver and mc32_close. I think this 
  could lead to deadlock on UP --- eg. thread sleeps with spinlock held,
  subsequent interrupt then waits in vain. Might be less deadly on SMP?
  (are interrupt handlers reentrant on SMP?) 
 
* Just noticed an old error in mc32_close --- sleep_on is called in
  without first disabling interrupts. 

I've had a go at testing it, but ran into troubles with the ibmmca.c
driver carking on an uninitialised spinlock. Hopefully, I'll find some
quality time in the weekend to get things going. 

best, 
Richard. 

On Wed, 3 Sep 2003, Felipe W Damasio wrote:

> 	Hi Richard,
> 
> 	Please try this patch instead.
> 
> 	This one holds the device lock before doing "finish_wait", which 
> seems to be the Right Way to do it.
> 
> 	Thanks.
> 
> Felipe
> 

