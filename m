Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVCTOiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVCTOiD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 09:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVCTOiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 09:38:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:61620 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261222AbVCTOhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 09:37:22 -0500
Date: Sun, 20 Mar 2005 15:39:02 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree()
 in security/ 
In-Reply-To: <200503201331.j2KDVhm12383@blake.inputplus.co.uk>
Message-ID: <Pine.LNX.4.62.0503201528290.2501@dragon.hyggekrogen.localhost>
References: <200503201331.j2KDVhm12383@blake.inputplus.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Ralph Corderoy wrote:

> 
> > and if there are places where it's important to remember that the
> > pointer might be NULL, then a simple comment would do, wouldn't it?
> > 
> > 	kfree(foo->bar);	/* kfree(NULL) is valid */
> 
> I'd rather be without the same comment littering the code.
> 
Me too, but if it's between having a comment or the long version of the 
code with the if() wrapped around it, then I'll personally take the 
comment.  But the actual code should be comment enough.


> > the short version also have the real bennefits of generating shorter
> > and faster code as well as being shorter "on-screen".
> 
> Faster code?  I'd have thought avoiding the function call outweighed the
> overhead of checking before calling.
> 
I haven't actually measured it, but that would be my guess from looking at 
the actual code gcc generates.
security/selinux/ss/conditional.c::cond_policydb_destroy() for instance :

The original version with the if() in place :

void cond_policydb_destroy(struct policydb *p)
{
        if (p->bool_val_to_struct)
                kfree(p->bool_val_to_struct);
        avtab_destroy(&p->te_cond_avtab);
        cond_list_destroy(p->cond_list);
}

turns out like this :

juhl@dragon:~/download/kernel/linux-2.6.11-mm4$ objdump -d -S 
security/selinux/ss/conditional.o
[...]
void cond_policydb_destroy(struct policydb *p)
{
 220:   55                      push   %ebp
 221:   89 e5                   mov    %esp,%ebp
 223:   53                      push   %ebx
 224:   89 c3                   mov    %eax,%ebx
        if (p->bool_val_to_struct)
 226:   8b 40 78                mov    0x78(%eax),%eax
 229:   85 c0                   test   %eax,%eax
 22b:   75 13                   jne    240 <cond_policydb_destroy+0x20>
                kfree(p->bool_val_to_struct);
        avtab_destroy(&p->te_cond_avtab);
 22d:   8d 43 7c                lea    0x7c(%ebx),%eax
 230:   e8 fc ff ff ff          call   231 <cond_policydb_destroy+0x11>
        cond_list_destroy(p->cond_list);
 235:   8b 83 84 00 00 00       mov    0x84(%ebx),%eax
 23b:   5b                      pop    %ebx
 23c:   c9                      leave
 23d:   eb c1                   jmp    200 <cond_list_destroy>
 23f:   90                      nop
 240:   e8 fc ff ff ff          call   241 <cond_policydb_destroy+0x21>
 245:   8d 43 7c                lea    0x7c(%ebx),%eax
 248:   e8 fc ff ff ff          call   249 <cond_policydb_destroy+0x29>
 24d:   8b 83 84 00 00 00       mov    0x84(%ebx),%eax
 253:   5b                      pop    %ebx
 254:   c9                      leave
 255:   eb a9                   jmp    200 <cond_list_destroy>
 257:   89 f6                   mov    %esi,%esi
 259:   8d bc 27 00 00 00 00    lea    0x0(%edi),%edi

[...]


Whereas the version without the if() turns out like this :

juhl@dragon:~/download/kernel/linux-2.6.11-mm4$ objdump -d -S 
security/selinux/ss/conditional.o
[...]
void cond_policydb_destroy(struct policydb *p)
{
 220:   55                      push   %ebp
 221:   89 e5                   mov    %esp,%ebp
 223:   53                      push   %ebx
 224:   89 c3                   mov    %eax,%ebx
        kfree(p->bool_val_to_struct);
 226:   8b 40 78                mov    0x78(%eax),%eax
 229:   e8 fc ff ff ff          call   22a <cond_policydb_destroy+0xa>
        avtab_destroy(&p->te_cond_avtab);
 22e:   8d 43 7c                lea    0x7c(%ebx),%eax
 231:   e8 fc ff ff ff          call   232 <cond_policydb_destroy+0x12>
        cond_list_destroy(p->cond_list);
 236:   8b 83 84 00 00 00       mov    0x84(%ebx),%eax
 23c:   5b                      pop    %ebx
 23d:   c9                      leave
 23e:   eb c0                   jmp    200 <cond_list_destroy>

[...]


First of all that's significantly shorter, so we'll gain a bit of memory 
and I'd guess it would improve cache behaviour as well (but I don't know 
enough to say for sure).
I'm also assuming that in the vast majority of cases (not just here, 
but all over the kernel) the pointer being tested will end up being !=NULL 
so we'll end up doing the function call in any case, so saving the 
conditional should be an overall win.


-- 
Jesper 

