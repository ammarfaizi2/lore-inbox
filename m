Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUCEENV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 23:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbUCEENV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 23:13:21 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:49052 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S262193AbUCEENR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 23:13:17 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Thu, 4 Mar 2004 20:13:11 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Userspace memory and kernel access
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.184.117]
X-Eon-Sig: AQHDJlhAR/5XAAGQmgEAAAAB,d18a4fd520c6143ea4153a66af5b3304
Message-Id: <20040305041311.1EEA27259@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to code an ACL system for the kernel that relies on a
userspace daemon instead of in-kernel code.  The daemon will call
sys_acl_connect() to connect to the kernel, and the kernel will
mmap() some ram for it, initialize the structure, pass it back,
and let the process sleep.

When an ACL request is made, the kernel follows the following
process:

 - mmap() more ram for the acl daemon
 - initialize the ram to an end plug
 - Tack the ram onto the daemon's linked list
 - Write the request into what WAS the last structure on the
   daemon's request linked list
 - wake the daemon
 - Sleep the current process
 - Evaluate the judgment returned from the daemon
 - return the result

Note that once the process sleeps, it doesn't wake up until
the acl daemon replies to the request; thus, the code for
this is going to be right after the sleep code.

To clean up certain race conditions, I'll have to create a
new type of wake-up signal "Wake or don't sleep" to be used
internally by the kernel only.  No big deal.

My question is about interracting with the acl daemon.  I'm
using mmap()ed ram, but in certain situations it belongs to
a process OTHER than the current, so I have to get the REAL
address of the ram and write to that.  My current unfinished
function looks as follows:


/*
 * Make a request.
 * wants the data for it as well as the request.
 * Returns the struct kacl_data
 *
 * This is insert sorted.
 */
int *acl_request(int msg, void *data){
        aclkdata *kaclitem;
        aclkdata *curkacl;
                                                                                                                                          
        if (!acl_daemon || current == acl_daemon)
                return ACL_RESP_NOT_DENY; /*acl is wide open until an acld is connected*/
        kaclitem = kalloc(sizeof(aclkdata),GFP_KERN);
                                                                                                                                          
        spin_lock(&lock_acl);
                                                                                                                                          
        for (curkacl = kaclhead; curkacl && curkacl->next &&
          curkacl->next->msgid == curkacl->msgid + 1; curkacl = curkacl->next) {
                ; /*do nothing!*/
        }
        kaclitem->next  = curkacl->next;
        curkacl->next   = kaclitem;
        kaclitem->msgid = curkacl->msgid + 1;
                                                                                                                                          
        down_write(&acl_daemon->mm->mmap_sem);
        acld_que->next = do_mmap_task(NULL, sizeof(acldata), PROT_READ|PROT_WRITE,
          MAP_SHARED | MAP_ANONYMOUS, NULL, 0, acl_daemon); /* for acld*/
        up_write(&acl_daemon->mm->mmap_sem);
/*OBJECT OF QUERY 1*/
        aclque_clear(acld_que->next);
        /*FIXME:  Set previous end object of acld aclque to have
          proper data, msgid, msg, and FINALLY eval type ACL_EVAL_EVAL*/
                                                                                                                                          
        acld_que->data  = data;
        acld_que->msgid = kaclitem->msgid;
        acld_que->msg   = msg;
        acld_que->eval  = ACL_EVAL_EVAL;
        acld_que = acld_que->next;
/*END OBJECT OF QUERY 1*/
        /*
         * FIXME:  Race here:  Wake ACLD and go to SLEEP immediately, what if
         * acld wakes you inbetween?  We'd need a preemptive wake, i.e. if
         * sleeping a process that was told to wake or not sleep, do not sleep.
         */
        /* FIXME:  Possible race:
         * acld:  if (!(aclque->eval))
         * kernel:  acld_que->eval = ACL_EVAL_EVAL;
         * kernel:  acld_que = acld_que->next;
         * kernel:  wake_up_acld();
         * acld:    sleeps;
         * MAKE SURE the sys_acl_sleep() syscall doesn't sleep after
         * acld_que->eval is set!!!!!!
         */
        /*FIXME:  Wake up acld*/
        spin_unlock(&lock_acl);
        /*FIXME:  Sleep this task here, until acld wakes it*/
        /*FIXME:  Read result*/
        /*FIXME:  Free *data*/
out:
        return retval;
}

On OBJECT OF QUERY 1:
  I have altered do_mmap() to trigger
    do_mmap_task(a,b,c,d,e,f,current);
  and made the proper changes to the original code.  What
would I have to do to the above code to actually be writing
to the ram I expect to write to? acl_que belongs to a process
that's NOT current. and so I expect the addresses to point to
somewhere other than where I'd want to write as-is.

I work best by example.  Show me the code around there, and
I'll just take it apart and use it in all the other places
I need it.

I'm also going to need to know the function to copy kernel
ram to userspace.  I thought it was copy_to_user() (I'd need
to do it from kernelspace data to acl_que->data) but I don't
know the syntax of the call and don't recall right now where
to look it up.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
