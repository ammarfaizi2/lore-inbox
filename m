Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbTJGEbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 00:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTJGEbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 00:31:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:7926 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261791AbTJGEbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 00:31:39 -0400
Date: Tue, 7 Oct 2003 10:01:57 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031007043157.GA9036@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006202656.GB9908@in.ibm.com> <Pine.LNX.4.44.0310061321440.985-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310061321440.985-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 01:29:20PM -0700, Patrick Mochel wrote:
> 
> Uh, that's about the same thing I suggested, though probably not as 
> concisely: 
> 
> "As I said before, I don't know the right solution, but the directions to 
> look in are related to attribute groups. Attributes definitely consume the 
> most amount of memory (as opposed to the kobject hierachy), so delaying 
> their creation would help, hopefully without making the interface too 
> awkward. 

Ok.. attributes do consume maximum in sysfs. In the system I mentioned
leaf dentries are about 65% of the total.

> You can also use the assumption that an attribute group exists for all the 
> kobjects in a kset, and that a kobject knows what kset it belongs to. And

That's not correct... kobject corresponding to /sys/block/hda/queue 
doesnot know which kset it belongs to and what are its attributes. Same
for /sys/block/hda/queue/iosched.

> that eventually, all attributes should be added as part of an attribute 
> group.."
> 
> Attributes are the leaf entries, and they don't need to always exist. But, 
> you have easy access to them via the attribute groups of the ksets the 
> kobjects belong to. 
> 

Having backing store just for leaf dentries should be fine. But there is 
_no_ easy access for attributes. For this also I see some data change required 
as of now. The reasons are 
 - not all kobjects belong to a kset. For example, /sys/block/hda/queue
 - not all ksets have attribute groups
  
I don't see any generic rule for finding attributes or attribute group
of a kobject. Such random-ness forced me to add new fields to kobject. The
sysfs picture doesnot show the kset-kobject relationship. For example
kobject corresponding /sys/devices/system does not belong to devices_subsystem.
and it is not in the devices_subsys->list. There was no other way except to
build new hierarchy info in the kobject. 

What are people's opinion about the way I have linked attributes and
attributes_group to the kobject. I could not link "struct attribute" and
"struct attriubte_group" directly to kobject because these are generally 
statically alocated and many kobjects will have the same attribute structure.
and are asigned to multiple kobjects 

Thanks
Maneesh
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
