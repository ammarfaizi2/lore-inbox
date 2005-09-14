Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVINRBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVINRBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVINRBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:01:43 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:7796 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030285AbVINRBm (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:01:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VvCLBxcE6O4rn+2Qn7AhebfX8nOdpiPxmWrsNS//RQroCSor0T8PVWoeID5LmtUeVil9XEyj+5aqasVs+Klufto3n1J/mRmo4a/K38ity+DcQ0BqwsYBv/CSjAU20XpKXtb+28a6Trpm+kyolV9AK4/4ISmxbr2kICN7FfJzakc=  ;
Message-ID: <43285374.3020806@yahoo.com.au>
Date: Thu, 15 Sep 2005 02:44:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <Pine.LNX.4.61.0509141814220.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509141814220.3743@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Sep 2005, Nick Piggin wrote:
> 
> 
>>Also needs work on those same architectures. Other architectures
>>might want to look at providing a more optimal implementation.
> 
> 
> IMO a rather pointless primitive, unless there is a cpu architecture which 
> has a inc_not_zero instruction, otherwise it will always be the same as 
> using cmpxchg.
> 

It will always be *implemented* with cmpxchg you mean, which is a
bit different. But even then, no, you definitely don't need an
inc_not_zero instruction to make this primitive faster than the
cmpxchg version. Just look at all the !SMP architectures that just
turn off interrupts while doing the op. Look at the architectures
that use hashed spinlocks.

Or here is possible pseudo code for an architecture with ll/sc
instructions:

   do {
     tmp = load_locked(v);
     if (!tmp)
       break;
     tmp++;
   } while (!store_cond(v, tmp));

   return tmp;

As opposed to using the cmpxchg version, which would have more
loads and conditional branches, AFAIKS.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
