Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbUCTTtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUCTTtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:49:14 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:51690 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S263517AbUCTTtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:49:12 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Peter Zaitsev <peter@mysql.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: reiser@namesys.com, Chris Mason <mason@suse.com>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040320102054.GB10398@mail.shareable.org>
References: <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
	 <1079643740.11057.16.camel@watt.suse.com>
	 <1079644190.2450.405.camel@abyss.local>
	 <1079644743.11055.26.camel@watt.suse.com> <405AA9D9.40109@namesys.com>
	 <1079704347.11057.130.camel@watt.suse.com> <405B4BA3.2030205@namesys.com>
	 <1079726769.2446.233.camel@abyss.local>
	 <20040320102054.GB10398@mail.shareable.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079812102.3182.31.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 20 Mar 2004 11:48:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 02:20, Jamie Lokier wrote:
> Peter Zaitsev wrote:
> > If file system would guaranty atomicity of write() calls (synchronous
> > would be enough) we could disable it and get good extra performance.
> 
> Store an MD5 or SHA digest of the page in the page itself, or elsewhere.
> (Obviously the digest doesn't include the bytes used to store it).
> 
> Then partial write errors are always detectable, even if there's a
> hardware failure, so journal writes are effectively atomic.

Jamie,

The problem is not detecting the partial page writes, but dealing with
them.   Obviously there is checksum on the page (it is however not
MD5/SHA which are designed for cryptographic needs) and so page
corruption is detected if it happens for whatever reason.

The problem is you can't do anything with the page if only unknown
portion of it was modified.   

Innodb uses sort of "logical" logging which   just says something like
delete row #2 from page #123, so if page is badly corrupted it will not
help to recover.

Of course you can log full pages, but this will increase overhead
significantly, especially for small  row sizes. 

This is why solution now is to use  long term "logical" log and short
term "physical" log, which is used by background page writer, before
writing pages to their original locations.


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

