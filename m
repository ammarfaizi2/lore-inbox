Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbQLJWOQ>; Sun, 10 Dec 2000 17:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbQLJWOH>; Sun, 10 Dec 2000 17:14:07 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:10696 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S135170AbQLJWNw>; Sun, 10 Dec 2000 17:13:52 -0500
Date: Sun, 10 Dec 2000 22:44:02 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 EXT2 corruption: mixing up file contents
Message-ID: <20001210224402.A913@iapetus.localdomain>
In-Reply-To: <20001210161723.A1060@iapetus.localdomain> <20001210183101.A6947@iapetus.localdomain> <20001210213500.A17413@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001210213500.A17413@iapetus.localdomain>; from F.vanMaarseveen@inter.NL.net on Sun, Dec 10, 2000 at 09:35:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After removing 128MB, leaving the original 64MB in the main board:

+ tar xzf /home/fvm/kernel/v2.4/linux-2.4.0-test10.tar.gz
+ bzcat /home/fvm/kernel/v2.4/patch-2.4.0-test11.bz2
+ patch -p0 -s
+ zcat /home/fvm/kernel/v2.4/test12-pre7.gz
+ patch -p0 -s
3 out of 3 hunks FAILED -- saving rejects to linux/arch/mips64/Makefile.rej
1 out of 1 hunk FAILED -- saving rejects to linux/arch/mips64/arc/Makefile.rej
1 out of 1 hunk FAILED -- saving rejects to linux/arch/mips64/arc/console.c.rej

-rw-r--r--   1 fvm      sec          4444 Aug 11 20:23 linux/arch/mips64/Makefile.orig
File contains C code (!!!), starts with:
	 Descr Read SM */
	#define CSR_DWRITE_RUN  (1L<<11)        /* Bit 11:      Rel. Descr Write SM */
	#define CSR_DWRITE_RST  (1L<<10)        /* Bit 10:      Reset Descr Write SM */
	#define CSR_TRANS_RUN   (1L<<9)         /* Bit  9:      Release Transfer SM */
	#define CSR_TRANS_RST   (1L<<8)         /* Bit  8:      Reset Transfer SM */
	#define CSR_ENA_POL     (1L<<7)         /* Bit  7:      Enable Descr Polling */
	#define CSR_DIS_POL     (1L<<6)         /* Bit  6:      Disable Descr Polling */
	#define CSR_STOP        (1L<<5)         /* Bit  5:      Stop Rx/Tx Queue */
	#define CSR_START       (1L<<4)         /* Bit  4:      Start Rx/Tx Queue */
	#define CSR_IRQ_CL_P    (1L<<3)         /* Bit  3: (Rx) Clear Parity IRQ */
	#define CSR_IRQ_CL_B    (1L<<2)         /* Bit  2:      Clear EOB IRQ */
	#define CSR_IRQ_CL_F    (1L<<1)         /* Bit  1:      Clear EOF IRQ */
	#define CSR_IRQ_CL_C    (1L<<0)         /* Bit  0:      Clear ERR IRQ */
Ends with (incomplete last line):
	/*      RB_TST1         8 bit   RAM Buffer Test Register 1 */
					/* Bit 7:       reserved */
	#define RB_WP_T_ON      (1<<6)  /* Bit 6:       Write Pointer Test On */
	#define RB_WP_T

-rw-r--r--   1 fvm      sec           320 May 13  2000 linux/arch/mips64/arc/Makefile.orig
Entire file is again C (incomplete last line):
	al Receive Buffer Address upper dword*/
		SK_U32  RxStat ;        /* Receive Frame Status Word */
		SK_U32  RxTiSt ;        /* Receive Timestamp provided by the XMAC */
	#ifndef SK_USE_REV_DESC 
		SK_U16  RxTcpSum1 ;     /* TCP Checksum 1 */
		SK_U16  RxTcpSum2 ;     /* TCP Checksum 2 */
		SK_U16  RxTcpSp1 ;      /* TCP Checksum Calculation Start Position


-rw-r--r--   1 fvm      sec           551 May 13  2000 linux/arch/mips64/arc/console.c.orig
Entire file:
	), XMA((Mac), (Reg+2)), (SK_U16)                        \
			 (((SK_U16)(pByte[2]) & 0x00ff)|                        \
			 (((SK_U16)(pByte[3]) << 8) & 0xff00)));                \
		SK_OUT16((IoC), XMA((Mac), (Reg+4)), (SK_U16)                   \
			 (((SK_U16)(pByte[4]) & 0x00ff)|                        \
			 (((SK_U16)(pByte[5]) << 8) & 0xff00)));                \
		SK_OUT16((IoC), XMA((Mac), (Reg+6)), (SK_U16)                   \
			 (((SK_U16)(pByte[6]) & 0x00ff)|                        \
			 (((SK_U16)(pByte[7]) << 8) & 0xff00)));                \
	}

	/*
	 * Different PHY Types
	 */
	#define SK_PHY_XMAC     0       /* integrated in Xmac II*/
	#define SK_PHY_BCOM     1       /* Broadcom BCM5400 */
	#define SK_PHY_LONE     2       /* Level

Rather unusual for a console driver ;-)

fsck didn't find anything.

I checked a test11 tree and it seems that only the contents of the three
files was messed up, not the mtime/length. I can't rule out a hardware
cause but this doesn't look like a typical hardware problem to me:
mixing up data of different files.

Maybe SMP related because hardware is a dual PIII-450.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
