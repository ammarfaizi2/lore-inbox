Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWINInS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWINInS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWINInS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:43:18 -0400
Received: from twin.jikos.cz ([213.151.79.26]:7101 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751468AbWINInR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:43:17 -0400
Date: Thu, 14 Sep 2006 10:43:00 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Dmitry Torokhov <dtor@insightbb.com>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
In-Reply-To: <200609132200.51342.dtor@insightbb.com>
Message-ID: <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
 <200609132200.51342.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Dmitry Torokhov wrote:

> Unfortunately these patches do not solve the problem in general but 
> rather fix one specific codepath. As far as I can see the warnings will 
> return as soon as we add another pass-through port to the link (and I am 
> considering adding a pass-through port to the trackpoint driver so you 
> will get chain like i8042-synaptics-ptport-trackpoint-ptport-psmouse). 
> Plus they are ugly and complicate serio and psmouse cores. I really 
> don't like this *_nested business as it makes the code aware of possible 
> usage patterns instead of just being re-entrant.

Hi Dmitry,

I agree that these patches are ugly, but I wasn't able to think of any 
other way how to get rid of those lockdep warnings.

Of course the lock validator could be extended to provide API such as 
mutex_init_nolockdep(), as you already proposed before, but this also has 
it's drawbacks (for example if any other future user of ps2_init() uses 
the mutex in a really bad way, this would not be detected by lock 
validator).

Another possibility that comes to mind is extending the ps2dev structure 
with a field which would work as an subclass identifier for the device, 
and this field will be then be used as an subclass argument to 
mutex_lock_nested(). However, this requires proper setting of this field 
on the very same places on which my _nested functions are called, so it 
has the same level of generality.

Do you have any other idea? I think this should get fixed, otherwise we 
will keep receiving these reports from users again and again.

Thanks,

-- 
JiKos.
