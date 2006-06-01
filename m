Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWFAOoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWFAOoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWFAOoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:44:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:54029 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750951AbWFAOod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:44:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=n8A881ihX3HJ0jbeI2IZ5/YHmyDn0vPjFzGtD5s9TX0ClNYxTYDtBXXcBSjjtG/h2wy2zyfTa/xMgRa6Y82UOuLNXm2Yrj6rUbOSRFm2A/cUTWMXpNTK5fHVwAZ5WyHNC+B3O2Tn8PFCceFnOyCEa+adewgpuhH2/Ni6LlFdbC8=
Date: Thu, 1 Jun 2006 16:42:41 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       yi.zhu@intel.com, jketreno@linux.intel.com
Subject: [patch mm1-rc2] lock validator: netlink.c netlink_table_grab fix
Message-ID: <20060601144241.GA952@slug>
References: <20060529212109.GA2058@elte.hu> <20060530091415.GA13341@ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530091415.GA13341@ens-lyon.fr>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 11:14:15AM +0200, Benoit Boissinot wrote:
> On 5/29/06, Ingo Molnar <mingo@elte.hu> wrote:
> >We are pleased to announce the first release of the "lock dependency
> >correctness validator" kernel debugging feature, which can be downloaded
> >from:
> >
> >  http://redhat.com/~mingo/lockdep-patches/
> >[snip]
> 
> I get this right after ipw2200 is loaded (it is quite verbose, I
> probably shoudln't post everything...)
> 
This got rid of the oops for me, is it the right fix?

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
--- /usr/src/linux/net/netlink/af_netlink.c	2006-05-24 14:58:38.000000000 +0200
+++ net/netlink/af_netlink.c	2006-06-01 16:36:51.000000000 +0200
@@ -157,7 +157,7 @@ static void netlink_sock_destruct(struct
 
 static void netlink_table_grab(void)
 {
-	write_lock_bh(&nl_table_lock);
+	write_lock_irq(&nl_table_lock);
 
 	if (atomic_read(&nl_table_users)) {
 		DECLARE_WAITQUEUE(wait, current);
@@ -167,9 +167,9 @@ static void netlink_table_grab(void)
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			if (atomic_read(&nl_table_users) == 0)
 				break;
-			write_unlock_bh(&nl_table_lock);
+			write_unlock_irq(&nl_table_lock);
 			schedule();
-			write_lock_bh(&nl_table_lock);
+			write_lock_irq(&nl_table_lock);
 		}
 
 		__set_current_state(TASK_RUNNING);
@@ -179,7 +179,7 @@ static void netlink_table_grab(void)
 
 static __inline__ void netlink_table_ungrab(void)
 {
-	write_unlock_bh(&nl_table_lock);
+	write_unlock_irq(&nl_table_lock);
 	wake_up(&nl_table_wait);
 }
 

