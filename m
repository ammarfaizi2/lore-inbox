Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161509AbWJLGHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161509AbWJLGHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161531AbWJLGHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:07:40 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:55225 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1161509AbWJLGHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:07:40 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] fdtable: Eradicate fdarray overflow.
Date: Wed, 11 Oct 2006 23:07:38 -0700
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200610111958.03238.vlobanov@speakeasy.net> <452DD058.7000301@cosmosbay.com>
In-Reply-To: <452DD058.7000301@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610112307.38485.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 22:19, Eric Dumazet wrote:
> Hi Vadim
>
> I find your PAGE_SIZE/4 minimum allocation quite unjustified.
>
> For architectures with 64K PAGE_SIZE, we endup allocating 16K, for poor
> tasks that happen to touch a not so high (>= 64) file descriptor...
>
> I would vote for a fixed size, like 1024

In my opinion, always picking 1024 would be highly suboptimal for some 
architectures (x86-64 in particular -- that's a whole page, just for the 
fdarray!). If anything, I'd prefer something similar to this pseudo-code:

#define FDTABLE_MIN min_t(uint, PAGE_SIZE / 4 / sizeof(struct file *), 1024)
...
nr /= FDTABLE_MIN;
nr = roundup_pow_of_two(nr + 1);
nr *= FDTABLE_MIN;

gcc should be smart enough to optimize that expression into a single constant. 
At least it did (version 4.1.0) in my quick test here.

> Eric

Let me know what you think. Please don't just go radio-silent on me. ;)

-- Vadim Lobanov
