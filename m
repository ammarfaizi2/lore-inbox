Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277068AbRKVK4b>; Thu, 22 Nov 2001 05:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRKVK4W>; Thu, 22 Nov 2001 05:56:22 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:35090 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S277068AbRKVK4K>; Thu, 22 Nov 2001 05:56:10 -0500
Date: Thu, 22 Nov 2001 13:55:50 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@redhat.com>
Cc: Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: [alpha] cleanup opDEC workaround
Message-ID: <20011122135550.A15090@jurassic.park.msu.ru>
In-Reply-To: <20011119232355.C16091@redhat.com> <20011120133150.A9033@jurassic.park.msu.ru> <20011120090818.A16366@redhat.com> <20011120205105.A15395@jurassic.park.msu.ru> <20011120104748.B16422@redhat.com> <20011121151555.A20128@jurassic.park.msu.ru> <20011121142753.A876@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011121142753.A876@redhat.com>; from rth@redhat.com on Wed, Nov 21, 2001 at 02:27:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 02:27:53PM -0800, Richard Henderson wrote:
> Actually, the custom entIF isn't that much work.  What about this?

Hmm, I like it.
However, if I didn't missed something again, some corrections are required.
First, in opDEC_check_entIF r16 should be stored on the stack frame
(PAL_rti will restore it). Also, if SRM is broken and doesn't update pc,
we'll jump back to cvttq/svm. So I think we need something like this:

opDEC_check_entIF:				\n\
	ldq $16,8($sp)				\n\
+	stq $16,24($sp)				\n\
+	addq $16,4,$16				\n\
+	stq $16,8($sp)				\n\
	call_pal 63	/* PAL_rti */		\n\

and

		"cvttq/svm $f31, $f31\n\t"
+		"nop\n\t"
		"subq $16, %0, %0"

No?

Ivan.
