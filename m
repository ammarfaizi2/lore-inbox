Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133022AbREIDFZ>; Tue, 8 May 2001 23:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132919AbREIDFO>; Tue, 8 May 2001 23:05:14 -0400
Received: from [63.143.102.194] ([63.143.102.194]:47350 "EHLO
	foo.penguincomputing.com") by vger.kernel.org with ESMTP
	id <S133022AbREIDFI>; Tue, 8 May 2001 23:05:08 -0400
Date: Tue, 8 May 2001 20:05:06 -0700 (PDT)
From: Jim Wright <jwright@penguincomputing.com>
Reply-To: Jim Wright <jwright@penguincomputing.com>
To: <redhat-devel-list@redhat.com>, <linux-kernel@vger.kernel.org>,
        Jeremy Hogan <jhogan@redhat.com>, Mike Vaillancourt <mikev@redhat.com>
cc: Jim Wright <jwright@penguincomputing.com>,
        Philip Pokorny <ppokorny@penguincomputing.com>
Subject: bug in redhat gcc 2.96
Message-ID: <Pine.LNX.4.33.0105081927320.1798-100000@foo.penguincomputing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We believe we have found a bug in gcc.  We have been trying to track
down why the .../drivers/scsi/sym53c8xx.c driver oopses with a divide
by zero when initializing at line 5265, which reads:

        period = (4 * div_10M[0] + np->clock_khz - 1) / np->clock_khz;

We believe the bug is that gcc is generating incorrect code for this:

                if      (f1 < 55000)            f1 =  40000;
		else                            f1 =  80000;

Here is the test code to demonstrate this:

% cat bug.c
int main (int argc, char *argv[])
{
    unsigned f1;

    f1 = (unsigned)argc;

    if (f1 < 5) {
	f1 = 4;
    } else {
	f1 = 8;
    }
    exit (f1);
}

And here are commands to exhibit the problem.

% for i in 0 1 2 3 4 5 6 ; do ln bug.c bug$i.c ; done
% for i in 0 1 2 3 4 5 6 ; do gcc -save-temps -O$i -o bug$i bug$i.c ; done
% for i in 0 1 2 3 4 5 6 ; do ./bug$i 1 2 ; echo $? ; done
% for i in 0 1 2 3 4 5 6 ; do ./bug$i 1 2 3 4 5 6 7 ; echo $? ; done

The level 0 optimization assembly code appears correct.  For level 1 and
above, the compiler emits a long-subtract-with-borrow statement which
leaves EAX either 0 filled or 1 filled, based on the carry flag.

As this is with Red Hat's version of gcc, I'm not sending
this to the gcc folks.  RPMs of gcc with this problem
include gcc-2.96-69 and gcc-2.96-81.  This has been logged
as http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=39764.
Any suggestions for a way to cope with this?  We have a
customer who's system fails due to this.


-- 
Jim Wright   Software Engineer   Penguin Computing
jwright@penguincomputing.com   v:415-358-2609   f:415-358-2646

