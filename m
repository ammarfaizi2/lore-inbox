Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWE1D1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWE1D1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 23:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWE1D1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 23:27:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:1437 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751173AbWE1D1t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 23:27:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IVNesaopf9o4YnudZ5i3qxWq8D8x71kjynDOnUQYraDlDd6zGSuVp2QenIepV/7t4LFzUvMoTOQjbeX7qlNDB1GDHAMYmsilJGWgF5+v0184kUUnv3GNJAkLKhn7vz6tTYoQ4rgzXgiriUbROsSV5n2GnnkYr5pjhIK7sEUEf3w=
Message-ID: <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
Date: Sat, 27 May 2006 23:27:48 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605272245.22320.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272213.58015.dhazelton@enter.net>
	 <9e4733910605271934q76d41330lcf339f221612d74b@mail.gmail.com>
	 <200605272245.22320.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/06, D. Hazelton <dhazelton@enter.net> wrote:
> > > Fully merging fbdev with DRM would really create some problems for the
> > > embedded people. If the design of using the fbdev driver as a base layer
> > > and the DRM drivers as an acceleration layer works then that's all that's
> > > truly needed. Merging the DRM and fbdev code bases would create a
> > > situation where the embedded people would have to configure *out* the DRM
> > > code that has been merged into the fbdev drivers. Not only would such a
> > > thing create potential bugs in the system, it is a step that could create
> > > problems with people maintaining the .config's for those systems.
> >
> > It may cause problems for some embedded people but I wouldn't worry
> > about them right now. If they don't like something I'm sure we'll hear
> > from them. Most people don't go to the expense of putting a DRM
> > capable chip into a system and then not use all of its capabilities.
> > Remember, only 8 out of the 60 fbdev drivers have DRM modules.
> >
> > Worst thing that can happen is that they lose 50K of memory. Don't
> > spend a lot of effort worrying about this especially if no one is
> > complaining. Issues like this can be addressed later.
>
> Yes, however, I don't think a lot of embedded people are putting DRM capable
> chips in their machines. And I will worry about that at all points, to great
> length - I will actually fight to keep a complete merger from happening. For
> exactly the reasons I stated above.

For a specific DRM chip there are currently four modules:
fbdev-core
fbdev-chip depends on fbdev-core
drm-core
drm-chip depends on drm-core
RIght now drm and fbdev can be loaded independently.

I would always keep fbdev-core and drm-core as separate modules.  But
drm-core may become dependent on fbdev-core.

So after merging, drivers without DRM would still load exactly what
they load today. They wouldn't need to load the dependent drm-core
module. These non-DRM modules are essentially unchanged.
fbdev-core
fbdev-chip depends on fbdev-core

Merged DRM drivers can end up in one of two configurations
fbdev-core
fbdev-chip depends on fbdev-core
drm-core depends on fbdev-core
drm-chip depends on fbdev-chip, drm-core, fbdev-core

fbdev-core
drm-core depends on fbdev-core
merged-chip depends on drm-core, fbdev-core

I'm saying don't worry too much if it is more efficient to create
merged-chip for somthing like the Radeon instead of keeping fbdev-chip
and drm-chip. It is more important to get a stable functioning driver
working. If someone really complains the driver can be broken back up
at a later date (they can always use the old fbdev driver in the
meanwhile). If you spend all of your time worrying about 10K of memory
for some embedded system that may or may not use the driver, you won't
be spending enough time on getting the basic driver right.

In the new model you won't be able to load standalone DRM. That's
becuase both of those modules are now dependent on their fbdev counter
parts.
drm-core - standalone disallowed
drm-chip - standalone disallowed

-- 
Jon Smirl
jonsmirl@gmail.com
