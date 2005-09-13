Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVIMWyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVIMWyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVIMWyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:54:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932216AbVIMWyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:54:00 -0400
Date: Tue, 13 Sep 2005 15:53:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
In-Reply-To: <43273CB3.7090200@oberhumer.com>
Message-ID: <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org>
References: <43273CB3.7090200@oberhumer.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Markus F.X.J. Oberhumer wrote:
> 
> It seems that the current signal code always sets up a stack frame so that
> signal handlers are run with a somewhat mis-aligned stack, i.e. (esp % 8 == 4).

Actually, not really.

They get entered with the stack pointer aligned, at least in my tests.

	#include <stdio.h>
	#include <signal.h>
	#include <unistd.h>
	
	extern void handler(int);
	void *saved_esp;
	
	asm("handler: movl %esp,saved_esp; ret");
	
	int main(int argc, char **argv)
	{
	        signal(SIGALRM, handler);
	        alarm(1);
	        pause();
	        printf("%p\n", saved_esp);
	        return 0;
	}

always prints out an aligned address for me.

You seem to be expecting that the address be aligned "before the return 
address push", which is a totally different thing. Quite frankly, I don't 
know which one gcc prefers or whether there's an ABI specifying any 
preferences.

		Linus
