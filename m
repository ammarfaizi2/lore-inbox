Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUI1Fpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUI1Fpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 01:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUI1Fpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 01:45:33 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:19147 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S267551AbUI1Fpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 01:45:30 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: Robert Love <rml@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096318369.30503.136.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Mon, 27 Sep 2004 22:45:28 -0700
Message-Id: <1096350328.26742.52.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 16:52 -0400, Robert Love wrote:
> > > +struct inotify_event {
> > > +	int wd;
> > > +	int mask;
> > > +	int cookie;
> > > +	char filename[INOTIFY_FILENAME_MAX];
> > > +};
> > 
> > yeah, that's not very nice.  Better to kmalloc the pathname.
> 
> That is the structure that we communicate with to user-space.
> 
> We could kmalloc() filename, but it makes the user-space use a bit more
> complicated (and right now it is trivial and wonderfully simple).
> 
> We've been debating the pros and cons.

The current way pads out the structure unnecessarily, and still doesn't
handle the really long filenames, by your admission. It incurs extra
syscalls, as few filenames are really 256 characters in length. It makes
userspace double-check whether the filename extends all the way to the
boundary of the structure, and if so, then go back to the disk to try to
guess what the kernel really meant to say.

My way, doing a kmalloc of either the entire structure + filename length
+ NUL, or just the filename + NUL makes userspace infinitesimally
trickier to write. There's more effort in just getting the error
handling correct in either version.

The current way viewed by userspace, stolen shamelessly from the beagle
source:

    /* FIXME: We need to check for errors, etc. */
    remaining = sizeof (struct inotify_event);
    event_buffer = (char *) &event;
    while (remaining > 0) {
        num_bytes = read (fd, event_buffer, remaining);
        event_buffer += num_bytes;
        remaining -= num_bytes;
    }

My way (where struct inotify_event is declared with a char filename[0]
at the end):

    if ((n=read(fd, buf, sizeof buf)) > 0) {
	unsigned offset=0;
        while (n > 0) {
            // inotify guarantees complete events 
            unsigned len = sizeof(struct inotify_event);
            dispatch((struct inotify_event *) &buf[offset]);
            len += strlen(buf[offset + len]) + 1;
            n -= len;
            offset += len;
        }
    }

Doesn't seem all that tricky.

I'm willing to believe that I'm missing something. Help me see what.

Ray

