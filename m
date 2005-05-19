Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVESOh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVESOh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVESOh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:37:28 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64504 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262530AbVESOhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:37:19 -0400
Subject: RE: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01
	whenRT program dumps core]
From: Steven Rostedt <rostedt@goodmis.org>
To: kus Kusche Klaus <kus@keba.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323213@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323213@MAILIT.keba.co.at>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 10:37:07 -0400
Message-Id: <1116513427.15866.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 16:23 +0200, kus Kusche Klaus wrote:
> Does that mean that the core dump is written 
> with the rt prio of the task which dumps?
> 

Yes, since the process itself that crashed is what is writing the core.
So if a RT process crashes, it writes the core as whatever it was.

> I'm not sure if this is a good idea: 
> Dumping a big core might take *ages* (at least w.r.t. realtime),
> especially because it usually goes to flash memory, a CF card,
> or some other really slow device.
> 

This is interesting, since if a RT task is dumping core, that usually
means that it crashed, and therefore there's a bug in the system.  Also,
unless the processes is writing to something that requires a busy wait
(which the serial might do, and probably some flashes), this shouldn't
effect the system.

> Doing that on a high rt prio is not nice; in an rt kernel, 
> it may even keep interrupt handlers from responding...
> Is there any way to do it in the background / at low prio?
> 

What can easily be done is switch the task to a non RT priority on the
core dump, after it sends the kill signal to the other tasks sharing the
mm. This way it would not affect the other tasks (and interrupt threads)
so badly.

Ingo, What do you think? Should the dumping of a RT task switch its
priority to a non-rt priority?

-- Steve


