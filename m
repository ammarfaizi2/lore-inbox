Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTD3IA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTD3IAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:00:55 -0400
Received: from f47.law10.hotmail.com ([64.4.15.47]:53265 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262134AbTD3IAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:00:51 -0400
X-Originating-IP: [12.210.22.14]
X-Originating-Email: [bobbysingh22@hotmail.com]
From: "Bobby Singh" <bobbysingh22@hotmail.com>
To: slpratt@austin.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: Having problem with io_getevents with o_direct flag
Date: Wed, 30 Apr 2003 01:13:05 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F474xOjIL2jpW00002a3c@hotmail.com>
X-OriginalArrivalTime: 30 Apr 2003 08:13:06.0042 (UTC) FILETIME=[53FB3DA0:01C30EF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steve .. The problem was requesting min requests as 0. I changed to 1 and 
now its working fine.

Thanks,
Bobby
P.S.: I was passing struct event * , wrote it wrong here while stating the 
problem;-)


>From: Steven Pratt <slpratt@austin.ibm.com>
>To: Bobby Singh <bobbysingh22@hotmail.com>
>CC: linux-kernel@vger.kernel.org, linux-aio@kvack.org
>Subject: Re: Having problem with io_getevents with o_direct flag
>Date: Tue, 29 Apr 2003 08:09:00 -0500
>
>Well a couple of possibilities.  First, are you opening a block device 
>(like /dev/sdb) ?  If you are, this is still broken in 2.5.67. A patch for 
>this has been submitted to the aio list and is also available in the 2.5 
>bugtraker (http://bugme.osdl.org) attached to bug 626.
>
>Also, as far as your code goes, the res from io_get_events only tells you 
>that the io_get_events succeeded.  To see if the IO actually succeeded you 
>always need to check event.res.  Be careful for event.res as there is a bug 
>in libaio where event.res is defined as unsigned but it is really signed 
>(negative=error, positive=bytesread/written).
>
>Also I see that you are setting the minimum number of events requested to 
>0, not sure what this will do.  Might want to set that to 1.
>
>Hmm, also see that you are passing in just a struct event where the API 
>calls for a struct event * (actually an array of event structs).  Not sure 
>why this ever works.
>
>Hope this helps,
>Steve
>
>Bobby Singh wrote:
>
>>Hi,
>>
>>  I am having problems with using io_getevents ? Is the o_direct aio 
>>support stable in 2.5.67? Following is the scenario:
>>
>>Machine: Dell 500SC 1.13Gz
>>Original Kernel : 2.4.18-3 ( redhat 7.3)
>>Downloaded kernel 2.5.67 and compiled it.
>>Installed libaio-0.3.92 aio library.
>>
>>I am writing an io intensive application and want to leverage the o_direct 
>>aio support. I am using in following way (borrowed from testcase in 
>>libaio)
>>
>>struct iocb **pAiocb;
>>struct io_event event;
>>if(io_submit(io_ctx,numAiocb, pAiocb) <0)
>>{
>>    perror("Error in io_submit");
>>    return(-1);
>>}
>>for(i=0;i<numAiocb;i++)
>>{
>>    if((res=io_getevents(io_ctx,0,1,event,NULL)) && (res != 1))
>>    {
>>        perror("Error in getevents");
>>        return(-1);
>>    }
>>    printf("%d\n",event.res);
>>}
>>
>>
>>PROBLEM is : THe code doesn't print an ERROR but in "event.res" the amount 
>>of data  read is not same as requested. Sometimes the return size is ZERO 
>>and event is returned.
>>
>>THE CODE WORKS fine if the file is opened WITHOUT O_DIRECT.
>>
>>Thanks,
>>Bobby
>>
>>_________________________________________________________________
>>Protect your PC - get McAfee.com VirusScan Online  
>>http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
>>
>>--
>>To unsubscribe, send a message with 'unsubscribe linux-aio' in
>>the body to majordomo@kvack.org.  For more info on Linux AIO,
>>see: http://www.kvack.org/aio/
>>Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
>
>
>


_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

