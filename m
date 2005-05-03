Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVECWNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVECWNH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVECWNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:13:07 -0400
Received: from web53808.mail.yahoo.com ([206.190.36.203]:36002 "HELO
	web53808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261852AbVECWMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:12:30 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=W/lvvOxrlSeh6TOBqlL3U6nl72FAciMEa7sbkynk2F91OsS7Cdp4lG7Fzc9YT6xNIS26WbmqgWfdjaASX7Yk4gjjADauTea+VnFqcUkde0g/P33yHQWzFUCHebnlA96uuE+n/vIL/pBI7yePawQ80J2s3UbMjwIoziNgrEcvThQ=  ;
Message-ID: <20050503221230.7112.qmail@web53808.mail.yahoo.com>
Date: Tue, 3 May 2005 15:12:30 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: Linux-tracecalls, a clarification
To: linux-kernel@vger.kernel.org
Cc: wa@almesberger.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner,
  Sorry for not responding to your excellent letter for so long.
Carl Spalletta


--- Werner Almesberger <wa@almesberger.net> wrote:

>> Subject: Re: Linux-tracecalls, a clarification

>>
http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?file=fs/jbd/transaction.c&func=do_get_write_access
>> should contain, among many others, this call chain:
>> 
>> fs/read_write.c:sys_read
>>   fs/read_write.c:vfs_read
>>     fs/ext3/file.c:ext3_file_operations.read =
>>     fs/read_write.c:do_sync_read
>>       fs/ext3/file.c:ext3_file_operations.aio_read =
>>       mm/filemap.c:generic_file_aio_read
>>         mm/filemap.c:__generic_file_aio_read
>>           include/linux/fs.h:do_generic_file_read
>>             mm/filemap.c:do_generic_mapping_read
>>               include/linux/fs.h:file_accessed
>>                 include/linux/fs.h:touch_atime
>>                   fs/inode.c:update_atime
>>                     include/linux/fs.h:mark_inode_dirty_sync
>>                       fs/fs-writeback.c:__mark_inode_dirty
>>                         fs/ext3/super.c:ext3_sops.dirty_inode =
>>                         fs/ext3/inode.c:ext3_dirty_inode
>>                           include/linux/ext3_jbd.h:ext3_journal_get_write_access
>>                             fs/jbd/transaction.c:journal_get_write_access
>>                               fs/jbd/transaction.c:do_get_write_access
>> 
>> Note the three functions pointers that were used in this ..


This would require taking a callback such as this from fs/fs-writeback.c, line 65:

    sb->s_op->dirty_inode(inode);

and finding what functions could be in sb->s_op->dirty_inode, then branching backwards at
that point instead of terminating the search, as linux-tracecalls does here:

    fs/ext3/inode.c::ext3_dirty_inode
    fs/ext3/inode.c::ext3_mark_inode_dirty
    fs/ext3/inode.c::ext3_reserve_inode_write
    include/linux/ext3_jbd.h::__ext3_journal_get_write_access
    fs/jbd/transaction.c::journal_get_write_access
    fs/jbd/transaction.c::do_get_write_access

Note that linux-tracecalls does find the callback function 'ext3_dirty_inode' but does not
trace beyond it.  On the other hand since it is neither syscall, trap or interrupt handler it
is obvious that it involves a callback of some kind.  Also note that the sequence of calls found
by linux-tracecalls differs slightly from what you have adduced and appears to be correct,
although the discrepancy may be due to the kernel version being 2.6.11.6 instead of 2.6.10.

Now, I am not really happy using cscope as the search tool since it doesn't find all callers
e.g. it sometimes gags on functions having parameters of the type ptr-to-function, but it is
the best I could find, and moreover with the 'cscope -l' flag it runs in a kind of server or
daemon mode which makes it possible to avoid spawning thousands of cscope processes to do the
tracing at each level of the call chain.

But if I were to do it in cscope, it would mean translating that one callback into some larger
number of identical calls at the same point, ie instead of 

    sb->s_op->dirty_inode(inode);

the sourcefile at that point would read:

    fsFWDSLASHext3FWDSLASHsuperDOT_CFILEext3_dirty_inode(inode);
    fsFWDSLASHjffs2FWDSLASHsuperDOT_CFILEjffs2_dirty_inode(inode);
    fsFWDSLASHjfsFWDSLASHsuperDOT_CFILEjfs_dirty_inode(inode);
    fsFWDSLASHreiserfsFWDSLASHsuperDOT_CFILEreiserfs_dirty_inode(inode);

or, without the mangling:

    ext3_dirty_inode(inode);
    jffs2_dirty_inode(inode);
    jfs_dirty_inode(inode);
    reiserfs_dirty_inode(inode);

Certainly this is ugly, but it would yield valid results.  I would have to either use some gcc
flag(s) that would enable me to find all function calls resulting from statements evaluating
to type-ptr-to-function(arglist), and then find all '.funcptr = somefunction;' initializers or
other assignments to type ptr-to-function that could affect the evaluation of the callback;
or I would have to find the callbacks lexically. Then I would have to determine at the top of
each call chain if the terminating function could indeed be invoked from a callback and branch
accordingly.

I consider the compiler based approach better and more accurate but right now I haven't a clue as
to which compiler flags could ultimately yield the desired info. Would you have any suggestions?

Moreover I am, as I said, unhappy with cscope and I am not sure just how much further I want
to develop linux-tracecalls based on cscope. Although it is excellent for most purposes, I
consider it's support uncertain and of uneven quality, it was never intended for this purpose,
and I am afraid of building my house on sand.

It would certainly be nice if cscope understood the scoping rules of 'C', as well as _all_
function declarations and would return only valid callers, not just all functions that call
a target of a given name as it presently does.  See also this discussion:

 
groups.google.com/groups?hl=en&lr=&ie=UTF-8&q=interesting+failures+of+cscope&meta=group%3Dlinux.kernel


>> Another thing that seems to be missing are macros. E.g. this query
>> 
>> http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?file=include/linux/seqlock.h&func=seqcount_init
>> 
>> should probably have found the reference in fs.h ..
>> Also, this query should have returned something:
>> 
>>
http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?file=include/linux/blkdev.h&func=blk_queue_plugged


The process used to create the cscope DBs is compiler based - it uses the output from
-fdump-translation-unit to mangle the special source files that are used to construct the cscope
databases.  Since macros can be recursive and terminate in actual function calls the sourcefiles
are expanded before the dumps are made.  At the present time that results in a tradeoff -
the hidden function calls are revealed but the macros are lost.  So the output, conceptually,
is something that could be and in almost all cases is identical to a kernel stack backtrace.

The only exceptions would be 'impossible' branches embedded in the kernel code (by design or
otherwise).

However it certainly _is_ desirable to be able to flag those macros. 


>> Since the call trees fan out very quickly (in either direction), I
>> think an interactive browser that lets you select which branch(es)
>> to follow (while remembering the chain you've already visited) would
>> be more useful than a huge dump that may require significant
>> post-processing.
>> 
>> It would also be nice to be able to go both ways, from called to
>> caller, and from caller to called. Again, the tricky bit here are
>> the function pointers.


This is a good idea.  Probably it can be done as an extension of 'cbrowser' although my own
experience of cbrowser combined w/ cscope kernel databases created with the 'q' flag - which
I use for speed - has not been promising, since cbrowser stalls for long periods of time.  Perhaps
by eliminating that flag the performance might be improved; alternatively cbrowser may not scale
well to large DBs at all.

The primary enhancement to cbrowser, resulting from your suggestion, would involve unmangling the
function names (at least partially) before presentation, for the sake of clarity. E.g. the stmt

    fsFWDSLASHext3FWDSLASHsuperDOT_CFILEext3_dirty_inode(inode);

would become

    fs/ext3/super.c::ext3_dirty_inode(inode);


Thanks again, Werner! I have both enjoyed and profited from your remarks.

