Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129812AbRBGUcO>; Wed, 7 Feb 2001 15:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130125AbRBGUcG>; Wed, 7 Feb 2001 15:32:06 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:65521 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129812AbRBGUb7>; Wed, 7 Feb 2001 15:31:59 -0500
Message-ID: <3A81B05F.D6390DC4@redhat.com>
Date: Wed, 07 Feb 2001 15:30:23 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: glouis@dynamicro.on.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-ac4 aic7xxx driver, heads-up re possible problem
In-Reply-To: <20010207152737Z129027-513+3874@vger.kernel.org>
Content-Type: multipart/mixed;
 boundary="------------F3B9707B025F1B28AE372D0F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F3B9707B025F1B28AE372D0F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

glouis@dynamicro.on.ca wrote:
> 
> Last night I installed 2.4.1-ac4 remotely on two machines that had been
> running -ac3.  Neither was essential to production so I rebooted
> remotely to try it.  One of them works fine.  The other hangs at boot
> with an interrupt synch problem (sorry, but I'm away from the office and
> have only sketchy secondhand info; will reproduce Friday and supply
> details if needed).  The contents of /proc/scsi/aic7xxx/0 follow for
> each (the machine that failed has been rebooted with -ac3).

> ===========================
> 2.4.1-ac4 fails to access disk, said to be an "interrupt synch
> problem," 2.4.1-ac3 running:
> 
> Adaptec AIC7xxx driver version: 5.2.1/5.2.0
> Compile Options:
>   TCQ Enabled By Default : Disabled
>   AIC7XXX_PROC_STATS     : Enabled
> 
> Adapter Configuration:
>            SCSI Adapter: Adaptec AHA-294X Ultra SCSI host adapter
>                            Ultra Wide Controller at PCI 0/11/0

There was a minor bug in the aic7xxx.seq script (actually, it was more like I
failed to take into account a limitation of the parsing program that parses
the binary sequencer code).  It resulting in invalid instructions getting
downloaded to every controller prior to a 7895.  The attached patch should
solve people's problems with this.  (Note, this patch wasn't made against a
full linux tree, so cd into driver/scsi and use patch -p1 in order to apply
it).


-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
--------------F3B9707B025F1B28AE372D0F
Content-Type: text/plain; charset=us-ascii;
 name="seq.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seq.diff"

diff -U 3 -rN scsi.save/aic7xxx/aic7xxx.seq scsi/aic7xxx/aic7xxx.seq
--- scsi.save/aic7xxx/aic7xxx.seq	Wed Feb  7 15:07:28 2001
+++ scsi/aic7xxx/aic7xxx.seq	Wed Feb  7 15:21:06 2001
@@ -531,7 +531,8 @@
 
 
 
-	} else {  /* NOT Ultra2 */
+	} /* NOT Ultra2 */
+ 	if ((p->features & AHC_ULTRA2) == 0) {
 
 
 
diff -U 3 -rN scsi.save/aic7xxx/aic7xxx_seq.c scsi/aic7xxx/aic7xxx_seq.c
--- scsi.save/aic7xxx/aic7xxx_seq.c	Wed Feb  7 15:07:28 2001
+++ scsi/aic7xxx/aic7xxx_seq.c	Wed Feb  7 15:21:06 2001
@@ -776,10 +776,10 @@
 	{ aic7xxx_patch0_func, 88, 1, 1 },
 	{ aic7xxx_patch7_func, 103, 1, 2 },
 	{ aic7xxx_patch0_func, 104, 2, 1 },
-	{ aic7xxx_patch7_func, 108, 84, 15 },
+	{ aic7xxx_patch7_func, 108, 84, 3 },
 	{ aic7xxx_patch9_func, 177, 1, 1 },
 	{ aic7xxx_patch9_func, 178, 4, 1 },
-	{ aic7xxx_patch0_func, 192, 72, 12 },
+	{ aic7xxx_patch10_func, 192, 72, 12 },
 	{ aic7xxx_patch1_func, 192, 1, 2 },
 	{ aic7xxx_patch0_func, 193, 2, 1 },
 	{ aic7xxx_patch1_func, 200, 1, 1 },

--------------F3B9707B025F1B28AE372D0F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
