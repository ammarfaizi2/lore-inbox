Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWGGJ6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWGGJ6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWGGJ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:58:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23066 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932101AbWGGJ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:58:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:organization:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=qpYalJPdRsQM7StIdHGqIdSWbhoJaHcl2yjsWBlm6BKXKpnyEvXvdoGE4cWxLzldZ8wXJhZySxOUcNIuDE0menGcQBBaN7p0bOt5csVv9q80H2FiroLQqstpYIGj4auco6lFGhiC7psZqeVl5heJeuSvNeIkkUUybbtx4Vfiao0=
Message-ID: <44AE3188.6000304@innomedia.soft.net>
Date: Fri, 07 Jul 2006 15:33:52 +0530
Reply-To: chinmaya@innomedia.soft.net
Organization: Innomedia Technologies Pvt. Ltd.
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Enabling message queue in 2.6.10 kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Chinmaya Mishra <chinmaya4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I am trying for message queue in linux-2.6.10 kernel.
I export sys_msgget(), sys_msgctl(), sys_msgsnd() and sys_msgrcv() in
the kernel with following EXPORT_SYMBOL(sys_msgget) and so on.
Then compile the kernel, boot with the new image.

My code is like this.
#include <linux/module.h>
#include <linux/kernel.h>

#include <linux/types.h>
#include <linux/ipc.h>
#include <linux/msg.h>
#include <linux/syscalls.h>

#include <asm/system.h>

int msqid, ret;
/* this is the thread function that we are executing */
void mymsgSend(void)
{
        struct msgbuf sbuf;
        printk("Start send message \n");
        memset(&sbuf, '\0', sizeof(sbuf));
        if((msqid = sys_msgget((key_t)1234, 0666 | IPC_CREAT )) < 0) {
                printk("Err: sys_msgget \n");
                return ;
        }
        sbuf.mtype = 1;
        //sprintf(sbuf.mtext,"a");
        ret = sys_msgsnd(msqid, &sbuf, sizeof(sbuf), IPC_NOWAIT);
        printk("Send ret = %d \n", ret);
        if (ret < 0) {
                printk("Err: sys_msgsnd \n");
                return ;
        }
        return ;
}

void mymsgRecv(void)
{
        int msqid;
        struct msgbuf rbuf;
        printk("Start recv message  \n");
        memset(&rbuf, '\0', sizeof(rbuf));
        if ((msqid = sys_msgget((key_t)1234, 0666)) < 0) {
                printk("Err: sys_msgget \n");
                return ;
        }
        rbuf.mtype = 1;
        ret = sys_msgrcv(msqid, (struct msgbuf *)&rbuf, sizeof(rbuf), 
rbuf.mtype, IPC_NOWAIT);
        printk("Recv ret = %d \n", ret);
        if (ret < 0) {
                printk("Err: sys_msgrcv \n");
                return ;
        }
        printk("Mesg Recv = %s \n", rbuf.mtext);
        return;
}

/* load the module */
int init_module(void)
{
              mymsgSend();
              msleep(1000);
              mymsgRecv();
        }
        return(0);
}

/* remove the module */
void cleanup_module(void)
{
        printk("Stop Kernel Thread \n");
        sys_msgctl(msqid, IPC_RMID, NULL);
        return;
}


But the out put messages in # dmesg <enter> is like this

Start send message
Send ret = -14
Err: sys_msgsnd
Start recv message
Recv ret = -42
Err: sys_msgrcv
Stop Kernel Thread

Is there any thing I am missing. Please help soon.


With Regards,
Chinmaya.
