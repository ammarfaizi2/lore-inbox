Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbSKUGrm>; Thu, 21 Nov 2002 01:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbSKUGrm>; Thu, 21 Nov 2002 01:47:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:65456 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266367AbSKUGrk>;
	Thu, 21 Nov 2002 01:47:40 -0500
Message-ID: <3DDC8330.FE066815@digeo.com>
Date: Wed, 20 Nov 2002 22:54:40 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Bill Davidsen <davidsen@tmr.com>, Aaron Lehmann <aaronl@vitelus.com>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com> <3DDC1480.402A0E5B@digeo.com> <20021121000811.GQ23425@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2002 06:54:40.0544 (UTC) FILETIME=[DD313A00:01C2912A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> On Wed, Nov 20, 2002 at 03:02:24PM -0800, Andrew Morton wrote:
> > signal_test 30000 122 122000.00 Signal Traps/second
> > signal_test 10000 91.7 91700.00 Signal Traps/second
> >     Signal delivery is a lot slower in 2.5.  I do not know why,
> 
> Similar things have been reported with 2.4.x vs. 2.2.x and IIRC there
> was some speculation they were due to low-level arch code interactions.
> I think this merits some investigation. I, for one, am a big user of
> SIGIO in userspace C programs...
> 

OK, got it back to 119000.  Each signal was calling copy_*_user 24 times.
This gets it down to six.


--- 25/arch/i386/kernel/i387.c~signal-speedup	Wed Nov 20 20:44:56 2002
+++ 25-akpm/arch/i386/kernel/i387.c	Wed Nov 20 21:06:04 2002
@@ -232,7 +232,7 @@ void set_fpu_mxcsr( struct task_struct *
  * FXSR floating point environment conversions.
  */
 
-static inline int convert_fxsr_to_user( struct _fpstate *buf,
+static int convert_fxsr_to_user( struct _fpstate *buf,
 					struct i387_fxsave_struct *fxsave )
 {
 	unsigned long env[7];
@@ -254,13 +254,18 @@ static inline int convert_fxsr_to_user( 
 	to = &buf->_st[0];
 	from = (struct _fpxreg *) &fxsave->st_space[0];
 	for ( i = 0 ; i < 8 ; i++, to++, from++ ) {
-		if ( __copy_to_user( to, from, sizeof(*to) ) )
+		unsigned long *t = (unsigned long *)to;
+		unsigned long *f = (unsigned long *)from;
+
+		if (__put_user(*f, t) ||
+				__put_user(*(f + 1), t + 1) ||
+				__put_user(from->exponent, &to->exponent))
 			return 1;
 	}
 	return 0;
 }
 
-static inline int convert_fxsr_from_user( struct i387_fxsave_struct *fxsave,
+static int convert_fxsr_from_user( struct i387_fxsave_struct *fxsave,
 					  struct _fpstate *buf )
 {
 	unsigned long env[7];
@@ -283,7 +288,12 @@ static inline int convert_fxsr_from_user
 	to = (struct _fpxreg *) &fxsave->st_space[0];
 	from = &buf->_st[0];
 	for ( i = 0 ; i < 8 ; i++, to++, from++ ) {
-		if ( __copy_from_user( to, from, sizeof(*from) ) )
+		unsigned long *t = (unsigned long *)to;
+		unsigned long *f = (unsigned long *)from;
+
+		if (__get_user(*f, t) ||
+				__get_user(*(f + 1), t + 1) ||
+				__get_user(from->exponent, &to->exponent))
 			return 1;
 	}
 	return 0;
@@ -305,7 +315,7 @@ static inline int save_i387_fsave( struc
 	return 1;
 }
 
-static inline int save_i387_fxsave( struct _fpstate *buf )
+static int save_i387_fxsave( struct _fpstate *buf )
 {
 	struct task_struct *tsk = current;
 	int err = 0;
@@ -355,7 +365,7 @@ static inline int restore_i387_fsave( st
 				 sizeof(struct i387_fsave_struct) );
 }
 
-static inline int restore_i387_fxsave( struct _fpstate *buf )
+static int restore_i387_fxsave( struct _fpstate *buf )
 {
 	int err;
 	struct task_struct *tsk = current;
@@ -373,7 +383,7 @@ int restore_i387( struct _fpstate *buf )
 
 	if ( HAVE_HWFP ) {
 		if ( cpu_has_fxsr ) {
-			err =  restore_i387_fxsave( buf );
+			err = restore_i387_fxsave( buf );
 		} else {
 			err = restore_i387_fsave( buf );
 		}

_
