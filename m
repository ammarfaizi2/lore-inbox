Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUFYX46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUFYX46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUFYX46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:56:58 -0400
Received: from mail3.vivodinet.gr ([80.76.39.13]:56481 "HELO mail.vivodinet.gr")
	by vger.kernel.org with SMTP id S266902AbUFYX44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:56:56 -0400
Message-ID: <40DCBBC3.2010308@di.uoa.gr>
Date: Sat, 26 Jun 2004 02:56:51 +0300
From: Paul Maurides <stud1313@di.uoa.gr>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.x signal handler bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bug has been reproduced successfully using the following program
on kernel 2.6.5 and 2.6.7, and probably affects any other 2.6 kernel.

Kernel 2.4 produce the correct behavior, an endless loop of handled 
signals, but on kernel 2.6 the program segfaults.

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <setjmp.h>

volatile int len;
volatile int real;
volatile int caught;
jmp_buf env;

void catcher(int sig){
    signal(SIGSEGV,catcher);
    printf("requested: %9d malloced: %9d\n",len,real);
    longjmp(env, 1);
}

int main(){
    char* p=0;
    len = 0;
    signal(SIGSEGV,catcher);

    setjmp(env);
    len++;
    free(p);
    p = malloc(len);
    real = 0;
    while(1){
        p[real] = 0;
        real++;
    }
    return 0;
}

PS. I'm not subscribed to this list, so please include me in the cc

