Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUIBQ0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUIBQ0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUIBQ0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:26:40 -0400
Received: from peabody.ximian.com ([130.57.169.10]:12749 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268680AbUIBQZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:25:55 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040902083407.GC3191@kroah.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
Content-Type: text/plain
Date: Thu, 02 Sep 2004 12:25:21 -0400
Message-Id: <1094142321.2284.12.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 10:34 +0200, Greg KH wrote:

> Why is the kset needed?  We can determine that from the kobject.
> 
> How about changing this to:
> 	int send_kevent(struct kobject *kobj, struct attribute *attr);
> which just tells userspace that a specific attribute needs to be read,
> as something "important" has changed.
> 
> Will passing the attribute name be able to successfully handle the 
> "enum kevent" and "signal" combinations?

We can drop the kset if you say we never need it.  Why do all the kobj
get_path functions take a kset then?  That is what confused me.

We can also drop the "enum kevent" if we decide we don't want to take
advantage of the multicasting of the netlink socket.  The enum defines
what multicast group the netlink message is sent out in.  I actually
have been talking to Kay about ditching it, and we are trying to figure
out if we ever _need_ it.

So that is 2 for 2.  But ...

I don't dig replacing the signal string with an attribute.  I think it
will really limit what we can do - having the signal as a verb
describing the event is really important.  We might also not always have
an attribute.  Kay's points are all valid.

So what if we had

	int send_kevent(struct kobject *kobj, const char *signal);

Which was a way of notifying user-space of a change of "signal" on the
object "kobj" in sysfs.

If we ever wanted to send an attribute, we can do something like

	const char *signal;

	signal = attribute_to_string(attribute);
	send_kevent(kobj, signal);
	kfree(signal);

Dig that?

Best,

	Robert Love


