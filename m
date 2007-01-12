Return-Path: <linux-kernel-owner+w=401wt.eu-S1750925AbXALPSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXALPSE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbXALPSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:18:03 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43348 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbXALPSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:18:01 -0500
Date: Fri, 12 Jan 2007 09:17:53 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Mimi Zohar <zohar@us.ibm.com>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@saff.watson.ibm.com
Subject: Re: mprotect abuse in slim
Message-ID: <20070112151753.GD10619@sergelap.austin.ibm.com>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com> <1168312045.3180.140.camel@laptopd505.fenrus.org> <20070109094625.GA11918@infradead.org> <20070109231449.GA4547@sergelap.austin.ibm.com> <Pine.LNX.4.64.0701100914550.22496@sbz-30.cs.Helsinki.FI> <20070110155845.GA373@sergelap.austin.ibm.com> <84144f020701102339n1935b0a7v5ca3419fe3b66be5@mail.gmail.com> <20070111154957.GG4791@sergelap.austin.ibm.com> <84144f020701112343n1e398fc4r65fa83717f9e5f02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020701112343n1e398fc4r65fa83717f9e5f02@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pekka Enberg (penberg@cs.helsinki.fi):
> On 1/11/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> >Right, but is returning -EINVAL to userspace on munmap a problem?
> 
> Yes, because an application has no way of reusing the revoked mapping
> range. The current patch should get this right, though.

Looks good.

> On 1/11/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> >Thanks for the tw other patches - I'll give them a shot and check
> >out current munmap behavior just as soon as I get a chance.
> 
> I hacked the remaining open issues yesterday so please use this instead:
> 
> http://www.cs.helsinki.fi/u/penberg/linux/revoke/revoke-2.6.20-rc4
> 
> The one at kernel.org will be updated as well when mirroring catches up.

Great, this patch (with the attached trivial patch to implement the
syscalls on my z guest) passes all of your testcases.

I'll give it a another, closer read over the weekend, and start
basing something to help slim on this code.

-serge


Subject: [PATCH] revoke: s390 architecture

Implement the revoke syscalls for s390.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 arch/s390/kernel/compat_wrapper.S |   11 +++++++++++
 arch/s390/kernel/syscalls.S       |    2 ++
 include/asm-s390/unistd.h         |    4 +++-
 3 files changed, 16 insertions(+), 1 deletions(-)

24ebe37142572d388569851edf4b919b7f97cc2f
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 71e54ef..b5c2bfa 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1665,3 +1665,14 @@ sys_getcpu_wrapper:
 	llgtr	%r3,%r3			# unsigned *
 	llgtr	%r4,%r4			# struct getcpu_cache *
 	jg	sys_getcpu
+
+	.globl sys_revokeat_wrapper
+sys_revokeat_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# const char *
+	jg	sys_revokeat
+
+	.globl sys_frevoke_wrapper
+sys_frevoke_wrapper:
+	llgfr	%r2,%r2			# unsigned int
+	jg	sys_frevoke
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index a4ceae3..85a6673 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -321,3 +321,5 @@ SYSCALL(sys_vmsplice,sys_vmsplice,compat
 NI_SYSCALL							/* 310 sys_move_pages */
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
 SYSCALL(sys_epoll_pwait,sys_epoll_pwait,sys_ni_syscall)
+SYSCALL(sys_revokeat,sys_revokeat,sys_revokeat_wrapper)
+SYSCALL(sys_frevoke,sys_frevoke,sys_frevoke_wrapper)
diff --git a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
index fb6fef9..6651cb1 100644
--- a/include/asm-s390/unistd.h
+++ b/include/asm-s390/unistd.h
@@ -250,8 +250,10 @@
 /* Number 310 is reserved for new sys_move_pages */
 #define __NR_getcpu		311
 #define __NR_epoll_pwait	312
+#define __NR_revokeat		313
+#define __NR_frevoke		314
 
-#define NR_syscalls 313
+#define NR_syscalls 315
 
 /* 
  * There are some system calls that are not present on 64 bit, some
-- 
1.1.6
