Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVBCJop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVBCJop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 04:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVBCJoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 04:44:44 -0500
Received: from mx1.elte.hu ([157.181.1.137]:45803 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262683AbVBCJo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 04:44:26 -0500
Date: Thu, 3 Feb 2005 10:44:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050203094410.GB1065@elte.hu>
References: <20050202165151.GA1804@elte.hu> <4201DBE7.30569.2F5D446@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4201DBE7.30569.2F5D446@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* pageexec@freemail.hu <pageexec@freemail.hu> wrote:

> > You can simulate the overflow itself so no need to find any real
> > application vulnerability, but show me _working code_ (or a convincing
> > description) that can call glibc's do_make_stack_executable() (or the
> > 'many ways of doing this'), _and_ will end up executing your shell code
> > as well.

> the overflow hits field1 and whatever is deemed necessary from
> that point on. i'll do this:
> 
> [...]
> [field1 and other locals replaced with shellcode]
> [saved EBP replaced with anything in this case]
> [saved EIP replaced with address of dl_make_stack_executable()]
> [user_input left in place, i.e., overflow ends before this]
> [...]
> 
> dl_make_stack_executable() will nicely return into user_input
> (at which time the stack has already become executable).

wrong, _dl_make_stack_executable() will not return into user_input() in
your scenario, and your exploit will be aborted. Check the glibc sources
and the implementation of _dl_make_stack_executable() in particular. 

I've also attached the disassembly of _dl_make_stack_executable(), from
glibc-2.3.4-3.i686.rpm. 

The sources are at:

   http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/glibc-2.3.4-3.src.rpm

	Ingo

0000ec50 <_dl_make_stack_executable>:
    ec50:	55                   	push   %ebp
    ec51:	ba 0c 00 00 00       	mov    $0xc,%edx
    ec56:	89 e5                	mov    %esp,%ebp
    ec58:	57                   	push   %edi
    ec59:	56                   	push   %esi
    ec5a:	53                   	push   %ebx
    ec5b:	83 ec 10             	sub    $0x10,%esp
    ec5e:	8b 08                	mov    (%eax),%ecx
    ec60:	e8 a6 34 00 00       	call   1210b <__i686.get_pc_thunk.bx>
    ec65:	81 c3 6f 73 00 00    	add    $0x736f,%ebx
    ec6b:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    ec6e:	8b bb d0 fc ff ff    	mov    0xfffffcd0(%ebx),%edi
    ec74:	89 54 24 04          	mov    %edx,0x4(%esp)
    ec78:	8b 45 04             	mov    0x4(%ebp),%eax
    ec7b:	f7 df                	neg    %edi
    ec7d:	21 cf                	and    %ecx,%edi
    ec7f:	89 04 24             	mov    %eax,(%esp)
    ec82:	ff 93 94 fe ff ff    	call   *0xfffffe94(%ebx)
    ec88:	85 c0                	test   %eax,%eax
    ec8a:	0f 85 da 00 00 00    	jne    ed6a <_dl_make_stack_executable+0x11a>
    ec90:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    ec93:	8b b3 34 ff ff ff    	mov    0xffffff34(%ebx),%esi
    ec99:	39 30                	cmp    %esi,(%eax)
    ec9b:	0f 85 c9 00 00 00    	jne    ed6a <_dl_make_stack_executable+0x11a>
    eca1:	80 bb d4 04 00 00 00 	cmpb   $0x0,0x4d4(%ebx)
    eca8:	0f 84 82 00 00 00    	je     ed30 <_dl_make_stack_executable+0xe0>
    ecae:	8b 83 d0 fc ff ff    	mov    0xfffffcd0(%ebx),%eax
    ecb4:	8d 34 c5 00 00 00 00 	lea    0x0(,%eax,8),%esi
    ecbb:	8d 3c 38             	lea    (%eax,%edi,1),%edi
    ecbe:	89 f6                	mov    %esi,%esi
    ecc0:	29 f7                	sub    %esi,%edi
    ecc2:	8b 93 14 ff ff ff    	mov    0xffffff14(%ebx),%edx
    ecc8:	81 e2 ff ff ff fe    	and    $0xfeffffff,%edx
    ecce:	89 54 24 08          	mov    %edx,0x8(%esp)
    ecd2:	89 74 24 04          	mov    %esi,0x4(%esp)
    ecd6:	89 3c 24             	mov    %edi,(%esp)
    ecd9:	e8 22 2a 00 00       	call   11700 <__mprotect>
    ecde:	85 c0                	test   %eax,%eax
    ece0:	74 de                	je     ecc0 <_dl_make_stack_executable+0x70>
    ece2:	8b 83 08 05 00 00    	mov    0x508(%ebx),%eax
    ece8:	83 f8 0c             	cmp    $0xc,%eax
    eceb:	75 3b                	jne    ed28 <_dl_make_stack_executable+0xd8>
    eced:	39 b3 d0 fc ff ff    	cmp    %esi,0xfffffcd0(%ebx)
    ecf3:	74 5b                	je     ed50 <_dl_make_stack_executable+0x100>
    ecf5:	89 f1                	mov    %esi,%ecx
    ecf7:	d1 e9                	shr    %ecx
    ecf9:	89 ce                	mov    %ecx,%esi
    ecfb:	01 cf                	add    %ecx,%edi
    ecfd:	8b 93 14 ff ff ff    	mov    0xffffff14(%ebx),%edx
    ed03:	81 e2 ff ff ff fe    	and    $0xfeffffff,%edx
    ed09:	89 54 24 08          	mov    %edx,0x8(%esp)
    ed0d:	89 74 24 04          	mov    %esi,0x4(%esp)
    ed11:	89 3c 24             	mov    %edi,(%esp)
    ed14:	e8 e7 29 00 00       	call   11700 <__mprotect>
    ed19:	85 c0                	test   %eax,%eax
    ed1b:	74 a3                	je     ecc0 <_dl_make_stack_executable+0x70>
    ed1d:	8b 83 08 05 00 00    	mov    0x508(%ebx),%eax
    ed23:	83 f8 0c             	cmp    $0xc,%eax
    ed26:	74 c5                	je     eced <_dl_make_stack_executable+0x9d>
    ed28:	83 c4 10             	add    $0x10,%esp
    ed2b:	5b                   	pop    %ebx
    ed2c:	5e                   	pop    %esi
    ed2d:	5f                   	pop    %edi
    ed2e:	5d                   	pop    %ebp
    ed2f:	c3                   	ret    
    ed30:	8b 8b 14 ff ff ff    	mov    0xffffff14(%ebx),%ecx
    ed36:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    ed3a:	8b 93 d0 fc ff ff    	mov    0xfffffcd0(%ebx),%edx
    ed40:	89 3c 24             	mov    %edi,(%esp)
    ed43:	89 54 24 04          	mov    %edx,0x4(%esp)
    ed47:	e8 b4 29 00 00       	call   11700 <__mprotect>
    ed4c:	85 c0                	test   %eax,%eax
    ed4e:	75 27                	jne    ed77 <_dl_make_stack_executable+0x127>
    ed50:	83 8b 34 04 00 00 01 	orl    $0x1,0x434(%ebx)
    ed57:	31 c0                	xor    %eax,%eax
    ed59:	8b 7d f0             	mov    0xfffffff0(%ebp),%edi
    ed5c:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    ed62:	83 c4 10             	add    $0x10,%esp
    ed65:	5b                   	pop    %ebx
    ed66:	5e                   	pop    %esi
    ed67:	5f                   	pop    %edi
    ed68:	5d                   	pop    %ebp
    ed69:	c3                   	ret    
    ed6a:	83 c4 10             	add    $0x10,%esp
    ed6d:	b8 01 00 00 00       	mov    $0x1,%eax
    ed72:	5b                   	pop    %ebx
    ed73:	5e                   	pop    %esi
    ed74:	5f                   	pop    %edi
    ed75:	5d                   	pop    %ebp
    ed76:	c3                   	ret    
    ed77:	8b 83 08 05 00 00    	mov    0x508(%ebx),%eax
    ed7d:	83 f8 16             	cmp    $0x16,%eax
    ed80:	75 a6                	jne    ed28 <_dl_make_stack_executable+0xd8>
    ed82:	c6 83 d4 04 00 00 01 	movb   $0x1,0x4d4(%ebx)
    ed89:	e9 20 ff ff ff       	jmp    ecae <_dl_make_stack_executable+0x5e>
    ed8e:	90                   	nop    
    ed8f:	90                   	nop    

