Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268837AbRH0UTU>; Mon, 27 Aug 2001 16:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRH0UTK>; Mon, 27 Aug 2001 16:19:10 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:19345 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S268792AbRH0UTB>; Mon, 27 Aug 2001 16:19:01 -0400
Message-ID: <3B8AAB3E.1EC121EA@pandora.be>
Date: Mon, 27 Aug 2001 22:19:10 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: DOS2linux
In-Reply-To: <E15bSeL-0004b3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Oh god, thats the deep magic EISA weirdness department

*gnarf* ;-)  Not good for a beginner like me I assume? :-(

> Well actually its one of those things that needs writing cleanly but
> currently appears in its own form in some EISA drivers

Hmm... with 'writing cleanly' you mean that there should become things
available like eisa_register_device() etc...?

> EISA slots are I/O mapped at 0x1000, 0x2000, 0x3000, 0x4000 -> 0x8000
> The ID port is at base+0xc80
> Configuration data follows at base+0xc84, 0xc88 ...

Yep, that was also what I figured out.

> I would assume the 320 byte buffer is providing this same data block, and
> maybe more but I don't know the details.

That is also what I think, but the problem is that I don't know at
which offset to look for that data...
If you look at the code:

static int getslotinfo( void )
{
  static char buff[320], *s=&buff[0]; int valid;

  inregs.h.ah=0xd8; inregs.h.al=0x1; inregs.h.cl=DiSC_Id.slot>>12;
inregs.h.ch=0;
  sregs.ds=FP_SEG(s); inregs.x.si=FP_OFF(s);
  int86x(0x15, &inregs, &outregs, &sregs);
  valid=outregs.h.ah;
  if(!valid) { DiSC_Id.it=buff[itconf]; DiSC_Id.dma=buff[dmachd]; }
  return(valid);
}

Would it help if i told you that itconf and dmachd are defined as (see
http://mc303.ulyssis.org/heim/downloads/DISCINC.H )

#define itconf                0xb2
#define dmachd                0xc0

So if my EISA board is at 0x1000, i should be able to read these
values from 0x1000+0xb2 and 0x1000+0xc0 ???  And if 'yes', any idea
about how to read them? (byte, word, long...? My guess would be as a
byte, but I'm not sure...)

> I thought EISA boards had gone away

Unfortunately... the device I am trying to write a driver for is
especially designed for our university.  Not many of those boards
exist in the world I guess :-(
(I hope that last sentence didn't take away your interest in my
project ;-)

Greetzzz,
mc303

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
