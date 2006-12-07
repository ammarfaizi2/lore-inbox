Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032239AbWLGOD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032239AbWLGOD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032240AbWLGOD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:03:28 -0500
Received: from smtpout.mac.com ([17.250.248.176]:50780 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032239AbWLGOD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:03:27 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEMLABAC.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKKEMLABAC.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A1480C13-162B-4593-A378-05FE43D1D0D2@mac.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       schwab@suse.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Thu, 7 Dec 2006 09:02:36 -0500
To: davids@webmaster.com
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-07_03:2006-12-06,2006-12-07,2006-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0611300000 definitions=main-0612070011
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for the late response, I've had a lot on my schedule  
over the last week.

On Dec 02, 2006, at 23:29:28, David Schwartz wrote:
>>> It comes down to just what those guarantees GCC provides actually  
>>> are.
>
>> This is the first correct statement in your email.  In any case  
>> the documented GCC guarantees have always been much stronger than  
>> you have been trying to persuade us they should be.  I would argue  
>> that the C standard somewhat indirectly specifies those guarantees  
>> but I really don't have the heart for any more language-lawyering  
>> so I'm going to leave it at that.
>
> I have tried to find any documentation of the guarantees gcc  
> actually provides and have been unable to do so. Where are these  
> "documented GCC guarantees" documented?

Well, under "When is a Volatile Object Accessed" in the GCC manual  
(seems to be present for at least a few versions back):
http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Volatiles.html#Volatiles

In that case it specifies that any evaluation of "*foo" in an rvalue  
context specifies a read (with a few exceptions for G++ where the C++  
language generally confuses things).  Specifically it mentions the  
statement "*src;" and discusses the statement as providing "a void  
context".  In other words, a statement such as "(void)(expr);" is  
redundant because the statement already implies void context and the  
extra cast-to-void is just extra text.  As such "(void)(*src);" on a  
"volatile int *src;" is documented to force a read of "*src".  Now,  
if you actually _use_ the result over just casting it to void and  
discarding it, then GCC can provide no _less_ guarantee with regards  
to the read-and-store than it provides to the read-and-discard.

For example:

/* This code is guaranteed to generate assembly to read the memory  
address into a register multiple times */
volatile int *foo = (expression);
*foo;
*foo;

/* This code is guaranteed to do the same */
volatile int *foo = (expression);
int x, y;
x = *foo;
y = *foo;

If the result is actually the conditional expression for a loop as in  
the problem code then GCC would plainly have no choice about  
optimizing, not only is the volatile variable read and returned, but  
the result is the conditional for continued execution of a block of  
code with unknown side effects.

Cheers,
Kyle Moffett

