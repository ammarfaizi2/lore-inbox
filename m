Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWHKRVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWHKRVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWHKRVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:21:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:12199 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932240AbWHKRVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:21:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d71pcgwMIKPmT09OQJoNFz9sIbRvRijfowXJhmoMCX4B4E0LDSyd+fQmK5Vdl0izNLIKowpX+jXoKzY6rWAiSvHBLE7fDt/xeIUyeniXmay6/bsSCQlFa78l9H6m8L2tZbsluNrmZ4GM0NghuLJDsT+d9coMdTaO0kr4EPgaHwA=
Message-ID: <d120d5000608111020h587b0494w1dcbccdb2cee2f6b@mail.gmail.com>
Date: Fri, 11 Aug 2006 13:20:59 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch 5/6] Convert to use mutexes instead of semaphores
Cc: "Michael Hanselmann" <linux-kernel@hansmi.ch>,
       LKML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <1155314751.25767.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.530817371.dtor@insightbb.com>
	 <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com>
	 <1155302169.19959.16.camel@localhost.localdomain>
	 <d120d5000608110634n501d33b0yb7702a24cbf064e3@mail.gmail.com>
	 <20060811134215.GA26017@hansmi.ch>
	 <d120d5000608110707o2b758739x20033b000449113f@mail.gmail.com>
	 <1155314751.25767.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Fri, 2006-08-11 at 10:07 -0400, Dmitry Torokhov wrote:
> > On 8/11/06, Michael Hanselmann <linux-kernel@hansmi.ch> wrote:
> > > On Fri, Aug 11, 2006 at 09:34:44AM -0400, Dmitry Torokhov wrote:
> > > > How about we add backlight_set_power(&bd, power) to the backlight core
> > > > to take care of proper locking for drivers?
>
> A couple of patches were attempted for this but they didn't solve the
> underlying races. The main reason was a lack of understanding of what
> the existing backlight lock protects and trying to make it do two thinsg
> at once.
>
> > > I've tried to add several functions to the backlight core
> > > ({s,g}et_{brightness,power}) and they were rejected. Thus all the
> > > locking is spread over the drivers. I agree it's faulty right now.
> > > It's still easier to move to backlight core functions than to fix all
> > > the drivers.
>
> If we can find a way to safely do the locking in the backlight core I
> agree.
>
> > > Because I am responsible/wrote for the broken code, how should I
> > > proceed?
>
> First, we need to define the potential problems. Dimitry mentioned: "For
> example, it could possibly race with setting power through sysfs
> attribute". This is not what the lock in the backlight core is for
> though. To quote backlight.h:
>
> /* This protects the 'props' field. If 'props' is NULL, the driver that
>   registered this device has been unloaded, and if class_get_devdata()
>   points to something in the body of that driver, it is also invalid.
> */

Yes, you are right. As long as ->update_status() method serializes
access to the underlying hardware by itself we don't need locking in
backlight core. If we have several writes one of them will win but we
will never have kernel and hardware disagree about the state they are
in. So we can just remove references to baccklight's semaphore from
drivers.

>
> Dimitry's "Backlight: convert to use default class device attributes"
> patch should really mean the class_device_unregister() call is moved to
> earlier in the function to try and avoid races from the attributes but
> it still doesn't guarantee anything.
>

No, it was not the intent of the patch. I was just trying to remove
unneeded code and simplify error handling because driver core can  do
that for us. The race window is still present and mutex is still
needed.

>
> > Well, I was reading some more of the drivers and I am also not sure if
> > such methods are needed in backlight core. Let's take atyfb_base.c -
> > it tries to manipulate backlight's power from atyfb_blank. But it is
> > normally called from fb_blank() which is then calls
> > fb_notifier_call_chain(FB_EVENT_BLANK, &event);
> > So on the end backlight device will get that event and will turn off
> > power anyway. Now, atyfb_blank is also called suring suspend/resume so
> > we probably should just add handling of FB_EVENT_SUSPEND and
> > FB_EVENT_RESUME to the backlight core.
> >
> > Richard?
>
> Think about the case where you have 2 framebuffers. The notification
> call was left to pass to the driver as only it can work out which
> framebuffer a given backlight is attached to.
>

I am not sure I follow... It would end up in the driver, like
FB_EVENT_BLANK ultimately does. RIght now FB_EVENT_SUSPEND and
FB_EVENT_RESUME are dropped by the blacklight core.

But it does not matter now - if we do not fiddle with backlight's
locks we can continue switching backlight off in drivers.

-- 
Dmitry
