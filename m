Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752414AbWCFTsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbWCFTsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbWCFTsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:48:08 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:16810 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751802AbWCFTsG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:48:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MqAc47HfpdbdGnxp+ZYxNLtwSCRoGpBZkNdiLDM1cTj+fnwd7UtMkqqXXeHzEIWvAzAErXjmastWvRWtlKnQcutwJ718FXrFtNOfSVbl9y/KtYdlV/7NFJbeX5eMjd/NKBzXxW6lOmH+kYCJ/h3tFasdM9QRLI9NUokQSWu0FWw=
Message-ID: <41b516cb0603061148v4f93778cs6b954bbb48bc25c6@mail.gmail.com>
Date: Mon, 6 Mar 2006 11:48:06 -0800
From: "Chris Leech" <christopher.leech@intel.com>
Reply-To: chris.leech@gmail.com
To: "Benjamin LaHaise" <bcrl@kvack.org>
Subject: Re: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060304192030.GA6510@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303214036.11908.10499.stgit@gitlost.site>
	 <20060303214220.11908.75517.stgit@gitlost.site>
	 <20060304192030.GA6510@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/06, Benjamin LaHaise <bcrl@kvack.org> wrote:
> On Fri, Mar 03, 2006 at 01:42:20PM -0800, Chris Leech wrote:
> > +void dma_async_device_unregister(struct dma_device* device)
> > +{
> ...
> > +     kref_put(&device->refcount, dma_async_device_cleanup);
> > +     wait_for_completion(&device->done);
> > +}
>
> This looks like a bug: device is dereferenced after it is potentially
> freed.

Actually, this is where the code is waiting to make sure it's safe to
free device.  The release function for the kref completes
device->done.  Each of the devices channels holds a reference to the
device.  When a device is unregistered it's channels are removed from
the clients, which hold a reference for each outstanding transaction. 
When all the outstanding transactions complete, the channels kref goes
to 0, and the reference to the device is dropped.  When the device
kref goes to 0 the completion is set, and it's now safe to free the
memory for the device and channel structures.

I have a writeup of the locking and reference counting that I'll
finish and add in as a big comment to the code.

-Chris
