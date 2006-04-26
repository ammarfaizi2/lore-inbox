Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWDZLh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWDZLh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWDZLh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:37:27 -0400
Received: from mailhost.tue.nl ([131.155.3.8]:12748 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S932403AbWDZLh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:37:26 -0400
Message-ID: <444F5B74.60809@etpmod.phys.tue.nl>
Date: Wed, 26 Apr 2006 13:37:24 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> <1146038324.5956.0.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de> <1146046118.7016.5.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI> <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de>
In-Reply-To: <20060426110656.GD29108@wohnheim.fh-wedel.de>
Content-Type: multipart/mixed;
 boundary="------------010308040706020806090002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010308040706020806090002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Jörn Engel wrote:
> On Wed, 26 April 2006 13:03:34 +0200, Arjan van de Ven wrote:
>> On Wed, 2006-04-26 at 13:57 +0300, Pekka J Enberg wrote:
>>> On Wed, 26 April 2006 10:27:18 +0200, Arjan van de Ven wrote:
>>>>>> what I would like is kfree to become an inline wrapper that does the
>>>>>> null check inline, that way gcc can optimize it out (and it will in 4.1
>>>>>> with the VRP pass) if gcc can prove it's not NULL.
>>> On Wed, 2006-04-26 at 12:05 +0200, Jörn Engel wrote:
>>>>> How well can gcc optimize this case? 
>>> On Wed, 26 Apr 2006, Arjan van de Ven wrote:
>>>> if you deref'd the pointer it'll optimize it away (assuming a new enough
>>>> gcc, like 4.1)
>>> Here are the numbers for allyesconfig on my setup.
>>>
>>> 				Pekka
>>>
>>> gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)
>> this is an ancient gcc without VRP so yeah the growth is expected ;)
> 
> In other words, we shouldn't do this as long as most users don't have
> gcc 4.1 or higher installed.  So this is somewhat pointless at the
> moment.
> 
> Still, if you could respin this with gcc 4.1 and post the numbers,
> Pekka, that would be quite interesting.
> 
> Jörn
> 

What about this:

static inline void my_kfree( void *ptr )
{
        if (__builtin_constant_p(ptr!=NULL)) {
                if (ptr!=NULL)
                        my_fast_free(ptr); /* skips NULL check */
        } else {
                my_checking_free(ptr); /* does a NULL check */
        }
}

That would skip the free when ptr is known to be NULL, and skip the
equal to NULL check if it is known to be not NULL, and do what happened
before otherwise. In other words, it is never worse than what we have now.

Attached is a small testcase in C and the resulting assembly. Note that
my compiler doesn't catch the "not equal to zero" case, but 4.1 is
supposed to do this.

Groeten,
Bart




-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/

--------------010308040706020806090002
Content-Type: text/x-csrc;
 name="testje.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testje.c"

#define NULL ((void *)(0))

extern void my_fast_free(void *);
extern void my_checking_free(void *);

static inline void my_kfree( void *ptr )
{
	if (__builtin_constant_p(ptr!=NULL)) {
		if (ptr!=NULL)
			my_fast_free(ptr);
	} else {
		my_checking_free(ptr);
	}
}

void test( int *bla )
{
	char *hello = NULL;
	my_kfree(hello);
	my_kfree(bla);
	*bla = 1;	/* now it is !=NULL */
	my_kfree(bla);
}

--------------010308040706020806090002
Content-Type: text/plain;
 name="testje.S"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testje.S"

	.file	"testje.c"
	.text
	.p2align 4,,15
.globl test
	.type	test, @function
test:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	movl	8(%ebp), %ebx
	pushl	%ebx
	call	my_checking_free
	movl	$1, (%ebx)
	movl	%ebx, 8(%ebp)
	addl	$16, %esp
	movl	-4(%ebp), %ebx
	leave
	jmp	my_checking_free
	.size	test, .-test
	.ident	"GCC: (GNU) 4.0.2 20050901 (prerelease) (SUSE Linux)"
	.section	.note.GNU-stack,"",@progbits

--------------010308040706020806090002--
