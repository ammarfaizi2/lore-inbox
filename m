Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272050AbRHVRVN>; Wed, 22 Aug 2001 13:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272049AbRHVRVE>; Wed, 22 Aug 2001 13:21:04 -0400
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:50802 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S272051AbRHVRUt>; Wed, 22 Aug 2001 13:20:49 -0400
Message-ID: <3B83E9FD.6020801@humboldt.co.uk>
Date: Wed, 22 Aug 2001 18:21:01 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Filling holes in ext2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at generic_file_write() a lot recently, and I'm a 
little bothered by this section, as mangled here by Mozilla:

status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
if (status)
	goto unlock;
status = __copy_from_user(kaddr+offset, buf, bytes);
flush_dcache_page(page);
if (status)
	goto fail_write;
status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);

If the __copy_from_user() does fail when writing to a hole or extending 
a file on ext2, disk blocks get added to the file, but are never 
cleared. The result is that data from a free block appears in the file.

I've not managed to trigger this in a real system, but I have explored 
the failure path by running UML under gdb. I filled the filesystem with 
data as root (yes > /mnt/test), deleted the files, then triggered this 
path on an application running as a normal user. The result was that 
root's old data appeared in the user file.

So:
Can this really happen on the mainstream kernel? (The kernel I tested on 
  was 2.4.7 with the corresponding UML patch.)

Can this actually be exploited?  I assume the test on __copy_from_user() 
is there in case another thread changes memory mappings while 
generic_file_write() is running. My attempts to do this haven't yet 
succeeded.

If this can happen, does it matter? Should ext2 have an abort_write() 
operation like ext3() has?

-- 
Adrian Cox   http://www.humboldt.co.uk/

