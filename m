Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbRFYBAZ>; Sun, 24 Jun 2001 21:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265833AbRFYBAP>; Sun, 24 Jun 2001 21:00:15 -0400
Received: from sncgw.nai.com ([161.69.248.229]:18883 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265828AbRFYBAC>;
	Sun, 24 Jun 2001 21:00:02 -0400
Message-ID: <XFMail.20010624180312.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sun, 24 Jun 2001 18:03:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: Collapsing RT signals ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm making some test with RT signals and looking at how they're implemented
inside the kernel.
After having experienced frequent queue overflow signals I looked at how
signals are queued inside the task_struct.
There's no signals optimization inside and this make the queue length depending
on the request rate instead of the number of connections.
It can happen that two ( or more ) POLL_IN signals are queued with a single
read() that sweep the buffer leaving other signals to issue reads ( read this
as user-mode / kernel-mode switch ) that will fail due lack of data.
So for every "superfluous" signal we'll have two user-mode / kernel-mode
switches, one for signal delivery and one for a failing read().
I'm just thinking at a way to optimize the signal delivery that is ( draft ) :


struct sigqueue {
        struct sigqueue *next;
        struct sigqueue **fsig;
        siginfo_t info;
};


struct fown_struct {
        int pid;                /* pid or -pgrp where SIGIO should be sent */
        uid_t uid, euid;        /* uid/euid of process setting the owner */
        int signum;             /* posix.1b rt signal to be delivered on IO */
        struct sigqueue *sig_hint;
};



At the end we'll have ( where fsig = &file->fown.sig_hint ) :


static int send_signal_hint(int sig, struct siginfo *info,
        struct sigpending *signals, struct sigqueue **fsig) {

        if (*fsig != NULL)
                merge_info(&(*fsig)->info, info);
        else {
                *fsig = allog_sig_queue();

                (*fsig)->fsig = fsig;

                copy_info(&(*fsig)->info, info);

                ...
                add-to-queue();
                ...
        }

        ...

}


When the message is delivered we'll have :

void clean_sig_hint(struct sigqueue *qsig) {

        if (qsig->fsig != NULL) {
                *(qsig->fsig) = NULL;
                qsig->fsig = NULL;
        }

}


When the file is closed :

void clean_fown_sighint(struct fown_struct *fown) {

        if (fown->sig_hint != NULL) {
                fown->sig_hint->fsig = NULL;
                fown->sig_hint = NULL;
        }

}


All these ops must be done under  sigmask_lock  lock ( send_signal() and signal
dequeue already does ).
This will make multiple signal from the same file to be stocked inside the same
slot reducing the RT signal traffic.

Comments ?






- Davide

