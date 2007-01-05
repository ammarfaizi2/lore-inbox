Return-Path: <linux-kernel-owner+w=401wt.eu-S1160998AbXAEHnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbXAEHnu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbXAEHnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:43:50 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:37343 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160998AbXAEHnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:43:49 -0500
Message-ID: <459E01B2.50309@vc.cvut.cz>
Date: Thu, 04 Jan 2007 23:43:46 -0800
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.9) Gecko/20061219 Iceape/1.0.7 (Debian-1.0.7-1)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: NCPFS and brittle connections
References: <459D1794.2060009@drzeus.cx> <459D38DA.4030803@vc.cvut.cz> <459D55E3.4000905@drzeus.cx>
In-Reply-To: <459D55E3.4000905@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Petr Vandrovec wrote:
>> Nobody is working on it (at least to my knowledge), and to me it is
>> feature - it always worked this way, like smbfs did back in the past -
>> if you send signal 9 to process using mount point, and there is some
>> transaction in progress, nobody can correctly finish that transaction
>> anymore.  Fixing it would require non-trivial amount of code, and
>> given that NCP itself is more or less dead protocol I do not feel that
>> it is necessary.
>>
> 
> Someone needs to tell our customers then so they'll stop using it. :)

When I asked at Brainshare 2001 when support for files over 4GB files 
will be added to NCP, they told me that I should switch to CIFS or 
NFS...  Years after that confirmed it - only NW6.5SP3 finally got NCPs 
to support for files over 4GB, although you could have such files even 
on NW5.

>> If you want to fix it, feel free.  Culprit is RQ_INPROGRESS handling
>> in ncp_abort_request - it just aborts whole connection so it does not
>> have to provide temporary buffers and special handling for reply - as
>> buffers currently specified as reply buffers are owned by caller, so
>> after aborting request you cannot use them anymore.
> 
> Do you have any pointers to how it was solved with smbfs? Relevant
> patches perhaps? Provided a similar solution can be applied here.

I believe it was fixed when smbiod was introduced.  When find_request() 
returns failure, it simple throws away data received from network.

Unfortunately NCP does not run on top of TCP stream, but on top of 
IPX/UDP, and so dropping reply is not sufficient - you must continue 
resending request (so you must buffer it somewhere...) until you get 
result from server - after you receive answer from server, you can 
finally throw away both request & reply, and move on.
							Petr


