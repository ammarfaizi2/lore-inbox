Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbULVA1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbULVA1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbULVA1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:27:13 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:17883 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261869AbULVA1A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:27:00 -0500
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F550846C103@srgraham.eng.emc.com>
From: "usvyatsky, ilya" <usvyatsky_ilya@emc.com>
To: linux-kernel@vger.kernel.org
Subject: A (dumb?) waitpid(2) question
Date: Tue, 21 Dec 2004 19:26:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-PMX-Version: 4.6.1.107272, Antispam-Core: 4.6.1.106808, Antispam-Data: 2004.12.21.31
X-PerlMx-Spam: Gauge=, SPAM=0%, Report='EMC_FROM_0 -0, __TLG_EMC_ENVFROM_0 0, __IMS_MSGID 0, __HAS_MSGID 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __MIME_VERSION 0, __ANY_IMS_MUA 0, __IMS_MUA 0, __HAS_X_MAILER 0, __CTYPE_CHARSET_QUOTED 0, __CT_TEXT_PLAIN 0, __CT 0, __CTE 0, __FRAUD_419_BADTHINGS 0, __C230066_P5 0, __MIME_TEXT_ONLY 0, EMC_BODY_1 -5'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As dumb as it seems, I am seing a weird behavior on my RH3.0 box
(2.4.21-20.Elsmp kernel).

It looks like (contrary to the man page and POSIX .1) waitpid(2) does not
return upon a SIGALRM.

I am porting an old piece of Solaris userland code (stripped from all useful
functionality):

#include <sys/types.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/wait.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <unistd.h>

void sig_handler(int signal) 
{
    printf("Alarm!!!\n");
}

int main(int argc, char *argv[])
{
    int  child_pid = -1;
        
    child_pid = fork();
    if (child_pid < 0) {
	perror("cannot fork()");
	exit(1);
    }
    
    if (child_pid) {
	/* parent */
	int status = 0, timeout = 1;

	do {
	    printf("Parent: setting an alarm for %d seconds\n", timeout);

	    signal(SIGALRM, sig_handler);
	    alarm(timeout);

	    printf("Parent: waiting for a child %d\n", child_pid);
	    child_pid = waitpid(child_pid, &status, 0);

	    if (child_pid < 0) {
		if (errno == ECHILD) {
		    perror("Parent: waitpid");
		    exit(1);
		}
		if (errno == EINTR) {
		    printf("Parent: wait was interrupted by a signal");
		}
	    }
	} while (child_pid < 0);

	printf("Parent: child %d ", child_pid);
	
	if (WIFEXITED(status)) {
	    printf("terminated normally with status %d\n",  
                    WEXITSTATUS(status));
	}
	if (WIFSIGNALED(status)) {
	    printf("was killed by signal %d\n", WTERMSIG(status));
	}
    }
    else {
	/* child */
	int timeout = 6;
	
	printf("Child:  sleeping for %d seconds\n", timeout);
	sleep(timeout);
	printf("Child:  exiting\n");
	exit(0);
    }
    return 0;
}

Here is the original Solaris output:

Child:  sleeping for 6 seconds
Parent: setting an alarm for 1 seconds
Parent: waiting for a child 7187
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Child:  exiting
Parent: child 7187 terminated normally with status 0

And here's what Linux outputs:

Child:  sleeping for 6 seconds
Parent: setting an alarm for 1 seconds
Parent: waiting for a child 24282
Alarm!!!
Child:  exiting
Parent: child 24282 terminated normally with status 0

Is it a bug or a feature?
Any suggestions would be greatly appreciated...


Ilya Usvyatsky

	EMC²  		
where information lives

Phone:  508-249-1299


