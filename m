Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTKKMoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 07:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTKKMoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 07:44:12 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:34804 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263487AbTKKMoF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 07:44:05 -0500
Message-ID: <3FB0D98F.2050504@softhome.net>
Date: Tue, 11 Nov 2003 13:43:59 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <QDtX.2dq.15@gated-at.bofh.it> <QDtX.2dq.17@gated-at.bofh.it> <QDtX.2dq.19@gated-at.bofh.it> <QDtX.2dq.21@gated-at.bofh.it> <QDtX.2dq.23@gated-at.bofh.it> <QDtY.2dq.25@gated-at.bofh.it> <QDtX.2dq.13@gated-at.bofh.it> <QEg2.3zi.9@gated-at.bofh.it>
In-Reply-To: <QEg2.3zi.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> On Tue, Nov 11, 2003 at 10:51:10AM +0100, Ihar 'Philips' Filipau wrote:
> 
>>Florian Weimer wrote:
>>
>>>Andreas Dilger wrote:
>>>
>>>
>>>
>>>>>This is fast turning into a creeping horror of aggregation.  I defy 
>>>>>anybody
>>>>>to create an API to cover all the options mentioned so far and *not* 
>>>>>have it
>>>>>look like the process_clone horror we so roundly derided a few weeks ago.
>>>>
>>>>	int sys_copy(int fd_src, int fd_dst)
>>>
>>>
>>>Doesn't work.  You have to set the security attributes while you open
>>>fd_dst.
>>
>>  int new_fd = sys_copy( int src_fd );  /* cloned copy, out of any fs */
>>  fchmod( new_fd, XXX_WHAT_EVER );      /* do the job. */
>>  ...
>>  flink(new_fd, "/some/path/some/file/name"); /* commit to fs */
> 
> 
> The associate open file descriptor with a new path system
> call (flink here) has already been rejected for solid
> security reasons.
> 

   So it was my point - without flink() IMHO it makes no sense.

   Just try to imagine any application for sys_copy(char*,char*).
   None _I_ _can_ imagine.

   "int new_fd = sys_copy( old_fd );" make sense to me - but you need to 
have counter-part of it - "flink();" - to commit it to file system.

    You really do not need a copy of a file just for copy of a file.
    That's what hard link is for.

    My way vim/emacs can:

    fd = open("originalfile");
    new_fildes = copy(fd);
    close(fd);
     ... [do the editing] ...
    flink(new_fildes, "newfile"); /* if user decides to save this job */
    close(new_fildes);

    This make sense - and this is the way usually we do processing of 
information. Mimicing cp - is really bad example.

    I have re-read thread. I see flink() not as security hole - but they 
use should be managed in some way.

    Original thread about flink() - everthing doable.
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=20030406190025%241ec6%40gated-at.bofh.it&rnum=50&prev=/&frame=on
    And there was no real security issue given whatsoever.
    Only design considerations ;-)

> 
> So if you can do it with open file descriptors why do you
> need a new system call?
> 

   The point, that different fs's can optimize this as they wish.
   This would be really nice thing to have in our networked age.

   Sshing just to copy huge file - is little bit annoying ;-)

P.S. actually my mind keeps spining idea of cut()/paste(). So file 
descriptor without assoc. file path can be useful.
Say:

    -----------
    fd_part_1 = open("some file");
    seek(fd_part_1, 100, 0);
    fd_part_2 = cut( fd_part_1 );  /* XXX */
    /* here eof(fd_part_1) == 1 && "some file" is truncated to 100b. */

    flink(fd_part_2, "second part"); /* create file
                    with rest of "some file" */
    -----------
    fd_part_1 = open("some file");
    fd_part_2 = open("second part");
    paste(fd_part_1, fd_part_2);   /* XXX */
            /* fd_part_2 is auto close()d
               and "second part" file unlinked */
    close(fd_part_1);
    /* here "some file" will be the same as in the begining */
    -----------

    This should help video/audio editing much.

P.P.S. not relevant but in any way SUSv3 docs for fattach()
http://www.opengroup.org/onlinepubs/007904975/functions/fattach.html


-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

