Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVJMX5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVJMX5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVJMX5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:57:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5865 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751132AbVJMX5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:57:08 -0400
Date: Thu, 13 Oct 2005 16:56:46 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, vsu@altlinux.ru, laforge@gnumonks.org,
       linux-usb-devel@lists.sourceforge.net, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, greg@kroah.com, security@linux.kernel.org,
       zaitcev@redhat.com
Subject: Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing
 async USB via usbdevio
Message-Id: <20051013165646.7845ebe8.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0510131611060.23590@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
	<Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>
	<20050927160029.GA20466@master.mivlgu.local>
	<Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
	<1127840281.10674.5.camel@localhost.localdomain>
	<20051013160010.7cc532ae.zaitcev@redhat.com>
	<Pine.LNX.4.64.0510131611060.23590@g5.osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2005 16:16:58 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> wrote:

> "release()" won't be called until the _last_ close, and the task that 
> opened the fd can certainly exit before that.
>[...]
> It's a fundamental mistake to think that file descriptors stay with the 
> process that opened them. 

I am quite aware and my proposal takes it into account. I am sorry that
I failed to explain it adequately.

Did you even look at the pseudocode though?

-- Pete

P.S.
submit_urb()
   as->pid = current->pid;
   as->tgid = current->tgid;
.....
async_complete()
   __kill_same_process(as->pid, as->tgid);

/* DO NOT USE IN DRIVERS (other than USB core) */
__kill_same_process(pid_t pid, pid_t tgid) {
   task_struct *we, *maybe_parent;
   lock(&tasklist_lock);
   we = find_task_by_pid(pid);
   maybe_parent = find_task_by_tgid(pid);
   if (maybe_parent != NULL && we->parent == maybe_parent)
      send_sig_info(sig, info, we);
   unlock(&tasklist_lock);
}
