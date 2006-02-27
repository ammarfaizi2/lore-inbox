Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWB0Hio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWB0Hio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWB0Hio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:38:44 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:15567 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751637AbWB0Hin convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:38:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oUucZ5QBNdCC+6H/+EvkNoe2V3vu8CNLbB8J55zdvDxVF89Q1ySiMQKiIfSZDrtNHXcY8Tsl47gq9cTeoXtvY97+zHGA1fBS9QWHAIlYtb5l3O6KmpphO+Zc4OMoyGH1Wm+vqk7YSKdsdqDhfDOa50CvdOolETSpHwJ7J4bdCAI=
Message-ID: <4ae3c140602262338u2666319vc6401e32257b3543@mail.gmail.com>
Date: Mon, 27 Feb 2006 02:38:42 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Sam Vilain" <sam@vilain.net>
Subject: Re: question about possibility of data loss in Ext2/3 file system
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Arjan van de Ven" <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <44021D2D.20105@vilain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com>
	 <1140645651.2979.79.camel@laptopd505.fenrus.org>
	 <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>
	 <20060223045836.GC9645@thunk.org> <43FE1110.1030707@vilain.net>
	 <20060224162957.GA22097@thunk.org> <44021D2D.20105@vilain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for above responses.

Sounds like Ext3 uses journal to protect the data integrity. In data
journal mode, ext 3 writes data to journal first, marks start to
commit, then marks "done with commit" after data is flushed to disk. 
If power failure happen during data flush, the system will redo the
data writes next time system is back.

However, how to guarantee the integrity of journal? This solution
works based on an assumption that the journal data has been flushed to
disk before file data is flushed. Otherwise, consider this scenario:
process A wrote a data block to File F. Ext3 first writes this data
block into journal, put a "start to commit" notice, flags that journal
page as dirty. (note that the journal data is not flushed into disk
yet). Then ext3 starts to flag data page as dirty and wait for flush
daemon to write it to disk. Say just when the disk controller writes
2048 out of 4096 bytes into disk, power outage happens. At this time,
journal data has not been flushed into disk, so no enough information
to support redo. The file A will end up with some junk data. So
flushing journal data to disk before starting to write file data to
disk seems to be necessary. If so, how ext3 guarantees that? Is it
because the dirty pages are flushed in a first come first serve
fashion?

Another concern is that the journal data mode requires twice as much
as data to write, this could impact performance if disk bandwidth
usage is over 50%. For small files, it could be rare to use 50%. But
how about large files?  In a real world system,  what's the probablity
of using over 50% disk bandwidth?

I am sorry for ask for too high integrity on data. But I think ext3 is
a famous stable file system, it should have some good design to
protect data integrity.

Last question, does anyone know whether it is possible that ext3
creates some junk data or makes bitmap and inode inconsistent (under
any extreme condition) ?

Again, thanks for your help!

Xin

otherwise, the journal may not contain sufficient data to redo file
writes.  Am I missing some points?

On 2/26/06, Sam Vilain <sam@vilain.net> wrote:
> Theodore Ts'o wrote:
> >>I always liked Sun's approach to this in Online Disk Suite - journal at
> >>the block device level rather than the FS / application level.
> >>Something I haven't seen from the Linux md-utils or DM.
> > You can do data block journalling in ext3.  But the performance impact
> > can be significant for some work loads.   TNSFAAFL.
>
> Sure, but on a large system with a big array, you just move the journal
> to a seperate diskset.  That can make a big speed improvement for those
> types of update patterns where you care about always applying updates
> sequentially, such as a filesystem or a database.
>
> Sam.
>
