Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265666AbSJXVeL>; Thu, 24 Oct 2002 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSJXVeL>; Thu, 24 Oct 2002 17:34:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2063 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265666AbSJXVeK>;
	Thu, 24 Oct 2002 17:34:10 -0400
Message-ID: <3DB868BC.1@pobox.com>
Date: Thu, 24 Oct 2002 17:40:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: Switching from IOCTLs to a RAMFS
References: <Pine.LNX.4.44.0210241051340.983-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:

> On Thu, 24 Oct 2002, Jeff Garzik wrote:
>
>> Mark Peloquin wrote:
>>
>>> Based on the feedback and comments regarding
>>> the use of IOCTLs in EVMS, we are switching to
>>> the more preferred method of using a ram based
>>> fs. Since we are going through this effort, I
>>> would like to get it right now, rather than
>>> having to switch to another ramfs system later
>>> on. The question I have is: should we roll our
>>> own fs, (a.k.a. evmsfs) or should we use sysfs
>>> for this purpose? My initial thoughts are that
>>> sysfs should be used. However, recent discussions
>>> about device mapper have suggested a custom ramfs.
>>> Which is the *best* choice?
>>
>>
>> (cc'd viro and mochel, as I feel they are 'owners' in the subject area)
>>
>> Let's jump back a bit, for a second. Why is procfs bad news? There are
>> minor issues with the implementation of single-page output and lack of
>> pure file operations, but the big issue is lack of a sane namespace.
>> sysfs is no better than procfs if we keep heaving junk into it without
>> thinking about proper namespace organization.
>
>
> That's one of my personal goals: to mandate some amount of sanity in the
> namespace organization. Without it, sysfs is basically just a modernized
> procfs.


Is there a namespace doc or guideline we can look at?
(for existing nodes, sure, but more guidelines for future nodes)


>
>> I personally prefer a separate filesystem for what you describe. That
>> gives the EVMS team control over their own portion of the namespace,
>> while giving complete flexibility. I do _not_ see sysfs as simply a
>> procfs replacement -- sysfs IMO is more intended as a way to organize
>> certain events and export internal kernel structure.
>
>
> I do not view those as necessarily competing goals. The mission statement
> of sysfs is to "export kernel objects, their attributes, and their
> relation to other objects".
>
> EVMS, like any other subsystem, has a set of objects and methods to
> operate on them, as exported via attributes. They have their have their
> own object hierarchy, and in no way do I want to dilute that (or pollute
> anything else ;). sysfs should be able to handle this. It does today,
> though it's not as seamless as I would prefer it.


I hope that sysfs imposes some sort of structure on random sysfs users?


>
> I would rather mature the API and consolidate the common code, than 
> have N
> copies of the same filesystem, each with a slightly different purpose, in
> existence. There are so many benefits:
>
> - Less code duplication, and less places to fix identical bugs.

Not in this argument :)  libfs.c handles this quite nicely.  And it's 
just a matter of moving more code into libfs.c for things like this.

In fact it looks like some of the sysfs/inode.c code could be moved to 
libfs.c or should be using libfs.c code ;-)

Further, looking at current sysfs/inode.c code, it seems that ->read and 
->write ops provided are severely lacking in flexibility.  If you let 
users provide their own file_operations directly, that would be nice.   
Calling __get_free_page and having users send data to that page is easy 
-- and kills quite a lot of flexibility that would push one towards 
creating a private 'meta' filesystem.  Having that page provided for you 
is IMO really only useful for spitting out status data...

>
> - It makes it easier to write for; instead of having to copy n' paste a
> new filesystem to export your subsystem's objects, you can add a field
> to a structure and call a function.

This is a function of any API.  copy-n-paste is not an argument against 
a private filesystem -- see libfs.c counter-argument above.

> - It's easier for the user to mount one filesystem and get everything,
> instead of trying to figure out what fs has what ifno. 

agreed

> - It's easier to associate objects between subsystems, since you can
> internally create relative symlinks between two objects (and soon with a
> single call). 

agreed

So let users provide their own file_operations, and have guidelines for 
new users, and I'll be happier :)

    Jeff




