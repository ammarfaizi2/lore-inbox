Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVGGTtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVGGTtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVGGTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:49:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22214 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261258AbVGGTse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:48:34 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Date: Thu, 7 Jul 2005 15:48:37 -0400
User-Agent: KMail/1.7.2
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
References: <1120668881.8328.1.camel@localhost> <200507071449.10271.sgrubb@redhat.com> <20050707190455.GA19570@kroah.com>
In-Reply-To: <20050707190455.GA19570@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071548.37996.sgrubb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 July 2005 15:04, Greg KH wrote:
> You are adding auditfs, a new userspace access, right?

Not sure what you mean. This is using the same netlink interface that all the 
rest of the audit system is using for command and control. Nothing has 
changed here. What is different is the message I send into the kernel. The 
audit system dispatches it into Tim's code which in turn sets up the watch. 

The notification that the event has occurred uses the same interface that all 
other audit events use. Its just a different message type. It is filtered by 
some attributes and if it is still of interest, the event is placed in the 
queue so it is serialized with all other events.

> His email provided no documentation that I could see.  Am I just missing
> something?

The auditfs code is programmed by filling out the watch_transport structure 
and sending a AUDIT_WATCH_INS message type. The perms, pathlen, & keylen are 
all that's filled out. The path & key are stored back to back in the payload 
section. To delete, you do the same thing and send AUDIT_WATCH_REM message. 
Yes, this should be added to the documentation.

> > > So the userspace package in FC4 will not use auditfs?
> >
> > Right. You get a few warnings due to missing functionality. If the kernel
> > were patched with Tim's code, it all works as expected. We have worked
> > out the user space access and that shouldn't be changing.
>
> Then what use is auditfs for if you don't need it?

But we do. You cannot audit files who's inode may change using the current 
syscall techniques. I put the code into FC4 hoping that one day we will have 
a kernel that supports it.

The current audit system code lets you audit by syscall, which means you can 
audit open or write, but then you get it for all processes that open or 
write. Or you could limit it with a pid, but that's impossible since you 
would have to predict the future pid when putting the audit rule in.

Tim's code lets you say I want change notification to this file only. The 
notification follows the audit format with all relavant pieces of information 
gathered at the time of the event and serialized with all other events.

> Am I correct in thinking that you all need to split this patch into two
> pieces, the new inode stuff, and auditfs, as neither one has anything to
> do with the other?

It could be split to make it easier to read, but one's useless without the 
other.

-Steve
