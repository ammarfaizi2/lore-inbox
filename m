Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267351AbUG2ABh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267351AbUG2ABh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUG2ABg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:01:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1715 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267351AbUG2ABF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:01:05 -0400
Subject: Re: 2.6.8-rc2-mm1 link errors
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20040728164920.5ad4c114.akpm@osdl.org>
References: <1091057256.2871.637.camel@nighthawk>
	 <20040728164920.5ad4c114.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1091059230.2871.676.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 17:00:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 16:49, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> > I'm getting some odd link errors from -rc2-mm1 that don't happen in
> > -rc1-mm1, or plain -rc2:
> > 
> >           LD      .tmp_vmlinux1
> >         ldchk: .tmp_vmlinux1: final image has undefined symbols:
> >         
> >         
> >         <bunch of blank lines>
> >         
> >         
> >         make: *** [.tmp_vmlinux1] Error 1
> >         
> > Any ideas?
> 
> Nope.   Could you take a look at the code in the top-level
> Makefile which is doing this, work out why it broke?

Well, it's this patch.  cc'ing Russell...  

I'd tend to think it's a false-positive, not a real problem that's just
being detected now.  Is the sed part of the patch borked?

-----

From: Russell King <rmk+lkml@arm.linux.org.uk>

The only issue with this is that, when a problem is detected, the
reported symbols will also include the Sparc64 register symbols.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/Makefile |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN Makefile~handle-undefined-symbols Makefile
--- 25/Makefile~handle-undefined-symbols	2004-07-26 23:24:30.552753872 -0700
+++ 25-akpm/Makefile	2004-07-26 23:24:30.556753264 -0700
@@ -525,6 +525,8 @@ endef
 
 #	set -e makes the rule exit immediately on error
 
+#	Note: Ensure that there are no undefined symbols in the final
+#	linked image.  Not doing this can lead to silent link failures.
 define rule_vmlinux__
 	+set -e;							\
 	$(if $(filter .tmp_kallsyms%,$^),,				\
@@ -536,6 +538,12 @@ define rule_vmlinux__
 	$(if $($(quiet)cmd_vmlinux__),					\
 	  echo '  $($(quiet)cmd_vmlinux__)' &&) 			\
 	$(cmd_vmlinux__);						\
+	if $(OBJDUMP) --syms $@ | egrep -q '^([^R]|R[^E]|RE[^G])[^w]*\*UND\*'; then	\
+		echo 'ldchk: $@: final image has undefined symbols:';	\
+		$(NM) $@ | sed 's/^ *U \(.*\)/  \1/p;d';		\
+		$(RM) -f $@;						\
+		exit 1;							\
+	fi;								\
 	echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 endef
 
_

-- Dave

