Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWB1Q6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWB1Q6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWB1Q6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:58:05 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:12292 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751866AbWB1Q6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:58:02 -0500
Message-ID: <440480C7.50507@cfl.rr.com>
Date: Tue, 28 Feb 2006 11:56:39 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: Sam Vilain <sam@vilain.net>, "Theodore Ts'o" <tytso@mit.edu>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: question about possibility of data loss in Ext2/3 file system
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com>  <1140645651.2979.79.camel@laptopd505.fenrus.org>  <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>  <20060223045836.GC9645@thunk.org> <43FE1110.1030707@vilain.net>  <20060224162957 <4ae3c140602262338u2666319vc6401e32257b3543@mail.gmail.com>
In-Reply-To: <4ae3c140602262338u2666319vc6401e32257b3543@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2006 16:59:58.0834 (UTC) FILETIME=[6837BD20:01C63C88]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14295.000
X-TM-AS-Result: No--21.150000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:
> Many thanks for above responses.
> 
> Sounds like Ext3 uses journal to protect the data integrity. In data
> journal mode, ext 3 writes data to journal first, marks start to
> commit, then marks "done with commit" after data is flushed to disk. 
> If power failure happen during data flush, the system will redo the
> data writes next time system is back.
> 
> However, how to guarantee the integrity of journal? This solution
> works based on an assumption that the journal data has been flushed to
> disk before file data is flushed. Otherwise, consider this scenario:

The kernel flushes the writes to the journal before it starts writing to 
the main area of the disk, then marks the transaction as complete only 
after the actual updates have been flushed.

> process A wrote a data block to File F. Ext3 first writes this data
> block into journal, put a "start to commit" notice, flags that journal
> page as dirty. (note that the journal data is not flushed into disk
> yet). Then ext3 starts to flag data page as dirty and wait for flush
> daemon to write it to disk. Say just when the disk controller writes
> 2048 out of 4096 bytes into disk, power outage happens. At this time,
> journal data has not been flushed into disk, so no enough information
> to support redo. The file A will end up with some junk data. So
> flushing journal data to disk before starting to write file data to
> disk seems to be necessary. If so, how ext3 guarantees that? Is it
> because the dirty pages are flushed in a first come first serve
> fashion?
> 
> Another concern is that the journal data mode requires twice as much
> as data to write, this could impact performance if disk bandwidth
> usage is over 50%. For small files, it could be rare to use 50%. But
> how about large files?  In a real world system,  what's the probablity
> of using over 50% disk bandwidth?
> 

Depending on exactly what you are doing it will be anywhere from 0 to 
100%.  It entirely depends on the hardware you have and the tasks you 
are asking it to perform.  For most people though, the performance hit 
is too high, and it really doesn't 100% prevent data loss because 
programs writing to a file do not inform the kernel about when a 
transaction should start or stop, so it has to guess.

Programs that are mission critical will use their own mechanism to 
prevent corruption of their data files rather than rely on data 
journaling.  Usually this results in better safety and efficiency.

> I am sorry for ask for too high integrity on data. But I think ext3 is
> a famous stable file system, it should have some good design to
> protect data integrity.
> 

Which is why it does.

> Last question, does anyone know whether it is possible that ext3
> creates some junk data or makes bitmap and inode inconsistent (under
> any extreme condition) ?
> 

No.

> Again, thanks for your help!
> 
> Xin
> 

