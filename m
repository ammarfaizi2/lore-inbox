Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281248AbRKTSsd>; Tue, 20 Nov 2001 13:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280967AbRKTSsQ>; Tue, 20 Nov 2001 13:48:16 -0500
Received: from t2.redhat.com ([199.183.24.243]:10486 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S281248AbRKTSsD>;
	Tue, 20 Nov 2001 13:48:03 -0500
Date: Tue, 20 Nov 2001 10:47:48 -0800
From: Richard Henderson <rth@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: [alpha] cleanup opDEC workaround
Message-ID: <20011120104748.B16422@redhat.com>
In-Reply-To: <20011119232355.C16091@redhat.com> <20011120133150.A9033@jurassic.park.msu.ru> <20011120090818.A16366@redhat.com> <20011120205105.A15395@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120205105.A15395@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, Nov 20, 2001 at 08:51:05PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 08:51:05PM +0300, Ivan Kokshaysky wrote:
> Ok, but with opDEC_fix = 8 we actually skip to addt/stt, so that asm
> probably should be rearranged to ...

No, read the comment and think about it some more.

 		"fmov $f31, $f0\n\t"
 		"cvttq/svm $f31, $f31\n\t"
 		"cmpteq $f31, $f31, $f0\n\t"
 		"addt $f31, $f31, $f31\n\t"
 		"stt $f0, %0"

In the broken case, we'll enter entIF with pc==cvttq.  Add 8 gives
addt, subtract 4 gives cmpteq, which gives $f0 = 2.0.

In the working case, we'll enter entIF with pc==cmpteq.  Add 8 gives
stt, subtract 4 gives addt, which is engineered to be a noop.

> Further, if fp emulation isn't compiled in, we'll have kernel mode
> instruction fault. A quick fix appears to be

Hmm.  If fp emulation isn't compiled in, we shouldn't bother
testing this, I think.  Means you can't debug fp emulation via
modules on Multia, but I'm pretty sure I don't care.

I suppose the other alternative to get the testing code out of
the normal entIF is to create a custom entIF that is installed
only during opDEC testing.  Seems too much work...


r~
