Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSDWSb6>; Tue, 23 Apr 2002 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315295AbSDWSb5>; Tue, 23 Apr 2002 14:31:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50188 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315293AbSDWSbz>;
	Tue, 23 Apr 2002 14:31:55 -0400
Message-ID: <3CC5A8AF.432380E3@zip.com.au>
Date: Tue, 23 Apr 2002 11:32:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.org
Subject: Re: [patch] 2.5.9 remove warnings
In-Reply-To: <10704.1019533171@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> ...
> @@ -47,7 +47,7 @@ static inline void __unhash_process(stru
>                 spin_unlock(&dcache_lock);
>         }
>         write_unlock_irq(&tasklist_lock);
> -       if (unlikely(proc_dentry)) {
> +       if (unlikely(proc_dentry != NULL)) {
>                 shrink_dcache_parent(proc_dentry);
>                 dput(proc_dentry);
>         }

Is it not possible to fix it for all time?

--- linux-2.5.9/include/linux/compiler.h	Sun Apr 14 15:45:08 2002
+++ 25/include/linux/compiler.h	Tue Apr 23 11:27:37 2002
@@ -10,8 +10,8 @@
 #define __builtin_expect(x, expected_value) (x)
 #endif
 
-#define likely(x)	__builtin_expect((x),1)
-#define unlikely(x)	__builtin_expect((x),0)
+#define likely(x)	__builtin_expect((x) != 0, 1)
+#define unlikely(x)	__builtin_expect((x) != 0, 0)
 
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */

(Interestingly, this patch shrinks my kernel by 32 bytes.  hmm.)

BTW, it would be very useful if someone could invert the sense of
`likely' and `unlikely', so they always say the *wrong* thing, and
then actually demonstrate some real-world slowdown.  coz if this
can't be done, why are we putting up with the visual clutter?

-
