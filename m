Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbRK0SlC>; Tue, 27 Nov 2001 13:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282492AbRK0Sks>; Tue, 27 Nov 2001 13:40:48 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:63983 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282470AbRK0Sko>;
	Tue, 27 Nov 2001 13:40:44 -0500
Date: Tue, 27 Nov 2001 11:38:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mathijs Mohlmann <mathijs@knoware.nl>,
        Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011127113830.E730@lynx.no>
Mail-Followup-To: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mathijs Mohlmann <mathijs@knoware.nl>, Jan Hudec <bulb@ucw.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E168SMG-0006k2-00@the-village.bc.nu> <01112716035401.00872@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <01112716035401.00872@manta>; from vda@port.imtp.ilyichevsk.odessa.ua on Tue, Nov 27, 2001 at 04:03:54PM -0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 27, 2001  16:03 -0200, vda wrote:
> On Monday 26 November 2001 18:28, Alan Cox wrote:
> > Nothing to do with me 8). I didnt write that bit of the i2o code. I agree
> > its both confusing and buggy. Send a fix ?
> 
> This is a test to be sure my replacement is equivalent:
> --------------------
> #include <stdio.h>
> #define MODINC(x,y) (x = x++ % y)
> #define MODULO_INC(x,y) ((x) = ((x)%(y))+1)

Ugh, clearly the code is broken, so we don't want equivalent code, but
correct code.  Use the unambiguous "MODINC(x,y) ((x) = ((x) + 1) % (y))"
form and not "have a bug that has properly defined behaviour under ANSI C".

Just looking at the code, it is fairly clear that the desire is to keep
q_in and q_out >= 0 and < I20_EVT_Q_LEN, which is the size of the event_q
array.  With the buggy version, it is possible that you could have q_in or
q_out == I2O_EVT_Q_LEN, which is overflowing the array.  Bad, bad, bad.

--- i2o_config.c.new	Mon Oct 22 13:39:56 2001
+++ i2o_config.c.orig	Tue Nov 27 16:03:19 2001
@@ -45,7 +45,7 @@
 static spinlock_t i2o_config_lock = SPIN_LOCK_UNLOCKED;
 struct wait_queue *i2o_wait_queue;

-#define MODINC(x,y) (x = x++ % y)
+#define MODINC(x,y) ((x) = ((x) + 1) % (y))

 struct i2o_cfg_info
 {

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

