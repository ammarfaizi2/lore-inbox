Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVANCcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVANCcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVANCci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:32:38 -0500
Received: from fmr18.intel.com ([134.134.136.17]:55989 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261853AbVANCcA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:32:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.10-mm3 scaling problem with inotify
Date: Fri, 14 Jan 2005 10:31:20 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013CA7E@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.10-mm3 scaling problem with inotify
Thread-Index: AcT52o0C5AURWXbkSQ+DbRIaBfM+WQABHv4wAAB0OVA=
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "John McCutchan" <ttb@tentacle.dhs.org>
Cc: <linux-kernel@vger.kernel.org>, <rml@novell.com>,
       <hawkes@tomahawk.engr.sgi.com>
X-OriginalArrivalTime: 14 Jan 2005 02:31:20.0974 (UTC) FILETIME=[222FEAE0:01C4F9E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Zou, Nanhai
> Sent: Friday, January 14, 2005 10:28 AM
> To: 'John McCutchan'
> Subject: RE: 2.6.10-mm3 scaling problem with inotify
> 
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of John
McCutchan
> > Sent: Friday, January 14, 2005 9:31 AM
> > To: Robert Love
> > Cc: John Hawkes; linux-kernel@vger.kernel.org
> > Subject: Re: 2.6.10-mm3 scaling problem with inotify
> >
> > On Thu, 2005-01-13 at 19:49 -0500, Robert Love wrote:
> > > On Thu, 2005-01-13 at 15:56 -0800, John Hawkes wrote:
> > > [snip]
> > >
> > > I am open to other ideas, too, but I don't see any nice shortcuts
like
> > > what we can do in inotify_inode_queue_event().
> > >
> > > (Other) John?  Any ideas?
> >
> > No, you covered things well. This code was really just a straight
copy
> > of the dnotify code. Rob cleaned it up at some point, giving us what
we
> > have today. The only fix I can think of is the one suggested by Rob
--
> > copying the dnotify code again.

 
 There is still a little difference between your implement in
 inotify_dentry_parent_queue_event from dnotify_parent
 
 In dnotify_parent, if parent is not watching the event, the code will
not fall
 through dget and dput path.
 
 While in inotify_dentry_parent_queue_event kernel will go dget and dput
even
 if (inode->inotify_data == NULL).
 
 While dget and dput will introduce a lot of atomic operations..
 And the most important, dput will grab global dcache_lock...,
 I think that is the reason why John Hawkes saw great performance drop.
 
 Simply follow dnotify_parent, only call dget and dput when
inode->inotify_data != NULL will solve this problem I think.

