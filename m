Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266770AbUHCUpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266770AbUHCUpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUHCUpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:45:05 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:7210 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266770AbUHCUo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:44:56 -0400
Date: Tue, 3 Aug 2004 22:46:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk-lkml@arm.linux.org.uk
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040803204616.GA20655@mars.ravnborg.org>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, rmk-lkml@arm.linux.org.uk
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040801023655.GN2334@holomorphy.com> <20040801010532.37966eda.akpm@osdl.org> <20040801123334.GR2334@holomorphy.com> <20040801211146.GA7954@mars.ravnborg.org> <20040801235729.GZ2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801235729.GZ2334@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 04:57:29PM -0700, William Lee Irwin III wrote:
Content-Description: brief message
> On Sun, Aug 01, 2004 at 11:11:46PM +0200, Sam Ravnborg wrote:
> > Took a look at this and atm compiling a sparc tool-chain to try it out.
> > What about moving the check added by rmk to kallsyms.c?
> > This would remove the extra pass on vmlinux which is for no use for
> > most people anyway. On the other hand an error could go unpassed
> > because we (for now) do not do the kallsyms stuff if not configured in.
> > We could make the kallsyms run independent on the configuration, but
> > only link in the symbols if required to do so.
> > This would also allow us to have architecture specific final-linking
> > rules in one place if sparc needs special rules.
> > Today kallsyms already knows about 'SDA_BASE*_' only valid for ppc.
> > wli - can you post the output of a failing sparc compile?
> 
> The only part that fails is the ldchk part (unique to -mm), which is
> just happening prematurely. Here's a log.
Thanks.

I have been looking into this - and got sidetracked by coding an Elf
parser to replace usage of nm & friends. I abandoned this idea
again - there was not much gain in the end.

For sparc the rule seems to be:
symbols starting with ___ are legal to be undefined, they will
be fixed up later.
Following the code in btfixupprep.c gave me an headace..
A few comments with sample output from objdump would have helped a lot.


For now I'm working with the idea to move generation of System.map to a
separate shell script 'scripts/mksystemmap'.
As a sideeffect let this script check for potential undefined symbols.
Either ignore ___* symbols always or make this a sparc special case.
Compared to rmk's original patch this would only execute the check once.

sparc can use the same script when generating the final image.

I did not use sed to make a nice output of undefined symbols to avoid
only seeing a bunch of empty lines as Dave Hansen reported in one case.

	Sam
	

First version of the (simple) script. 
Direct reference to nm only for testing purpose.
Too late so no patch..

#!/bin/sh -e
# From the vmlinux file create the System.map file
# System.map is used by various debugging tools to retreive the actual
# addresses of symbols in the kernel.
# The optional kallsyms file in /proc/kallsyms serve the same purpose
# While creating the System.map file as a sideeffect check for
# undefined symbols.
# At least one version of the ARM bin-utils did not error out on
# undefined symbols, so catch them here instead.
# Usage
# mksystemmap vmlinux System.map

# $(NM) produces the following output:
# f0081e80 T alloc_vfsmnt
# The second row specify the type f the symbol:
# A = Absolute
# B = Uninitialised data (.bss)
# C = Comon symbol
# D = Initialised data
# G = Initialised data for small objects
# I = Indirect reference to another symbol
# N = Debugging symbol
# R = Read only
# S = Uninitialised data for small objects
# T = Text code symbol
# U = Undefined symbol
# V = Weak symbol
# W = Weak symbol
# Corresponding small letters are local symbols

# For System.map filter away:
# a - local absolute symbols
# U - undefined global symbols
# w - local weak symbols

nm $1 | grep -v ' [aUw] ' > $2

# Any undefined symbols?
UNDEF=`nm -u $1 | grep -v ' ____'`

UNDEFCNT=`echo $UNDEF | wc -l`

if [ $UNDEFCNT ]; then
	echo $0: Found $UNDEFCNT undefined symbols:
	nm -u $1
	echo This may signal in error in bin-utils
	exit 1
fi
exit 0
