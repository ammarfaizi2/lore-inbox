Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWHaJGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWHaJGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 05:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWHaJGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 05:06:12 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:41440 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751018AbWHaJGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 05:06:11 -0400
Subject: Re: [S390] cio: kernel stack overflow.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060830191927.GA8408@osiris.ibm.com>
References: <20060830124047.GA22276@skybase>
	 <ed4nih$gb0$2@taverner.cs.berkeley.edu>
	 <20060830191927.GA8408@osiris.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 31 Aug 2006 11:06:07 +0200
Message-Id: <1157015167.23755.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 21:19 +0200, Heiko Carstens wrote:
> > >-            cdev->id = (struct ccw_device_id) {
> > >-                    .cu_type   = cdev->private->senseid.cu_type,
> > >-                    .cu_model  = cdev->private->senseid.cu_model,
> > >-                    .dev_type  = cdev->private->senseid.dev_type,
> > >-                    .dev_model = cdev->private->senseid.dev_model,
> > >-            };
> > >+            cdev->id.cu_type   = cdev->private->senseid.cu_type;
> > >+            cdev->id.cu_model  = cdev->private->senseid.cu_model;
> > >+            cdev->id.dev_type  = cdev->private->senseid.dev_type;
> > >+            cdev->id.dev_model = cdev->private->senseid.dev_model;
> > 
> > I don't see any obvious place that zeroes out cdev->id.
> > In particular, it looks like cdev->id.match_flags and .driver_info
> > are never cleared (i.e., they retain whatever old garbage they had
> > before).  More importantly, if anyone ever adds any more fields to
> > struct ccw_device_id, then they will also be retain old garbage values,
> > which is a maintenance pitfall.  Is this right, or did I miss something
> > again?
> 
> You're right. Thanks for pointing this out! I will take care of it.

The ccw_device_id structure contains two more fields in addition to the
field that are set up in ccw_device_recog_done, namely match_flags and
driver_info. driver_info is set later in ccw_bus_match, so that is fine.
match_flags of the device is never used, only the match_flags of the
drivers version of the ccw_device_id is used. So the code is correct
even without the memset. But your point about the maintenance pitfall is
valid, we will add a memset after 2.6.18. I don't want to push yet
another patch.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


