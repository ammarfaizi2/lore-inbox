Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWFATyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWFATyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWFATyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:54:54 -0400
Received: from smtp.enter.net ([216.193.128.24]:22801 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030254AbWFATyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:54:53 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Marko M" <marcus.magick@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Thu, 1 Jun 2006 15:54:43 +0000
User-Agent: KMail/1.8.1
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Dave Airlie" <airlied@gmail.com>, "Jon Smirl" <jonsmirl@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <Pine.LNX.4.61.0606011140110.3533@yvahk01.tjqt.qr> <4423333a0606010451q25c1e6d5l8745b11d511c1481@mail.gmail.com>
In-Reply-To: <4423333a0606010451q25c1e6d5l8745b11d511c1481@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011554.44474.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 11:51, Marko M wrote:
> Sure it is. I mean, it uses only VESA (extended VGA) registers and
> doesn't know anything about present bliters, backend scalers or
> similar hw features, AFAIK.
>
> I think DirectFB guy have right approach, only they do it from user
> space. fbdev should be capable of detecting present chip(s) and load
> appropriate (acceleration) module, which describes hardware more
> precisely.
>
> If there is no specific (fbdev) driver module for your gfx then
> everything should work with generic (VESA) one, though it would be
> somewhat slower.

(Ewww, top-posting!)

Anyway, this method is what drmcon is going to do. For fbdev the plan is to 
make it a very minimal driver under most circumstances, and capable of being 
told to shut down so that the drmcon that I am working on can take over.

Jon makes a good point about daemons being able to get killed by the OOM 
killer. However, because drmcon is going to provide the full DRI capacity to 
userspace, having tons of helpers that need to be launched for various tasks 
isn't a good choice. Sure X could retain it's own DRI system and not require 
the helpers or whatever, but what of an app written using Qt or GTK that runs 
on the console rather than under X?

Such an application would continuously be using the 2D acceleration features 
(which will all be merged into DRM) - having to start the helpers for every 
acceleration call would be stupid. By providing a daemon to do the work we 
simplify things immensely.

And in the case that the daemon is killed (for any reason) the console itself 
should survive, since it doesn't need the daemon to run. What will die is the 
application that depends on it... Yes, that isn't good, but it's better than 
the whole system coming down. And since the OOM killer does provide an error 
message that nominally hits the console, the user will know what occurred.

DRH
