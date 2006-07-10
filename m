Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWGJKUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWGJKUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWGJKUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:20:00 -0400
Received: from mail.gmx.de ([213.165.64.21]:64729 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932348AbWGJKT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:19:59 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc1: slab BUG_ON(!PageSlab(page)) upon umount after
	failed suspend
From: Mike Galbraith <efault@gmx.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020607100142l62f02321i9802f9eed64d39f4@mail.gmail.com>
References: <6wDCq-5xj-25@gated-at.bofh.it> <6wM2X-1lt-7@gated-at.bofh.it>
	 <6wOxP-4QN-5@gated-at.bofh.it> <44B189D3.4090303@imap.cc>
	 <20060709161712.c6d2aecb.akpm@osdl.org>
	 <1152513068.7748.13.camel@Homer.TheSimpsons.net>
	 <84144f020607100142l62f02321i9802f9eed64d39f4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 12:25:48 +0200
Message-Id: <1152527148.8700.8.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 11:42 +0300, Pekka Enberg wrote:
> On 7/10/06, Mike Galbraith <efault@gmx.de> wrote:
> > While trying to figure out what happened to break suspend to disk on my
> > box, and booting between various other kernels to compare messages, I
> > accidentally captured the following during shutdown.  I have no idea if
> > failed suspends have anything to do with it, but it may, because I
> > haven't had this happen in any other circumstance.  I'm making a rash
> > presumption that the two or three other times the box has died on
> > shutdown (without serial console being connected) were the same.
> 
> [snip]
> 
> > kernel BUG at <bad filename>:45803! <-- what goeth on here.  it's slab.c:1542
> 
> Looks as if kernel text is messed up.
> 
> > Code: 30 8b 57 3c 8b 45 f0 e8 d5 ac fe ff f6 47 36 02 74 11 8b 4f 3c b8 01 00 00 00 d3 e0 f0 29 05 14 ad 5f b1 83 c4 04 5b 5e 5f 5d c3 <0f> 0b eb b2 55 89 e5 57 56 53 83 ec 28 89 c6 89 d3 89 e0 25 00
> 
> See how ud2a comes after ret which doesn't match what GCC generates
> for me at least. Furthermore, the BUG() line number is messed up (eb
> b2). So doesn't look like a slab bug to me.

Hm.  I've never _noticed_ gcc putting anything out there before.  This
is gcc version 4.1.2 20060531 (prerelease) (SUSE Linux).

000002ee <kmem_freepages>:
     2ee:	55                   	push   %ebp
     2ef:	89 e5                	mov    %esp,%ebp
     2f1:	57                   	push   %edi
     2f2:	56                   	push   %esi
     2f3:	53                   	push   %ebx
     2f4:	83 ec 04             	sub    $0x4,%esp
     2f7:	89 c7                	mov    %eax,%edi
     2f9:	89 55 f0             	mov    %edx,0xfffffff0(%ebp)
     2fc:	8b 48 3c             	mov    0x3c(%eax),%ecx
     2ff:	be 01 00 00 00       	mov    $0x1,%esi
     304:	d3 e6                	shl    %cl,%esi
     306:	89 d3                	mov    %edx,%ebx
     308:	81 c3 00 00 00 50    	add    $0x50000000,%ebx
     30e:	c1 eb 0c             	shr    $0xc,%ebx
     311:	c1 e3 05             	shl    $0x5,%ebx
     314:	03 1d 00 00 00 00    	add    0x0,%ebx
     31a:	8b 03                	mov    (%ebx),%eax
     31c:	89 f1                	mov    %esi,%ecx
     31e:	f7 d9                	neg    %ecx
     320:	c1 e8 1e             	shr    $0x1e,%eax
     323:	8b 04 85 00 00 00 00 	mov    0x0(,%eax,4),%eax
     32a:	ba 03 00 00 00       	mov    $0x3,%edx
     32f:	e8 fc ff ff ff       	call   330 <kmem_freepages+0x42>
     334:	85 f6                	test   %esi,%esi
     336:	74 18                	je     350 <kmem_freepages+0x62>
     338:	31 d2                	xor    %edx,%edx
     33a:	eb 03                	jmp    33f <kmem_freepages+0x51>
     33c:	83 c3 20             	add    $0x20,%ebx
     33f:	8b 03                	mov    (%ebx),%eax
     341:	84 c0                	test   %al,%al
     343:	79 4a                	jns    38f <kmem_freepages+0xa1>  <===
     345:	0f ba 33 07          	btrl   $0x7,(%ebx)
     349:	83 c2 01             	add    $0x1,%edx
     34c:	39 d6                	cmp    %edx,%esi
     34e:	75 ec                	jne    33c <kmem_freepages+0x4e>
     350:	89 e0                	mov    %esp,%eax
     352:	25 00 f0 ff ff       	and    $0xfffff000,%eax
     357:	8b 00                	mov    (%eax),%eax
     359:	8b 80 dc 04 00 00    	mov    0x4dc(%eax),%eax
     35f:	85 c0                	test   %eax,%eax
     361:	74 02                	je     365 <kmem_freepages+0x77>
     363:	01 30                	add    %esi,(%eax)
     365:	8b 57 3c             	mov    0x3c(%edi),%edx
     368:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     36b:	e8 fc ff ff ff       	call   36c <kmem_freepages+0x7e>
     370:	f6 47 36 02          	testb  $0x2,0x36(%edi)
     374:	74 11                	je     387 <kmem_freepages+0x99>
     376:	8b 4f 3c             	mov    0x3c(%edi),%ecx
     379:	b8 01 00 00 00       	mov    $0x1,%eax
     37e:	d3 e0                	shl    %cl,%eax
     380:	f0 29 05 00 00 00 00 	lock sub %eax,0x0
     387:	83 c4 04             	add    $0x4,%esp
     38a:	5b                   	pop    %ebx
     38b:	5e                   	pop    %esi
     38c:	5f                   	pop    %edi
     38d:	5d                   	pop    %ebp
     38e:	c3                   	ret    
     38f:	0f 0b                	ud2a   
     391:	eb b2                	jmp    345 <kmem_freepages+0x57>

00000393 <__cache_free>:


