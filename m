Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUC3Fri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbUC3Fri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:47:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:9426 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263228AbUC3FrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:47:20 -0500
Date: Tue, 30 Mar 2004 11:21:35 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, stern@rowland.harvard.edu, david-b@pacbell.net,
       viro@math.psu.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040330055135.GA8448@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040328063711.GA6387@kroah.com> <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org> <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329153117.558c3263.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 03:31:17PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > > The module should remain in memory, "unhashed", until the final kobject
> > > reference falls to zero.  Destruction of that kobject causes the refcount
> > > on the module to fall to zero which causes the entire module to be
> > > released.
> > > 
> > > (hmm, the existence of a kobject doesn't appear to contribute to its
> > > module's refcount.  Why not?)
> > 
> > It does, if a file for that kobject is opened.  In this case, there was
> > no file opened, so the module refcount isn't incremented.
> 
> hm, surprised.  Shouldn't the existence of a kobject contribute to its
> module's refcount?
> 
> > > Maybe a shrink_dcache_parent(dentry) on entry to simple_rmdir() would
> > > suffice?
> > 
> > Will that get rid of the references properly nwhen we remove the
> > kobject?
> 
> That's one the dcache guys could address better, but I was mainly proposing
> it as a way of removing any negative dentries.  But it appears that we have
> problems beyond negative dentries?

shrink_dcache_parent() will only free up the zero ref. counted dentries,
positive or negatvie doesnot matter. But we may have some faulty user space
app holding a sysfs file, sysfs directory, corresponding kobject, module etc.
Refer http://bugme.osdl.org/show_bug.cgi?id=1884

(Greg, I am including the reply for other thread also here)
http://marc.theaimsgroup.com/?l=linux-kernel&m=108059485726012&w=2

Fix for these problems will depend upon the life time rule for
modules Vs kobjects Vs dentries. When and what should die or live?
                                                                                
I am not very clear about how the first two behave. Still I can think
of a solution within sysfs like this as Alen suggested. But again I am not 
very sure if this can be done properly without any races. But anyway I am 
trying.
                                                                                
1) backout my patch sysfs-pin-kobject.patch
2) handle NULL d_fsdata while trying to access the corresponding kobject
   for an attribute file.

Maneesh
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
