Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSGGWsq>; Sun, 7 Jul 2002 18:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSGGWsp>; Sun, 7 Jul 2002 18:48:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4300 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316609AbSGGWsm>;
	Sun, 7 Jul 2002 18:48:42 -0400
Message-ID: <3D28C3F0.7010506@us.ibm.com>
Date: Sun, 07 Jul 2002 15:42:56 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44.0207071551180.10105-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:

 >> "As long as I comment [and understand] why I am using the BKL."
 >> would be a bit more accurate.  How many places in the kernel have
 >> you seen comments about what the BKL is actually doing?  Could
 >> you point me to some of your comments where _you_ are using the
 >> BKL?  Once you fully understand why it is there, the extra step
 >> of removal is usually very small.
 >
 > Old Blue, could you please bring me an example on where in USB the
 > bkl shouldn't be used, but is?  And can you explain why it's wrong
 > to use bkl there?

Old Blue?  23 isn't _that_ old!

BKL use isn't right or wrong -- it isn't a case of creating a deadlock 
or a race.  I'm picking a relatively random function from "grep -r 
lock_kernel * | grep /usb/".  I'll show what I think isn't optimal 
about it.

"up" is a local variable.  There is no point in protecting its 
allocation.  If the goal is to protect data inside "up", there should 
probably be a subsystem-level lock for all "struct uhci_hcd"s or a 
lock contained inside of the structure itself.  Is this the kind of 
example you're looking for?

  static int uhci_proc_open(struct inode *inode, struct file *file)
  {
         const struct proc_dir_entry *dp = PDE(inode);
         struct uhci_hcd *uhci = dp->data;
         struct uhci_proc *up;
         unsigned long flags;
         int ret = -ENOMEM;

-       lock_kernel();

         up = kmalloc(sizeof(*up), GFP_KERNEL);
         if (!up)
                 goto out;

         up->data = kmalloc(MAX_OUTPUT, GFP_KERNEL);
         if (!up->data) {
                 kfree(up);
                 goto out;
         }

+       lock_kernel();
         spin_lock_irqsave(&uhci->frame_list_lock, flags);
         up->size = uhci_sprint_schedule(uhci, up->data, MAX_OUTPUT);
         spin_unlock_irqrestore(&uhci->frame_list_lock, flags);

         file->private_data = up;
+ 
unlock_kernel();

         ret = 0;
  out:
-       unlock_kernel();
         return ret;
  }



-- 
Dave Hansen
haveblue@us.ibm.com


