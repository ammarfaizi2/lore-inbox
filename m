Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWHKQq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWHKQq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWHKQq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:46:26 -0400
Received: from tim.rpsys.net ([194.106.48.114]:36559 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750806AbWHKQqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:46:25 -0400
Subject: Re: [patch 5/6] Convert to use mutexes instead of semaphores
From: Richard Purdie <rpurdie@rpsys.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>,
       LKML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <d120d5000608110707o2b758739x20033b000449113f@mail.gmail.com>
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.530817371.dtor@insightbb.com>
	 <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com>
	 <1155302169.19959.16.camel@localhost.localdomain>
	 <d120d5000608110634n501d33b0yb7702a24cbf064e3@mail.gmail.com>
	 <20060811134215.GA26017@hansmi.ch>
	 <d120d5000608110707o2b758739x20033b000449113f@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 17:45:51 +0100
Message-Id: <1155314751.25767.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 10:07 -0400, Dmitry Torokhov wrote: 
> On 8/11/06, Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> > On Fri, Aug 11, 2006 at 09:34:44AM -0400, Dmitry Torokhov wrote:
> > > How about we add backlight_set_power(&bd, power) to the backlight core
> > > to take care of proper locking for drivers?

A couple of patches were attempted for this but they didn't solve the
underlying races. The main reason was a lack of understanding of what
the existing backlight lock protects and trying to make it do two thinsg
at once.

> > I've tried to add several functions to the backlight core
> > ({s,g}et_{brightness,power}) and they were rejected. Thus all the
> > locking is spread over the drivers. I agree it's faulty right now.
> > It's still easier to move to backlight core functions than to fix all
> > the drivers.

If we can find a way to safely do the locking in the backlight core I
agree.

> > Because I am responsible/wrote for the broken code, how should I
> > proceed?

First, we need to define the potential problems. Dimitry mentioned: "For
example, it could possibly race with setting power through sysfs
attribute". This is not what the lock in the backlight core is for
though. To quote backlight.h:

/* This protects the 'props' field. If 'props' is NULL, the driver that
   registered this device has been unloaded, and if class_get_devdata()
   points to something in the body of that driver, it is also invalid.
*/

My previous patches have gone a long way to removing race issues. The
need for the existing lock comes from backlight_device_unregister()
which basically does:

class_device_remove_files()
bd->props->brightness = 0;
bd->props->power = 0;
bd->props->update_status(bd);
bd->props = NULL
fb_unregister_client()
class_device_unregister()

If we could guarantee that after class_device_unregister(), nothing was
still executing any of the show/store methods, we'd be fine (the
fb_notifier is safe). As I understand the class device and sysfs
attributes, we can't guarantee that though. I'd appreciate comments from
the device model people as I could be wrong about this. The owner field
also can't help us.

Dimitry's "Backlight: convert to use default class device attributes"
patch should really mean the class_device_unregister() call is moved to
earlier in the function to try and avoid races from the attributes but
it still doesn't guarantee anything.

If we could somehow sync class_device_unregister(), we could get rid of
that semaphore entirely. 

Regardless, if we want to add locking for synchronising the attributes
into the core, we need a different lock. I did think the drivers would
be able to handle this themselves with locking inside update_status if
needed but I can see why certain drivers might not like that.

> Well, I was reading some more of the drivers and I am also not sure if
> such methods are needed in backlight core. Let's take atyfb_base.c -
> it tries to manipulate backlight's power from atyfb_blank. But it is
> normally called from fb_blank() which is then calls
> fb_notifier_call_chain(FB_EVENT_BLANK, &event);
> So on the end backlight device will get that event and will turn off
> power anyway. Now, atyfb_blank is also called suring suspend/resume so
> we probably should just add handling of FB_EVENT_SUSPEND and
> FB_EVENT_RESUME to the backlight core.
> 
> Richard?

Think about the case where you have 2 framebuffers. The notification
call was left to pass to the driver as only it can work out which
framebuffer a given backlight is attached to.

Cheers,

Richard



