Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbTE1Q3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbTE1Q3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:29:35 -0400
Received: from watch.techsource.com ([209.208.48.130]:14228 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264795AbTE1Q3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:29:32 -0400
Message-ID: <3ED4E8E6.8060400@techsource.com>
Date: Wed, 28 May 2003 12:50:46 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Nikita Danilov <Nikita@namesys.com>,
       Nick Piggin <piggin@cyberone.com.au>, elladan@eskimo.com,
       Rik van Riel <riel@imladris.surriel.com>,
       David Woodhouse <dwmw2@infradead.org>, ptb@it.uc3m.es,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       root@chaos.analogic.com
Subject: Re: recursive spinlocks. Shoot.
References: <PEEPIDHAKMCGHDBJLHKGMEMJCMAA.rwhite@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone's probably already suggested this, but here goes...

If you REALLY have places where multiple levels may try to grab the same 
spinlock, and you would therefore have lock contention with yourself, 
why not just use multiple spinlocks?  So if you often call B(), which 
grabs lock X, but sometimes you call A() which also needs lock X, but 
A() calls B() which therefore causes self contention, why not have A() 
use lock Y instead?  Treat what A() uses as a separate resource?  Or 
here's another idea:  Why not have A() unlock before calling B()?

Oh, and there's the obvious idea of passing parameters around which 
indicate whether or not a lock has been taken, although that's certainly 
a pain.

I do see some value in tracking lock ownership.  But what do you do 
about the unlocks?  Do you keep a refcount and unlock when it reaches 
zero?  Now, not only do you have to deal with locks across function 
calls, but you have to make sure everything unravels properly.  Sounds 
difficult.

