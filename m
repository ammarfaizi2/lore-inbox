Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUF1V5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUF1V5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUF1V5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:57:16 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:9362 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265237AbUF1V43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:56:29 -0400
Date: Mon, 28 Jun 2004 23:56:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Maurides <stud1313@di.uoa.gr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.x signal handler bug
Message-ID: <20040628215601.GD29901@wohnheim.fh-wedel.de>
References: <40DCBBC3.2010308@di.uoa.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40DCBBC3.2010308@di.uoa.gr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 June 2004 02:56:51 +0300, Paul Maurides wrote:
> 
> The bug has been reproduced successfully using the following program
> on kernel 2.6.5 and 2.6.7, and probably affects any other 2.6 kernel.

All, since about 2.5.71 or so.

> Kernel 2.4 produce the correct behavior, an endless loop of handled 
> signals, but on kernel 2.6 the program segfaults.

The program never returns from it's signal handler.  Instead, it
causes yet another segfault.  Any program stupid enough to cause a
segfault inside the segfault handler, should be killed.  Full stop.

> #include <signal.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <setjmp.h>
> 
> volatile int len;
> volatile int real;
> volatile int caught;
> jmp_buf env;
> 
> void catcher(int sig){
>    signal(SIGSEGV,catcher);
>    printf("requested: %9d malloced: %9d\n",len,real);
>    longjmp(env, 1);
> }
> 
> int main(){
>    char* p=0;
>    len = 0;
>    signal(SIGSEGV,catcher);
> 
>    setjmp(env);
>    len++;
>    free(p);
>    p = malloc(len);
>    real = 0;
>    while(1){
>        p[real] = 0;
>        real++;
>    }
>    return 0;
> }

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike
