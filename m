Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281768AbRKUMQr>; Wed, 21 Nov 2001 07:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281763AbRKUMQh>; Wed, 21 Nov 2001 07:16:37 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:12049 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S281758AbRKUMQZ>; Wed, 21 Nov 2001 07:16:25 -0500
Date: Wed, 21 Nov 2001 15:15:55 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@redhat.com>
Cc: Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: [alpha] cleanup opDEC workaround
Message-ID: <20011121151555.A20128@jurassic.park.msu.ru>
In-Reply-To: <20011119232355.C16091@redhat.com> <20011120133150.A9033@jurassic.park.msu.ru> <20011120090818.A16366@redhat.com> <20011120205105.A15395@jurassic.park.msu.ru> <20011120104748.B16422@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120104748.B16422@redhat.com>; from rth@redhat.com on Tue, Nov 20, 2001 at 10:47:48AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 10:47:48AM -0800, Richard Henderson wrote:
> In the working case, we'll enter entIF with pc==cmpteq.  Add 8 gives
> stt, subtract 4 gives addt, which is engineered to be a noop.

Argh. I was thinking too much about dummy_emul case and missed the fact
that instruction at pc-4 is actually executed in alpha_fp_emul()...

> Hmm.  If fp emulation isn't compiled in, we shouldn't bother
> testing this, I think.  Means you can't debug fp emulation via
> modules on Multia, but I'm pretty sure I don't care.

Yes, making opDEC_check stuff `#ifdef CONFIG_MATHEMU' would be
reasonable.

> I suppose the other alternative to get the testing code out of
> the normal entIF is to create a custom entIF that is installed
> only during opDEC testing.  Seems too much work...

Agreed. Alternatively, it's possible to hack dummy_emul(), which
doesn't affect the normal case.

static long dummy_emul(unsigned long pc)
{
	if (opDEC_fix != 8)
		return 0;
	/* Trap in opDEC_check() */
	if (*(u32 *)pc == 0x5bff141f)	/* addt $f31, $f31, $f31 */
		return 1;		/* SRM updates PC correctly */
	/* Broken SRM. "Emulate" cmpteq in opDEC_check() */
	__asm__ __volatile__("cmpteq $f31, $f31, $f0\n");
	return 1;
}

Ivan.
