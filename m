Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268452AbUHLHze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbUHLHze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268456AbUHLHze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:55:34 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:46084 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S268452AbUHLHzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:55:32 -0400
Message-ID: <20040812115531.A16166@castle.nmd.msu.ru>
Date: Thu, 12 Aug 2004 11:55:31 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jirka Kosina <jikos@jikos.cz>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: FW: Linux kernel file offset pointer races
References: <XFMail.20040805104213.pochini@shiny.it> <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz> <20040807171500.GA26084@logos.cnet> <20040811182602.A2055@castle.nmd.msu.ru> <20040811211430.GA4275@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20040811211430.GA4275@dmt.cyclades>; from "Marcelo Tosatti" on Wed, Aug 11, 2004 at 06:14:30PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:14:30PM -0300, Marcelo Tosatti wrote:
> On Wed, Aug 11, 2004 at 06:26:02PM +0400, Andrey Savochkin wrote:
> > BTW, f_pos assignments are non-atomic on IA-32 since it's a 64-bit value.
> > The file position is protected by the BKL in llseek(), but I do not see any
> > serialization neither in sys_read() nor in generic_file_read() and other
> > methods.
> > 
> > Have we accepted that the file position may be corrupted after crossing 2^32
> > boundary by 2 processes reading in parallel from the same file?
> > Or am I missing something?
> 
> Yes, as far as I know, parallel users of the same file descriptions (which 
> can race on 64-bit architectures) is expected, we dont care about handling it.
> 
> Behaviour is undefined. 

I prefer explainable behaviours :)

If 2 processes start reading at offset 0xfffffffe, and one of them reads 1
byte and the second 2 bytes, I can expect the file position be 0xffffffff,
0x100000000, 0x100000001, or, in the worst case, 0xfffffffe again.
But 0x1ffffffff will be a real surprise.

For a bigger surprise, we can kill one of the processes with SIGFPE if we
find that the processes perform such an "incorrect" parallel read and the
file position has changed behind us ;)
But we don't want that much undefined behaviour, do we? :)

Best regards
		Andrey
