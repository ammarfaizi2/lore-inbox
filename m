Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934293AbWLFPWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934293AbWLFPWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934378AbWLFPWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:22:44 -0500
Received: from belize.chezphil.org ([80.68.91.122]:3708 "EHLO
	belize.chezphil.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934293AbWLFPWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:22:43 -0500
To: "Jan Blunck" <jblunck@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Date: Wed, 06 Dec 2006 15:22:38 +0000
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <1165418558832@dmwebmail.belize.chezphil.org>
In-Reply-To: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com>
References: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com>
X-Mailer: Decimail Webmail 3alpha14
MIME-Version: 1.0
Content-Type: text/plain; format="flowed"
From: "Phil Endecott" <phil_arcwk_endecott@chezphil.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck wrote:
> On 12/6/06, Phil Endecott <phil_arcwk_endecott@chezphil.org> wrote:
>> I used to think that this:
>>
>> struct foo {
>>    int a  __attribute__((packed));
>>    char b __attribute__((packed));
>>    ... more fields, all packed ...
>> };
>>
>> was exactly the same as this:
>>
>> struct foo {
>>    int a;
>>    char b;
>>    ... more fields ...
>> } __attribute__((packed));
>>
>> but it is not, in a subtle way.
>>
>
> The same code is generated. [...]

I don't think so.  Example:

struct test {
   int a __attribute__((packed));
   int b __attribute__((packed));
};

char c = 1;
struct test t = { .a=2, .b=3 };

$ arm-linux-gnu-gcc -O2 -S -W -Wall test1.c

	.file	"test2.c"
	.global	c
	.data
	.type	c, %object
	.size	c, 1
c:
	.byte	1
	.global	t
	.align	2               <<<<<<<<===== t is aligned
	.type	t, %object
	.size	t, 8
t:
	.word	2
	.word	3
	.ident	"GCC: (GNU) 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)"


Compare with:

struct test {
   int a;
   int b;
} __attribute__((packed));

char c = 1;
struct test t = { .a=2, .b=3 };

$ arm-linux-gnu-gcc -O2 -S -W -Wall test2.c

	.file	"test1.c"
	.global	c
	.data
	.type	c, %object
	.size	c, 1
c:
	.byte	1
	.global	t                    <<<<<<  "align" has gone, t is unaligned
	.type	t, %object
	.size	t, 8
t:
	.4byte	2
	.4byte	3
	.ident	"GCC: (GNU) 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)"



Phil.





