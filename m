Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVAGFCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVAGFCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 00:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVAGFCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 00:02:00 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:25187 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261242AbVAGFB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 00:01:56 -0500
Subject: minor nit with decoding popf instruction - was Re: ptrace
	single-stepping change breaks Wine
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Jesse Allen <the3dfxdude@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412311359460.2280@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <1104401393.5128.24.camel@gamecube.scs.ch>
	 <1104411980.3073.6.camel@littlegreen> <200412311413.16313.sailer@scs.ch>
	 <1104499860.3594.5.camel@littlegreen>
	 <53046857041231074248b111d5@mail.gmail.com>
	 <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com>
	 <Pine.LNX.4.58.0412311359460.2280@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1105073464.8135.17.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 Jan 2005 23:51:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-31 at 17:01, Linus Torvalds wrote:
> On Fri, 31 Dec 2004, Davide Libenzi wrote:
> > 
> > I don't think Linus ever posted a POPF-only patch. Try to comment those 
> > lines in his POPF patch ...
> 
> Here the two patches are independently, if people want to take a look.
> 
> If somebody wants to split (and test) the TF-careful thing further (the
> "send_sigtrap()" changes are independent, I think), that would be
> wonderful... Hint hint.
> 
> 		Linus

+static inline int is_at_popf(struct task_struct *child, struct pt_regs
*regs)
+{
+       int i, copied;
+       unsigned char opcode[16];
+       unsigned long addr = convert_eip_to_linear(child, regs);
+
+       copied = access_process_vm(child, addr, opcode, sizeof(opcode),
0);
+       for (i = 0; i < copied; i++) {
+               switch (opcode[i]) {
+               /* popf */
+               case 0x9d:
+                       return 1;
+               /* opcode and address size prefixes */
+               case 0x66: case 0x67:
+                       continue;
+               /* irrelevant prefixes (segment overrides and repeats)
*/
+               case 0x26: case 0x2e:
+               case 0x36: case 0x3e:
+               case 0x64: case 0x65:
+               case 0xf0: case 0xf2: case 0xf3:
+                       continue;
+
+               /*
+                * pushf: NOTE! We should probably not let
+                * the user see the TF bit being set. But
+                * it's more pain than it's worth to avoid
+                * it, and a debugger could emulate this
+                * all in user space if it _really_ cares.
+                */
+               case 0x9c:
+               default:
+                       return 0;
+               }
+       }
+       return 0;
+}

In order to avoid false positives, I think you should remove the line
case 0xf0: case 0xf2: case 0xf3:

0xf0 corresponds to the lock prefix which would trigger an invalid
opcode exception with a popf instruction.

0xf2 and 0xf3 correspond to the repeat prefixes and are also not valid
with popf


