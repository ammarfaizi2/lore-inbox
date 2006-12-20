Return-Path: <linux-kernel-owner+w=401wt.eu-S1030385AbWLTWXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWLTWXE (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWLTWXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:23:03 -0500
Received: from mail.tmr.com ([64.65.253.246]:57902 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030385AbWLTWXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:23:00 -0500
Message-ID: <4589B92F.2030006@tmr.com>
Date: Wed, 20 Dec 2006 17:29:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Manish Regmi <regmi.manish@gmail.com>
CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Linux disk performance.
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>	 <1166431020.3365.931.camel@laptopd505.fenrus.org> <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
In-Reply-To: <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Regmi wrote:
> On 12/18/06, Arjan van de Ven <arjan@infradead.org> wrote:
>> if you want truely really smooth writes you'll have to work for it,
>> since "bumpy" writes tend to be better for performance so naturally the
>> kernel will favor those.
>>
>> to get smooth writes you'll need to do a threaded setup where you do an
>> msync/fdatasync/sync_file_range on a frequent-but-regular interval from
>> a thread. Be aware that this is quite likely to give you lower maximum
>> performance than the batching behavior though.
>>
> 
> Thanks...

Just to say it another way.
> 
> But isn't O_DIRECT supposed to bypass buffering in Kernel?
That's correct. But it doesn't put your write at the head of any queue, 
it just doesn't buffer it for you.

> Doesn't it directly write to disk?
Also correct, when it's your turn to write to disk...

> I tried to put fdatasync() at regular intervals but there was no
> visible effect.
> 
Quite honestly, the main place I have found O_DIRECT useful is in 
keeping programs doing large i/o quantities from blowing the buffers and 
making the other applications run like crap. If you application is 
running alone, unless you are very short of CPU or memory avoiding the 
copy to an o/s buffer will be down in the measurement noise.

I had a news (usenet) server which normally did 120 art/sec (~480 tps), 
which dropped to about 50 tps when doing large file copies even at low 
priority. By using O_DIRECT the impact essentially vanished, at the cost 
of the copy running about 10-15% slower. Changing various programs to 
use O_DIRECT only helped when really large blocks of data were involved, 
and only when i/o clould be done in a way to satisfy the alignment and 
size requirements of O_DIRECT.

If you upgrade to a newer kernel you can try other i/o scheduler 
options, default cfq or even deadline might be helpful.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
