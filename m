Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423871AbWKHXIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423871AbWKHXIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423939AbWKHXIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:08:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:50334 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423871AbWKHXIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:08:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alasdair G Kergon <agk@redhat.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Thu, 9 Nov 2006 00:06:11 +0100
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611081543.28548.rjw@sisk.pl> <20061108152533.GH30653@agk.surrey.redhat.com>
In-Reply-To: <20061108152533.GH30653@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611090006.12880.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 8 November 2006 16:25, Alasdair G Kergon wrote:
> On Wed, Nov 08, 2006 at 03:43:26PM +0100, Rafael J. Wysocki wrote:
> > Will it be enough to cover the interactions with dm?
>  
> There are cases where you *cannot* freeze the filesystem (unless
> you wait for userspace processes to finish what they are doing) -
> and only dm can tell you that.
> 
> The freeze_filesystems() code ought to do it's best in any given 
> circumstances within the constraints.
> 
> So:
>   Get the filesystem's block device.
>   Check the full tree of devices that that block device depends upon
> and for any device that belongs to device-mapper check if it is suspended.
> If it is, skip the original device.
> 
>   struct mapped_device *dm_get_md(dev_t dev);
>   int dm_suspended(struct mapped_device *md);
>   void dm_put(struct mapped_device *md);
> 
> Handling the tree is the difficult bit, but sysfs could help.
> [You can get the device-mapper dependencies with:
>   struct mapped_device *dm_get_md(dev_t dev);
>   struct dm_table *dm_get_table(struct mapped_device *md);
>   struct list_head *dm_table_get_devices(struct dm_table *t);
>   void dm_table_put(struct dm_table *t);
>   void dm_put(struct mapped_device *md);
> ]
> 
> Consider that you could have an already-frozen filesystem containing a loop
> device containing a device-mapper device containing a not-frozen filesystem.

I think the last point is handled correctly by freezing the filesystems in the
reverse order - unless the fs below the loop has been frozen before by
someone else, but I guess that would lead to problems anyway.

> You won't be able to freeze that top filesystem because the I/O would
> queue lower down the stack.  (Similar problem if the device-mapper device
> in the stack was suspended.)

The suspended dm device in the stack is not, however.

Is there any list of all dm devices in the system?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
