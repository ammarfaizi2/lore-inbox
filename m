Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317671AbSGZKno>; Fri, 26 Jul 2002 06:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSGZKno>; Fri, 26 Jul 2002 06:43:44 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:2323 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317671AbSGZKnm>;
	Fri, 26 Jul 2002 06:43:42 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Fri, 26 Jul 2002 12:46:15 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE lockups with 2.5.28...
CC: lkml <linux-kernel@vger.kernel.org>, axboe@suse.de, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.50
Message-ID: <32F26B48A5@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jul 02 at 12:30, Marcin Dalecki wrote:
> Petr Vandrovec wrote:
> 
> > Well, no. Both of these loop have completely different terminating conditions.
> > You exit when IDE hardware is busy, while SCSI exits if hardware is busy,
> > or when there is nothing to do. Fundamental difference.
> 
> Shit - you are right. We look until the next request sets IDE_BUSY as a 
> side effect.... I just wanted to close the window between clear we clear
> IDE_BUSY in ata_irq_handler just before recalling do_request to set it 
> immediately on again.
> Should be both of course.

Most of IDE code access IDE_BUSY flag when queue lock is held. So just 
move it inside lock everywhere... As side benefit you do not have to use 
atomic test_and_set then, you can use faster non-atomic (without lock prefix) 
equivalents.

In fact it looks to me like that only tcq's udma_tcq_start accesses
IDE_BUSY without holding queue lock, and it is only read access to print
some BUG()-like message.
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                                       
