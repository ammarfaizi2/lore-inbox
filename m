Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946407AbWJ0Lav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946407AbWJ0Lav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946415AbWJ0Lav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:30:51 -0400
Received: from science.horizon.com ([192.35.100.1]:50239 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1946407AbWJ0Lau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:30:50 -0400
Date: 27 Oct 2006 07:30:49 -0400
Message-ID: <20061027113049.7236.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, zippel@linux-m68k.org
Subject: Re: 2.6.19-rc2 and very unstable NTP
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610271250490.6761@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To analyze the kernel behaviour I would at least need the information fed 
> to the kernel, e.g. by tracing the ntp daemon via "TZ=utc strace -f -tt 
> -e trace=adjtimex -o ntpd.trace ..." and the ntp peer logs of same time 
> period. Kernel boot messages and config might help as well.

Actually, I just found it!  It's kind of a combination bug.

I had hacked NTP_MINPOLL to 2 in the ntpd source, and was using that
value on the pps source.  But ntpd would copy that value, minus 4,
into ntv.constant (and set ADJ_TIMECONST), and adjtimex() would complain
and return EINVAL.

It wouldn't accept the passed-in values, but would still fill in the
structure with the current values.

But ntpd didn't notice or log this error, and would log the *returned*
consstant.  Which was oddly dissociated from the expected one.

The failure to check the return code is an ntpd bug.


Now, in the kernel, I wonder what the allowed range should properly be.

I notice that on the input side, you have
	time_constant = min(txc->constant + 4, (long)MAXTC);
but on the output side, it's
	txc->constant      = time_constant;

This is clearly inconsistent and wrong, but which side should be fixed
is an interesting question I haven't got an answer to yet.

For now, I've just hacked the kernel to allow values of time_constant
down to 0 (txc->constant >= -4), as nothing will break with that
value.  (The only complicated one is ntp.c:296, and SHIFT_PLL is 4,
while SHIFT_NSEC is 12, so it all works.)

(Also, is MAXTC high enough for ntpv4?  I think it's in "-4" space,
so it should be time_constant = min(txc->constant, (long)MAXTC) + 4;)


That was an interesting piece of debugging... I was all over the map
before finding it.  And your suggestion of "strace -e adjtimex" was
indeed exactly what found it in the end.

So thanks!
