Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUCaSGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUCaSGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:06:15 -0500
Received: from palrel10.hp.com ([156.153.255.245]:55983 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262272AbUCaSGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:06:07 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16491.2184.253165.545651@napali.hpl.hp.com>
Date: Wed, 31 Mar 2004 10:06:00 -0800
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: ulrich.windl@rz.uni-regensburg.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip 400000000062ada1, isr 0000020000000008
In-Reply-To: <200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
References: <406AE0D5.10359.1930261@localhost>
	<200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 31 Mar 2004 19:00:17 +0200, Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:

  Denis> kernel says that you have them too frequently, which probably
  Denis> impairs efficiency. It's a hint to programmer.

Close: the kernel limits the frequency of the printing to avoid
flooding the log files.  Even if you do get the faults frequently, it
won't print more than 5 warning messages every 5 seconds.  The
floating-point software-assist (fpswa) faults are harmless in the
sense that they don't affect correctness of the program, but if you do
get them _very_ frequently (which is quite rare), they could impair
performance.  FPSWA faults occur only for corner-cases of
floating-point arithmetic, such as operations on denormals or
non-finite numbers.  Many programs don't need denormal support at all
and for those, you can link the program with -ffast-math (GCC) or -ftz
(Intel compiler).  This will turn on "flush-to-zero" mode and avoid
any FPSWA-faults due to denormals (in x86-speak, this is equivalent to
the "flush-to-zero" mode that SSE offers).

If the messages appear with a frequency of less than 5 messages/5
seconds, then there is certainly no performance issue and you may want
to just turn off the messages.  This can be done via the prctl(2)
system-call or with the prctl command.  With the latter:

	prctl --fp-emul=silent

will fork a new shell and disable the printing of the FPSWA-messages
in the shell and all its children.  There is also "--unaligned=silent"
which will turn off a similar message for unaligned access emulation
done by the kernel.

	--david
