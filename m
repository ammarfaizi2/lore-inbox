Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRACKFv>; Wed, 3 Jan 2001 05:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130427AbRACKFb>; Wed, 3 Jan 2001 05:05:31 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:19987 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130422AbRACKF2>; Wed, 3 Jan 2001 05:05:28 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "otto meier" <gf435@gmx.net>
Date: Wed, 3 Jan 2001 20:18:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14930.61022.834984.309906@notabene.cse.unsw.edu.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel freeze on 2.4.0.prerelease (smp,raid5)
In-Reply-To: message from Otto Meier on Tuesday January 2
In-Reply-To: <200101022018.f02KIVR00865@gate2.private.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 2, gf435@gmx.net wrote:
> 
> Perhaps a deadlock with a normal (not irq) spinlock.
> 
> Could you enable SysRQ and press <Alt>+<SysRq>+<P> ("showPc")
> Then write down the EIP values (including the [< >] brackets) and
> translate them with ksymoops.
> 
> Ksymoops repeats only the EIP values.
> 
> But searching through the System.map file has only Labels from
> the raid5 staff around.
> 
> As stated in my first mail I run actually my raid5 devices in degrated mode
> and as I remenber there has been some raid5 stuff changed between 
> test13p3 and newer kernels.

So tell us, why do you run your raid5 devices in degraded mode??  I
cannot be good for performance, and certainly isn't good for
redundancy!!!  But I'm not complaining as you found a bug...


> 
> Hope this gives someone an idea?

Yep.  This, combined with a related bug report from  n0ymv@callsign.net
strongly suggests the following patch.
Writes to the failed drive are never completing, so you eventually
run out of stripes in the stripe cache and you block waiting for a
stripe to become free.  

Please test this and confirm that it works.

NeilBrown


--- ./drivers/md/raid5.c	2001/01/03 09:04:05	1.1
+++ ./drivers/md/raid5.c	2001/01/03 09:04:13
@@ -1096,8 +1096,10 @@
 				bh->b_rdev = bh->b_dev;
 				bh->b_rsector = bh->b_blocknr * (bh->b_size>>9);
 				generic_make_request(action[i]-1, bh);
-			} else
+			} else {
 				PRINTK("skip op %d on disc %d for sector %ld\n", action[i]-1, i, sh->sector);
+				clear_bit(BH_Lock, &bh->b_state);
+			}
 		}
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
