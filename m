Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUIMTBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUIMTBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268670AbUIMTBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:01:44 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:5504 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268658AbUIMTBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:01:41 -0400
Date: Mon, 13 Sep 2004 11:57:21 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Hugh Dickins <hugh@veritas.com>, cmm@us.ibm.com, dipankar@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Put size in array to get rid of barriers in grow_ary()
Message-ID: <20040913185721.GG1241@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040907230936.GA13387@us.ibm.com> <Pine.LNX.4.44.0409081623380.8697-100000@localhost.localdomain> <20040908220753.GD1240@us.ibm.com> <20040911034025.GA8676@us.ibm.com> <4145E98F.4050106@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4145E98F.4050106@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 08:40:15PM +0200, Manfred Spraul wrote:
> Paul E. McKenney wrote:
> 
> >And here, finally, is the updated patch.  Still untested.
> >
> >Thoughts?
> >
> > 
> >
> Looks good.
> I've even tried to test it, but doesn't compile with -rc1-bk11 due to 
> missing rcu_assign_pointer.

My bad!  It needs the rcu_assign_pointer() patch as pre-req.

http://marc.theaimsgroup.com/?l=linux-kernel&m=109459678719365&w=2

Below is the part of that patch that is actually supplies
rcu_assign_pointer(), which should be all that is needed.

						Thanx, Paul

diff -urpN -X ../dontdiff linux-2.5/include/linux/rcupdate.h linux-2.5-rap/include/linux/rcupdate.h
--- linux-2.5/include/linux/rcupdate.h	Tue Sep  7 10:04:29 2004
+++ linux-2.5-rap/include/linux/rcupdate.h	Tue Sep  7 12:12:09 2004
@@ -238,6 +238,24 @@ static inline int rcu_pending(int cpu)
 				(_________p1); \
 				})
 
+/**
+ * rcu_assign_pointer - assign (publicize) a pointer to a newly
+ * initialized structure that will be dereferenced by RCU read-side
+ * critical sections.  Returns the value assigned.
+ *
+ * Inserts memory barriers on architectures that require them
+ * (pretty much all of them other than x86), and also prevents
+ * the compiler from reordering the code that initializes the
+ * structure after the pointer assignment.  More importantly, this
+ * call documents which pointers will be dereferenced by RCU read-side
+ * code.
+ */
+
+#define rcu_assign_pointer(p, v)	({ \
+						smp_wmb(); \
+						(p) = (v); \
+					})
+
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
