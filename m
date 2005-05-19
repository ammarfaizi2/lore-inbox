Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVESONO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVESONO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVESONN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:13:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36827 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262512AbVESONB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:13:01 -0400
Message-ID: <428C9E62.2090205@redhat.com>
Date: Thu, 19 May 2005 10:10:42 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: steve <lingxiang@huawei.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
Subject: Re: why nfs server delay 10ms in nfsd_write()?
References: <0IGP00IZRULADZ@szxml02-in.huawei.com>	 <1116472423.11327.1.camel@mindpipe>  <428C8C32.2030803@redhat.com> <1116511140.21587.4.camel@mindpipe>
In-Reply-To: <1116511140.21587.4.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Thu, 2005-05-19 at 08:53 -0400, Peter Staubach wrote:
>  
>
>>There are certainly many others way to get gathering, without adding an
>>artificial delay.  There are already delay slots built into the code 
>>which could
>>be used to trigger the gathering, so with a little bit different 
>>architecture, the
>>performance increases could be achieved.
>>
>>Some implementations actually do write gathering with NFSv3, even.  Is
>>this interesting enough to play with?  I suspect that just doing the 
>>work for
>>NFSv2 is not...
>>    
>>
>
>Also, how do you explain the big performance hit that steve observed?
>Write gathering is supposed to help performance, but it's a big loss on
>his test...
>

Well, a little bit more information about what he is doing would be 
helpful.  I'd
like to better understand the environment and what the traffic from the 
client
looks like.

Write gathering is not a panacea for all of the ills caused by the NFSv2 
WRITE
stable storage requirements.  In fact, if done wrong, it can cause 
performance
regressions, such as those being noticed by Steve.

--

I implemented the write gathering used in Solaris and experimented with
several (many?) different approachs.  Adding a delay in order to allow
subsequent WRITE requests to arrive seems like a good thing, but can
end up just adding latency to the entire process if not done right.

A suggestion might be to use the delay caused by the nfsd_sync() call
and synchronize other WRITE requests around that.  The delay caused by
doing real i/o to the storage subsystem should allow write gathering to
take place, assuming that the client is generating concurrent WRITE
requests.

       ps
