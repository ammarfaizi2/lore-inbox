Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbUKPVRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbUKPVRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUKPVRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:17:36 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:31076 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261814AbUKPVQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:16:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CseuZp3yUUf208yQpRmt3ki41i138rjTwB426yQKqxf2R4p5Vq3DtTbm+JNXJD80G5YgFsbu1Ai0No6prfXPrx+609cRv5kfIetXcbsz/5a3SJCaAcZm+ya5kxPlSP+57KSdLFcJcBMcV2ysduo7qg8NJkt+sfalkLq1QxWCdwM=
Message-ID: <d120d5000411161309100a0d4e@mail.gmail.com>
Date: Tue, 16 Nov 2004 16:09:31 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: ambx1@neo.rr.com, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Tejun Heo <tj@home-tj.org>, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
In-Reply-To: <20041116070413.GJ29574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041109223729.GB7416@kroah.com>
	 <200411092249.44561.dtor_core@ameritech.net>
	 <20041116061315.GG29574@neo.rr.com>
	 <200411160137.57402.dtor_core@ameritech.net>
	 <20041116070413.GJ29574@neo.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 02:04:13 -0500, Adam Belay <ambx1@neo.rr.com> wrote:
> 
> "*stop"
> - safely stop the upper class layer
> - free resources, and reset device specific data
> 
> And we're ready for the next step. (which may even include another *start)
> 
> This would easily allow for things like "reconnect", which would simply be a
> "*stop" follow by a "*start".
> 
> Comments?
> 

Sounds interesting, although I do not think that freeing resources should be
done at stop time, it is task for remove() IMHO. Do you have an idea how
setting up process (between probe and start) will work? Will start called
automatically or by request from userspace?

> 
> > My bind mode patch is somewhat independent of "drvctl" as it just adds a new
> > attribute - "bind_mode" to all devices and drivers. It can be either "auto"
> > or "manual" and device/drivers that are set as manual mode will be ignored
> > by driver core and will only be bound when user explicitely asks to do that.
> > This is useful when you want "penalize" one driver over another, like
> > psmouse/serio_raw.
> 
> That's actually a really interesting idea.  In some cases we may not want the
> kernel automatically binding drivers.  A question would be should this feature
> be disabled on a per device basis or globally?  If it's globally then should
> it occur after init is done.  And if that's the case, couldn't we free the
> device ID tables and handle everything from userspace.  I'm sure there are
> some problems with this but I figured I'd mention it as well.
> 

Well, it sure needs to be available on per-device/per-driver basis as while
I am generally enjoying automatic binding without userspace involvement.
For example I sometimes want to be able to disable my touchpad and not
let it spring back to life (normally serio core will try to find
proper driver for
an unbound port whenever there is a data coming from it).

Whether it should also be controlled on per bus/per system basis is
another question. I am not quite ready to drop all device tables and rely
solely on userspace handling, altthough if all tables are marked as __init
and and the end of the boot process we walk all buses and set their
->match() methods to NULL we effectively switch to manual binding
mode and can discard ID tables.

-- 
Dmitry
