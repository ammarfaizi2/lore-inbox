Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVBOM6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVBOM6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVBOM6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:58:52 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:56775 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261713AbVBOM6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:58:20 -0500
X-ME-UUID: 20050215125817862.D2A911C001FD@mwinf0307.wanadoo.fr
Message-ID: <4211F1F4.1070806@wanadoo.fr>
Date: Tue, 15 Feb 2005 13:58:28 +0100
From: Yves Crespin <crespin.quartz@wanadoo.fr>
Organization: Quartz
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Yves Crespin <Crespin.Quartz@Wanadoo.fr>
Subject: sigwait() and 2.6
References: <20050215031441.EFABE1DDFE@X31.nui.nul> <1108471847.10281.3.camel@gaston>
In-Reply-To: <1108471847.10281.3.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------010404000908010003050007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010404000908010003050007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Going on a 2.6 kernel, I have a trouble with sigwait()

When I send a kill to this program, the exit code is 143 (signal 15 and 
core)!

Is there a workaround ?

Thanks,

Yves

gcc -g -Wall -D_REENTRANT=1 -D_THREAD_SAFE=1 s.c -lpthread -o s

/===== début du code =====/

#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <pthread.h>

typedef    void Sigfunc(int);

#define ThreadBlockSignal()    ThreadSignalAction(SIG_BLOCK)
#define ThreadUnblockSignal()    ThreadSignalAction(SIG_UNBLOCK)

/*----------STATIC------------------*/
extern void ThreadSignalAction(const int how)
{
   sigset_t    newmask;

   if (sigemptyset(&newmask)<0){
       printf("sigemptyset failed");
       return;
   }
   if (sigaddset(&newmask,SIGTERM)<0){
       printf("sigaddset failed");
       return;
   }
   if (pthread_sigmask(how,&newmask,NULL)){
       printf("pthread_sigmask SIG_BLOCK failed");          return;
   }
}

extern Sigfunc * signal_intr(int signo,Sigfunc *func)
{
   struct sigaction    act, oact;

   act.sa_handler = func;
   sigemptyset(&act.sa_mask);
   act.sa_flags = 0;
   if (signo == SIGALRM){
#ifdef SA_INTERRUPT
       act.sa_flags |= SA_INTERRUPT;    /* Interrupt mode */
#endif /* SA_INTERRUPT */
   }else{
#ifdef SA_RESTART
       /*
        * automatic restart of interrupted system calls except
        * if they are operating on a slow device.
        * For select():
        * Under BSD, even if SA_RESTART is specified, select() was
        * never restarted.
        * Under SVR4, if SA_RESTART is specified, even select() and
        * pool() are automatically restarted.
        */
       act.sa_flags |= SA_RESTART;
#endif /* SA_RESTART */
       if (signo == SIGCHLD){
           act.sa_flags |= SA_NOCLDSTOP; /* Don't send SIGCHLD when 
children stop*/
       }
   }

#ifdef SA_RESETHAND
   act.sa_flags &= ~SA_RESETHAND;    /* signal handle remains installed */
#endif /* SA_RESETHAND */
   if (sigaction(signo, &act, &oact) < 0){
       return(SIG_ERR);
   }
   return(oact.sa_handler);
}

extern int WaitSignal(void)
{
   sigset_t    newmask;
   int        ret;
   int        sig;

   if (sigemptyset(&newmask)<0){
       printf("sigemptyset failed");
       return -1;
   }
   if (sigaddset(&newmask,SIGTERM)<0){
       printf("sigaddset failed");
       return -1;
   }
   printf("Waiting signal ..."); fflush(stdout);
   ret = sigwait(&newmask,&sig);
   if (ret!=0){
       printf("WaitSignal: sigwait failed %d",ret);
   }else{
       printf("WaitSignal: sigwait sig %d",sig);
   }
   return sig;
}

int main(int argc,char * const argv[])
{
   if (signal_intr(SIGTERM,SIG_DFL) == SIG_ERR){
       printf("signal %d (set handle) failed",SIGTERM);
   }

   /* -- Main loop */
   printf("%lu ready ...",(unsigned long)getpid()); fflush(stdout);
       int    signo;

       ThreadUnblockSignal();
       signo = WaitSignal();
       ThreadBlockSignal();
       if (signo==SIGTERM){
           printf("\nSIGTERM in main\n"); fflush(stdout);
       }else{
           printf("\n%d in main\n",signo); fflush(stdout);
       }
   return 0;
}

/===== fin du code =====/


--------------010404000908010003050007
Content-Type: text/x-vcard; charset=utf-8;
 name="crespin.quartz.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="crespin.quartz.vcf"

begin:vcard
fn:Yves Crespin
n:Crespin;Yves
org:Quartz
adr:Hameau du Pra - CIDEX 322;;39, rue Victor Hugo;CROLLES;;38920;France
email;internet:Crespin.Quartz@Wanadoo.fr
tel;work:04.76.92.21.91
tel;cell:06.86.42.86.81
x-mozilla-html:FALSE
url:http://crespin.quartz.free.fr/
version:2.1
end:vcard


--------------010404000908010003050007--

