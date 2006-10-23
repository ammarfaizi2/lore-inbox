Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWJWAbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWJWAbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 20:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWJWAbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 20:31:14 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:7580 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750967AbWJWAbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 20:31:13 -0400
Date: Sun, 22 Oct 2006 18:31:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061023003111.GD25210@parisc-linux.org>
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org> <20061020005337.GV29920@ftp.linux.org.uk> <20061019213545.bf5a51c1.rdunlap@xenotime.net> <45389662.6010604@s5r6.in-berlin.de> <20061020091302.a2a85fb1.rdunlap@xenotime.net> <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 07:58:53PM +0200, Geert Uytterhoeven wrote:
> On Fri, 20 Oct 2006, Randy Dunlap wrote:
> > Yes, we have lots of header include indirection going on.
> > I don't know of a good tool to detect/fix it.
> 
> BTW, what about making sure all header files are self-contained (i.e. all
> header files include all stuff they need)? This would make it easier for the
> users to know which files to include.

I was wondering about putting in some tags in comments in the headers and
using scripts to parse them out.  Something like:

/*+
 * Provides: struct sched
 * Provides: total_forks, nr_threads, process_counts, nr_processes()
 * Provides: nr_running(), nr_uninterruptible(), nr_active(), nr_iowait(), weighted_cpuload()
 */

(you should be able to have multiple /*+ blocks in the file, multiple
Provides: lines and multiple things provided on a line.  Functions are
tagged with a trailing (), structs with the leading 'struct' and
everything else is a variable.)

Not only does that tell a script unambiguously which header needs to
be included for what function, struct definition and variable, it also
tells the programmer what header to include for what function.

This would have the benefit over automated analysis that you can put
Provides: irq_canonicalize() in <linux/interrupt.h> despite it being
actually defined in <asm/irq.h> (there's probably better examples
than this).

The script could warn for both unnecessary headers included and warn for
headers which weren't included but should be.  The warnings would start
out fairly useful and improve as we added more Provides: lines.

Anyone want to code this, or just pick holes in it?
