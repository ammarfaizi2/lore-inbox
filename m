Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVBOSSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVBOSSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVBOSSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:18:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45447 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261733AbVBOSSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:18:14 -0500
Message-ID: <42123C6C.3070102@sgi.com>
Date: Tue, 15 Feb 2005 12:16:12 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-mm <linux-mm@kvack.org>, Robin Holt <holt@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, Marcello.Tossattu@cyclades.com,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215115302.GB19586@wotan.suse.de>
In-Reply-To: <20050215115302.GB19586@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>(1)  You really don't want to migrate the code pages of shared libraries
>>     that are mapped into the process address space.  This causes a
>>     useless shuffling of pages which really doesn't help system
>>     performance.  On the other hand, if a shared library is some
>>     private thing that is only used by the processes being migrated,
>>     then you should move that.
> 
> 
> I think the better solution for this would be to finally integrate Steve L.'s 
> file attribute code (and find some solution to make it persistent,
> e.g. using xattrs with a new inode flag) and then "lock" the shared 
> libraries to their policy using a new attribute flag.
> 

I really don't see how that is relevant to the current discussion, which,
as AFAIK, is that the kernel interface should be "migrate an entire process"
versus what I have proposed.  What we are trying to avoid here for shared
libraries is two things:  (1) don't migrate them needlessly, and (2) don't
even make the migration request if we know that the pages shouldn't be
migrated.

Using Steve Longerbeam's approach avoids (1).  But you will still scan the
pte's of the proceeses to be migrated (if you go with a "migrate the
entire process" approach) and try to migrate them, only to find out that
they are pinned in place.  How is that a good thing?

A much simpler way to do this would be to add a list of libraries that
you don't want to be migrated to the migration library that I have
proposed to be the interface between the batch scheduler and the kernel.
Then when the library scans the /proc/pid/maps stuff, it can exlcude
those libraries from migration.  Furthermore, no migration requests will
even be initiated for those parts of the address space.

Of course, this means maintaining a library list in the migration
library.  We may eventually decide to do that.  For now, we're following
up on the reference count approach I outlined before.

> 
>>(2)  You really only want to migrate pages once.  If a file is mapped
>>     into several of the pid's that are being migrated, then you want
>>     to figure this out and issue one call to have it moved wrt one of
>>     the pid's.
>>     (The page migration code from the memory hotplug patch will handle
>>     updating the pte's of the other processs (thank goodness for
>>     rmap...))
> 
> 
> I don't get this. Surely the migration code will check if a page
> is already in the target node, and when that is the case do nothing.
> 
> How could this "double migration" happen? 

Not so much a double migration, but a double request for migration.
(This is not a correctness, but a performance issue, once again.)
Consider the case of a 300 GB file mapped into 256 pid's.  One doesn't
want each pid to try to migrate the file pages.  Granted, all after the
first one will find the data already migrated, but if you issue a
migration request for each address space, the others won't know that
the page has been migrated until they have found the page and looked
up its current node.  That means doing a find_get_page() for each page
in the mapped file in all 256 address spaces, and 255 of those address
spaces will find the page has already been migrated.  How is that
useful?  I'd much rather migrate it once from the perspective of
a single address space, and then skip the scanning for pages to
migrate in all of the other address spaces.

> 
> 
>>(3)  In the case where a particular file is mapped into different
>>     processes at different file offsets (and we are migrating both
>>     of the processes), one has to examine the file offsets to figure
>>     out if the mappings overlap or not. If they overlap, then you've
>>     got to issue two calls, each of which describes a non-overlapping
>>     region; both calls taken together would cover the entire range
>>     of pages mapped to the file.  Similarly if the ranges do not
>>     overlap.
> 
> 
> That sounds like a quite obscure corner case which I'm not sure
> is worth all the complexity.
> 
> -Andi
> 
> 

So what is your solution when this happens?  Make the job non-migratable?
Yes, it may be an obscure case in your view but we've got to handle all of
those cases to make a robust facility that can be used in a production 
environment.

-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------
