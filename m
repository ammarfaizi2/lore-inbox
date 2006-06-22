Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWFVBEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWFVBEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWFVBEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:04:09 -0400
Received: from tbcorp.com ([130.94.185.195]:53511 "EHLO tbcorp.com")
	by vger.kernel.org with ESMTP id S1030477AbWFVBEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:04:07 -0400
From: "Thomas E. Besemer" <tbesemer@tbcorp.com>
To: <linux-kernel@vger.kernel.org>
Subject: ptrace() associated seg faults using GDB, PowerPC versus x86
Date: Wed, 21 Jun 2006 18:04:53 -0700
Message-ID: <INEDKMDHFAPNJHHJCFHOMEJFCIAA.tbesemer@tbcorp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C6955D.32212D10"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C6955D.32212D10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Using 2.6.16.20, on both x86 and PowerPC, I am finding that
GDB will cause a seg fault on PowerPC, but not x86, using
the same test fixture.

The problem is associated with calling a subroutine in a
stopped process.  The attached C file provides a very
reproducible fault:

 - In x86, I can attach to the running process, and call
   'runStub()' without problems.

 - In PowerPC, I can attach.  I call 'runStub()', but it
   does not return until the sleep() times out, and then
   there is a seg fault.

I do not believe this is a GDB issue; GDB was used to help
diagnose the original problem in my application - using
ptrace() to invoke subroutines on a stopped process.  I
was met with continued seg faults on PowerPC, but not in
x86 world.  I have spent a lot of time looking at this, and
am extremely comfortable that the problem lay in either the
ptrace() implementation, or possibly the signal handling
functions.  More likely ptrace().

I have looked at the ~arch specific routines for ptrace, and
signal handling.  I believe that these machine specific
files behave very differently, due to architecture specific
issues.

I am interested in finding a person who understands how
ptrace() works on the PowerPC, possibly the maintainer of
it, to do some back and forth to resolve/understand these
issues.  I will be happy to find/fix, with some guidance and
understanding.


------=_NextPart_000_0000_01C6955D.32212D10
Content-Type: application/octet-stream;
	name="t1.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="t1.c"

#include	<stdio.h>=0A=
#include	<stdlib.h>=0A=
=0A=
void runStdio()=0A=
    {=0A=
    char  inBuff[ 200 ];=0A=
    char  *tmpPtr;=0A=
=0A=
    for (;;)=0A=
        {=0A=
        tmpPtr =3D fgets (inBuff, 200, stdin );=0A=
        if (tmpPtr)=0A=
            printf ("string: %s", tmpPtr);=0A=
        else=0A=
            exit (1);=0A=
        }=0A=
=0A=
    }=0A=
=0A=
void runSleep()=0A=
    {=0A=
    int  timeLeft;=0A=
=0A=
    for (;;)=0A=
        {=0A=
	timeLeft =3D sleep(40);=0A=
        printf( "time left =3D=3D %d\n", timeLeft);=0A=
        }=0A=
    }=0A=
=0A=
void  runStub()=0A=
    {=0A=
    }=0A=
=0A=
void  runStubIo()=0A=
    {=0A=
    printf ("runStubIo(): called\n");=0A=
    }=0A=
=0A=
main()=0A=
    {=0A=
    int cpid;=0A=
=0A=
#ifdef	USE_FORK=0A=
    cpid =3D fork ();=0A=
    if (cpid)=0A=
        runSleep ();=0A=
    else=0A=
        runStdio ();=0A=
#else=0A=
    runSleep ();=0A=
#endif=0A=
=0A=
    }=0A=
=0A=

------=_NextPart_000_0000_01C6955D.32212D10--


