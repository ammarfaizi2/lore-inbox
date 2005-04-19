Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVDSCPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVDSCPG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 22:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVDSCPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 22:15:06 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:62138 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261273AbVDSCOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 22:14:48 -0400
Message-ID: <42646983.4020908@lab.ntt.co.jp>
Date: Tue, 19 Apr 2005 11:14:27 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Chris Wedgwood <cw@f00f.org>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 18 Apr 2005, Takashi Ikebe wrote:
>
>  
>
>>I believe process status copy consume more time, may be below sequences are
>>needed;
>>- Stop the service on ACT-process.
>>- Copy on memory/on transaction status to shared memory.
>>    
>>
>
>No need for this, the process could ALWAYS store its
>status in a shared memory status.  This is just as
>fast as private memory, only more flexible
>  
>
I don't think so, because ACT process must stop service logic to
takeover, if the service use network listen port.(ACT process need to
stop service and close socket to take over.)

>>- Takeover shared memory key to SBY process and release the shared memory
>>- SBY process access to shared memory.
>>    
>>
>
>Which means the SBY process can attach to the shared
>memory region while the ACT process is running.  It
>can then communicate with the ACT process through a
>socket ...
>  
>
this makes software developer crazy....

>>- SBY process checks the memory and reset broken sessions.
>>- SBY process restart the service.
>>    
>>
>
>... and the SBY process can take over immediately.
>The state machine running the SBY software can
>continue using the same data structures the ACT
>process was using beforehand, since they're in a 
>shared memory region.
>  
>
>>Some part may be parallelize, but seems the more data make service 
>>disruption time longer...(It seems exceeds 100 milliseconds depends on 
>>data size..) and process will be more complicated....makes more bugs...
>>    
>>
>
>The data size should not be an issue, since the primary
>copy of the state is in the shared memory area.
>  
>
For me, is seems very dangerous to estimate the primary copy is not
broken through status takeover..

>The state machine in the SBY process can directly run
>using those data structures, so no copying is needed.
>
>The only overhead will be inter-process communication,
>having the first process close file descriptors, yielding
>the CPU to the second process, which then opens up the
>devices again.  We both know how long a context switch
>and an open() syscall take - negligable.
>
>The old version of the program can shut itself down
>after it knows the new version has taken over - in the
>background, without disrupting the now active process.
>
>  
>
I think your assumption works on some type of process, but not for all
the process.
Some process use critical resources such as fixed network listen port
can not speed up so.
More importantly, the only process who prepare to use this mechanism
only allows to use quick process takeover. This cause software
development difficult.
The live patching does not require to implement such special techniques
on applications.


-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


