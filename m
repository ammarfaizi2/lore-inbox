Return-Path: <linux-kernel-owner+w=401wt.eu-S965251AbXAKAh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbXAKAh3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbXAKAh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:37:29 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37388 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965251AbXAKAh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:37:28 -0500
From: Neil Brown <neilb@suse.de>
To: Sean Reifschneider <jafo@tummy.com>
Date: Thu, 11 Jan 2007 11:37:05 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17829.34481.340913.519675@notabene.brown>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: PATCH - x86-64 signed-compare bug, was Re: select() setting ERESTARTNOHAND (514).
In-Reply-To: message from Sean Reifschneider on Wednesday January 10
References: <20070110234238.GB10791@tummy.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 10, jafo@tummy.com wrote:
> 
> In looking at the Linux code for ERESTARTNOHAND, I see that
> include/linux/errno.h says this errno should never make it to the user.
> However, in this instance we ARE seeing it.  Looking around on google shows
> others are seeing it as well, though hits are few.
..
> 
> Thoughts?

Just a 'me too' at this point. 
The X server on my shiny new notebook (Core 2 Duo) occasionally dies
with 'select' repeatedly returning ERESTARTNOHAND.  It is most
annoying!

You don't mention in the Email which kernel version you use but I see
from the web page you reference it is 2.6.19.1.  I'm using
2.6.18.something.

I thought I'd have a quick look at the code, comparing i386 to x86-64
and guess what I found.....

On x86-64, regs->rax is "unsigned long", so the following is
needed....

I haven't tried it yet.

NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./arch/x86_64/kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/arch/x86_64/kernel/signal.c ./arch/x86_64/kernel/signal.c
--- .prev/arch/x86_64/kernel/signal.c	2007-01-11 11:33:27.000000000 +1100
+++ ./arch/x86_64/kernel/signal.c	2007-01-11 11:34:01.000000000 +1100
@@ -331,7 +331,7 @@ handle_signal(unsigned long sig, siginfo
 	/* Are we from a system call? */
 	if ((long)regs->orig_rax >= 0) {
 		/* If so, check system call restarting.. */
-		switch (regs->rax) {
+		switch ((long)regs->rax) {
 		        case -ERESTART_RESTARTBLOCK:
 			case -ERESTARTNOHAND:
 				regs->rax = -EINTR;
