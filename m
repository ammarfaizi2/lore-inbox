Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130849AbQLEWbQ>; Tue, 5 Dec 2000 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130847AbQLEWbK>; Tue, 5 Dec 2000 17:31:10 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:63249 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130803AbQLEWa7>; Tue, 5 Dec 2000 17:30:59 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Roberto Ragusa <robertoragusa@technologist.com>
Date: Wed, 6 Dec 2000 09:00:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14893.25967.936504.881427@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic in SoftwareRAID autodetection
In-Reply-To: message from Roberto Ragusa on Monday December 4
In-Reply-To: <14888.93.991512.725794@notabene.cse.unsw.edu.au>
	<yam8373.2691.155547848@a4000>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday December 4, robertoragusa@technologist.com wrote:
> On 01-Dec-00, Neil Brown wrote:
> > On Friday December 1, robertoragusa@technologist.com wrote:
> >> I found a real showstopper problem in the SoftwareRAID autodetect
> >> code; 2.4.0-test10 and 2.4.0-test11 are affected (I didn't test
> >> previous versions).
> [detailed report]
> > 
> > Fixed in 2.4.0-test12pre3.  
> 
> I tried 2.4.0-test12pre3.
> The problem is *not* fixed: kernel panic again.

My apologies.  There was a "oops in SoftwareRAID autodetect" in test10
and test11 that was fixed in test12pre3, and I just assumed that your's
was the same, and didn't look at it properly.

On looking again, your problem is definately different and quite
weird.

The fact that it works fine with "console=ttyS0" but doesn't without
is very suspicious.  It suggests to me that there is some odd
interaction going on, and that the problem may well have nothing
directly to do with RAID.

I will try to reproduce it myself, but I suspect that there is at
least an even chance that I won't be able to.  If small changes like
"console=ttyS0"  make it go away then some other small difference in
my setup could equally change the result.

The code which was Oopsing was in kfree, and this seems to compile
very differently for SMP than for UP.  I think that you were compiling
for UP - is that correct?  Could you try compiling with SMP support
and see if that makes a difference?

...... however, I went back and poured over the code for a little
while, and I think I found something.  linear.c may over-run a
kmalloced buffer, which could product exactly what you are getting.
The following patch isn't *correct*, but if it makes a difference for
you, then it means that we have found the problem.. please let me
know.


--- drivers/md/linear.c	2000/12/03 22:14:54	1.3
+++ drivers/md/linear.c	2000/12/05 21:57:42
@@ -98,7 +98,7 @@
 			table++;
 		}
 	}
-	table->dev1 = NULL;
+/*	table->dev1 = NULL; */
 
 	return 0;
 

> 
> Please CC to me because I'm not a LKML subscriber.

Ofcourse.  I think it is common courtesy to reply to the author, and
cc to the list if appropriate.
I would prefer it if, when replying to me, you send the reply
explicitly to me as well as to the list, as that way I get to see it
sooner (I only read mail to linux-kernel every few days, whereas mail
explicitly addressed to me get a much higher priority).

NeilBrown

> 
> -- 
>         Roberto Ragusa   robertoragusa at technologist.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
