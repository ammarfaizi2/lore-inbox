Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTBKHGs>; Tue, 11 Feb 2003 02:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTBKHGs>; Tue, 11 Feb 2003 02:06:48 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48885 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267190AbTBKHGq>;
	Tue, 11 Feb 2003 02:06:46 -0500
Date: Tue, 11 Feb 2003 12:51:44 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andy Pfiffer <andyp@osdl.org>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, fastboot@osdl.org
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
Message-ID: <20030211125144.A2355@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210164401.A11250@in.ibm.com> <1044896964.1705.9.camel@andyp.pdx.osdl.net> <m13cmwyppx.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m13cmwyppx.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Feb 10, 2003 at 11:07:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2003 at 11:07:06AM -0700, Eric W. Biederman wrote:
> Andy Pfiffer <andyp@osdl.org> writes:
> 
> > On Mon, 2003-02-10 at 03:14, Suparna Bhattacharya wrote:
> > > Surprisingly though, when I tried just a simple 
> > > kexec -e today (having loaded the kernel earlier on), 
> > > I ran into the following Oops, consistently:
> > > 
> > > I'm using kexec-tools-1.8, and this has worked for me
> > > earlier. The test system is a 4way SMP machine.
> > > 
> > > Has anyone seen this as well ?  (I'd already issued init 1 
> > > and unmounted filesystems by this point)
> 
> Hmm.  Would love to know which cpu this is on...
> 
> I think the primary candidate if this only occurs in smp is
> the switch_mm.  It may be that modifying the init_mm is not safe,
> or it gets zapped somewhere else.
> 

The following patch from Anton Blanchard's WIP kexec tree 
for ppc64 seems to fix this for me. It just does a use_mm() 
(routine from fs/aio.c) instead of switch_mm(). 

Andy could you try this out and see if it helps  ?

The other change in Anton's tree that we should probably
include uses a separate kexec_mm rather than init_mm
for the mapping. 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kexec-usemm.patch"

diff -u -X ../dontdiff linux-2.5.59/fs/aio.c linux-2.5.59-kexecdump/fs/aio.c
--- linux-2.5.59/fs/aio.c	Fri Jan 17 07:52:06 2003
+++ linux-2.5.59-kexecdump/fs/aio.c	Tue Feb 11 09:14:25 2003
@@ -539,7 +539,7 @@
 	return ioctx;
 }
 
-static void use_mm(struct mm_struct *mm)
+void use_mm(struct mm_struct *mm)
 {
 	struct mm_struct *active_mm = current->active_mm;
 	atomic_inc(&mm->mm_count);
--- linux-2.5.59/arch/i386/kernel/machine_kexec.c	Thu Feb  6 16:31:14 2003
+++ linux-2.5.59-kexecdump/arch/i386/kernel/machine_kexec.c	Tue Feb 11 09:14:05 2003
@@ -80,7 +80,8 @@
 	relocate_new_kernel_t rnk;
 
 	/* switch to an mm where the reboot_code_buffer is identity mapped */
-	switch_mm(current->active_mm, &init_mm, current, smp_processor_id());
+	extern void use_mm(struct mm_struct *mm);
+	use_mm(&init_mm);
 
 	stop_apics();
 

--ikeVEW9yuYc//A+q--
