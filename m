Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135364AbRAGWW5>; Sun, 7 Jan 2001 17:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135304AbRAGWWs>; Sun, 7 Jan 2001 17:22:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27155 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135658AbRAGWWd>; Sun, 7 Jan 2001 17:22:33 -0500
Message-ID: <3A58EC10.4C99F976@transmeta.com>
Date: Sun, 07 Jan 2001 14:22:08 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cyrix III boot fix and bug report
In-Reply-To: <E14FNek-0003Nt-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > (Could this code have been written by someone who was confused between
> > MSR 0x80000001 and CPUID 0x80000001?)
> 
> It looks like thats what happened. The docs say it has 3dnow and mmx but
> I think your diagnosis is correct

Especially since it's bit 31 in EDX.  I don't think Cyrixi uses MSRs in
the 0x8000xxxx range.  I bet this should have been CPUID.

I suspect that that whole code should look more like this.  The MSR
access shouldn't have any effect on the extended CPUID flags, so that
shouldn't need to be there at all, unless there are Cyrix III's out there
which fail to report it in CPUID.

	-hpa

	case 6: /* Cyrix III */
		rdmsr (0x1107, lo, hi);
		lo |= (1<<1 | 1<<7);    /* Report CX8 & enable PGE */
                wrmsr (0x1107, lo, hi);

		/* Update the feature flags to include just revealed ones */
		c->x86_capability[0] = cpuid_edx(1);

		get_model_name(c);
		display_cacheinfo(c);
                break;


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
