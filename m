Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265072AbTFRE4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 00:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265073AbTFRE4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 00:56:19 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:12993 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S265072AbTFRE4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 00:56:17 -0400
Message-ID: <3EEFF46A.8010405@oracle.com>
Date: Tue, 17 Jun 2003 22:11:06 -0700
From: Scot McKinley <scot.mckinley@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Myers <jgmyers@netscape.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net>	<3EEE6FD9.2050908@netscape.com>  <20030617085408.A1934@in.ibm.com> <1055884008.1250.1479.camel@dell_ss5.pdx.osdl.net> <3EEFAC58.905@netscape.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the error can be determined at submissions time, it should be
returned at submission time. It is a waste for the application to have
to setup for an async completion, when the operation has *already*
failed. I think that the number of apps that would find this logic
desirable is significant enough that we should support it. *If* we
feel that enough apps would also support the "*always* return
asynchronously" methodology, then maybe we should look at conditionally
supporting both.

Actually, for the immediate return case, we should not only support
immediate return of errors, but also successful synchronous completions.
ie, libaio already calls down to the lower layer desriptor specific
code to submit the operation, and has return values for that submission.
If those return values indicate that the operation has ALREADY completed
(synchronously), it makes sense to be *able* to return that to the
application. If the application can take advantage of this synchronous
completion, it could be a nice performance win in terms of the application
not having to keep that memory reserved and not having to track the aio
operation (ie, whatever app specific context it keeps associated w/ that
operation).

There is also a precedent for async api's supporting synchronous
completions in the industry o/s' which support async io.

One question is how would the interface change to support this model.
I like the ability to support *both* methodologies. We could simply
leave the existing interface, and apply the "always return async"
semantics to it. The NEW interface could simply return an list of
io_events, like io_get_events, w/ the immediate completions.

Another possibility is to change the iocb to actually contain an
io_event, and add to it the ability to be added to a linked list.
This way we could simply return a pointer to a list of iocb's, instead
of always requiring the user to setup an array of io_events. ie, i
would prefer to only have to worry about the memory model for
*one* entity (iocb's), instead of the current *two* entities
(iocb's and io_event's). In fact, this paradigm could also be
applied to io_get_events.

Regards, -sm

John Myers wrote:
> Daniel McNeil wrote:
> 
>> I prefer getting the error on io_submit.
>>  
>>
> I prefer getting the error on io_getevents().  The code that handles the 
> output of io_getevents() already has to handle per-operation errors.  
> The only thing user space can reasonably do with errors returned by 
> io_submit() is to retry or assert.  Anything else would duplicate logic 
> that already has to be in and is better handled by the code that handles 
> the output io_getevents().
> 
> io_submit() should only return errors in cases where the caller is 
> obviously buggy/malicious or in cases where it is not possible to 
> generate an event.
> 
> 


-- 
Scot McKinley--------------------------------------------------------
Oracle Corporation/Network Development >\\\|/<
500 Oracle Parkway, 2OP410             (o) (o)     Phone:650.506.9481
Redwood Shores, CA  94065----------oOOO--(_)--OOOo-Fax  :650.506.7226


