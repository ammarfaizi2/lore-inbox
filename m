Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUDOTOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUDOTOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:14:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15754 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262311AbUDOTOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:14:48 -0400
Date: Thu, 15 Apr 2004 20:14:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040415191447.GE24997@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com> <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk> <20040415091752.A24815@flint.arm.linux.org.uk> <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk> <20040415161942.A7909@flint.arm.linux.org.uk> <20040415161011.GB2965@kroah.com> <20040415161332.GC24997@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415161332.GC24997@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 05:13:32PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Apr 15, 2004 at 09:10:11AM -0700, Greg KH wrote:
> > Yeah, I agree.  For 2.7, I want to make static allocation of anything
> > that contains a kobject or kref not allowed to help fix things like
> > this.
> > 
> > So once again we are back at the "module unload is hard" problem :)
> 
> ITYM "for once we have a kind of objects that does disappear only on
> module unload, so yes, this time it's really module unload that is hard".

BTW, how about a new section that would
	a) be allocated separately at module load time
	b) contain a kobject with ->release() freeing that section
	c) be populated with structures containing kobjects and having
no ->release(); main kobject would be pinned down by them.  Original
refcount in each of those guys would be 1.

module_exit() would unregister all stuff we have in there and then drop
the references to them.  No waiting for anything and when all references
to these objects are gone, we get the section freed.  That can happen
way after the completion of rmmod - as the matter of fact we could have
the same module loaded again by that time.

AFAICS, that would solve the problem with static objects.  Comments?
