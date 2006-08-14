Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWHNOUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWHNOUO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWHNOUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:20:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:16221 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932441AbWHNOUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:20:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DYSGnbMwJXAQeVAHvVgzB+w1SgtO0l0enepQC/RLiAzAI6y0Rc1/hL0Ti+zRcLX5ao2oRcFUBzCyvBAWMUIQlmEkI41cN9JyUJdmvSjBvzLQ/ucA0xoPbbZnXHkIYqMIAWKgyteP54To5b9/Y+8qCoxN8Zw9Hp4GogPBp3w4nVU=
Message-ID: <d120d5000608140720o4e8cc039u278fea6ccc0aae07@mail.gmail.com>
Date: Mon, 14 Aug 2006 10:20:09 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>,
       "=?ISO-8859-1?Q?Magnus_Vigerl=F6f?=" <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
In-Reply-To: <20060813032821.GB5251@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608121724.16119.wigge@bigfoot.com>
	 <20060812165228.GA5255@aehallh.com>
	 <200608122000.47904.dtor@insightbb.com>
	 <20060813032821.GB5251@aehallh.com>
X-Google-Sender-Auth: 37b8f793530d4210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Sat, Aug 12, 2006 at 08:00:47PM -0400, Dmitry Torokhov wrote:
> > On Saturday 12 August 2006 12:52, Zephaniah E. Hull wrote:
> > > I can dust off the masking patch sometime here if Dmitry thinks that
> > > he'd be willing to see a second method for this in addition to grabbing,
> > > adding support to xf86-input-evdev would be trivial, and the same could
> > > probably be said for the wacom driver that does grabbing at the moment.
> > >
> >
> > I would not mind if we get it working right ;) Do we need to turn off
> > "undesirable" handlers or do we want to limit output to one particular
> > handler? I'd prefer the former, if possible. Do we keep a counter or
> > set of counters so several processes can mask output, etc. Can we keep
> > event delivery somewhat fast?
>
> EVIOCGRAB provides for the latter, though it seems to go too far and
> mess with sysrq as well.
>
> My old old EVIOCMASK patch just added a long (or was it an int?  It's
> been a while) to each device struct, and to each handler struct, and if
> they had bits set in common then they received the events, and if not
> they did not.
>
> That was the cost of a quick & operation and a branch in the input event
> path, so not too expensive, though my memory seems to indicate that I
> tried to play some evil games to invert the bits first to allow things
> to be zero inited.
>
> I'd definitely want to just rewrite it these days, but that approach is
> fast, and if we define it something along the lines of 'bit 0 is the
> kernel console layer, bit 1 is any further handlers in the kernel like
> /dev/input/mice or the joystick interface, the rest belong to userspace'
> that gives userspace plenty of bits for odd policy decisions.
>
> One obvious catch is that programs would have to be careful to reset the
> mask when leaving, though having the sysrq handler always present and
> adding controls for 'reset input device masks' would be one escape
> route for X masking keyboard events from the kernel, then crashing
> messily.
>
> We probably don't want to automaticly reset on close by a program that
> did the masking, as I can see some cases where someone might want to use
> a utility that adjusts the masks on input devices.
>
>
> On a side note, if we mess with sysrq for the masking, we should add a
> 'ungrab all input devices' one as well.
>

I've been thinking about all of this and all of it is very fragile and
unwieldy and I am not sure that we really need another ioctl after
all. The only issue we have right now is that mousedev delivers
undesirable events through /dev/input/mice while there is better
driver listening to /dev/input/eventX and they clash with each other.
Still, /dev/input/mice is nice for dealing with hotplugging of simple
USB mice. So can't we make mousedev only multiplex devices that are
not opened directly (where directly is one of mouseX, jsX, tsX, or
evdevX)? We could even control this behavior through a module
parameter. Then noone (normally) would need to use EVIOCGRAB.

-- 
Dmitry
