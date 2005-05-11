Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVEKLpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVEKLpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 07:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVEKLpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 07:45:13 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39301 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261380AbVEKLoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 07:44:54 -0400
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, aq <aquynh@gmail.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <1115647061.936.76.camel@localhost.localdomain>
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	 <1115644436.8540.83.camel@frecb000711.frec.bull.fr>
	 <1115647061.936.76.camel@localhost.localdomain>
Date: Wed, 11 May 2005 13:44:44 +0200
Message-Id: <1115811884.18689.32.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/05/2005 13:55:20,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/05/2005 13:55:24,
	Serialize complete at 11/05/2005 13:55:24
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 15:57 +0200, Alexander Nyberg wrote:
> > +static inline void cn_fork_send_status(void)
> > +{
> > +	/* TODO: An informational line in log is maybe not enough... */
> > +	printk(KERN_INFO "cn_fork_enable == %d\n", cn_fork_enable);
> > +}
> > +
> > +/**
> > + * cn_fork_callback - enable or disable the fork connector
> > + * @data: message send by the connector 
> > + *
> > + * The callback allows to enable or disable the sending of information
> > + * about fork in the do_fork() routine. To enable the fork, the user 
> > + * space application must send the integer 1 in the data part of the 
> > + * message. To disable the fork connector, it must send the integer 0.
> > + */
> > +static void cn_fork_callback(void *data) 
> > +{
> > +	struct cn_msg *msg = data;
> > +	int action;
> > +
> > +	if (cn_already_initialized && (msg->len == sizeof(cn_fork_enable))) {
> > +		memcpy(&action, msg->data, sizeof(cn_fork_enable));
> > +		switch(action) {
> > +			case FORK_CN_START:
> > +				cn_fork_enable = 1;
> > +				break;
> > +			case FORK_CN_STOP:
> > +				cn_fork_enable = 0;
> > +				break;
> > +			case FORK_CN_STATUS:
> > +				cn_fork_send_status();
> 
> Why does this not pass down the status to the app asking about it
> instead?

I don't know exactly how to do that. A solution could be to send a
message through the connector. I think about using the following
structure:

#define FORK_CN_MSG_P   0  /* Information is about processes */
#define FORK_CN_MSG_S   1  /* Information is about status */

/*
 * The fork connector sends information to a user-space
 * application. From the user's point of view, the process
 * ID is the thread group ID and thread ID is the internal
 * kernel "pid". So, fields are assigned as follow:
 *
 *  In user space     -  In  kernel space
 *
 * parent process ID  =  parent->tgid
 * parent thread  ID  =  parent->pid
 * child  process ID  =  child->tgid
 * child  thread  ID  =  child->pid
 */
struct cn_fork_msg {
        int type;       /* 0: information about fork     
                           1: information about the status */
        int cpu;        /* ID of the cpu where the fork occured */
        union {
                struct {
                        pid_t ppid;     /* parent process ID */
                        pid_t ptid;     /* parent thread ID  */
                        pid_t cpid;     /* child process ID  */
                        pid_t ctid;     /* child thread ID   */
                };
                int status;
        };
};

And then, the cn_fork_send_status() could be coded as follow:

/**
 * cn_fork_send_status - send a message with the status
 */
static inline void cn_fork_send_status(void)
{
        struct cn_msg *msg;
        struct cn_fork_msg *forkmsg;
        __u8 buffer[CN_FORK_MSG_SIZE];

        msg = (struct cn_msg *)buffer;

        memcpy(&msg->id, &cb_fork_id, sizeof(msg->id));

        msg->ack = 0;   /* not used */
        msg->seq = 0;   /* not used */

        msg->len = CN_FORK_INFO_SIZE;
        forkmsg = (struct cn_fork_msg *)msg->data;
        forkmsg->type = FORK_CN_MSG_S;
        forkmsg->status = cn_fork_enable;

        cn_netlink_send(msg, CN_IDX_FORK, GFP_KERNEL);
}

I think this solution is good. Agree?

Best,
Guillaume.

