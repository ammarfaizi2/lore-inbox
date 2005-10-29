Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVJ2BFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVJ2BFJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 21:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVJ2BFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 21:05:09 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:13517 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751067AbVJ2BFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 21:05:06 -0400
Subject: Re: [ckrm-tech] Re: [PATCH] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <1130543791.10680.853.camel@stark>
References: <1130489713.10680.685.camel@stark>
	 <1130541585.10680.846.camel@stark>  <1130543791.10680.853.camel@stark>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 17:57:18 -0700
Message-Id: <1130547438.10680.872.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 16:56 -0700, Matt Helsley wrote:
> OK, I wasn't as thorough as I had hoped re: 64-bit kernel/32-bit
> userspace. The uid_t and gid_t types appear to present a problem to the
> following:
> 
> User  <-> Kernel
> i386  <-> x86_64/IA64
> sparc <-> sparc64
> s390  <-> s390x
> 
> :(
> 
> 	I'll look at this some more and see if I need to resubmit. Until then
> I'll hold off on my request for inclusion in -mm.
> 
> Cheers,
> 	-Matt Helsley

	Userspace can include sys/types.h -- in which case uid_t and gid_t
match -- or linux/types.h -- in which case they are not guaranteed to
match. To further complicate things translation is not possible because
the connector broadcasts the events to multiple 'listener's. A mix of 32
and 64-bit userspace programs could be listening; guaranteeing
incompatibility if the structure layouts do not match.

	This patch addresses the problem by fixing the size to the largest size
found in the kernel (and likely the largest size needed). This preserves
the total size of the event structure while ensuring that the event
structure layouts match.

	Are there better alternative solutions?

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

---

Index: linux-2.6.14/include/linux/cn_proc.h
===================================================================
--- linux-2.6.14.orig/include/linux/cn_proc.h
+++ linux-2.6.14/include/linux/cn_proc.h
@@ -84,16 +84,16 @@ struct proc_event {
 
 		struct id_proc_event {
 			pid_t process_pid;
 			pid_t process_tgid;
 			union {
-				uid_t ruid; /* current->uid */
-				gid_t rgid; /* current->gid */
+				__u32 ruid; /* task uid */
+				__u32 rgid; /* task gid */
 			};
 			union {
-				uid_t euid;
-				gid_t egid;
+				__u32 euid;
+				__u32 egid;
 			};
 		} id;
 
 		struct exit_proc_event {
 			pid_t process_pid;


