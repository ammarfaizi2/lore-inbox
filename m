Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUI3BcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUI3BcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 21:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268104AbUI3BcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 21:32:16 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:45957 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S268100AbUI3BcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 21:32:12 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: John McCutchan <ttb@tentacle.dhs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ray-lk@madrabbit.org, rml@novell.com, cfriesen@nortelnetworks.com,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <20040929211533.5e62988a.akpm@osdl.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
	 <41599456.6040102@nortelnetworks.com>
	 <1096390398.4911.30.camel@betsy.boston.ximian.com>
	 <1096392771.26742.96.camel@orca.madrabbit.org>
	 <1096403685.30123.14.camel@vertex>  <20040929211533.5e62988a.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096507968.17643.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 21:32:49 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.29.3
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 00:15, Andrew Morton wrote:
> John McCutchan <ttb@tentacle.dhs.org> wrote:
> >
> > >  ~ ~
> > > 
> > > As Chris points out, we still need a way to pass the name or path back
> > > to userspace when an event occurs, which is the interface I was harping
> > > on a few messages back.
> > > 
> > > It seems we're trying to recreate a variant struct dirent for
> > > communicating changes to userspace. Perhaps we can learn something from
> > > already trodden ground? Just sayin'.
> > 
> > Yes the current method of passing the name back to user space is
> > definitely sub par. But I don't think passing a full path to user space
> > is reasonable, as that would require walking the dirent tree for every
> > event. Really the best we can provide user space is the filename/dirname
> > (relative to the directory you are currently watching).
> 
> Userspace requests that the kernel start monitoring an fd.  The kernel
> returns an integer cookie which corresponds to that monitor.
> 
> When an event occurs, the kernel returns the event identifier and the
> cookie to userspace.
> 
> Userspace then does a lookup to work out what pathname corresponds to the
> cookie.

That is what inotify does. Except user space asks the kernel to monitor
a particular path (not an fd).

> 
> 
> Or is it the case that you expect a single monitor on /etc will return
> "/etc/passwd" if someone modified that file, or "/etc/hosts" if someone
> modified that file?  If so, perhaps we should take that feature away and
> require that userspace rescan the directory?
> 

Yes, this is the case that we are discussing. Rescanning the directory
is a waste, if the kernel can cheaply tell userspace what happened.

> 
> Because passing pathnames into and back from the kernel from this manner is
> really not a nice design.
> 
> A halfway point might be to return {cookie-of-/etc,EVENT_MODIFY,"hosts"} to
> a monitor on the /etc directory.
> 
> 

This is what the current inotify code does. You get an event with the
filename relative to your watch descriptor (cookie). 

John
