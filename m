Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292178AbSCONCE>; Fri, 15 Mar 2002 08:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSCONBy>; Fri, 15 Mar 2002 08:01:54 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:46604 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292178AbSCONBp>; Fri, 15 Mar 2002 08:01:45 -0500
Date: Fri, 15 Mar 2002 13:01:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        "Marcelo W. Tosatti" <marcelo@conectiva.com.br>
Subject: Re: execve() fails to report errors
Message-ID: <20020315130133.A24984@flint.arm.linux.org.uk>
In-Reply-To: <20020305233437.GA130@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020305233437.GA130@elf.ucw.cz>; from pavel@ucw.cz on Wed, Mar 06, 2002 at 12:34:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 12:34:37AM +0100, Pavel Machek wrote:
> Now, I do not know if this is the right fix (binfmt_elf looks
> spaghetty to me) but its certainly better than it was.

Here's another fix in this area.  If setup_arg_pages() fails, we continue
although nothing went wrong.  The following patch kills the process
instead.

Linus/Marcelo - please apply.

--- orig/fs/binfmt_elf.c	Fri Mar 15 10:14:29 2002
+++ linux/fs/binfmt_elf.c	Mon Mar 11 17:29:03 2002
@@ -585,7 +585,12 @@
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
 	current->mm->rss = 0;
-	setup_arg_pages(bprm); /* XXX: check error */
+	retval = setup_arg_pages(bprm);
+	if (retval < 0) {
+		send_sig(SIGKILL, current, 0);
+		return retval;
+	}
+	
 	current->mm->start_stack = bprm->p;
 
 	/* Now we do a little grungy work by mmaping the ELF image into


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

