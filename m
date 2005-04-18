Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVDRMzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVDRMzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVDRMzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:55:23 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:18640 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261325AbVDRMyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:54:24 -0400
Message-ID: <4263AD94.0@lab.ntt.co.jp>
Date: Mon, 18 Apr 2005 21:52:36 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Chris Wedgwood <cw@f00f.org>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Rik van Riel wrote:
> On Mon, 18 Apr 2005, Chris Wedgwood wrote:
> 
>>On Mon, Apr 18, 2005 at 02:16:09AM -0700, Paul Jackson wrote:
>>
>>
>>>The call switching folks have been doing live patching at least
>>>since I worked on it, over 25 years ago.  This is not just
>>>marketing.
>>
>>That still doesn't explain *why* live patching is needed.
> 
> 
> I suspect it was needed in the past, on embedded computers so
> small they could only run one program at a time.
> 
> I see no reason why changing programs on the fly couldn't be
> done nicer with SHM segments today - just start up the new
> program in parallel with the old one, have it attach to the
> SHM region and handshake with the old program to take over
> operations.
> 
> At that point the old program can let go of file descriptors
> (eg. those to devices), yield the CPU and the new program can
> open those file descriptors.  The SHM area contains all of the
> state information needed, so the program can continue running
> like it always would.
> 
> This may well be lower latency than live patching, and probably
> lower complexity/risk too...
> 

I think most important thing for carrier system is service availability.
The live patch only stops process(which have 3 threads) 180 nanoseconds 
with 2functions, 2 variable changes on my linux desktop(Xeon 2.8G dual). 
(on sample 1)

I believe process status copy consume more time, may be below sequences 
are needed;
- Stop the service on ACT-process.
- Copy on memory/on transaction status to shared memory.
- Takeover shared memory key to SBY process and release the shared memory
- SBY process access to shared memory.
- SBY process checks the memory and reset broken sessions.
- SBY process restart the service.

Some part may be parallelize, but seems the more data make service 
disruption time longer...(It seems exceeds 100 milliseconds depends on 
data size..)
and process will be more complicated....makes more bugs...


-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp
