Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbULVXZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbULVXZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbULVXZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:25:11 -0500
Received: from mail.suse.de ([195.135.220.2]:48268 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262085AbULVXYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:24:48 -0500
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3, i386: fpu handling on sigreturn
References: <41C9B21F.90802@fujitsu-siemens.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Dec 2004 00:24:45 +0100
In-Reply-To: <41C9B21F.90802@fujitsu-siemens.com.suse.lists.linux.kernel>
Message-ID: <p73mzw5zzk2.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Stroesser <bstroesser@fujitsu-siemens.com> writes:
> 
> Now, the interrupted processes fpu no longer is cleared!

I agree it's a bug, although it's probably pretty obscure so people
didn't notice it.  The right fix would be to just clear_fpu again
in this case.  The problem has been in Linux forever.

Here's an untested patch for i386 and x86-64. 

-Andi

diff -u linux-2.6.10rc2-time/arch/i386/kernel/signal.c-o linux-2.6.10rc2-time/arch/i386/kernel/signal.c
--- linux-2.6.10rc2-time/arch/i386/kernel/signal.c-o	2004-11-15 12:34:25.000000000 +0100
+++ linux-2.6.10rc2-time/arch/i386/kernel/signal.c	2004-12-23 00:07:18.000000000 +0100
@@ -190,7 +190,8 @@
 			if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
 				goto badframe;
 			err |= restore_i387(buf);
-		}
+		} else if (current->used_math) 
+			clear_fpu(current); 
 	}
 
 	err |= __get_user(*peax, &sc->eax);
diff -u linux-2.6.10rc2-time/arch/x86_64/kernel/signal.c-o linux-2.6.10rc2-time/arch/x86_64/kernel/signal.c
--- linux-2.6.10rc2-time/arch/x86_64/kernel/signal.c-o	2004-10-19 01:55:08.000000000 +0200
+++ linux-2.6.10rc2-time/arch/x86_64/kernel/signal.c	2004-12-23 00:07:19.000000000 +0100
@@ -125,7 +125,8 @@
 			if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
 				goto badframe;
 			err |= restore_i387(buf);
-		}
+		} else if (current->used_math) 
+			clear_fpu(current); 
 	}
 
 	err |= __get_user(*prax, &sc->rax);
diff -u linux-2.6.10rc2-time/arch/x86_64/ia32/ia32_signal.c-o linux-2.6.10rc2-time/arch/x86_64/ia32/ia32_signal.c
--- linux-2.6.10rc2-time/arch/x86_64/ia32/ia32_signal.c-o	2004-10-19 01:55:08.000000000 +0200
+++ linux-2.6.10rc2-time/arch/x86_64/ia32/ia32_signal.c	2004-12-23 00:07:17.000000000 +0100
@@ -261,7 +261,8 @@
 			if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
 				goto badframe;
 			err |= restore_i387_ia32(current, buf, 0);
-		}
+		} else if (current->used_math) 
+			clear_fpu(current); 
 	}
 
 	{ 

