Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUIWExK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUIWExK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbUIWExK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:53:10 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:27834 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S268275AbUIWExA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:53:00 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Ray Lee <ray-lk@madrabbit.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Edgar Toernig <froese@gmx.de>,
       Robert Love <rml@novell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095910956.9652.2.camel@vertex>
References: <1095652572.23128.2.camel@vertex>
	 <1095744091.2454.56.camel@localhost>
	 <20040921173404.0b8795c9.froese@gmx.de>
	 <41504C21.3090506@nortelnetworks.com>  <1095820046.22558.4.camel@vertex>
	 <1095904012.11637.81.camel@orca.madrabbit.org>
	 <1095910956.9652.2.camel@vertex>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1095915177.4101.63.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 21:52:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, just skimmed the latest patch to try to make sure I'm not talking
crazy talk. No guarantees, though.

On Wed, 2004-09-22 at 20:42, John McCutchan wrote: 
> the inotify kernel driver only allows userspace 
> program to read in event sized chunks (So that the event queue
> handling is kept simple)

It's not much more code.

Instead of calculating events as:

+static ssize_t inotify_read(struct file *file, __user char *buf,
+			   size_t count, loff_t *pos) {
[...]
+	int events;
[...]
+	/* We only hand out full inotify events */
+	if (count < sizeof(struct inotify_event)) {
+		out = -EINVAL;
+		goto out;
+	}
+
+	events = count / sizeof(struct inotify_event);

...just keep track of the actual byte count left in buf, and continue
copying until the next event would overflow buf. Require userspace to
provide a buffer at least NAME_MAX + sizeof(struct inotify_event) [*]
where the last field in the struct is declared as filename[0], which
will guarantee forward progress in passing events.

	[*] Here's one of those things that makes me think that I'm
	talking out my tush. The comments claim that only the filename
	will be returned to userspace, but later on another comment says
	that the size might technically fly up to PATH_MAX. Wassup?

Events still arrive at userspace in logical chunks; all is good.

Perhaps I'm missing something. Always a possibility, that.

BTW:
<pedantic>
+	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];

would be more correct if written

  unsigned long bitmask[(MAX_INOTIFY_DEV_WATCHERS + BITS_PER_LONG - 1) / BITS_PER_LONG];

</pedantic>

BTW #2: 'mask' is variously declared as an unsigned long and other times
as an int. Granted, the two base declarations seem to live in different
structs, but I can't figure out when a mask-like thing would want to be
signed. Please consider either changing the name or, more likely,
changing all usages to unsigned. My single linear reading through the
patch hasn't quite clarified the usage to me.

Ray

P.s. Have I mentioned that I like the inotify idea a heck of a lot
better than dnotify? Ghu save us from people who think signals are a
wonderful way to communicate complex information.

