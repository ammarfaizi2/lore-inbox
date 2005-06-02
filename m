Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVFBJMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFBJMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFBJMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:12:23 -0400
Received: from pcmath126.unice.fr ([134.59.10.126]:13703 "EHLO
	pcmath126.unice.fr") by vger.kernel.org with ESMTP id S261248AbVFBJMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:12:14 -0400
Message-ID: <429ECD6D.8000503@unice.fr>
Date: Thu, 02 Jun 2005 11:12:13 +0200
From: XIAO Gang <xiao@unice.fr>
Organization: =?ISO-8859-1?Q?Universit=E9_de_Nice_-_Sophia_Anti?=
 =?ISO-8859-1?Q?polis?=
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, fr, zh-CN, zh-TW
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
References: <429EB537.4060305@unice.fr> <20050602084840.GA32519@wohnheim.fh-wedel.de>
In-Reply-To: <20050602084840.GA32519@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Thu, 2 June 2005 09:28:55 +0200, XIAO Gang wrote:
>  
>
>>Examples:
>>
>>1. In the types of sys_[gs]ethostname, sys_[gs]etdomainname, "int len" 
>>could be replaced
>>by "unsigned int" or "size_t" and sanity check simplified.
>>    
>>
>
>If you really want that fun, try changing it to "unsigned long long"
>on your private machine and do some testing.
>
>Hint: arch/i386/kernel/syscall_table.S
>
I know; I might try to do something later. The question here is to find 
the best balancing point between what
are better replaced and what are not. I would hesitate a lot before 
doing things as below which are more likely to introduce new bugs than 
to avoid old ones.

>>3. The similar situation occurs in fs/namei.c, vfs_readlink(). Here it does 
>>not matter if len
>>is declared to be unsigned, but for size_t, we have to take care about the 
>>size of size_t.
>>    
>>
>
>You could possibly change the code to:
>
>int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen, const char *link)
>{
>	union {
>		unsigned len;
>		int ret;
>	} u;
>
>	u.ret = PTR_ERR(link);
>	if (IS_ERR(link))
>		goto out;
>
>	u.len = strlen(link);
>	if (u.len > (unsigned) buflen)
>		u.len = buflen;
>	if (copy_to_user(buffer, link, u.len))
>		u.ret = -EFAULT;
>out:
>	return u.ret;
>}
>
>But what would we gain, except for a few additional lines?
>
>Jörn
>
>  
>


-- 

XIAO Gang (~{P$8U~})                          xiao@unice.fr
          home page: pcmath126.unice.fr/xiao.html 



