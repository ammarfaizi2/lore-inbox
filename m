Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130303AbRCESlm>; Mon, 5 Mar 2001 13:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbRCESlc>; Mon, 5 Mar 2001 13:41:32 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:47086 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S130303AbRCESl2>; Mon, 5 Mar 2001 13:41:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Fault Address from sigcontext for the various archs
From: Camm Maguire <camm@enhanced.com>
Date: 05 Mar 2001 13:41:14 -0500
In-Reply-To: "Cappellini, Tony"'s message of "Wed, 28 Feb 2001 14:08:52 -0700"
Message-ID: <54snksdpo5.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!  I'm trying to assist in porting gcl to the various Linux
archs, and the code as is needs the fault address from struct
sigcontext.  i386 and m68k work, with solutions shown below.  What
about the other archs?  Where can I find the fault address around this
struct?

Thanks!

=============================================================================
i386
=============================================================================
#define GET_FAULT_ADDR(sig,code,sv,a) \
    ((void *)(((struct sigcontext_struct *)(&code))->cr2))     
=============================================================================
m68k
=============================================================================
#define GET_FAULT_ADDR(sig,code,sv,a) \
    ({	\
		struct sigcontext *scp = (struct sigcontext *)(sv);\
		int format = (scp->sc_formatvec >> 12) & 0xf;\
		unsigned long *framedata = (unsigned long *)(scp + 1);\
		unsigned long ea;\
		if (format == 0xa || format == 0xb)\
			/* 68020/030 */\
			ea = framedata[2];\
		else if (format == 7)\
			/* 68040 */\
			ea = framedata[3];\
		else if (format == 4) {\
			/* 68060 */\
			ea = framedata[0];\
			if (framedata[1] & 0x08000000)\
				/* correct addr on misaligned access */\
				ea = (ea+4095)&(~4095);\
		}\
		ea;\
	})
=============================================================================

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
