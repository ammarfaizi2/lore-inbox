Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVAQJaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVAQJaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVAQJaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:30:08 -0500
Received: from astro.systems.pipex.net ([62.241.163.6]:65430 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262741AbVAQJ33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:29:29 -0500
Date: Mon, 17 Jan 2005 09:30:17 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: "H. Peter Anvin" <hpa@zytor.com>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
In-Reply-To: <cs9v6f$3tj$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
 <20050114205651.GE17263@kam.mff.cuni.cz> <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
 <cs9v6f$3tj$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2005, H. Peter Anvin wrote:
> It depends on the architecture ABI.  This is the case for the i386
> ABI, but definitely *NOT* for x86-64.

<begin stuff superseded by later findings, but left here to clarify the 
train of thoughts>
Yes, precisely. The ABI/x86_64 defines this behaviour explicitly. However, 
that would mean the ABI was designed without giving thought to debugging 
via kdb.

When I said "2-3 weeks of work" I didn't fully realize the complexity of 
the problem. It is actually more like several months of research work and 
then (most likely) coming to the conclusion that the code to simulate the 
cpu (by disassembling the functions to track down where those registers 
went in each function) is just too complex to be written.

So, this means there is no way for kdb on x86_64 to show the parameter 
values for each function in the back trace. Any chance of changing the 
ABI/x86_64 to do the right (i.e. passing via stack like on i386) thing 
now? Then kdb would automatically support it via normal ar-handling code.

Also, we should NOT claim that Linux has been ported to x86_64 
architecture yet, because the port is not clean, i.e. doesn't allow 
breaking ABI like it allows on i386, by means of CONFIG_REGPARM 
optimization. Anyone working on fixing this?

I cc'd Linus as I cannot believe he agreed with allowing such an 
optimization to be a default and standard thing accepted by the Linux 
kernel. (But I may be wrong, especially since Linus isn't particularly 
fond of kdb anyway :)
<end of stuff declared as superceded>

Actually, having cc'd Linus made me think very _carefully_ about what I 
say and I went and checked how the userspace does it, as I couldn't 
believe that such fine piece of software as gdb would be broken as well. 
And to my surprize I discovered that gdb (when a program is compiled with 
-g) works fine! I.e. it shows the function arguments correctly. And 
disassembling the functions shows that although the arguments are passed 
via registers (as ABI demands) they are also saved somewhere on the stack. 
Hmmm, interesting, then -g compiled Linux kernel should also be useable, 
with perhaps some tweaks to kdb to decode these frames correctly, right?

I just want someone who knows the answer to confirm the last statement and 
so then I can go ahead and (try to) implement the solution by mimicking 
gdb behaviour (or help Jack Vogel implement it if he prefers doing it 
himself as defacto kdb/x86_64 maintainer)

Kind regards
Tigran
