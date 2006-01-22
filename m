Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWAVRbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWAVRbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWAVRbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:31:12 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:41165 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964771AbWAVRbL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:31:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qjVrcR+qAMloGPgiO0JxEpHxVHqaS5jdaudmbHoqAaVJQGQUNf+uArkW5O7KfIXFlG9RLL4eQf3ebEkcdEmVd311FvyfYK1NsYts3lyGUIom1/rBYIeqhn8r0ipRKhtFGJzHXrdrbtG8JPt+L+1+2zGVQ0Xm61s+hduJflN7pGQ=
Message-ID: <9e4733910601220931x3a21e47dj7dbf834e2f36d31c@mail.gmail.com>
Date: Sun, 22 Jan 2006 12:31:10 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Jim Nance <jlnance@sdf.lonestar.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060122142401.GA24738@SDF.LONESTAR.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
	 <20060122142401.GA24738@SDF.LONESTAR.ORG>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Jim Nance <jlnance@sdf.lonestar.org> wrote:
> On Fri, Jan 20, 2006 at 04:53:44PM -0500, Jon Smirl wrote:
>
> > Any other ideas why sendfile() would get into a seek storm?
>
> I can't really comment on the quality of the linux sendfile() implementation,
> I've never looked at the code.  However, a couple of general observations.
>
> The seek storm happens because linux is trying to be "fair," where fair
> means no one process get to starve another for I/O bandwidth.

I think there is something more going on. The user space processes
submitted requests for the same IO in 500K chunks and didn't get into
a seek storm. If it was a disk fairness problem the user space
implementation would have gotten in trouble too.

There seems to be some difference in the way sendfile() submits the
requests to the disk system and how the 500K requests from user space
are handled. I believe both tests were using the same disk scheduler
algorithm so the data points to differences in how the requests are
submitted to the disk system. The sendfile() submission pattern
triggers a storm and the user space one doesn't.

I've asked the lighttpd people for more data but I haven't gotten
anything back yet. Things like RAM, network speed, disk scheduler
algorithm, etc.

>
> The fastest way to transfer 100 100M files would be to send them one at a
> time.  The 99th person in line of course would percieve this as a very poor
> implementation.  The current sendfile implementation seems to live at the
> other end of the extream.

One at a time may not be the fastest. When the network transmission
window is full you will stop transmitting on that socket but you can
probably still transmit on the others. Packet loss is another reason
for sockets blocking.

>
> It is possible to come up with a compromise behavior by limiting the
> number of concurrent sendfiles running, and the maximum size they are
> allowed to send in one squirt.
>
> Thanks,
>
> Jim
>
> --
> jlnance@sdf.lonestar.org
> SDF Public Access UNIX System - http://sdf.lonestar.org
>


--
Jon Smirl
jonsmirl@gmail.com
