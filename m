Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUMdA>; Tue, 21 Nov 2000 07:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbQKUMcu>; Tue, 21 Nov 2000 07:32:50 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:47112 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129793AbQKUMcm>; Tue, 21 Nov 2000 07:32:42 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14874.25691.629724.306563@wire.cadcamlab.org>
Date: Tue, 21 Nov 2000 06:02:35 -0600 (CST)
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: beware of dead string constants
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While trying to clean up some code recently (CONFIG_MCA, hi Jeff), I
discovered that gcc 2.95.2 (i386) does not remove dead string
constants:

  void foo (void)
  {
    if (0)
      printk(KERN_INFO "bar");
  }

Annoyingly, gcc forgets to drop the "<6>bar\0".  It shows up in the
object file, needlessly clogging your cachelines.

This has ramifications for anyone thinking of converting #ifdefs to
if(){}, which is supposed to be the way of the future.  In my situation
I am trying to convert '#ifdef CONFIG_MCA' to 'if (MCA_bus)' where
MCA_bus is #defined to 0 on most architectures.

'static' variables in block scope, same story.

This is mostly a heads-up to say that in this regard gcc is not ready
for prime time, so we really can't get away with using if() as an ifdef
yet, at least not without penalty.

I've just asked gcc-help@gcc.gnu.org about this; if I hear anything
interesting I'll report back.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
