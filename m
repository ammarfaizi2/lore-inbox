Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUHMSAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUHMSAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUHMSAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:00:40 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:43669 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266366AbUHMSAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:00:18 -0400
Date: Fri, 13 Aug 2004 20:02:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: __crc_* symbols in System.map
Message-ID: <20040813180239.GA7571@mars.ravnborg.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, torvalds@osdl.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040811205529.1ff86e9d.davem@redhat.com> <20040812050136.GA7246@mars.ravnborg.org> <20040812000558.220d7e5d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812000558.220d7e5d.davem@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 12:05:58AM -0700, David S. Miller wrote:
> On Thu, 12 Aug 2004 07:01:36 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > Would it be an option to skip all 'A' symbols?
> 
> I doubt it.  Symbols defined via the linker script will
> end up as " A ".  On sparc64 this happens for swapper_pmd_dir,
> empty_pg_dir, _etext, _edata, and _end for example.
Did a:
nm vmlinux | grep ' A ' | grep -v '__crc_' | wc -l
32

So yep.

Modified your patch to match my tree - patched soon to appear at lkml.

	Sam

In my tree I now have a script to generate System.map - that now looks like this:

#!/bin/sh -x
# Based on the vmlinux file create the System.map file
# System.map is used by module-init tools and some debugging
# tools to retreive the actual addresses of symbols in the kernel.
#
# Before creating the System.map file as a sideeffect check for
# undefined symbols.
# At least one version of the ARM bin-utils did not error out on
# undefined symbols, so catch them here instead.

# Usage
# mksysmap vmlinux System.map


#####
# Check for undefined symbols.
# Undefined symbols with three leading underscores are ignored since
# they are used by the sparc BTFIXUP logic - and is assumed to be undefined.


if [ "`$NM -u $1 | grep -v ' ___'`" != "" ]; then
	echo "$1: error: undefined symbol(s) found:"
	$NM -u $1 | grep -v ' ___'
	exit 1
fi

#####
# Generate System.map (actual filename passed as second argument)

# $NM produces the following output:
# f0081e80 T alloc_vfsmnt

#   The second row specify the type of the symbol:
#   A = Absolute
#   B = Uninitialised data (.bss)
#   C = Comon symbol
#   D = Initialised data
#   G = Initialised data for small objects
#   I = Indirect reference to another symbol
#   N = Debugging symbol
#   R = Read only
#   S = Uninitialised data for small objects
#   T = Text code symbol
#   U = Undefined symbol
#   V = Weak symbol
#   W = Weak symbol
#   Corresponding small letters are local symbols

# For System.map filter away:
#   a - local absolute symbols
#   U - undefined global symbols
#   w - local weak symbols

# readprofile starts reading symbols when _stext is found, and
# continue until it finds a symbol which is not either of 'T', 't',
# 'W' or 'w'. __crc_ are 'A' and placed in the middle
# so we just ignore them to let readprofile continue to work.
# (At least sparc64 has __crc_ in the middle).

$NM -n $1 | grep  '\( [aUw] \)\|\(__crc_\)' > $2



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
