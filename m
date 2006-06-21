Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWFUJk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWFUJk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWFUJk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:40:27 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:9766 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751335AbWFUJk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:40:26 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Jan Glauber <jan.glauber@de.ibm.com>
To: schwidefsky@de.ibm.com
Cc: Mike Grundy <grundym@us.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
In-Reply-To: <1150141217.5495.72.camel@localhost>
References: <20060612131552.GA6647@localhost.localdomain>
	 <1150141217.5495.72.camel@localhost>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:40:32 +0200
Message-Id: <1150882832.6219.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 21:40 +0200, Martin Schwidefsky wrote:
> On Mon, 2006-06-12 at 09:15 -0400, Mike Grundy wrote:
> > +/* get_instruction type will return 0 if only the regular offset adjustments
> > + * after out of line singlestep are required. If a register needs to be fixed,
> > + * bits 16-23 will contain the register number, bits 24-31 contain the length
> > + * of the instruction unit. If fixup is only required when the branch is not
> > + * taken, bits 0-16 will all be set.
> > + */
> > +int __kprobes get_instruction_type(kprobe_opcode_t * instruction)
> > +{
> > +	__u8 opcode[6];
> > +	int ret = 0;
> > +
> > +	memcpy(opcode, instruction, 6 * sizeof(__u8));
> 
> Again that memcpy. Why don't you just cast the instruction pointer to
> __u8 and __u16 and deference it? 
> 
> The following switch deals with all the instructions that need special
> handling. Please get rid of the BALR/BASR/BCR/BCTR/... defines and use
> the opcode number directly. Add a comment which instruction it is like
> in the new is_prohibited_opcode. All these defines are only used in
> get_instruction_type and the opcodes will certainly not change, only new
> ones will get added. No point in all those #defines.
> 
> > +
> > +	switch (opcode[0]) {
> > +		/* RR Format - instruction unit length = 2
> > +		 *  ________ ____ ____
> > +		 * |Op Code | R1 | R2 |
> > +		 * |________|_M1_|____|
> > +		 * 0         8   12  15
> > +		 */
> > +	case BALR:	/* PSW addr saved in R1, branch address in R2 */
> > +		ret = (opcode[1] & 0xf0) + 2;
> > +		/* Special non branching use of BALR */
> > +		if ((opcode[1] & 0x0f) == 0)
> > +			ret &= FIXUP_NOBRANCH;
> > +		break;
> 
> ((opcode[1] & 0xf0) + 2) & FIXUP_NOBRANCH is always 0. If the target
> register is 0 no branch takes place but R1 still needs fixup.
> resume_execution will just fixup the psw address in that case. I think
> you meant "ret |= FIXUP_NOBRANCH".
> 
> 
> > +	case BASR:	/* PSW addr saved in R1, branch address in R2 */
> > +		ret = (opcode[1] & 0xf0) + 2;
> > +		/* Special non branching use of BASR */
> > +		if ((opcode[1] & 0x0f) == 0)
> > +			ret &= FIXUP_NOBRANCH;
> > +		break;
> 
> Same here..
> 
> > +	case BCR:	/* M1 is mask val (condition), branch addr in R2 */
> > +		ret = FIXUP_NOBRANCH & 2;
> > +		break;
> 
> ..here..
> 
> > +	case BCTR:	/* R1 is count down, R2 is branch addr until R1 = 0 */
> > +		ret = FIXUP_NOBRANCH & 2;
> > +		break;
> 
> ..here..
> 
> > +		/* RX Format - instruction unit length = 4
> > +		 *  ________ ____ ____ ____ ____________
> > +		 * |Op Code | R1 | X2 | B2 |     D2     |
> > +		 * |________|_M1_|____|____|____________|
> > +		 * 0         8   12   16   20          31
> > +		 */
> > +	case BAL:	/* PSW addr saved in R1, branch addr D2(X2,B2) */
> > +		ret = (opcode[1] & 0xf0) + 4;
> > +		break;
> > +	case BAS:	/* PSW addr saved in R1, branch addr D2(X2,B2) */
> > +		ret = (opcode[1] & 0xf0) + 4;
> > +		break;
> > +	case BC:	/* M1 is mask val (condition), branch addr D2(X2,B2) */
> > +		ret = FIXUP_NOBRANCH & 4;
> > +		break;
> 
> ..here..
> 
> > +	case BCT:	/* R1 is count down, D2(X2,B2) is branch addr */
> > +		ret = FIXUP_NOBRANCH & 4;
> > +		break;
> 
> ..here..
> 
> > +		/* RI Format - instruction unit length = 4
> > +		 *  ________ ____ ____ _________________
> > +		 * |Op Code | R1 |OpCd|       I2        |
> > +		 * |________|____|____|_________________|
> > +		 * 0         8   12   16               31
> > +		 */
> > +	case 0xA7:	/* first byte (multiple ops have same 1st byte) */
> > +		if ((opcode[1] & 0x0f) == BRAS) {
> > +			ret = (opcode[1] & 0xf0) + 4;
> > +		}
> > +		break;
> > +		/* RS Format - instruction unit length = 4
> > +		 *  ________ ____ ____ ____ ____________
> > +		 * |Op Code | R1 | R3 | B2 |     D2     |
> > +		 * |________|____|_M3_|____|____________|
> > +		 * 0         8   12   16   20          31
> > +		 */
> > +	case BXH:
> > +		ret = FIXUP_NOBRANCH & 4;
> > +		break;
> 
> ..here..
> 
> > +	case BXLE:
> > +		ret = FIXUP_NOBRANCH & 4;
> > +		break;
> 
> ..here..
> 
> > +		/* RIL Format - instruction unit length = 6
> > +		 *  ________ ____ ____ _____________/______________
> > +		 * |Op Code | R1 |OpCd|            I2              |
> > +		 * |________|_M1_|____|_____________/______________|
> > +		 * 0         8   12   16                          47
> > +		 */
> > +	case 0xC0:
> > +		if ((opcode[1] & 0x0f) == BRASL) {
> > +			ret = (opcode[1] & 0xf0) + 6;
> > +		} else if ((opcode[1] & 0x0f) == BRCL) {
> > +			ret = FIXUP_NOBRANCH & 6;
> > +		}
> > +		break;
> 
> ..here..
> 
> > +		/* RSY Format - instruction unit length = 6
> > +		 *  ________ ____ ____ ____ __/__ ________ ________
> > +		 * |Op Code | R1 | R3 | B2 | DL2 |  DH2   |Op Code |
> > +		 * |________|____|_M3_|____|__/__|________|________|
> > +		 * 0         8   12   16   20    32       40      47
> > +		 */
> > +	case 0xEB:
> > +		if (opcode[5] == BXHG || opcode[5] == BXLEG) {
> > +			ret = FIXUP_NOBRANCH & 6;
> > +		}
> > +		break;
> 
> ..here..
> 
> > +		/* RXY Format - instruction unit length = 6
> > +		 *  ________ ____ ____ ____ __/__ ________ ________
> > +		 * |Op Code | R1 | X2 | B2 | DL2 |  DH2   |Op Code |
> > +		 * |________|____|____|____|__/__|________|________|
> > +		 * 0         8   12   16   20    32       40      47
> > +		 */
> > +	case 0xE3:
> > +		if (opcode[5] == BCTG) {
> > +			ret = FIXUP_NOBRANCH & 6;
> > +		}
> > +		break;
> 
> ..and here.
> 
> > +	default:
> > +		break;
> > +	}
> > +	return ret;
> > +}
> > +
> 
> There are some more instructions missing that need fixup:
> "brxh" 0x84??????, "brxle" 0x85??????, "brc" 0xa7?4????,
> "brct" 0xa7?6????, "brctg" 0xa7?7????, "bctgr" 0xb946????,
> "brxhg" 0xec????????44 and "brxlg" 0xec??????45.

We need to handle lpsw and larl too, since they change the instruction
pointer.

Jan

---
Jan Glauber
IBM Linux Technology Center
Linux on zSeries Development, Boeblingen

