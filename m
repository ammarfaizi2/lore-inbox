Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWEBVtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWEBVtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWEBVtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:49:12 -0400
Received: from soundwarez.org ([217.160.171.123]:38094 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S965006AbWEBVtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:49:11 -0400
Date: Tue, 2 May 2006 23:49:08 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Michael Holzheu <holzheu@de.ibm.com>,
       akpm@osdl.org, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi,
       ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060502214908.GB18192@vrfy.org>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <20060429215501.GA9870@kroah.com> <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com> <20060501203815.GE19423@kroah.com> <2DBA690E-B11A-478E-B2E0-0529F4CE45A9@mac.com> <20060502040053.GA14413@kroah.com> <13D6E299-061B-46A5-A3CD-12E1075B9451@mac.com> <20060502213043.GB30957@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502213043.GB30957@kroah.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 02:30:43PM -0700, Greg KH wrote:
> On Tue, May 02, 2006 at 04:48:42AM -0400, Kyle Moffett wrote:
> > On May 2, 2006, at 00:00:53, Greg KH wrote:
> > >On Mon, May 01, 2006 at 07:29:23PM -0400, Kyle Moffett wrote:
> > >>So my question stands:  What is the _recommended_ way to handle  
> > >>simple data types in low-bandwidth/frequency multiple-valued  
> > >>transactions to hardware?  Examples include reading/modifying  
> > >>framebuffer settings (currently done through IOCTLS), s390 current  
> > >>state (up for discussion), etc.  In these cases there needs to be  
> > >>an atomic snapshot or write of multiple values at the same time.   
> > >>Given the situation it would be _nice_ to use sysfs so the admin  
> > >>can do it by hand; makes things shell scriptable and reduces the  
> > >>number of binary compatibility issues.
> > >
> > >I really don't know of a way to use sysfs for this currently, and  
> > >hence, am not complaining too much about the different /proc files  
> > >that have this kind of information in it at the moment.
> > >
> > >If you or someone else wants to come up with some kind of solution  
> > >for it, I'm sure that many people would be very happy to see it.
> > 
> > Hmm, ok; I'll see what I can come up with.  Would anybody object to  
> > this kind of API (as in my previous email) that uses an open fd as a  
> > transaction "handle"?
> 
> No, I think Kay played around with something like using the open fd of
> the directory as such a lock (or was he using flock on it, I can't
> remember now...)

If you can assume that processes accessing the values are cooperative,
it already works without any changes:

  $ time flock /sys/class/firmware echo 1 > /sys/class/firmware/timeout
  real    0m0.005s

  $ flock /sys/class/firmware sleep 5&
  [1] 6468

  $ time flock /sys/class/firmware echo 1 > /sys/class/firmware/timeout
  real    0m3.558s

Kay
