Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVC2UFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVC2UFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVC2UFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:05:48 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:55433 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261369AbVC2UFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:05:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GBK5eAFn32nQSS1iy72n6Zc9gCgQ1GhkZr1WEbHQYjKq3ETII/jT3k3J3Es5upw2Ipzr7oPIqSwrhRu7Dh91T3wgXG4n7yM/RAQTQzzXlOOn4kqzaJxcpdOhnwxM/APsslvsQRz84LRHndQ4SoR6E4p5eHMltAHmpuZoheVUemo=
Message-ID: <d120d50005032912051fee6e91@mail.gmail.com>
Date: Tue, 29 Mar 2005 15:05:15 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20050329192339.GE8125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de>
	 <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de>
	 <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de>
	 <d120d50005032908183b2f622e@mail.gmail.com>
	 <20050329181831.GB8125@elf.ucw.cz>
	 <d120d50005032911114fd2ea32@mail.gmail.com>
	 <20050329192339.GE8125@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 21:23:39 +0200, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > > > If you look at Andy's second trace you will see that we are waiting
> > > > for the disk I/O to get /sbin/hotplug from the disk. Pavel, do you
> > > > know why IO does not complete? khelper is a kernel thread so it is
> > > > marked with
> > > > PF_NOFREEZE. Could it be that we managed to freeze kblockd?
> > >
> > > Uf, no idea about kblockd freezing -- we certainly should not.
> > >
> > > *But*, if we are doing execve while system is frozen, something is
> > > very wrong. We should not be doing execve in the first place.
> >
> > Well, there lies a problem - some devices have to do execve because
> > they need firmware to operate. Also, again, some buses with
> > hot-pluggable devices will attempt to clean up unsuccessful resume and
> > this will cause hotplug events. The point is you either resume system
> > or you don't. We probably need a separate "unfreeze" callback,
> > although this is kind of messy.
> 
> There's a better solution for firmware: You should load your firmware
> prior to suspend and store it in RAM. Anything else just plain does
> not work. (Because your wireless firmware might be on NFS mounted over
> that wireless card).
> 
> Hotplug... I guess udev just needs to hold that callbacks before
> system is fully up... it has to do something similar on regular boot,
> no?

Well, I did not really look into udev but hotplug (which can iteract
with udev) does not keep anything. If it fails its ok - that's why
there are coldplug scripts that "recover" lost events. But here we
block trying to start hotplug - we not getting an error - and this is
bad. Unfortunately I am not familiar with block devices working to say
why it hangs.

Should we pull Jens into the discussion?
 
-- 
Dmitry
