Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310787AbSCSXjF>; Tue, 19 Mar 2002 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSCSXi6>; Tue, 19 Mar 2002 18:38:58 -0500
Received: from rover.mkp.net ([209.217.122.9]:24335 "EHLO rover")
	by vger.kernel.org with ESMTP id <S310783AbSCSXir>;
	Tue, 19 Mar 2002 18:38:47 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@zip.com.au>, Joel Becker <jlbec@evilplan.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au>
	<3C945D7D.8040703@mandrakesoft.com>
	<5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
	<20020318080531.W4836@parcelfarce.linux.theplanet.co.uk>
	<3C95A1DB.CA13A822@zip.com.au> <yq1bsdmq6so.fsf@austin.mkp.net>
	<3C963CD5.8E371FF@zip.com.au> <yq17ko9r7bc.fsf@austin.mkp.net>
	<m1it7swca7.fsf@frodo.biederman.org>
Date: 19 Mar 2002 18:38:31 -0500
Message-ID: <yq1wuw8nn60.fsf@austin.mkp.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Eric" == Eric W Biederman <ebiederm@xmission.com> writes:

>> In the end, cloning the kiobuf from the above and adjusting
>> offset/length in the children turned out to be the best approach.

Eric> Unless I am mistaken this interacts very badly with the writing
Eric> data out to disk to free up memory, because you must allocate
Eric> memory to split the bio.  Which is the last place you want to
Eric> allocate memory if you can avoid it.

Well.  We have several places in the I/O path already where we need to
allocate memory in order to fulfill an I/O.  

Think RAID1 where you need to turn one request from the filesystem
into several - one for each mirror.  Or RAID5 where a write may cause
several reads/writes so you can mask and write the checksum out.

Also, with journaling filesystems you may very well be in a situation
where pushing a file to disk involves writing transactions to the log
before you can actually free up buffers.

In this case the clones come from the bio slab cache and are thus no
different from any other I/Os.  Furthermore, the clones share the bulk
of their data with the parent, so the overhead isn't that big.

-- 
Martin K. Petersen, Principal Linux Consultant, Linuxcare, Inc.
mkp@linuxcare.com, http://www.linuxcare.com/
SGI XFS for Linux Developer, http://oss.sgi.com/projects/xfs/

