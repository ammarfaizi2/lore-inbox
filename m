Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318487AbSIFK1C>; Fri, 6 Sep 2002 06:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSIFK1C>; Fri, 6 Sep 2002 06:27:02 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:29966 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318487AbSIFK1B>;
	Fri, 6 Sep 2002 06:27:01 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linux-ide.org>
Date: Fri, 6 Sep 2002 12:30:59 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] IDE cleanup (1.612) broke all fdisks I have...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <10244EC5BEF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Sep 02 at 15:53, Andre Hedrick wrote:
> 
> I know you are active in 2.5, and I would like to tap your resouces and
> ideas.  Would it be possible to put things behind and move forward, as
> Halloween is near? TIA!

I have no problem, I did not CC-ed you because of it looked to me like
pure 2.5.x problem. And besides that, my interest in IDE is currently
limited to get working system so I can continue in ncpfs and matroxfb
hacking ;-)

If you are interested in long story, then here it comes...
On Sunday afternoon my primary channel (Promise 20265) started magically 
   dying while starting Netware6 as a guest in VMware. After poking here 
   and there I found that simple 'cat Netware6.vmdk > /dev/null' kills the 
   system: cat in D state, IDE doing nothing.
So I tried 2.5.32, 2.5.31, 2.5.29-c476 and 2.4.19-pre7, and behavior was
   all same - cat-ting Netware6.vmdk killed system, regardles of your/Martins
   IDE, or kernel version.
Then an Idea appeared: I did "hdparm -d 0 /dev/hde", and then I did
   "cat Netware6.vmdk > /dev/null" - and, voila, Unrecoverable error
   reading sector XXXXXX appeared.
Well, so disk died, and there are missing some timeouts or error recovery
   in the pdc driver while using UDMA on 20265. I hoped that I'll look into
   that, but...
... I booted Windows, and started Windows Data Lifeguard tools. They told
   me that disk has really problem, so I run extended test and let it 
   reallocate bad sector. It told me that everything was fine, so I rerun
   it again, and it again found (same) bad sector, and told me that something
   went wrong. So I concluded that disk is really dead, rebooted windows and...
... my MBR was full of crap. Then I brought disk to the work, downloaded
   Western's DOS based tool, and it repaired disk without a glitch. So
   my current idea is that WDL version I have relocated sector 0 instead
   of bad sector :-( Grr... Now back to the my problems ;-) gpart recovered
   partitions, and everything was nice.
Yesterday new disks arrived, and I found that I cannot partition that,
   as cfdisk reports unreadable disk although I specified -h/-s/-c on
   the command line. fdisk worked, though, after using extended options
   to set c/h/s params, but fixed kernel and simple cfdisk UI is better
   (although cfdisk does not allow to set extended partition as bootable
   one, so I had to do that in fdisk anyway).
So now when I have working system back, I can actually look at promise
   driver what's wrong there. Unfortunately, as DOS diag tool repaired
   my drive, it looks like that even if I'll find where bug lives, it
   will not be easy to verify it...
And because of I now have my HDD in the removable bay internally connected
   using 40w cable (it is about 2 inches of 40w cable, but apparently
   it is enough to get some echos or bad impendance or...) to the 80w one, 
   kernel found 80w cable and decided to use 88.8MB/s on my i845. It was 
   unreliable, so I did 'hdparm -X 66 /dev/hdc', and now disk works OK, but 
   atapci reports cycle time 7ns, transfer rate 266.6MB/s. But it looks more 
   like atapci problem than IDE driver problem, as disk really works fine.

I'll look at all problems reported here (except WDL... I do not have
their sources, maybe they fixed it already in newer versions, and I have
no way to test it again until new bad sector appears), but I cannot say 
in what timeframe... Probably this year ;-)
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
