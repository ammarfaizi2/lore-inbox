Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUI0Piw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUI0Piw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUI0PhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:37:01 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:51392 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266511AbUI0PgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:36:16 -0400
Message-ID: <4158342B.4020505@austin.ibm.com>
Date: Mon, 27 Sep 2004 10:39:23 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com>	<20040923194216.1f2b7b05.akpm@osdl.org>	<41543FE2.5040807@austin.ibm.com>	<20040924150523.4853465b.akpm@osdl.org>	<4154A2F7.1050909@austin.ibm.com> <20040924160147.27dbc589.akpm@osdl.org>
In-Reply-To: <20040924160147.27dbc589.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>>It's an application-specified readahead hint.  It should ideally be
>>>asynchronous so the application can get some I/O underway while it's
>>>crunching on something else.  If the queue is contested then the
>>>application will accidentally block when launching the readahead, which
>>>kinda defeats the purpose.
>>> 
>>>
>>>
>>>posix_fadvise(POSIX_FADV_WILLNEED) is used by applications to tell the
>>>kernel that the application will need that part of the file in the future. 
>>>Presumably, the application has something else to be going on with
>>>meanwhile.  Hence the application doesn't want to block.
>>>      
>>>
Ok, got it.

>>>Yes, the application will block when it does the subsequent read() anyway,
>>>but applications expect to block in read().  Seems saner this way.
>>>
>>>      
>>>
>>Just to be sure I have this correct, the readahead code will be invoked 
>>once on the POSIX_FADV_WILLNEED request, but this looks mostly like a 
>>regular read, and then again for the same pages on a real read?
>>    
>>
>
>
>yup.  POSIX_FADV_WILLNEED should just populate pagecache and should launch
>asynchronous I/O.
>

Well then this could cause problems (other than congestion) on both the 
current and new code since both will effectivly see 2 reads, the second 
of which may appear to be a seek backwards thus confusing the code 
slightly.  Would it be best to just special case the POSIX_FADV_WILLNEED 
and issue the I/O required (via do_page_cache_readahead) without 
updating any of the window or current page offset  information ? Of 
course adding the neccesary check for queue congestion.

Steve

