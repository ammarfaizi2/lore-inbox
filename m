Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSHBKMk>; Fri, 2 Aug 2002 06:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSHBKMj>; Fri, 2 Aug 2002 06:12:39 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:16907 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S316775AbSHBKMj>;
	Fri, 2 Aug 2002 06:12:39 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andrew Morton <akpm@zip.com.au>
Date: Fri, 2 Aug 2002 12:15:10 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE hang, partition strangeness
CC: dalecki@evision-ventures.com, viro@math.psu.edu,
       linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <DA7022651A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Aug 02 at 23:56, Andrew Morton wrote:
> > 
> > Seems that the partitioning code in 2.5.30 is sending illegal LBAs
> > to the IDE driver, which responds by hanging the box:
> 
> I misread this backtrace:
> 
> _this_ is the lba. 160086527.  It is the very last sector on the disk.

Did not it issued an error on the console before that? Something
like 'hda: xxxx: status=YY' ? If it did, just open
drivers/ide/ide.c in your favorite editor, locate function ata_error,
in this function locate 'if (rq->errors >= ERROR_MAX)' and replace
it with 'if (1)'... 

Problem is that current IDE code does not start retry, although it 
thinks that it started it - so code waits for something to happen,
without timer set up, and without xxx->handler set to anything, so
even if something will happen (spurious interrupt), it will not awake.

Changing condition to '1' will force IDE driver to fail operation 
immediately, and so channel will not deadlock (put it in another 
way: any time current ata_error returns ATA_OP_CONTINUES, you just 
lost your IDE channel with kernels >= 2.5.27 (at least)).
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
