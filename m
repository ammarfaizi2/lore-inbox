Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTGAJ1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 05:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTGAJ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 05:27:21 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:996 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261801AbTGAJ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 05:27:11 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Tue, 1 Jul 2003 19:40:30 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16129.22286.274059.518816@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC/PATCH] Touchpads in absolute mode (synaptics) and mousedev
In-Reply-To: message from Dmitry Torokhov on Tuesday July 1
References: <200307010303.53405.dtor_core@ameritech.net>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 1, dtor_core@ameritech.net wrote:
> Hi,
> 
> I was trying to teach mousedev to bind to new synaptics driver. This 
> may be useful for gpm and other programs that don't have native event
> processing module written yet. Unfortunately absolute to relative 
> conversion in mousedev only suits for tablets (digitizers) and not for
> touchpads because:
> 
> - touchpads are not precise; when I take my finger off touchpad and then
>   touch it again somewhere else I do not expect my cursor jump anywhere,
>   I only expect cursor to move when I move my finger while pressing 
>   touchpad.

Yep, that's a bug.  mousedev needs to know when there is or isn't a
finger and ignore absolute differences when there is no finger.

> - synaptics has Y axis reversed from what mousedev expects.
> 
> I tried to modify mousedev to account for differences between touchpads 
> in absolute mode and digitizers in absolute mode but all my solutions 
> required ugly flags - brrr... So what if we:
> 
> 1. Modify mousedev so if an input device announces that it generates both
>    relative and absolute events mousedev will discard all absolute axis 
>    events and will rely on device supplied relative events.

Nah.  I have an ALPS dualpoint which generates ABSolute events for the
touchpad part and RElative events for the pointstick part.  I want
them both.

> 2. Add absolute->relative conversion code to touchpad drivers themselves
>    as drivers should know the best how to do that. If they turn out to be
>    similar across different touchpads then the common module could be 
>    made.
> 
> What you think?

I think that mousedev should be just clever enough to mostly work and
no cleverer.  Anything more interesting should be done in user-space.

For example, there is the idea of treating one edge of a touch pad
like a scroll wheel.  I don't think this should be done in the
kernel. 
I have just started working on a program to do this.  It opens
/dev/input/event1 (in my case) to read events from the touchpad.  It
uses an ioctl to "grab" the device so mousedev doesn't see any events
directly.
Then it opens /dev/input/uinput and registers itself as a mouse-like
device.  It copies event from one to the other with some translation.
It will eventually do all the magic abs->rel translations that I want
and notice corner-taps and such.  At the moment it only does some
simple mapping of button events so that I can use one of my two 'left'
buttons as a 'middle' button.

I actually think that it should be possible to do everything in
user-space.  I find it quite awkward that I *cannot* get a clear
channel from a user-space program to the PS/2 aux port like I could in
2.4 via /dev/psaux.  I would really like to be able to open some
device, "GRAB" it, and then have complete control of the PS/2 AUX
port.  Then I could similarly open /dev/input/uinput and do exactly
what translations I wanted.

NeilBrown
