Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTLRGUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 01:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTLRGUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 01:20:30 -0500
Received: from moof.zeroth.org ([203.117.131.35]:61706 "EHLO moof.zeroth.org")
	by vger.kernel.org with ESMTP id S265085AbTLRGU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 01:20:28 -0500
Message-ID: <3FE14706.3070003@metaparadigm.com>
Date: Thu, 18 Dec 2003 14:19:50 +0800
From: Jamie Clark <jclark@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1 ext3 oops
References: <3FA713B9.3040405@metaparadigm.com>	 <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com>	 <20031206010505.GB14904@dualathlon.random>	 <3FD7D78A.4080409@metaparadigm.com> <1071661358.13152.26.camel@imladris.demon.co.uk>
In-Reply-To: <1071661358.13152.26.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>On Thu, 2003-12-11 at 10:33 +0800, Jamie Clark wrote:
>  
>
>>After a quick browse of the assembler output the zeroing would appear to 
>>be part of the list_del inline, and edi seems to equate to &sb. 
>>    
>>
>Seems reasonable. It does look like something's stomped on sb->s_dirty.
>  
>
>>__mark_inode_dirty() does not appear to take sb_lock before adding to 
>>the s_dirty list. Could that be the culprit?
>>    
>>
>
>I don't think so; it's holding the inode_lock which should be
>sufficient. Besides -- in practice all updates to the 4-byte pointer
>sb->s_dirty.next are going to be atomic, and there's no reason _ever_
>for it to be set to d7ffbc08. It's hard to see how a simple locking
>problem is going to cause such a thing.
>  
>
True.  I confess I didn't think too hard after narrowing down where it 
tripped up.

>How repeatable is this? 
>
The first oops ocurred after 4 or 5 days. My second run crashed in the 
first night, this time in filemap.c: precheck_file_write().
This oops seemed to be at or near the first dereference of inode, before 
the f_flags test.

        /* FIXME: this is for backwards compatibility with 2.4 */
        if (!S_ISBLK(inode->i_mode) && (file->f_flags & O_APPEND))
                *ppos = pos = inode->i_size;

 >>EIP; c01306fb <precheck_file_write+53/1f8>   <=====
Trace; c01308f8 <generic_file_write_nolock+58/4c8>
Trace; c013108f <generic_file_write+13f/158>
Trace; c016f3a7 <ext3_file_write+23/bc>
Trace; c0140e57 <sys_write+8f/100>
Trace; c0107133 <system_call+33/38>

>Can you turn on slab poisoning?
>  
>
Is CONFIG_DEBUG_SLAB all that I need?

I'm currently running 2.4.23aa1 with the inode.c patch reversions as 
Marcelo first suggested. When (IF) that crashes, or if I can get the 
test running on another SMP box I will revert to 2.4.23 + the qla2300 
driver that I need for the fibre-channel array.

-Jamie

