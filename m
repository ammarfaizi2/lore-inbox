Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268353AbUIBSgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268353AbUIBSgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUIBSgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:36:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21893 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S268353AbUIBSgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:36:08 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Robert Love <rml@ximian.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, kay.sievers@vrfy.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1094142321.2284.12.camel@betsy.boston.ximian.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Message-Id: <1094150112.1316.55.camel@DYN319498.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 11:35:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 09:25, Robert Love wrote:
> On Thu, 2004-09-02 at 10:34 +0200, Greg KH wrote:
> 
> > Why is the kset needed?  We can determine that from the kobject.
> > 
> > How about changing this to:
> > 	int send_kevent(struct kobject *kobj, struct attribute *attr);
> > which just tells userspace that a specific attribute needs to be read,
> > as something "important" has changed.
> > 
> > Will passing the attribute name be able to successfully handle the 
> > "enum kevent" and "signal" combinations?
> 
> We can drop the kset if you say we never need it.  Why do all the kobj
> get_path functions take a kset then?  That is what confused me.
> 
> We can also drop the "enum kevent" if we decide we don't want to take
> advantage of the multicasting of the netlink socket.  The enum defines
> what multicast group the netlink message is sent out in.  I actually
> have been talking to Kay about ditching it, and we are trying to figure
> out if we ever _need_ it.


The only problem I see is making an app sift through all of the events
to get to a specific type of event. They'd have to parse and match the
signal, that could be costly. 

Will there be small single purpose applications listening on the netlink
socket or off dbus for specific signals? Or do you see this mainly
handled by a single kevent daemon? 



> So that is 2 for 2.  But ...
> 
> I don't dig replacing the signal string with an attribute.  I think it
> will really limit what we can do - having the signal as a verb
> describing the event is really important.  We might also not always have
> an attribute.  Kay's points are all valid.
> 
> So what if we had
> 
> 	int send_kevent(struct kobject *kobj, const char *signal);
> 
> Which was a way of notifying user-space of a change of "signal" on the
> object "kobj" in sysfs.
> 
> If we ever wanted to send an attribute, we can do something like
> 
> 	const char *signal;
> 
> 	signal = attribute_to_string(attribute);
> 	send_kevent(kobj, signal);
> 	kfree(signal);
> 
> Dig that?


I thought you wanted to standardize the signals? Would you have a
delimiter in your signal to have a standard prefix to use to identify
the string in User Space? 

Why not add the attribute name to the path you get from the kobj? 

send_attribute_kevent(kobj, attr->name, signal);

and

send_kevent(kobj, signal);


Thanks,

Dan

