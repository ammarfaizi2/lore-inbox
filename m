Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbSJQVZz>; Thu, 17 Oct 2002 17:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262157AbSJQVYe>; Thu, 17 Oct 2002 17:24:34 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:51214 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262156AbSJQVYU>;
	Thu, 17 Oct 2002 17:24:20 -0400
Date: Thu, 17 Oct 2002 14:29:58 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.43
Message-ID: <20021017212958.GE1125@kroah.com>
References: <20021017212620.GA1125@kroah.com> <20021017212809.GB1125@kroah.com> <20021017212839.GC1125@kroah.com> <20021017212924.GD1125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017212924.GD1125@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.801, 2002/10/17 14:05:48-07:00, greg@kroah.com

LSM: change all security bprm related calls to the new format.


diff -Nru a/arch/ppc64/kernel/sys_ppc32.c b/arch/ppc64/kernel/sys_ppc32.c
--- a/arch/ppc64/kernel/sys_ppc32.c	Thu Oct 17 14:19:04 2002
+++ b/arch/ppc64/kernel/sys_ppc32.c	Thu Oct 17 14:19:04 2002
@@ -3518,8 +3518,7 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	retval = security_ops->bprm_alloc_security(&bprm);
-	if (retval) 
+	if ((retval = security_bprm_alloc(&bprm)))
 		goto out;
 
 	retval = prepare_binprm(&bprm);
@@ -3542,7 +3541,7 @@
 	retval = search_binary_handler(&bprm,regs);
 	if (retval >= 0) {
 		/* execve success */
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 		return retval;
 	}
 
@@ -3555,7 +3554,7 @@
 	}
 
 	if (bprm.security)
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 
 out_mm:
 	mmdrop(bprm.mm);
diff -Nru a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
--- a/arch/sparc64/kernel/sys_sparc32.c	Thu Oct 17 14:19:04 2002
+++ b/arch/sparc64/kernel/sys_sparc32.c	Thu Oct 17 14:19:04 2002
@@ -2964,8 +2964,7 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	retval = security_ops->bprm_alloc_security(&bprm);
-	if (retval) 
+	if ((retval = security_bprm_alloc(&bprm)))
 		goto out;
 
 	retval = prepare_binprm(&bprm);
@@ -2988,7 +2987,7 @@
 	retval = search_binary_handler(&bprm, regs);
 	if (retval >= 0) {
 		/* execve success */
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 		return retval;
 	}
 
@@ -3001,7 +3000,7 @@
 	}
 
 	if (bprm.security)
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 
 out_mm:
 	mmdrop(bprm.mm);
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Thu Oct 17 14:19:04 2002
+++ b/fs/exec.c	Thu Oct 17 14:19:04 2002
@@ -819,8 +819,7 @@
 	}
 
 	/* fill in binprm security blob */
-	retval = security_ops->bprm_set_security(bprm);
-	if (retval)
+	if ((retval = security_bprm_set(bprm)))
 		return retval;
 
 	memset(bprm->buf,0,BINPRM_BUF_SIZE);
@@ -868,7 +867,7 @@
 	if(do_unlock)
 		unlock_kernel();
 
-	security_ops->bprm_compute_creds(bprm);
+	security_bprm_compute_creds(bprm);
 }
 
 void remove_arg_zero(struct linux_binprm *bprm)
@@ -937,8 +936,7 @@
 	    }
 	}
 #endif
-	retval = security_ops->bprm_check_security(bprm);
-	if (retval) 
+	if ((retval = security_bprm_check(bprm)))
 		return retval;
 
 	/* kernel module loader fixup */
@@ -1034,8 +1032,7 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	retval = security_ops->bprm_alloc_security(&bprm);
-	if (retval) 
+	if ((retval = security_bprm_alloc(&bprm)))
 		goto out;
 
 	retval = prepare_binprm(&bprm);
@@ -1058,7 +1055,7 @@
 	retval = search_binary_handler(&bprm,regs);
 	if (retval >= 0) {
 		/* execve success */
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 		return retval;
 	}
 
@@ -1071,7 +1068,7 @@
 	}
 
 	if (bprm.security)
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 
 out_mm:
 	mmdrop(bprm.mm);
