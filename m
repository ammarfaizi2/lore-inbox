Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVCVUpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVCVUpB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVCVUoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:44:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14469 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261942AbVCVUmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:42:51 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Ram <linuxram@us.ibm.com>
To: johnpol@2ka.mipt.ru
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050322232524.67bf5054@zanzibar.2ka.mipt.ru>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	 <1111438349.5860.27.camel@localhost>
	 <1111475252.8465.23.camel@frecb000711.frec.bull.fr>
	 <1111515979.5860.57.camel@localhost>
	 <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
	 <1111519086.5860.80.camel@localhost>
	 <20050322232524.67bf5054@zanzibar.2ka.mipt.ru>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1111524168.5860.109.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Mar 2005 12:42:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 12:25, Evgeniy Polyakov wrote:
> On Tue, 22 Mar 2005 11:18:07 -0800
> Ram <linuxram@us.ibm.com> wrote:
> 
> > > I still do not see why it is needed.
> > > Super-user can run ip command and turn network interface off
> > > not waiting while apache or named exits or unbind.
> > > 
> > > In theory I can create some kind of userspace registration mechanism,
> > > when userspace application reports it's pid to the connector, 
> > > and then it sends data to the specified pids, but does not 
> > > allow controlling from userspace.
> > > But I really do not think it is a good idea to permit
> > > non-priviledged userspace processes to know about deep
> > > kernel internals through connector's messages.
> > 
> > Yes. non-priviledged userspace processes should not know
> > any deep kernel internals through connector events.
> > 
> > I think what I am driving at is, an application that is critically
> > dependent on the fork-notification, suddenly stops receiving such
> > notification because some other application has switched off the 
> > service without its notice. 
> > 
> > the reason I am concerned is I am planning to feed this fork-events
> > to my in-kernel module. Side note: I would really like support for
> > in-kernel listners through connector infrastructure.
> 
> fork connector can be extended to send to the rest of the world
> information that it was turned off or on.

This will support the paradigm: "Let me know if this is switched off,
and I don't mind any arbitrary process switching it off".  No
applications can seriously rely on this service, because there is this
*arbritray-application-being-able-to-control* component to it.

A ideal paradigm would be: "Don't switch it off, without my consent".
Essentially this will give applications enough confidence to rely on it
seriously.

However an inbetween paradigm that would acceptable is:
"Let me know if this is swtiched off provided only application that I
can trust-on has the power to manage it".

To me 2nd or 3rd paradigm seems acceptable, but not the 1st.

> 
> The easiest way to listen inside the kernel for connector's 
> notifications is creating appropriate socket in userspace
> and then obtain it through the following code which must be
> run in context of the process that created above socket:
> 
> 	struct file *file;
> 	struct inode *inode;
> 	int err = 0;
> 	
> 	file = fget(userspace_socket_number_in_the_current_process_context);
> 	if (!file) {
> 		return -ENODEV;
> 	}
> 	inode = file->f_dentry->d_inode;
> 	if (inode->i_sock) {
> 		sock = SOCKET_I(inode);
> 		err = 0;
> 	} else {
> 		fput(file);
> 		err = -ENODEV;
> 	}
> 
> sock is struct sock, which then can be used for read/write
> operations using 
> kernel_recvmsg(sock, &msg, &iov, 1, size, 0);
> kernel_sendmsg(sock, &msg, &iov, 1, size);
> 
> with the following initialisation:
> 
> sock->sk->sk_allocation |= GFP_NOIO;
> iov.iov_base = buf;
> iov.iov_len = size;
> msg.msg_name = NULL;
> msg.msg_namelen = 0;
> msg.msg_control = NULL;
> msg.msg_controllen = 0;
> msg.msg_namelen = 0;
> msg.msg_flags = msg_flags | MSG_NOSIGNAL;
> 

right. thanks for the code snippet. I should be coding something
around these lines.
> 
> Of course it can be done directly from kernelspace without
> touching process's structures, but this way is easier.

Thanks,
RP

> 
> > RP
> 
> 	Evgeniy Polyakov
> 
> Only failure makes us experts. -- Theo de Raadt

