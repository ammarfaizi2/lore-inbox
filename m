Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265307AbRFVBn4>; Thu, 21 Jun 2001 21:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265308AbRFVBnr>; Thu, 21 Jun 2001 21:43:47 -0400
Received: from sncgw.nai.com ([161.69.248.229]:24734 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265307AbRFVBnd>;
	Thu, 21 Jun 2001 21:43:33 -0400
Message-ID: <XFMail.20010621184645.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Thu, 21 Jun 2001 18:46:45 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: About I/O callbacks ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was just thinking to implement I/O callbacks inside the kernel and test which
kind of performance could result compared to a select()/poll() implementation.
I prefer IO callbacks against async-io coz in this way is more direct to
implement an I/O driven state machine + coroutines.
This is a first draft :



#define ASCB_INFO_NPARAMS 4

struct ascb_info {
        unsigned long param[ASCB_INFO_NPARAMS];
};

struct iocb {
        struct iocb * next;
        struct task_struct * task;
        unsigned long event;
        int (*iocb_func)(struct ascb_info *, void *);
        void * data;
};

struct ascb {
        struct ascb * next;
        int (*ascb_func)(struct ascb_info *, void *);
        void * data;
        struct ascb_info info;
};





struct task_struct {
        ...
        struct ascb * ascb_list;
        spinlock_t ascb_list_lock;
        ...
};


struct file {
        ...
        struct iocb * iocb_list;
        spinlock_t iocb_list_lock;
        ...
};




The user call some user-space api to add the callback to the fd and this will
result ( inside the kernel ) to a call to :



int iocb_file_add(struct file * file,
                int (*iocb_func)(struct ascb_info *, void *), void * data,
                unsigned long event) {

/*
 *  Add the callback to the file list with task = current
 */


}



This is used to add callbacks to the task's list :

int ascb_task_add(struct task_struct * task,
                int (*ascb_func)(struct ascb_info *, void *),
                void * data, struct ascb_info * info) {

/*
 *  Add the callback to the task list
 */

}




Low level I/O layers will call this to dispatch I/O events :


int iocb_file_dispatch(struct file * file, unsigned long event) {

/*
 *  Scan the iocb_list and ( if event match ) call ascb_task_add()
 *  and remove ( y/n ? ) the callback from iocb_list
 */


}




In entry.S we'll have a call like do_signal() that will build the frame for a
callback call ( like do_signal() ) and will remove the entry from the list.
My first implementation should address only sockets but once the concept of
async callbacks is inside the task_struct this could be gradually extended to
std files and even used as an extension of signals.

Comments ?





- Davide


