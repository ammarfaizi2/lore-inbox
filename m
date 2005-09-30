Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVI3UPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVI3UPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 16:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVI3UPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 16:15:00 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:59107 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030382AbVI3UO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 16:14:59 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <433D9035.6000504@adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 14:14:50 -0600
Message-Id: <1128111290.10079.147.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 15:21 -0400, Luben Tuikov wrote:
> On 09/30/05 14:39, Andrew Patterson wrote:
> > 
> > SDI is supposed to be a cross-platform spec, so mandating sysfs would
> > not work.
> 
> True, sysfs is a Linux only thing.
> 
> But you can write a user space library which uses sysfs or whatever
> _that_ OS uses to represent an SDI spec-ed out picture.

Yes you can, which is what I am trying to do.  However, is that library
also available on Solaris and Windows? Is it up to date?  These are the
reasons why the spec authors rejected that approach. I don't agree with
them BTW, but I do understand why they think that way.

> 
> So a user space program would call (uniformly across all OSs)
> a libsdi library which will use whatever OS dependent way there is
> to get the information (be it sysfs or ioctl).

See the paragraph below.

> 
> > I suggested to the author to use a library like HPAAPI (used
> > by Fibre channel), so you could hide OS implementation details.  I am in
> > fact working on such a beasty (http://libsdi.berlios.de).  He thinks
> > that library solutions tend to not work, because the library version is
> > never in synch with the standard/LLDD's. Given Linux vendor lead-times,
> > he does have a valid point.
> 
> Yes, but it would be the best of all the current ways there are
> to do it.

Theoretically yes.  Practically, perhaps not.  The authors seem to have
been left with a bad taste in their mouths after their experience with
HBA API.  They agree that IOCTL are bad too do to lack of linux support,
but do not have a better cross-platform solution as yet.  The current
way around this is to use CSMI and brow-beat various Linux vendors into
allowing these IOCTL's into their kernels.

> 
> > Note that a sysfs implementation has problems.  Binary attributes are
> > discouraged/not-allowed.
> 
> I've never heard that.  Is this similar to the argument
> "The sysfs tree would be too deep?"

>From Documentation/filesystes/sysfs.txt

"Attributes should be ASCII text files, preferably with only one value
per file. It is noted that it may not be efficient to contain only
value per file, so it is socially acceptable to express an array of
values of the same type.

Mixing types, expressing multiple lines of data, and doing fancy
formatting of data is heavily frowned upon. Doing these things may get
you publically humiliated and your code rewritten without notice."

My understanding is that sysfs is meant to be human-readable.  I do not
know if this is a hard and fast rule or just a convention.  Configfs is
probably a better fit at least for writeable attributes, but may not be
cooked yet.

> 
> > There is no atomic request/response operations
> 
> For a reason: let user space do it, there is plenty of ways to
> do it, some assisted by the kernel.

User space locking can only guarantee atomic operations in user space.  

> 
> > buffers limited to page size, etc.
> 
> "You have an attribute larger than 4k?  What is it?"

Not sure at the moment, can I guarantee this for the future?

> 
> As to SMP response/request is more than 4K/8K?  The largest
> I'm aware of is 64 bytes.
> 
> > Other alternatives are
> > configfs, SG_IO, and the above mentioned character device.  None are a
> 
> Again, char devices for controlling are discouraged.  There are not enough
> around and it is old technology.

There are as many as one would want.  We now have 32 bit device numbers.
Old technology is fine as long as it works, especially if their is no
new technology to replace it.  Note that I don't like the character
device solution either. What would really be nice is something that will
allow us to pass an arbitrary request buffer, and get an arbitrary
response buffer back in a single transaction,  SG_IO comes closest, but
shares request/response buffers and is limited to a 16-byte commands.
It also requires a device file.

> 
> > complete replacement for the transactional nature of IOCTL's.  A group
> 
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

See above.  This stuff works for trivial user-space apps.  It will not
suffice for most storage management apps.  

Andrew


> 	Luben
> 



