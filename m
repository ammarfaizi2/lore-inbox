Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136523AbREIPDb>; Wed, 9 May 2001 11:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136525AbREIPDW>; Wed, 9 May 2001 11:03:22 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:53465 "EHLO
	supserv.support.redhat.com") by vger.kernel.org with ESMTP
	id <S136523AbREIPDK>; Wed, 9 May 2001 11:03:10 -0400
Message-ID: <3AF95BBE.8885B234@redhat.com>
Date: Wed, 09 May 2001 11:01:18 -0400
From: Jeremy Hogan <jhogan@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Wright <jwright@penguincomputing.com>
CC: redhat-devel-list@redhat.com, linux-kernel@vger.kernel.org,
        Mike Vaillancourt <mikev@redhat.com>,
        Philip Pokorny <ppokorny@penguincomputing.com>
Subject: Re: bug in redhat gcc 2.96
In-Reply-To: <Pine.LNX.4.33.0105081927320.1798-100000@foo.penguincomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is fixed in gcc-2.96-82 and higher, as per
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=37054. I've posted
gcc-2.96-84.src.rpm at your enterprise ftp folder.

--jeremy


Jim Wright wrote:
> 
> We believe we have found a bug in gcc.  We have been trying to track
> down why the .../drivers/scsi/sym53c8xx.c driver oopses with a divide
> by zero when initializing at line 5265, which reads:
> 
>         period = (4 * div_10M[0] + np->clock_khz - 1) / np->clock_khz;
> 
> We believe the bug is that gcc is generating incorrect code for this:
> 
>                 if      (f1 < 55000)            f1 =  40000;
>                 else                            f1 =  80000;
> 
> Here is the test code to demonstrate this:
> 
> % cat bug.c
> int main (int argc, char *argv[])
> {
>     unsigned f1;
> 
>     f1 = (unsigned)argc;
> 
>     if (f1 < 5) {
>         f1 = 4;
>     } else {
>         f1 = 8;
>     }
>     exit (f1);
> }
> 
> And here are commands to exhibit the problem.
> 
> % for i in 0 1 2 3 4 5 6 ; do ln bug.c bug$i.c ; done
> % for i in 0 1 2 3 4 5 6 ; do gcc -save-temps -O$i -o bug$i bug$i.c ; done
> % for i in 0 1 2 3 4 5 6 ; do ./bug$i 1 2 ; echo $? ; done
> % for i in 0 1 2 3 4 5 6 ; do ./bug$i 1 2 3 4 5 6 7 ; echo $? ; done
> 
> The level 0 optimization assembly code appears correct.  For level 1 and
> above, the compiler emits a long-subtract-with-borrow statement which
> leaves EAX either 0 filled or 1 filled, based on the carry flag.
> 
> As this is with Red Hat's version of gcc, I'm not sending
> this to the gcc folks.  RPMs of gcc with this problem
> include gcc-2.96-69 and gcc-2.96-81.  This has been logged
> as http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=39764.
> Any suggestions for a way to cope with this?  We have a
> customer who's system fails due to this.
> 
> --
> Jim Wright   Software Engineer   Penguin Computing
> jwright@penguincomputing.com   v:415-358-2609   f:415-358-2646
