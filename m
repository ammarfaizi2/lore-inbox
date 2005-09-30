Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbVI3VQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbVI3VQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 17:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbVI3VQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 17:16:00 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:18100 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030382AbVI3VP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 17:15:59 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <433DA0DF.9080308@adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>
	 <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 15:15:50 -0600
Message-Id: <1128114950.10079.170.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 16:32 -0400, Luben Tuikov wrote:
> On 09/30/05 16:14, Andrew Patterson wrote:
> > 
> > Yes you can, which is what I am trying to do.  However, is that library
> > also available on Solaris and Windows? Is it up to date?  These are the
> 
> Is the kernel the latest one? Is it up to date?
> 
> See?  Same argument.
> 
> >>>Note that a sysfs implementation has problems.  Binary attributes are
> >>>discouraged/not-allowed.
> >>
> >>I've never heard that.  Is this similar to the argument
> >>"The sysfs tree would be too deep?"
> > 
> > 
> >>From Documentation/filesystes/sysfs.txt
> > 
> > "Attributes should be ASCII text files, preferably with only one value
> > per file. It is noted that it may not be efficient to contain only
> > value per file, so it is socially acceptable to express an array of
> > values of the same type.
> > 
> > Mixing types, expressing multiple lines of data, and doing fancy
> > formatting of data is heavily frowned upon. Doing these things may get
> > you publically humiliated and your code rewritten without notice."
> 
> I see this talk _only_ about non-binary attributes.

I think that "ASCII text files" implies non-binary. As Willy has pointed
out, this has already been violated.

> 
> Plus you have to admit: the SAS sysfs "smp_portal" binary
> attribute is very versatile: you completely control the
> expander from user space _if_ you can see it:  It is 
> almost like "point and click".

No problem with this.  

> 
> I imagine there would be GUIs built on top of it, which would
> actually implement that "point, click, control".
> 
> > My understanding is that sysfs is meant to be human-readable.  I do not
> 
> But `cat /sysfs/.../smp_portal` _is_ human readable.  See?  Its size is
> 0 bytes and when you read it you get 0 data read.

I don't quite think your definition of human readable is the same as
mine. I think the intention is to do something like:

$ cat attribute
3 Gb/s

or 

$ echo "3 Gb/s" >attribute

Rather than

$ cat attribute
gibberish.

or

$ echo "gibberish" >attribute

But again, this may be just a goal and not a hard and fast rule.  I can
definitely see a use for binary attributes in sysfs. Configfs seems to
be designed for this sort of thing.

> 
> > User space locking can only guarantee atomic operations in user space.  
> 
> And user space is the whole audience of this interface.
> 
> > Not sure at the moment, can I guarantee this for the future?
> 
> How far in the future? 1, 3, 6 months?  1, 3, 6 years?
> Plus if you need an attribute larger than 4K, you've got
> other problems to worry about.
> 
> > There are as many as one would want.  We now have 32 bit device numbers.
> > Old technology is fine as long as it works, especially if their is no
> > new technology to replace it.  Note that I don't like the character
> > device solution either. What would really be nice is something that will
> > allow us to pass an arbitrary request buffer, and get an arbitrary
> > response buffer back in a single transaction,
> , locks it, then hangs.
> Here:
> 
> /* User space lock */
> 
> fd = open(smp_portal, ...);
> write(fd, smp_req, smp_req_size);
> read(fd, smp_resp, smp_resp_size);
> close(fd);
> 
> /* User space unlock */
> 
> > See above.  This stuff works for trivial user-space apps.  It will not
> > suffice for most storage management apps.  
> 
> Sorry but I completely fail to see this argument., locks it, then hangs.
> 
> How will it "fail for most storage managament apps"?

Let's see, one example:

Process A opens an attribute and writes to it.  Process B opens another
attribute and writes to it, affecting the result that process A will see
from its subsequent read. I suppose you could lock every attribute, but
that would be very error-prone, and not allow much concurrency.

Andrew

> 
> 	Luben
> 

