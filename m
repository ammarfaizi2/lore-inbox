Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUBPBFO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUBPBFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:05:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22961 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265280AbUBPBFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:05:08 -0500
Message-ID: <40301713.50609@us.ibm.com>
Date: Sun, 15 Feb 2004 17:04:19 -0800
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kthread vs. dm-daemon
References: <402A4B52.1080800@centrum.cz>	 <1076866470.20140.13.camel@leto.cs.pocnet.net>	 <20040215180226.A8426@infradead.org>	 <1076870572.20140.16.camel@leto.cs.pocnet.net>	 <20040215185331.A8719@infradead.org>	 <1076873760.21477.8.camel@leto.cs.pocnet.net>	 <20040215194633.A8948@infradead.org>	 <1076876668.21968.22.camel@leto.cs.pocnet.net>	 <402FEF1F.2030308@us.ibm.com> <1076889854.5525.22.camel@leto.cs.pocnet.net>
In-Reply-To: <1076889854.5525.22.camel@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> Am So, den 15.02.2004 schrieb Mike Christie um 23:13:
> 
> 
>>>Making dm-daemon use the kthread primitives would make dm-daemon a very
>>>small and stupid wrapper. Changing all dm targets to handle worker
>>>thread notification themselves would result in unnecessary code
>>>duplication.
>>
>>When dm-multipath is more stable it could be using a work queue (my 
>>patch was prematurely sent). Imagine a large number of dm-mp devices 
>>multipathing across two fabrics and one switch failing. Every dm-mp 
>>device could be resubmitting io at the same time.
> 
> 
> I've thought of workqueues but at least for the snapshot and crypt
> target they're overkill. 

It is a bigger problem for targets submitting io becuase the underlying 
device's queue could hit nr_requests.

> 
>>If every write for every dm-raid1 device is going through 
>>a single dm-daemon, it could become a bottleneck.
> 
> 
> Hmm. The read decryption in dm-crypt is also a only-one-cpu-at-a-time
> thing. Didn't anybody notice that? Cryptoloop has the same limitation.
> I don't know how that could be handled differently. Every successful
> read gets dispatched to the next free cpu and decrypted? 

You do not have to create a work_struct for every read. Why not just 
have a bio-successful-reads-queue and a workstruct per device? That way 
you can at least have num cpu devices running in parallel.
