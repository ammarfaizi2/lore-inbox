Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUBFLdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 06:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbUBFLdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 06:33:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55466 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265433AbUBFLdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 06:33:07 -0500
Date: Fri, 6 Feb 2004 11:33:05 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Message-ID: <20040206113305.GF21151@parcelfarce.linux.theplanet.co.uk>
References: <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 03:22:35AM -0800, John Cherry wrote:
> drivers/net/ne.c:168: warning: unused variable `irq'
> drivers/scsi/imm.c:1146: warning: `ports' might be used uninitialized in this function
> drivers/scsi/ppa.c:1006: warning: `ports' might be used uninitialized in this function

Sigh...  we have
        switch (dev->mode) {
        case IMM_NIBBLE:
        case IMM_PS2:
                ports = 3;
                break;
        case IMM_EPP_8:
        case IMM_EPP_16:
        case IMM_EPP_32:
                ports = 8;
                break;
        default:        /* Never gets here */
                BUG();
        }
	...
	/* use the value of 'ports' */

IOW, gcc doesn't realize that we never return from BUG().  AFAICS, it
should.  Some changes of __volatile__ semantics?
