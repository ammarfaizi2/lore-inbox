Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUEFXte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUEFXte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 19:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUEFXte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 19:49:34 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:54138 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261184AbUEFXtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 19:49:31 -0400
Message-ID: <409ACF04.8010805@yahoo.com.au>
Date: Fri, 07 May 2004 09:49:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Zaitsev <peter@mysql.com>, alexeyk@mysql.com, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
References: <200405022357.59415.alexeyk@mysql.com>	<200405050301.32355.alexeyk@mysql.com>	<20040504162037.6deccda4.akpm@osdl.org>	<200405060204.51591.alexeyk@mysql.com>	<20040506014307.1a97d23b.akpm@osdl.org>	<1083867233.2420.29.camel@abyss.local> <20040506144933.1918317f.akpm@osdl.org>
In-Reply-To: <20040506144933.1918317f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Zaitsev <peter@mysql.com> wrote:
> 
>>On Thu, 2004-05-06 at 01:43, Andrew Morton wrote:
>>
>>
>>>One thing I note about this test is that it generates a huge number of
>>>inode writes.  atime updates from the reads and mtime updates from the
>>>writes.  Suppressing them doesn't actually make a lot of performance
>>>difference, but that is with writeback caching enabled.  I expect that with
>>>a writethrough cache these will really hurt.
>>
>>Perhaps.  By the way is there a way to disable update time modification
>>as well ?
> 
> 
> No, there is not.
> 
> 
>>It would make quite a good sense for partition used for
>>Database needs - you do not need last modification time in most cases.
> 
> 
> First up, one needs to remove the inode_update_time() call from
> generic_file_aio_write_nolock() and run the tests.  If this (and noatime)
> indeed makes a significant difference (probably on writethrough-caching
> disks) then yup, we should do something.
> 
> `nomtime' would be simple enough.  But another option would be to arrange
> for a/m/ctime dirtiness to not cause an inode writeout in fsync(). 
> Instead, only sync the a/m/ctime-dirty inodes via sync, umount and pdflush.
> 
> That way, the inodes get written every thirty seconds rather than once per
> second.
> 
> It's probably not standards-compliant, but shoot me.  Who cares if the
> mtimes come up 30 seconds out of date after a system crash?
> 
> `nomtime' would be simpler and safer to implement, but not as nice.
> 
> But we need those numbers first.  I'll take a look.
> 

Can they use fdatasync? Does it do the right thing on Linux?
