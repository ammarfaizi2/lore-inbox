Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbVINJBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVINJBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVINJBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:01:38 -0400
Received: from spc1-leed3-6-0-cust185.seac.broadband.ntl.com ([80.7.68.185]:10254
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S965094AbVINJBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:01:35 -0400
Message-ID: <4327E6E3.3050501@redhat.com>
Date: Wed, 14 Sep 2005 10:01:23 +0100
From: Patrick Caulfield <pcaulfie@redhat.com>
Organization: Red Hat
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux clustering <linux-cluster@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, ak@suse.de, linux-fsdevel@vger.kernel.org,
       Joel.Becker@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
References: <20050901104620.GA22482@redhat.com>	<20050903183241.1acca6c9.akpm@osdl.org>	<20050904030640.GL8684@ca-server1.us.oracle.com>	<200509040022.37102.phillips@istop.com>	<20050903214653.1b8a8cb7.akpm@osdl.org>	<20050904045821.GT8684@ca-server1.us.oracle.com>	<20050903224140.0442fac4.akpm@osdl.org>	<20050905043033.GB11337@redhat.com>	<20050905015408.21455e56.akpm@osdl.org>	<20050905092433.GE17607@redhat.com>	<20050905021948.6241f1e0.akpm@osdl.org> <1125922894.8714.14.camel@localhost.localdomain>
In-Reply-To: <1125922894.8714.14.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just returned from holiday so I'm late to this discussion so let me tell
you what we do now and why and lets see what's wrong with it.

Currently the library create_lockspace() call returns an FD upon which all lock
operations happen. The FD is onto a misc device, one per lockspace, so if you
want lockspace protection it can happen at that level. There is no protection
applied to locks within a lockspace nor do I think it's helpful to do so to be
honest. Using a misc device limits you to <255 lockspaces depending on the other
uses of misc but this is just for userland-visible lockspace - it does not
affect GFS filesystems for instance.

Lock/convert/unlock operations are done using write calls on that lockspace FD.
Callbacks are implemented using poll and read on the FD, read will return data
blocks (one per callback) as long as there are active callbacks to process. The
current read functionality behaves more like a SOCK_PACKET than a data stream
which some may not like but then you're going to need to know what you're
reading from the device anyway.

ioctl/fcntl isn't really useful for DLM locks because you can't do asynchronous
operations on them - the lock has to succeed or fail in the one operation - if
you want a callback for completion (or blocking notification) you have to poll
the lockspace FD anyway and then you might as well go back to using read and
write because at least they are something of a matched pair. Something similar
applies, I think, to a syscall interface.

Another reason the existing fcntl interface isn't appropriate is that it's not
locking the same kind of thing. Current Unix fcntl calls lock byte ranges. DLM
locks arbitrary names and has a much richer list of lock modes. Adding another
fcntl just runs in the problems mentioned above.

The other reason we use read for callbacks is that there is information to be
passed back: lock status, value block and (possibly) query information.

While having an FD per lock sounds like a nice unixy idea I don't think it would
work very well in practice. Applications with hundreds or thousands of locks
(such as databases) would end up with huge pollfd structs to manage, and it
while it helps the refcounting (currently the nastiest bit of the current
dlm_device code) removes the possibility of having persistent locks that exist
after the process exits - a handy feature that some people do use, though I
don't think it's in the currently submitted DLM code. One FD per lock also gives
each lock two handles, the lock ID used internally by the DLM and the FD used
externally by the application which I think is a little confusing.

I don't think a dlmfs is useful, personally. The features you can export from it
are either minimal compared to the full DLM functionality (so you have to export
the rest by some other means anyway) or are going to be so un-filesystemlike as
to be very awkward to use. Doing lock operations in shell scripts is all very
cool but how often do you /really/ need to do that?

I'm not saying that what we have is perfect - far from it - but we have thought
about how this works and what we came up with seems like a good compromise
between providing full DLM functionality to userspace using unix features. But
we're very happy to listen to other ideas - and have been doing I hope.

-- 

patrick


