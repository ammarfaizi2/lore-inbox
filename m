Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVCYXKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVCYXKw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 18:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVCYXKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 18:10:52 -0500
Received: from mail.dif.dk ([193.138.115.101]:41405 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261859AbVCYXKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 18:10:32 -0500
Date: Sat, 26 Mar 2005 00:12:28 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-os <linux-os@analogic.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove redundant NULL pointer checks prior to calling
 kfree() in fs/nfsd/
In-Reply-To: <Pine.LNX.4.61.0503251731240.6372@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0503252347240.2498@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252319220.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251731240.6372@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, linux-os wrote:

> On Fri, 25 Mar 2005, Jesper Juhl wrote:
> 
> > (please keep me on CC)
> > 
> > 
> > checking for NULL before calling kfree() is redundant and needlessly
> > enlarges the kernel image, let's get rid of those checks.
> > 
> 
> Hardly. ORing a value with itself and jumping on condition is
> real cheap compared with pushing a value into the stack and
> calling a function. This is NOT a good change if you want
> performance. You really should reconsider this activity. It
> is quite counter-productive.
> 
> 
Let's have a look - at fs/nfsd/export.o for example.

Size first.
Without my patch :
$ ls -l fs/nfsd/export.o
-rw-r--r--  1 juhl users 97144 2005-03-25 23:58 fs/nfsd/export.o
With my patch : 
$ ls -l fs/nfsd/export.o
-rw-r--r--  1 juhl users 97092 2005-03-25 23:59 fs/nfsd/export.o

That's our first bennefit - 52 bytes saved - not much, but still some.


Now let's take a look at the code gcc generates for one of the functions - 
expkey_parse for example. Here's a diff -u of an  objdump -D  of export.o 
cut down to just the bit for expkey_parse : 

--- func-without-patch	2005-03-26 00:02:47.000000000 +0100
+++ func-with-patch	2005-03-26 00:03:26.000000000 +0100
@@ -8,7 +8,7 @@
      13b:	81 ec d0 00 00 00    	sub    $0xd0,%esp
      141:	89 95 40 ff ff ff    	mov    %edx,0xffffff40(%ebp)
      147:	80 7c 0a ff 0a       	cmpb   $0xa,0xffffffff(%edx,%ecx,1)
-     14c:	0f 85 2b 02 00 00    	jne    37d <expkey_parse+0x24d>
+     14c:	0f 85 27 02 00 00    	jne    379 <expkey_parse+0x249>
      152:	c6 44 0a ff 00       	movb   $0x0,0xffffffff(%edx,%ecx,1)
      157:	a1 64 00 00 00       	mov    0x64,%eax
      15c:	ba d0 00 00 00       	mov    $0xd0,%edx
@@ -17,7 +17,7 @@
      168:	89 c3                	mov    %eax,%ebx
      16a:	c7 85 30 ff ff ff f4 	movl   $0xfffffff4,0xffffff30(%ebp)
      171:	ff ff ff 
-     174:	0f 84 fd 01 00 00    	je     377 <expkey_parse+0x247>
+     174:	0f 84 f2 01 00 00    	je     36c <expkey_parse+0x23c>
      17a:	89 c2                	mov    %eax,%edx
      17c:	8d 85 40 ff ff ff    	lea    0xffffff40(%ebp),%eax
      182:	b9 00 10 00 00       	mov    $0x1000,%ecx
@@ -52,7 +52,7 @@
      208:	80 38 00             	cmpb   $0x0,(%eax)
      20b:	0f 85 46 01 00 00    	jne    357 <expkey_parse+0x227>
      211:	f6 05 00 00 00 00 04 	testb  $0x4,0x0
-     218:	0f 85 6a 01 00 00    	jne    388 <expkey_parse+0x258>
+     218:	0f 85 66 01 00 00    	jne    384 <expkey_parse+0x254>
      21e:	83 ff 02             	cmp    $0x2,%edi
      221:	0f 8f 30 01 00 00    	jg     357 <expkey_parse+0x227>
      227:	8d 85 40 ff ff ff    	lea    0xffffff40(%ebp),%eax
@@ -134,22 +134,20 @@
      35f:	74 0b                	je     36c <expkey_parse+0x23c>
      361:	8b 85 34 ff ff ff    	mov    0xffffff34(%ebp),%eax
      367:	e8 fc ff ff ff       	call   368 <expkey_parse+0x238>
-     36c:	85 db                	test   %ebx,%ebx
-     36e:	74 07                	je     377 <expkey_parse+0x247>
-     370:	89 d8                	mov    %ebx,%eax
-     372:	e8 fc ff ff ff       	call   373 <expkey_parse+0x243>
-     377:	8b 85 30 ff ff ff    	mov    0xffffff30(%ebp),%eax
-     37d:	81 c4 d0 00 00 00    	add    $0xd0,%esp
-     383:	5b                   	pop    %ebx
-     384:	5e                   	pop    %esi
-     385:	5f                   	pop    %edi
-     386:	c9                   	leave  
-     387:	c3                   	ret    
-     388:	89 7c 24 04          	mov    %edi,0x4(%esp)
-     38c:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
-     393:	e8 fc ff ff ff       	call   394 <expkey_parse+0x264>
-     398:	e9 81 fe ff ff       	jmp    21e <expkey_parse+0xee>
-     39d:	8d 76 00             	lea    0x0(%esi),%esi
+     36c:	89 d8                	mov    %ebx,%eax
+     36e:	e8 fc ff ff ff       	call   36f <expkey_parse+0x23f>
+     373:	8b 85 30 ff ff ff    	mov    0xffffff30(%ebp),%eax
+     379:	81 c4 d0 00 00 00    	add    $0xd0,%esp
+     37f:	5b                   	pop    %ebx
+     380:	5e                   	pop    %esi
+     381:	5f                   	pop    %edi
+     382:	c9                   	leave  
+     383:	c3                   	ret    
+     384:	89 7c 24 04          	mov    %edi,0x4(%esp)
+     388:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
+     38f:	e8 fc ff ff ff       	call   390 <expkey_parse+0x260>
+     394:	e9 85 fe ff ff       	jmp    21e <expkey_parse+0xee>
+     399:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
      3a0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      3a4:	c7 04 24 16 00 00 00 	movl   $0x16,(%esp)
      3ab:	e8 fc ff ff ff       	call   3ac <expkey_parse+0x27c>

This is not too bad, but I've seen a lot worse, see this one for a gross 
example : http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1050.html


-- 
Jesper Juhl
 
