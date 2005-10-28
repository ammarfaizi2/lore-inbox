Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVJ1KRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVJ1KRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbVJ1KRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:17:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:57515 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932237AbVJ1KR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:17:29 -0400
Subject: Re: [PATCH] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
In-Reply-To: <1130491147.2800.15.camel@laptopd505.fenrus.org>
References: <1130489713.10680.685.camel@stark>
	 <1130491147.2800.15.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 03:03:18 -0700
Message-Id: <1130493798.10680.750.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 11:19 +0200, Arjan van de Ven wrote:
> On Fri, 2005-10-28 at 01:55 -0700, Matt Helsley wrote:
> 
> > +void proc_fork_connector(struct task_struct *task)
> > +{
> > +	struct cn_msg *msg;
> > +	struct proc_event *ev;
> > +	__u8 buffer[CN_PROC_MSG_SIZE];
> 
> do you really want to do this stack based?

	cn_netlink_send() performs an skb_alloc() and I wanted to avoid doing
two allocations that might sleep. 

	On a 32-bit machine the buffer should be around 42 bytes, making the
function locals around 50 bytes. On a 64-bit machine I believe this
should be around 58 bytes. Is this generally considered to be too large?

These functions are called from:

fork:

-> do_fork -> copy_process -> proc_fork_connector -> ...
-> fork_idle (this holds a struct ptregs) -> copy_process ->
proc_fork_connector -> ...

exec:

-> do_execve -> search_binary_handler -> proc_exec_connector -> ...

id:

-> sys_set(r|e|s|fs)?[ug]id -> proc_id_connector -> ...

exit:

-> do_exit -> proc_exit_connector -> ...

	Where "-> ..." signifies a call to cn_netlink_send(). So they should
only be a problem if a caller or cn_netlink_send() use too much stack
space.

Cheers,
	-Matt Helsley
	< matthltc @ us.ibm.com >

