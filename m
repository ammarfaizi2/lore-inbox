Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVHCOWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVHCOWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVHCOWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:22:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60815 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261399AbVHCOWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:22:12 -0400
Date: Wed, 3 Aug 2005 16:20:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [UPDATE PATCH] Add schedule_timeout_{intr,unintr}{,_msecs}()
 interfaces
In-Reply-To: <20050801193522.GA24909@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0508031419000.3728@scrub.home>
References: <1122116986.3582.7.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com>
 <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com>
 <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com>
 <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 1 Aug 2005, Nishanth Aravamudan wrote:

> +unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
> +{
> +	unsigned long expire_jifs;
> +
> +	if (timeout_msecs == MAX_SCHEDULE_TIMEOUT_MSECS) {
> +		expire_jifs = MAX_SCHEDULE_TIMEOUT;
> +	} else {
> +		/*
> +		 * msecs_to_jiffies() is a unit conversion, which truncates
> +		 * (rounds down), so we need to add 1.
> +		 */
> +		expire_jifs = msecs_to_jiffies(timeout_msecs) + 1;
> +	}
> +
> +	expire_jifs = schedule_timeout(expire_jifs);
> +
> +	/*
> +	 * don't need to add 1 here, even though there is truncation,
> +	 * because we will add 1 if/when the value is sent back in
> +	 */
> +	return jiffies_to_msecs(expire_jifs);
> +}

As I already mentioned for msleep_interruptible this is a really terrible 
interface.
The "jiffies_to_msecs(msecs_to_jiffies(timeout_msecs) + 1)" case (when the 
process is immediately woken up again) makes the caller suspectible to 
timeout manipulations and requires constant reauditing, that no caller 
gets it wrong, so it's better to avoid this error source completely.
Constant conversion between different time units is a really bad idea. If 
the user needs the remaining time, he is really better off to do it 
himself by checking jiffies and only does an initial conversion from 
relative to absolute (kernel) time.
This wrapper function really should be an inline function and should look 
more like this:

static inline int schedule_timeout_msecs(unsigned int timeout_msecs)
{
	return schedule_timeout(msecs_to_jiffies(timeout_msecs) + 1) != 0;
}

bye, Roman
