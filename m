Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWHaVFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWHaVFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWHaVFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:05:52 -0400
Received: from mx.delair.de ([62.80.31.6]:6600 "EHLO mx.delair.de")
	by vger.kernel.org with ESMTP id S1751244AbWHaVFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:05:51 -0400
From: Andreas Hobein <ah2@delair.de>
Reply-To: ah2@delair.de
Organization: delair Air Traffic Systems GmbH
To: linux-kernel@vger.kernel.org
Subject: Trouble with ptrace self-attach rule since kernel > 2.6.14
Date: Thu, 31 Aug 2006 23:05:47 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r809EmyG6ed6Tx5"
Message-Id: <200608312305.47515.ah2@delair.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_r809EmyG6ed6Tx5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi !

I have some trouble with the restriction of the ptrace functionality assu=
mably=20
introduced into the linux kernel =A0with the patch from 9. 11.2006=20
1105_2_ptrace-self-attach.patch.

My multithreaded application tries to write callstacks of all threads (so=
me=20
sort of built-in mini debugger) in case of abnormal situations or failure=
.=20
With the newer linux kernel (> 2.6.14) self-attaching to processes of the=
=20
same thread group does not work any longer. Any call to ptrace results in=
 a=20
EPERM result.

I have worked around this problem by first forking the process, than crea=
ting=20
the callstack output in the forked child process - which works without th=
e=20
above mentioned problem - and terminating the child process just after th=
is=20
operation.

Anyway this solution is somehow dirty and I would prefer the way it was=20
implemented before. My question is: Why may a sibling thread not=20
ptrace_attach another process of the same thread group, while at the same=
=20
time a forked child process of the same thread is allowed to do this=20
operation? Is there any replacement like pthread_suspend, which is availa=
ble=20
on other Unixes?

(A short program for the demonstration of this effect is attached. Use Op=
tion=20
-f to enable forking)

Best regards,

=A0=A0=A0=A0=A0=A0=A0=A0Andreas


--Boundary-00=_r809EmyG6ed6Tx5
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="trace.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trace.c"

// Build with:    gcc trace.c -o trace -lpthread
// Usage trace [-f ]    Option -f forks the tracing process before attaching to child thread

#include <stdio.h>
#include <errno.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <pthread.h>
#include <sys/syscall.h>
#include <unistd.h>

pthread_t threadPid=0;

void *threadFunc(void* dummy)
{

    threadPid=syscall(__NR_gettid);
    
    while(1)
    {
        printf("Thread is running with pid %d\n",threadPid);
	sleep(1);
    }
}

int main (int argc,char** argv)
{
    printf("Parent pid: %d\n",getpid());
    
    pthread_t thread;
    if (pthread_create(&thread, NULL, &threadFunc, NULL) == -1)
    {
	perror("pthread_create:");
	return 10;
    }

    sleep(1);
    
    pid_t childPid;
    
    if(argc==2 && strcmp(argv[1],"-f")==0 &&( childPid=fork()) > 0)
    {
        printf("Forking process for PTRACE_ATTACH, waitig for\n");
        int status;
        
        waitpid(childPid,&status,0);
        
        if( WIFEXITED(status) )
        {
            printf("Child terminated normally\n");
        }
        return 0;
    }
        
    printf("Tracing threadPid %d.\n",threadPid);

    if(ptrace(PTRACE_ATTACH,threadPid,NULL,NULL)!=-1)
    {
        int status;

        if(waitpid(threadPid, &status, WUNTRACED|__WALL) == threadPid)
        {
            if(ptrace(PTRACE_DETACH,threadPid,NULL,NULL)!=-1)
            {
                printf("Process %d attaching/detaching was sucessful!\n");
            }
            else
            {
                perror("PTRACE_ATTACH:");
            }
        }
        else
        {
            perror("waitthreadPid:");
            printf("status:%d errno:%d\n",status,errno);
        }

    }
    else
    {
        perror("PTRACE_ATTACH: ");
    }
    return 0;
}

--Boundary-00=_r809EmyG6ed6Tx5--
