Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUH0QXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUH0QXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUH0QXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:23:47 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:65290 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266457AbUH0QVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:21:37 -0400
Date: Fri, 27 Aug 2004 17:21:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040827172131.A473@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <20040827165443.A32567@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040827165443.A32567@infradead.org>; from hch@infradead.org on Fri, Aug 27, 2004 at 04:54:43PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 04:54:43PM +0100, Christoph Hellwig wrote:
> On Fri, Aug 27, 2004 at 10:10:01AM -0500, Patrick Gefre wrote:
> > 
> > This is an update to our last set of patches. I've added some comments from the
> > last review and another synopsis of the patches. The individual patches will
> > follow this email.
> 
> Matthew Wilcox suggested we should really review it as completely new
> code.  So maybe you should split it into one patch that kills all old
> code ånd one that adds new code.  Note that I mean all all code includeing
> the headers which provides a nice opporuntiy to move all of them that
> aren't public interface inside arch/ia64/sn/

Okay, let's start a review for the actual files based on that

all files: lots of missing statics, try running
http://samba.org/ftp/unpacked/junkcode/findstatic.pl over the compiled code.

io_init.c:

 - sal_get_hubdev_info
	umm, you're getting a kernel pointer by a SAL
 	call.  I wonders how this is supposed to work when the kernel
	changes it's VA layout.  (Dito for a bunch of other functions)

 - sn_io_init
	what's going on here?

iomv.c:

 - okay, could use some reformatting to fit 80 chars

pci_dma.c:

 - still using all those indirections althoug there's only a single backend

pci_extension.c:

 - dito.  Why does this single function need a separate file?

pcibr_ate.c:

 - doesn't look to bad, but should probably merged into pcibr_dma.c.  And
   the trivial < 10 line function opencoded in their only callers.

pcibr_dma.c:

 - okay

pcibr_provider.c

 actual code code looks okay, but:

  - sal_pcibr_slot_enable/sal_pcibr_slot_disabl are completely unused
  - the pci_provider abstraction is right now completely useless, please
    add such abstractions only when you need them (and if you'll ever need
    that a few hints:  stop that casting of methods silliness but use
    container_of, use C99 initializers, stop the typedef abuse)
  - request_irq return value needs checking

pcibr_reg.c:

 - all this casting is rather horrible.  At least keep a pointer to each
   of struct tiocp and pic_s (and kill the _s postifx) in syruct pcibus_info.
   the volatiles looks bogus, if you need it you're missing memorry barries.

xtalk_providers.c:

 - bogus indirection again.  if you actually do have different lowlevel
   implementations they should be hidden inside the prom.  While at it I think
   the two calls could just move to arch/ia64/sn/kernel/irq.c
