Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284935AbSABVue>; Wed, 2 Jan 2002 16:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284538AbSABVu0>; Wed, 2 Jan 2002 16:50:26 -0500
Received: from mail.webmaster.com ([216.152.64.131]:53662 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S284542AbSABVuK> convert rfc822-to-8bit; Wed, 2 Jan 2002 16:50:10 -0500
From: David Schwartz <davids@webmaster.com>
To: <malekith@pld.org.pl>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (995) - Registered Version
Date: Wed, 2 Jan 2002 13:49:56 -0800
In-Reply-To: <20020102162806.GA29399@ep09.kernel.pl>
Subject: Re: strange TCP stack behiviour with write()es in pieces
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020102214957.AAA29754@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Jan 2002 17:28:06 +0100, Michal Moskal wrote:

>So, it occurs in programs doing packet communication over TCP, when peer
>waits for a packet to send an answer. If they send data with two write()
>calls (for example to write packet header and packet data), the performance
>dramaticly decrases (down to exactly 100 (2.2.19)
>or 25 (2.4.[57]) packet exchanges per second on x86, from several thousands.
>100 seems to be related to HZ variable, see also AXP results, where HZ is 10
>times bigger).

	That's why you should never, ever do anything that stupid. What should the 
kernel do? When it sees the first write, it has no idea there's going to be a 
second write, so it sends a packet. It gives you the benefit of the doubt and 
assumes that you know how to use TCP. When it sees the second write 
immediately thereafter and they're both small, it no longer trusts you and it 
has no idea there isn't going to be a third write a microsecond later, so it 
doesn't send a packet.

>I, personally, would expect the second version to be at most two times
>slower (as there might be need to send two IP packets instead of one).
>Also note, that as it is obvious that version with copying to buffer on the
>stack should be faster, it is not so obvious if there is need to malloc()
>buffer before sending (for example if there is no upper limit on len).
>However even if we need to malloc() buffer, second version is still by
>orders of magnitude faster.

	If you can design an algorithm that makes that only two times slower, then 
the world will be excited and interested and perhaps that algorithm will 
replace TCP. But until that time, we're stuck with what we have.

>I found it during work with client/server program that worked horribly slow
>just becouse of this. (of course I fixed it, but that's not the point).

	THAT IS THE POINT. The problem wasn't in the kernel, it was in the program, 
and you fixed it. If you do smart buffering, TCP can behave efficiently. If 
you don't, it has to guess when to send packets, and it can't possibly 
predict the future and behave in the way you think is optimum.

	How does it know you care about latency rather than throughput? And what 
should it do if it sees a steady stream of one byte writes, one every tenth 
of a second?

	DS


