Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTD2Nxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbTD2Nxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:53:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:17370 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261950AbTD2Nxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:53:52 -0400
Message-ID: <3EAE796C.7010405@austin.ibm.com>
Date: Tue, 29 Apr 2003 08:09:00 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bobby Singh <bobbysingh22@hotmail.com>
CC: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: Having problem with io_getevents with o_direct flag
References: <Law10-F78IJsaJbqJGN00015519@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well a couple of possibilities.  First, are you opening a block device 
(like /dev/sdb) ?  If you are, this is still broken in 2.5.67. A patch 
for this has been submitted to the aio list and is also available in the 
2.5 bugtraker (http://bugme.osdl.org) attached to bug 626.

Also, as far as your code goes, the res from io_get_events only tells 
you that the io_get_events succeeded.  To see if the IO actually 
succeeded you always need to check event.res.  Be careful for event.res 
as there is a bug in libaio where event.res is defined as unsigned but 
it is really signed (negative=error, positive=bytesread/written).

Also I see that you are setting the minimum number of events requested 
to 0, not sure what this will do.  Might want to set that to 1.

Hmm, also see that you are passing in just a struct event where the API 
calls for a struct event * (actually an array of event structs).  Not 
sure why this ever works.

Hope this helps,
Steve

Bobby Singh wrote:

> Hi,
>
>  I am having problems with using io_getevents ? Is the o_direct aio 
> support stable in 2.5.67? Following is the scenario:
>
> Machine: Dell 500SC 1.13Gz
> Original Kernel : 2.4.18-3 ( redhat 7.3)
> Downloaded kernel 2.5.67 and compiled it.
> Installed libaio-0.3.92 aio library.
>
> I am writing an io intensive application and want to leverage the 
> o_direct aio support. I am using in following way (borrowed from 
> testcase in libaio)
>
> struct iocb **pAiocb;
> struct io_event event;
> if(io_submit(io_ctx,numAiocb, pAiocb) <0)
> {
>    perror("Error in io_submit");
>    return(-1);
> }
> for(i=0;i<numAiocb;i++)
> {
>    if((res=io_getevents(io_ctx,0,1,event,NULL)) && (res != 1))
>    {
>        perror("Error in getevents");
>        return(-1);
>    }
>    printf("%d\n",event.res);
> }
>
>
> PROBLEM is : THe code doesn't print an ERROR but in "event.res" the 
> amount of data  read is not same as requested. Sometimes the return 
> size is ZERO and event is returned.
>
> THE CODE WORKS fine if the file is opened WITHOUT O_DIRECT.
>
> Thanks,
> Bobby
>
> _________________________________________________________________
> Protect your PC - get McAfee.com VirusScan Online  
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
>
> -- 
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>



