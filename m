Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUCSUHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUCSUHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:07:07 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:56778 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261918AbUCSUHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:07:01 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Peter Zaitsev <peter@mysql.com>
To: reiser@namesys.com
Cc: Chris Mason <mason@suse.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <405B4BA3.2030205@namesys.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de> <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
	 <1079643740.11057.16.camel@watt.suse.com>
	 <1079644190.2450.405.camel@abyss.local>
	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com>
	 <1079704347.11057.130.camel@watt.suse.com>  <405B4BA3.2030205@namesys.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079726769.2446.233.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 19 Mar 2004 12:06:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 11:36, Hans Reiser wrote:

> mysql fsync()'s a file, which it thinks guarantees that all of a mysql 
> transaction has reached disk.  The disk write caches it.  You let fsync 
> return.  It is not on disk.  mysql performs its mysql commit, and writes 
> a mysql commit record which reaches disk, but not all of the transaction 
> is on disk.  The system crashes.  mysql plays the log.  mysql has 
> internal corruption.  User  calls Peter.  Peter asks, what do you expect 
> when you use a piece of shit like reiserfs?  User doesn't care about our 
> internal squabbling and goes back to using windows which does proper 
> commits.

This is right,

We had some unexplained data corruptions in Innodb which can be
explained by broken fsync(), but in the most cases the scenario is less
gloomy.  Users just do not see some of last committed transactions if
they test durability by shutting off the power, which is however already
not good enough for critical applications.

However this is due to external pre-caution Innodb does. It uses 
"double write buffer", which basically means each page is first written
to some small page based log file, and only afterwards written to the
proper place on the disk.   We have to do it even with proper fsync()
implementation as there is still possibility to crash in the middle of
fsync (or synchronous write) which will result in partial page write. 
Think for example about the case when page crosses stripe boundary on
RAID. 


If file system would guaranty atomicity of write() calls (synchronous
would be enough) we could disable it and get good extra performance.



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

