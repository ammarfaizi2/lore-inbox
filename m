Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267909AbTAMODD>; Mon, 13 Jan 2003 09:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267911AbTAMODD>; Mon, 13 Jan 2003 09:03:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8600
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267909AbTAMODB>; Mon, 13 Jan 2003 09:03:01 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15906.13194.169834.758112@argo.ozlabs.ibm.com>
References: <20030110165441$1a8a@gated-at.bofh.it>
	 <15906.13194.169834.758112@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042469960.18624.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 14:59:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 03:33, Paul Mackerras wrote:
> I'm using the patch below, which makes sure that ide_release (in
> ide-cs.c) runs in process context not interrupt context.  The specific
> problem I saw was that ide_unregister calls various devfs routines
> that don't like being called in interrupt context, but there may well
> be other thing ide_unregister does that aren't safe in interrupt
> context.

The ide release code isnt safe in any context.

> I have "fixed" the problem for now by adding a call to
> init_hwif_data(index) in ide_register_hw just before the first
> memcpy.  I'd be interested to know what the right fix is. :)

The code is currently written on the basis that people don't mangle
free interfaces (the free up code restores stuff which I grant is
kind of ass backwards). It also needs serious review and 2.5 testing
before I'd want to move it to the right spot.


Also note that freeing the IDE can fail. If it fails then the code
should probably be a lot smarter. Right now it 'loses' the interface.
Really it should set a timer and try again. It might also want to
add a null iops (out does nothing in returns FFFFFFFF) to stop
further I/O cycles.

