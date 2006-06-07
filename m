Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWFGD31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWFGD31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWFGD31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:29:27 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:55666 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750781AbWFGD30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:29:26 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Tue, 6 Jun 2006 20:29:22 -0700
User-Agent: KMail/1.7.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Don Zickus <dzickus@redhat.com>, Andrew Morton <akpm@osdl.org>,
       jeremy@goop.org, miles.lane@gmail.com, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <20060607004217.GF11696@redhat.com> <200606071050.24916.ncunningham@linuxmail.org>
In-Reply-To: <200606071050.24916.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606062029.24123.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 June 2006 5:50 pm, Nigel Cunningham wrote:

> Suspend: It's going to be put into a low (possibly no-) power state. It's 
> going to come back, and when it does, you want to be able to put it back in 
> the state it's in prior to this call.

Not exactly.  Suspended devices can in general can resume() into a RESET
state in which case software reinit is appropriate ... or they can come back
in the state that the suspend() left them in, modulo changes that may come
from hot-unplugging hardware connected to that device.  (Which may be a
wakeup event, depending on system configuration.)

CPU suspend might have additional rules (just like for any pm-smart class
of drivers), but those are the generic rules.  Not that I think many
platforms treat CPUs quite the same as other hardware!  :)

I don't think the PM events -- suspend()/resume() -- should ever be
entangled with hotplug events.  The former apply to devices which are
known; the latter are how they become known (or get forgotten).


> Every suspend or freeze must be followed by a resume.

Freeze is an optional nuance; it's basically OK to treat every suspend() as
an "enter low power mode" suspend request, regardless of the event signified
by its parameter.  The canonical/main example of when it might _not_ do that
is avoiding disk drive spindown on freeze durin swsusp.

It's a bit problematic just now to handle hot-unplug during suspend(), so
the best advice just now is to make sure that if that's physically possible
(like ejecting a PCMCIA/Cardbus adapter) then driver resume() checks whether
the device is present, just like it checks for power-lost/reset.

- Dave

