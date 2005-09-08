Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVIHU2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVIHU2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbVIHU2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:28:12 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:25319 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964991AbVIHU2K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:28:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMHwR4TCmwT4V+5UjtA/I51WfmOAOIqcnWJH8fyaXaTthBqrI76YP2yn5/hifGt2ANWhUJQiJ//IiaXXm+C5tOkXcpuP2wv8CQ4loW0gHuSqDWcI/5nYeK9ttMoFXN/SVPy0DZVP9WnV6jo4VJHPsuibgeA3KuhM/dI8Yy2WlvM=
Message-ID: <4789af9e05090813287f05e12a@mail.gmail.com>
Date: Thu, 8 Sep 2005 14:28:09 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
Reply-To: jim.ramsay@gmail.com
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-usb-users@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [Linux-usb-users] Possible bug in usb storage (2.6.11 kernel)
In-Reply-To: <4789af9e05090812521d9d687b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4789af9e05090810142bd3531d@mail.gmail.com>
	 <20050908175852.GA3196@one-eyed-alien.net>
	 <4789af9e05090812521d9d687b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Jim Ramsay <jim.ramsay@gmail.com> wrote:
> On 9/8/05, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> > On Thu, Sep 08, 2005 at 11:14:36AM -0600, Jim Ramsay wrote:
> > > I think I have found a possible bug:
> > > [...]
> > > I suppose the scsi code could be changed to guarantee that
> > > srb->request_buffer is page-aligned or cache-aligned, but that seems
> > > like the wrong solution for this bug.
> >
> > Fixing the SCSI layer is -exactly- the correct solution.  The SCSI layer is
> > supposed to guarantee us that those buffers are suitable for DMA'ing, and
> > apparently it's violating that promise.
> 
> Thanks, I'll check on what buffer I'm actually getting, where it's
> allocated, and post back what I find, or how I fixed it.

More information:

The error only occurrs during device sensing when the
srb->request_buffer is assigned as follows, by usb/storage/transport.c
in the routine usb_stor_invoke_transport:

old_request_buffer = srb->request_buffer;
srb->request_buffer = srb->sense_buffer;

Now, this is a problem because srb->sense_buffer is defined as follows
in the struct scsi_cmnd:

#define SCSI_SENSE_BUFFERSIZE   96
        unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];

Since it is not allocated at runtime there is NO WAY the SCSI layer
can possibly guarantee it is page- or cache-aligned and ready for DMA.

Any suggestions on best fix for this?  Is it still a SCSI-layer issue?
 Or should USB step up in this case and ensure this buffer is dma-safe
itself?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
