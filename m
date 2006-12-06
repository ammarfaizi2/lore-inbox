Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935964AbWLFPyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935964AbWLFPyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936090AbWLFPyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:54:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:35851 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935964AbWLFPyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:54:46 -0500
Date: Wed, 6 Dec 2006 16:54:39 +0100
From: Jan Blunck <jblunck@suse.de>
To: Phil Endecott <phil_arcwk_endecott@chezphil.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <20061206155439.GA6727@hasse.suse.de>
References: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com> <1165418558832@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165418558832@dmwebmail.belize.chezphil.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, Phil Endecott wrote:

> I don't think so.  Example:
> 
> struct test {
>   int a __attribute__((packed));
>   int b __attribute__((packed));
> };
> 
> char c = 1;
> struct test t = { .a=2, .b=3 };
> 
> $ arm-linux-gnu-gcc -O2 -S -W -Wall test1.c
> 
> 	.file	"test2.c"
> 	.global	c
> 	.data
> 	.type	c, %object
> 	.size	c, 1
> c:
> 	.byte	1
> 	.global	t
> 	.align	2               <<<<<<<<===== t is aligned
> 	.type	t, %object
> 	.size	t, 8
> t:
> 	.word	2
> 	.word	3
> 	.ident	"GCC: (GNU) 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)"
> 
> 
> Compare with:
> 
> struct test {
>   int a;
>   int b;
> } __attribute__((packed));
> 
> char c = 1;
> struct test t = { .a=2, .b=3 };
> 
> $ arm-linux-gnu-gcc -O2 -S -W -Wall test2.c
> 
> 	.file	"test1.c"
> 	.global	c
> 	.data
> 	.type	c, %object
> 	.size	c, 1
> c:
> 	.byte	1
> 	.global	t                    <<<<<<  "align" has gone, t is unaligned
> 	.type	t, %object
> 	.size	t, 8
> t:
> 	.4byte	2
> 	.4byte	3
> 	.ident	"GCC: (GNU) 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)"
> 

Maybe the arm backend is somehow broken. AFAIK (and I verfied it on S390 and
i386) the alignment shouldn't change.

struct foo {
	int a;
	char b;
	int c;
};

struct bar1 {
	char a __attribute__((__packed__));
	struct foo b __attribute__((__packed__));
};

struct bar2 {
	char a;
	struct foo b;
} __attribute__((__packed__));

struct bar3 {
	char a;
	struct foo b;
};

struct bar1 packed1 = { 10, { 20, 30, 40 } };
struct bar2 packed2 = { 50, { 60, 70, 80 } };
struct bar3 unpacked = { 90, { 100, 110, 120 } };

s390x-linux-gcc -S packed2.c:
packed2.c:9: warning: '__packed__' attribute ignored for field of type 'char'

	.file	"packed2.c"
.globl packed1
.data
	.align	2
	.type	packed1, @object
	.size	packed1, 13
packed1:
	.byte	10
	.4byte	20
	.byte	30
	.zero	3
	.4byte	40
.globl packed2
	.align	2
	.type	packed2, @object
	.size	packed2, 13
packed2:
	.byte	50
	.4byte	60
	.byte	70
	.zero	3
	.4byte	80
.globl unpacked
	.align	4
	.type	unpacked, @object
	.size	unpacked, 16
unpacked:
	.byte	90
	.zero	3
	.long	100
	.byte	110
	.zero	3
	.long	120
	.ident	"GCC: (GNU) 4.1.2 20060531 (prerelease) (SUSE Linux)"
	.section	.note.GNU-stack,"",@progbits
