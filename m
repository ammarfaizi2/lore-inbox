Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVIMXYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVIMXYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVIMXYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:24:08 -0400
Received: from mail.servus.at ([193.170.194.20]:12039 "EHLO mail.servus.at")
	by vger.kernel.org with ESMTP id S932500AbVIMXYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:24:07 -0400
Message-ID: <4327611D.7@oberhumer.com>
Date: Wed, 14 Sep 2005 01:30:37 +0200
From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
References: <43273CB3.7090200@oberhumer.com> <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org>
X-no-Archive: yes
X-Oberhumer-Conspiracy: There is no conspiracy. Trust us.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 13 Sep 2005, Markus F.X.J. Oberhumer wrote:
> 
>>It seems that the current signal code always sets up a stack frame so that
>>signal handlers are run with a somewhat mis-aligned stack, i.e. (esp % 8 == 4).
> 
> Actually, not really.
> 
> They get entered with the stack pointer aligned, at least in my tests.
> 
> 	#include <stdio.h>
> 	#include <signal.h>
> 	#include <unistd.h>
> 	
> 	extern void handler(int);
> 	void *saved_esp;
> 	
> 	asm("handler: movl %esp,saved_esp; ret");
> 	
> 	int main(int argc, char **argv)
> 	{
> 	        signal(SIGALRM, handler);
> 	        alarm(1);
> 	        pause();
> 	        printf("%p\n", saved_esp);
> 	        return 0;
> 	}
> 
> always prints out an aligned address for me.
> 
> You seem to be expecting that the address be aligned "before the return 
> address push", which is a totally different thing. Quite frankly, I don't 
> know which one gcc prefers or whether there's an ABI specifying any 
> preferences.

I'm pretty sure that on both amd64 and i386 the alignment has to be 
_before_ the address push from the call, though I cannot find any exact ABI 
specs at the moment. Experts please advise.

What do you get when running this slightly modified version of your test 
program? My patch would fix the alignment of Aligned16 here.

And for amd64, please also see arch/x86_64/kernel/signal.c where 8 is 
subtracted from the get_stack() result. Actually I wonder if other archs 
might be affected as well...

~Markus


#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <assert.h>

typedef struct { double x,y; } Aligned16 __attribute__((__aligned__(16)));

void *saved_esp;
void handler(int unused) {
         Aligned16 a;
         assert(__alignof(a) >= 16),
         saved_esp = (void *) &a;
}

int main()
{
         Aligned16 a;
         assert(__alignof(a) >= 16),
         printf("%p\n", &a);
         signal(SIGALRM, handler);
         alarm(1);
         pause();
         printf("%p\n", saved_esp);
         return 0;
}


-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
