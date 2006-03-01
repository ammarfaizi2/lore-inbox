Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWCAWLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWCAWLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWCAWLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:11:41 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:3753 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750773AbWCAWLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:11:40 -0500
Message-ID: <44061C0F.2090806@vilain.net>
Date: Thu, 02 Mar 2006 11:11:27 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] vfs: cleanup of permission()
References: <20060228052606.GA6494@MAIL.13thfloor.at> <1141202744.11585.20.camel@lade.trondhjem.org>
In-Reply-To: <1141202744.11585.20.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>>after thinking some time about the oracle words
>>(sent in reply to previous BME submissions) we 
>>(Sam and I) came to the conclusion that it would 
>>be a good idea to remove the nameidata introduced
>>in September 2003 from the inode permission()
>>checks, so that vfs_permission() can take care
>>of them ...
> Why? There may be perfectly legitimate reasons for the filesystem to
> request information about the path.

Part of what we're trying to achieve is clearly seperating VFS from FS 
operations.  A lot of the problems with supporting the per-vfsmnt 
options stemmed from this confusion.

In fact this was largely developed from your feedback on the prior 
thread¹ :) we audited the uses, and you were right - some places really 
couldn't set that field properly.  After some playing and discussion, we 
came to guess that this kind of cleanup was a good way to satisfy your 
concerns as well as Christoph's².

¹ http://xrl.us/j9et
² http://xrl.us/j9eo

The only place that the nameidata structure is currently used is in 
those two places, and given that it *does* appear to represent FS vs VFS 
brain damage to some extent, it's quite important we get this right 
before umpteen security modules spring up using this bad hook ... the 
API is broken (doesn't cover (struct file*)-based operations, only 
lookup (struct nameidata*), and parameter is optional).

> I can think of server failover
> situations in NFSv4 where the client may need to look up the filehandle
> for the file on the new server before it can service the ACCESS call.

The current code doesn't seem to use that right now, at least not via 
permission().  Either way, the information should be available - it just 
needs to hook in somewhere else.

> Firstly, the fact that the lookup intent flags happen not to collide
> with MAY_* is a complete fluke, not a design. The numerical values of
> either set of flags could change tomorrow for all you know.
 > Secondly, an intent is _not_ a permissions mask by any stretch of the
 > imagination.

Yeah, I had this in there at one point as a safety check;

#if (_LOOKUP_MASK ^ _ACCESS_MASK) != (_LOOKUP_MASK | _ACCESS_MASK)
#error splode
#endif

You are right, it should either be converted to two parameters or the 
combination made more formal.

> IOW: at the very least make that intent flag a separate parameter.

Yes, or rename it mask_and_intent perhaps if they were to be combined in 
the same word (which makes sense, with a grand total of 7 bits being 
used, and gcc not being in a position to spot that and optimise for us).

> 
> Cheers,
>   Trond

Thanks for your feedback!

Sam.



