Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUI3BZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUI3BZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 21:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUI3BZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 21:25:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:48348 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266650AbUI3BZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 21:25:33 -0400
Date: Wed, 29 Sep 2004 21:15:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: ray-lk@madrabbit.org, rml@novell.com, cfriesen@nortelnetworks.com,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040929211533.5e62988a.akpm@osdl.org>
In-Reply-To: <1096403685.30123.14.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
	<20040926211758.5566d48a.akpm@osdl.org>
	<1096318369.30503.136.camel@betsy.boston.ximian.com>
	<1096350328.26742.52.camel@orca.madrabbit.org>
	<20040928120830.7c5c10be.akpm@osdl.org>
	<41599456.6040102@nortelnetworks.com>
	<1096390398.4911.30.camel@betsy.boston.ximian.com>
	<1096392771.26742.96.camel@orca.madrabbit.org>
	<1096403685.30123.14.camel@vertex>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <ttb@tentacle.dhs.org> wrote:
>
> >  ~ ~
> > 
> > As Chris points out, we still need a way to pass the name or path back
> > to userspace when an event occurs, which is the interface I was harping
> > on a few messages back.
> > 
> > It seems we're trying to recreate a variant struct dirent for
> > communicating changes to userspace. Perhaps we can learn something from
> > already trodden ground? Just sayin'.
> 
> Yes the current method of passing the name back to user space is
> definitely sub par. But I don't think passing a full path to user space
> is reasonable, as that would require walking the dirent tree for every
> event. Really the best we can provide user space is the filename/dirname
> (relative to the directory you are currently watching).

Userspace requests that the kernel start monitoring an fd.  The kernel
returns an integer cookie which corresponds to that monitor.

When an event occurs, the kernel returns the event identifier and the
cookie to userspace.

Userspace then does a lookup to work out what pathname corresponds to the
cookie.


Or is it the case that you expect a single monitor on /etc will return
"/etc/passwd" if someone modified that file, or "/etc/hosts" if someone
modified that file?  If so, perhaps we should take that feature away and
require that userspace rescan the directory?


Because passing pathnames into and back from the kernel from this manner is
really not a nice design.

A halfway point might be to return {cookie-of-/etc,EVENT_MODIFY,"hosts"} to
a monitor on the /etc directory.

