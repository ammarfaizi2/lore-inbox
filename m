Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUDTI7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUDTI7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 04:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUDTI7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 04:59:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262353AbUDTI7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 04:59:40 -0400
Message-ID: <4084E671.4090509@redhat.com>
Date: Mon, 19 Apr 2004 22:59:29 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040418)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
References: <4083BA03.1090606@redhat.com> <20040419121225.GT1966@suse.de> <408471E2.8060201@redhat.com> <40848159.7090605@togami.com> <20040420070805.GC25806@suse.de> <4084D83D.8060405@redhat.com> <20040420080325.GD25806@suse.de>
In-Reply-To: <20040420080325.GD25806@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>>We figured removing error handling was not safe, the previous post was 
>>only reporting test results to ask for more suggestions.  I have now 
>>tested your suggested patch above and it seems to crash in the same way 
>>as originally.
>>
>>http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie2.txt
> 
> 
> As a temporary safe work-around, you can apply this patch.
> 
> 
>>This makes me curious, the other elevators lacked this type of error 
>>checking.  Did this mean they were possibly allowing data corruption to 
>>happen with buggy drivers like this?  Kind of scary!  We were lucky to 
>>test this now, because this was one of the first FC kernels that 
>>included cfq by default.
> 
> 
> Not necessarily, it's most likely a CFQ bug. Otherwise it would have
> surfaced before :-)
> 

I forgot to mention in the previous reports:

Prior to three of your original suggested cleanups of i2o_block, four 
simultaneous bonnie++'s on four independent arrays would almost 
immediately cause the crash while running elevator=cfq.  After those 
three cleanups four simultaneous bonnie++ would survive for a while 
without crashing... until you run "sync" in another terminal.  We 
however did not test it enough times to determine if without "sync" it 
can survive the test run.  Do you want this tested without "sync"?

With the deadline scheduler "sync" would take maybe 30 seconds and 
return.  With the cfq scheduler "sync" would be stuck there for much 
longer, then trigger the crash.  Markus has suspected that it crashes 
when sync returns, but we have not confirmed that.

With the cfq scheduler with the error checking completely removed, 
"sync" would be stuck there for a minute or more but eventually return 
without crashing.  (The array is reformatted between every test so we 
don't really care about data corruption.)

I hope this data is helpful.

Warren Togami
wtogami@redhat.com
