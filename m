Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUFZQFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUFZQFn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267178AbUFZQFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:05:43 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:58561 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267180AbUFZQFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:05:37 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 26 Jun 2004 09:05:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Steve G <linux_4ever@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x signal handler bug
In-Reply-To: <20040626143326.50865.qmail@web50607.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0406260839460.10038@bigblue.dev.mdolabs.com>
References: <20040626143326.50865.qmail@web50607.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004, Steve G wrote:

> Hi,
> 
> I looked at the test program and do not see anything wrong with the code.
> Contrary to what's already been said in this thread, sigsetjmp/siglongjmp only
> differ in that they restore the signal context. This should never cause a
> segfault. 
> 
> Regarding re-entrancy, longjmp is stated as one of only 2 ways to exit signal
> handlers. Also, while the printf is not signal safe, it is not your problem
> either. BTW, this mechanism is used by some servers to prevent crashes even in
> the face of big problems. xinetd for one does this...so its important to have
> working.
> 
> I ran the test program on my machine under 2.4 and all works as expected. Under
> 2.6, it definitely segfaults. I tried using Electric Fence and valgrind to trap
> the error. Neither one could.
> 
> In summary, the program is valid and real world servers do this kind of thing. It
> does segfault under 2.6.

You're receiving a SIGSEGV while SIGSEGV is blocked (force_sig_info). The 
force_sig_info call wants to send a signal that the task can't refuse 
(kinda The GodFather offers ;). The kernel will noticed this and will 
restore the handler to SIG_DFL. All three examples below works fine on 2.6.



- Davide


--------------------------------------------------------------------
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <setjmp.h>

volatile int len;
volatile int real;
volatile int caught;
jmp_buf env;

void catcher(int sig){
        signal(SIGSEGV, catcher);
        printf("requested: %9d malloced: %9d\n",len,real);
        longjmp(env, 1);
}

int main(){
        char* p=0;
        sigset_t m;
        len = 0;
        sigemptyset(&m);
        sigaddset(&m, SIGSEGV);
        signal(SIGSEGV, catcher);
        setjmp(env);
        sigprocmask(SIG_UNBLOCK, &m, NULL);
        printf("len %d\n", len);
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

--------------------------------------------------------------------
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <setjmp.h>

volatile int len;
volatile int real;
volatile int caught;
jmp_buf env;

void catcher(int sig){
        signal(SIGSEGV, catcher);
        printf("requested: %9d malloced: %9d\n",len,real);
        siglongjmp(env, 1);
}

int main(){
        char* p=0;
        len = 0;
        signal(SIGSEGV, catcher);
        sigsetjmp(env, 1);
        printf("len %d\n", len);
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


--------------------------------------------------------------------
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <setjmp.h>

volatile int len;
volatile int real;
volatile int caught;
jmp_buf env;

void catcher(int sig){
        printf("requested: %9d malloced: %9d\n",len,real);
        longjmp(env, 1);
}

int main(){
        char* p=0;
        struct sigaction act;

        len = 0;
        act.sa_handler = catcher;
        act.sa_flags = SA_NODEFER;
        sigaction(SIGSEGV, &act, NULL);

        setjmp(env);
        printf("len %d\n", len);
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


