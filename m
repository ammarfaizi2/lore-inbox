Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVGMQsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVGMQsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVGMQsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:48:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40438 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261161AbVGMQqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:46:08 -0400
Subject: Re: RT and XFS
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050713064739.GD12661@elte.hu>
References: <1121209293.26644.8.camel@dhcp153.mvista.com>
	 <20050713002556.GA980@frodo>  <20050713064739.GD12661@elte.hu>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 09:45:58 -0700
Message-Id: <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 08:47 +0200, Ingo Molnar wrote:
> 
> downgrade_write() wasnt the main problem - the main problem was that for 
> PREEMPT_RT i implemented 'strict' semaphores, which are not identical to 
> vanilla kernel semaphores. The thing that seemed to impact XFS the most 
> is the 'acquirer thread has to release the lock' rule of strict 
> semaphores.  Both the XFS logging code and the XFS IO completion code 
> seems to release locks in a different context from where the acquire 
> happened. It's of course valid upstream behavior, but without these 
> extra rules it's hard to do sane priority inheritance. (who do you boost 
> if you dont really know who 'owns' the lock?) It might make sense to 
> introduce some sort of sem_pass_to(new_owner) interface? For now i 
> introduced a compat type, which lets those semaphores fall back to the 
> vanilla implementation.



There's a lot of code like this in there .. I've seen some that down()
in process contex, and up() in interrupt contex which is weird .. But
those aren't major features, just little drivers. XFS is pretty major
feature.

Nathan, does XFS need this property or could we convert it to
synchronize the locking (with ease?)?

Daniel

