Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTI2IZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbTI2IZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:25:46 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:9441 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262878AbTI2IZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:25:45 -0400
Subject: Re: [PATCH] s390 (2/19): common i/o layer.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFA73D5DE7.2CE6ABA5-ONC1256DB0.002D7A05-C1256DB0.002E2AB4@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 29 Sep 2003 10:24:15 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 29/09/2003 10:24:55
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christoph,

> > +static inline void
> > +__ccwgroup_remove_symlinks(struct ccwgroup_device *gdev)
> > +{
> > +        int i;
> > +        char str[8];
> > +
> > +        for (i = 0; i < gdev->count; i++) {
> > +                    sprintf(str, "cdev%d", i);
> > +                    sysfs_remove_link(&gdev->dev.kobj, str);
> > +                    /* Hack: Make sure we act on still valid subdirs. */
> > +                    if (atomic_read(&gdev->cdev[i]->dev.kobj.dentry->d_count))
> > +                                sysfs_remove_link(&gdev->cdev[i]->dev.kobj,
> > +                                                          "group_device");
> > +        }
>
> This looks like you have a bad refcounting problem somewhere.  I'd rather
> see it fixed than hacked around..

Conny and I looked at the code paths and we came to the conclusion that it should
work as is but without the atomic_read hack. The remove function of groupable
ccw devices points to ccwgroup_remove_ccwdev. This function ungroups the ccw devices
if one of them is deleted. This is done prior to the removal of the sysfs directory
for the ccw device. So the atomic_read is superflous, d_count has to be > 0.
Conny once saw a crash due to an already deleted dentry but we couldn't recreate the
problem. We decided to remove the hack and to see what happens. If we get another
crash we'll have to find the real cause of it.

blue skies,
   Martin


