Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTKXT4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTKXT4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:56:14 -0500
Received: from lpbproductions.com ([68.98.208.147]:57735 "HELO azgamers.com")
	by vger.kernel.org with SMTP id S263389AbTKXT4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:56:08 -0500
From: Matt <matt@lpbproductions.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test10 : compile error in /fs/proc/array.c
Date: Mon, 24 Nov 2003 12:56:20 -0700
User-Agent: KMail/1.5.93
References: <Pine.LNX.4.44.0311242014030.8867-100000@sarijopen.student.utwente.nl>
In-Reply-To: <Pine.LNX.4.44.0311242014030.8867-100000@sarijopen.student.utwente.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kJmw/NtnEhizgqs"
Message-Id: <200311241256.20554.matt@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_kJmw/NtnEhizgqs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

appy this patch , it was posted here on the lkml before. Not quite sure who 
posted it first , but it works.

Matt H.


>On Monday 24 November 2003 12:29 pm, mp3project@sarijopen.student.utwente.nl 
wrote:
> Ave people
>
> My redhat 7.3 compiler (gcc 2.96--113) is still complaining about that
> file.
>
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC      fs/proc/array.o
> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:398: Unrecognizable insn:
> (insn/i 1332 1663 1657 (parallel[
>             (set (reg:SI 0 eax)
>                 (asm_operands ("") ("=a") 0[
>                         (reg:DI 1 edx)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                     ]  ("include/linux/times.h") 38))
>             (set (reg:SI 1 edx)
>                 (asm_operands ("") ("=d") 1[
>                         (reg:DI 1 edx)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                     ]  ("include/linux/times.h") 38))
>             (clobber (reg:QI 19 dirflag))
>             (clobber (reg:QI 18 fpsr))
>             (clobber (reg:QI 17 flags))
>         ] ) -1 (insn_list 1326 (nil))
>     (nil))
> fs/proc/array.c:398: confused by earlier errors, bailing out
> make[2]: *** [fs/proc/array.o] Error 1
> make[1]: *** [fs/proc] Error 2
> make: *** [fs] Error 2
>
>
> It's a known error and various patches are floating around on lkml.
>
> Is this
> a)a post 2.6.0 item
> b)a case of fix the compiler,we ain't gonna work around.
>
> Patching the source is not difficult to do,but it would be nice if
> vanilla 2.6.0 is gonna compile cleanly without patching on redhat 7.3
>
> Greetz Mu
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--Boundary-00=_kJmw/NtnEhizgqs
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="501-gcc-2.96-array-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="501-gcc-2.96-array-fix.patch"

On Tuesday October 21st 2003 at 15:52 uur Marco Roeland wrote:

> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106651554401143&w=2
> > 
> > It's supposed to fix test8 compile with gcc-2.96 for RedHat 7.x.
> 
> Perhaps if the huge sprintf with 40+ arguments (fs/proc/array.c, line 346)
> amongst which several trinary operators, were to be split up into several
> parts, might that not solve the problem more elegantly?

Does this compile (and work) for any of you friendly RedHat 7.[23] users? 
In 2.6.0-test8 yet another argument was added to the monstrous sprintf.
Perhaps this was just the droplet to overflow gcc-2.96's buckets? Here we
split it into 3 distinct parts.

--- linux-2.6.0-test8/fs/proc/array.c.orig	2003-10-21 16:18:40.000000000 +0200
+++ linux-2.6.0-test8/fs/proc/array.c	2003-10-21 16:24:42.000000000 +0200
@@ -343,9 +343,7 @@
 	read_lock(&tasklist_lock);
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
-	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu ",
 		task->pid,
 		task->comm,
 		state,
@@ -355,7 +353,8 @@
 		tty_nr,
 		tty_pgrp,
 		task->flags,
-		task->min_flt,
+		task->min_flt);
+	res += sprintf(buffer + res,"%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu ",
 		task->cmin_flt,
 		task->maj_flt,
 		task->cmaj_flt,
@@ -375,7 +374,8 @@
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
 		mm ? mm->start_stack : 0,
-		esp,
+		esp);
+	res += sprintf(buffer + res,"%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		eip,
 		/* The signal information here is obsolete.
 		 * It must be decimal for Linux 2.0 compatibility.

-

--Boundary-00=_kJmw/NtnEhizgqs--
