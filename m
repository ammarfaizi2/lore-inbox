Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVJMXAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVJMXAs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVJMXAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:00:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964886AbVJMXAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:00:47 -0400
Date: Thu, 13 Oct 2005 16:00:10 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, vsu@altlinux.ru, laforge@gnumonks.org,
       linux-usb-devel@lists.sourceforge.net, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, greg@kroah.com, security@linux.kernel.org,
       zaitcev@redhat.com
Subject: Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing
 async USB via usbdevio
Message-Id: <20051013160010.7cc532ae.zaitcev@redhat.com>
In-Reply-To: <1127840281.10674.5.camel@localhost.localdomain>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
	<Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>
	<20050927160029.GA20466@master.mivlgu.local>
	<Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
	<1127840281.10674.5.camel@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 17:58:00 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-09-27 at 09:09 -0700, Linus Torvalds wrote:

> > > root-owned), then the urb completes, and kill_proc_info() sends the
> > > signal to the unsuspecting process.
> > 
> > Ehh.. pid's don't get re-used until they wrap.
> 
> Which doesn't take very long to arrange. Relying on pids is definitely a
> security problem we don't want to make worse than it already is. 

The whole application cannot exit and leave URBs running behind,
because usbdevio_release() blocks until they are terminated.
Only separate threads can exit.

So, the only thing a malicious user can do is something like this:
 - open /proc/bus/usb/BUS/DEV
 - submit URB
 - fork
 - exit parent thread
 - wait in the child until PIDs wrap very close to former parent
 - exit and hope that someone forks while the exit is processing

Right? But if so, why don't we do something like this:

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

This does not need to check any IDs, I think. Then we do not have to
ponder if effective or real is more appropriate, and if any sort of
new-fanged security thingies like capabilities apply.

-- Pete
