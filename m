Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVKVSBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVKVSBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVKVSBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:01:16 -0500
Received: from [67.137.28.188] ([67.137.28.188]:61320 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S965036AbVKVSBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:01:15 -0500
Message-ID: <43834906.5010504@wolfmountaingroup.com>
Date: Tue, 22 Nov 2005 09:36:22 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
       linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051122075148.GB20476@infradead.org> <20051122145047.GB29179@thunk.org> <20051122152531.GU12760@delft.aura.cs.cmu.edu> <20051122162836.GA31444@thunk.org> <20051122173723.GY12760@delft.aura.cs.cmu.edu>
In-Reply-To: <20051122173723.GY12760@delft.aura.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:

>On Tue, Nov 22, 2005 at 11:28:36AM -0500, Theodore Ts'o wrote:
>  
>
>>On Tue, Nov 22, 2005 at 10:25:31AM -0500, Jan Harkes wrote:
>>    
>>
>>>On Tue, Nov 22, 2005 at 09:50:47AM -0500, Theodore Ts'o wrote:
>>>      
>>>
>>>>I will note though that there are people who are asking for 64-bit
>>>>inode numbers on 32-bit platforms, since 2**32 inodes are not enough
>>>>for certain distributed/clustered filesystems.  And this is something
>>>>we don't yet support today, and probably will need to think about much
>>>>sooner than 128-bit filesystems....
>>>>        
>>>>
>>>As far as the kernel is concerned this hasn't been a problem in a while
>>>(2.4.early). The iget4 operation that was introduced by reiserfs (now
>>>iget5) pretty much makes it possible for a filesystem to use anything to
>>>identify it's inodes. The 32-bit inode numbers are simply used as a hash
>>>index.
>>>      
>>>
>>iget4 wasn't even strictly necessary, unless you want to use the inode
>>cache (which has always been strictly optional for filesystems, even
>>inode-based ones) --- Linux's VFS is dentry-based, not inode-based, so
>>we don't use inode numbers to index much of anything inside the
>>kernel, other than the aforementioned optional inode cache.
>>    
>>
>
>Ah yes, you're right.
>
>  
>
>>The main issue is the lack of a 64-bit interface to extract inode
>>numbers, which is needed as you point out for userspace archiving
>>tools like tar. There are also other programs or protocols that in the
>>past have broken as a result of inode number collisions.
>>    
>>
>
>64-bit? Coda has been using 128-bit file identifiers for a while now.
>And I can imagine someone trying to plug something like git into the VFS
>might want to use 168-bits. Or even more for a CAS-based storage that
>identifies objects by their SHA256 or SHA512 checksum.
>
>On the other hand, any large scale distributed/cluster based file system
>probably will have some sort of snapshot based backup strategy as part
>of the file system design. Using tar to back up a couple of tera/peta
>bytes just seems like asking for trouble, even keeping track of the
>possible hardlinks by remembering previously seen inode numbers over
>vast amounts of files will become difficult at some point.
>
>  
>
>>As another example, a quick google search indicates that the some mail
>>programs can use inode numbers as a part of a technique to create
>>unique filenames in maildir directories.  One could easily also
>>    
>>
>
>Hopefully it is only part of the technique. Like combining it with
>grabbing a timestamp, the hostname/MAC address where the operation
>occurred, etc.
>
>  
>
>>imagine using inode numbers as part of creating unique ids returned by
>>an IMAP server --- not something I would recommend, but it's an
>>example of what some people might have done, since everybody _knows_
>>they can count on inode numbers on Unix systems, right?  POSIX
>>promises that they won't break!
>>    
>>
>
>Under limited conditions. Not sure how stable/unique 32-bit inode
>numbers are on NFS clients, taking into account client-reboots, failing
>disks that are restored from tape, or when the file system reuses inode
>numbers of recently deleted files, etc. It doesn't matter how much
>stability and uniqueness POSIX demands, I simply can't see how it can be
>guaranteed in all cases.
>
>  
>
>>>The only thing that tends to break are userspace archiving tools like
>>>tar, which assume that 2 objects with the same 32-bit st_ino value are
>>>identical. I think that by now several actually double check that the
>>>inode linkcount is larger than 1.
>>>      
>>>
>>Um, that's not good enough to avoid failure modes; consider what might
>>happen if you have two inodes that have hardlinks, so that st_nlink >
>>1, but whose inode numbers are the same if you only look at the low 32
>>bits?  Oops.
>>
>>It's not a bad hueristic, if you don't have that many hard-linked
>>files on your system, but if you have a huge number of hard-linked
>>trees (such as you might find on a kernel developer with tons of
>>hard-linked trees), I wouldn't want to count on this always working.
>>    
>>
>
>Yeah, bad example for the typical case. But there must be some check to
>at least avoid problems when files are removed/created and the inode
>numbers are reused during a backup run.
>
>Jan
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Someone needs to fix the mmap problems with some clever translation for 
supporting huge files and filesystems
beyond 16 TB. Increasing block sizes will help (increase to 64K in the 
buffer cache). I have a lot of input here
ajnd I am supporting huge data storage volumes at present with 32 bit 
version, but I have had to insert my own
64K managements layer to interface with the VFS and I have had to also 
put some restrictions on file sizes. Packet
capture based FS's can generate more data than any of these traditional 
FS's do.

Jeff
