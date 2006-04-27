Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWD0PZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWD0PZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWD0PZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:25:39 -0400
Received: from smtpout.mac.com ([17.250.248.181]:51148 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965153AbWD0PZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:25:38 -0400
In-Reply-To: <44507E2E.90101@etpmod.phys.tue.nl>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> <1146038324.5956.0.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de> <1146046118.7016.5.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI> <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de> <444F5B74.60809@etpmod.phys.tue.nl> <444F6FDD.7040000@etpmod.phys.tue.nl> <CB27C57D-BABF-4900-9299-F342861CF1E0@mac.com> <44507E2E.90101@etpmod.phys.tue.nl>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E2F57D57-6D47-4AE9-8047-8C31FDACDFC3@mac.com>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
Date: Thu, 27 Apr 2006 11:23:47 -0400
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 27, 2006, at 04:17:50, Bart Hartgers wrote:
> Kyle Moffett wrote:
>> static inline void kfree(void *ptr)
>> {
>>     if (__builtin_constant_p((ptr == NULL))) {
>>         if (ptr)
>>             kfree_nonnull(ptr);
>>     } else {
>>         kfree_unknown(ptr);
>>     }
>> }
>>
>> void kfree_nonnull(void *ptr)
>> {
>>     /* kfree code here, no null check */
>> }
>>
>> void kfree_unknown(void *ptr)
>> {
>>     if (ptr)
>>         kfree_nonnull(ptr);
>> }
>
> I still think there is an inconsistency in gcc. If I call your  
> kfree with the following:
>
> void test( char *ptr )
> {
>         char *null = NULL;
>         kfree(ptr);	/* unknown */
>         *ptr = 'a';
>         kfree(ptr);	/* nonnull */
>         kfree(null);	/* should be optimised away */
> }
>
> ,the compiler (4.1) generates two calls to kfree_unknown instead of  
> one to kfree_nonnull and one to kfree_unknown. It seems that the  
> __builtin_constant_p((ptr==NULL)) check does not always trigger,  
> even if the compiler 'knows' ptr to be equal to NULL. I posted a  
> nasty hack around this problem yesterday.

I know.  You can "fix" this problem by changing the if statement to  
this:

if (__builtin_constant_p(ptr) || __builtin_constant_p((ptr == NULL)))

On the other hand, calling kfree(ptr) on a non-NULL constant pointer  
is a bug and will crash, and calling kfree(ptr) on a NULL constant  
ptr is just dead code and we should find and kill that separately.   
There's no reason to ever call kfree(<constant>).

Cheers,
Kyle Moffett

