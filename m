Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUE3M4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUE3M4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUE3M4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:56:16 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:35026 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263629AbUE3M4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:56:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired with a single array
Date: Sun, 30 May 2004 22:56:02 +1000
User-Agent: KMail/1.6.1
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40B81F24.9080405@bigpond.net.au> <200405292117.56089.kernel@kolivas.org> <40B92874.50009@bigpond.net.au>
In-Reply-To: <40B92874.50009@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405302256.02703.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004 10:19, Peter Williams wrote:
> Out of interest, what was the reason?  What problem were you addressing?

The interactive credit?

There was a problem with difficulty elevating back to interactive state if an 
interactive task had used too long a burst of cpu (ie Xfree) which was 
addressed by making the bonus pseudo-exponentially curved for rapid recovery 
and slow decay - in fact this is probably the most important part of 
addressing the interactive tasks and had the best effect. The problem was 
that giving this to all tasks meant that cpu bound tasks that had, as a 
property of their behaviour, long waits on say pipes or i/o would also get 
this rapid recovery to interactive state and as soon as they became fully 
bound to cpu again they would cause noticable stalls. The standard example is 
the increasing number of jobs in a make, where each job waits longer for i/o 
as the job numbers increase. However there were much worse examples at even 
normal - low loads, such as mpeg or divx encoding where the encoder would 
buffer say 250 frames sleeping and then do them in a burst. (this is the 
maximum space between key [I] frame or intervals). The interactive credit 
prevented those tasks that would have long but only infrequent sleeps from 
getting the curved bonus/penalty.

Hmm... if this is black magic I guess I'm breaking the magician's cardinal 
rules and revealing my tricks ;-)

Con
