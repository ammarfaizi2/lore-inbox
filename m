Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263377AbSKDHmV>; Mon, 4 Nov 2002 02:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSKDHmV>; Mon, 4 Nov 2002 02:42:21 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:48578 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263377AbSKDHmU>; Mon, 4 Nov 2002 02:42:20 -0500
From: <benh@kernel.crashing.org>
To: "Alan Cox" <alan@redhat.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Pavel Machek" <pavel@ucw.cz>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Date: Mon, 4 Nov 2002 08:47:32 +0100
Message-Id: <20021104074732.3349@smtp.wanadoo.fr>
In-Reply-To: <200211031636.gA3GakF14660@devserv.devel.redhat.com>
References: <200211031636.gA3GakF14660@devserv.devel.redhat.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Bus ordering applies to power off not to suspend to disk sequence

Sure it does. Drivers have to save & resume state don't they ?

How can a driver save a consistent state if that state isn't
saved after blocking IOs and how can that be done if childs
of that device haven't already done their save_state/block
sequence ?

The problem is tricky with things like USB or FireWire. Basically
the host chip state save will not save pending requests state (it
would be way too nasty), so child devices will have to make sure
they stop any pending request before saving a consistent state.

Later on, during the actual "suspend" phase of the process, the
child drivers may eventually re-issue a new request, but that
will not result to a state change in the saved state (as it will
be too late for suspend to disk typically).

The suspending of tasks etc... as done currently by swsusp makes
definitely things easier as far as VM & block IO interactions
are concerned though, I agree. Might be a good idea to keep
that part "simple" for now as there is still enough work
with things like USB & 1394.

>> Then, I volunteer writing a HOWTO explaining clearly what a
>> driver should do for proper PM, and I'm pretty sure that won't
>> be that nasty and race prone as you are afraid of ;)
>
>Good. It'll be nice to have suspend to disk in 2.7

Well, it's mostly driver work, and the hooks are in there already
with the device model, so this will be driver updates going to
2.5/2.6 over time I guess. We just need to get the semantics right.

Ben.


