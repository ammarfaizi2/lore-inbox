Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbSLDSoo>; Wed, 4 Dec 2002 13:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267016AbSLDSoo>; Wed, 4 Dec 2002 13:44:44 -0500
Received: from mort.demon.co.uk ([158.152.28.197]:19891 "EHLO mort.demon.co.uk")
	by vger.kernel.org with ESMTP id <S267001AbSLDSol>;
	Wed, 4 Dec 2002 13:44:41 -0500
From: mbm@mort.demon.co.uk
Message-Id: <200212041852.gB4IqEt29557@mort.demon.co.uk>
Subject: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Dec 2002 18:52:14 +0000 (GMT)
In-Reply-To: <20021204170701.16075.58972.Mailman@lists.us.dell.com> from "linux-kernel-digest-request@lists.us.dell.com" at Dec 04, 2002 11:07:01 
Reply-To: "Malcolm Mladenovic" <mbm@tinc.org.uk>
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alexander Riesen wrote:
> >On Wed, Dec 04, 2002 at 12:34:19PM +0100, Matthias Andree wrote:
> >> SuSE Linux 7.0, 7.3, 8.1 (2.4.19 kernel, binfmt_script.c identical to
> >> 2.4.20 BK):
> >> $ /tmp/try.pl
> >> /bin/sh: -- # -*- perl -*- -T: invalid option
> >
> >looks correct. The interpreter (/bin/sh) has got everything after
> >its name. IOW: "-- # -*- perl -*- -T"
> >It's just solaris' shell (/bin/sh) just ignores options starting with
> >"--". And freebsd's as well.
> 
> FreeBSD splits #! magic strings on whitespace and passes multiple
> arguments. Linux passes everything after the first whitespace as a
> single argument but strips trailing whitespace. NetBSD does the same as
> Linux but passes trailing whitespace as part of the argument.

NetBSD is also broken, in that case.  Everything I ever used that
supported #! except linux worked sensibly.  I even wrote myself
a patch, which still applied to 2.4 fairly recently.  It's not
perfect (has a fixed number of args to avoid allocating from the
heap, would be easy to change), but it's functional.


*** linux-2.4.20-rc1/fs/binfmt_script.c	Sun Nov 10 20:34:21 2002
--- linux-mbm/fs/binfmt_script.c	Sun Nov 10 20:32:30 2002
***************
*** 3,8 ****
--- 3,10 ----
   *
   *  Copyright (C) 1996  Martin von Löwis
   *  original #!-checking implemented by tytso.
+  *  2001-10-06 - mbm@tinc.org.uk - reimplement to be more like *BSD/SVR4
+  *				(allow multiple args and terminate at '#')
   */
  
  #include <linux/module.h>
***************
*** 14,25 ****
  #include <linux/file.h>
  #include <linux/smp_lock.h>
  
  static int load_script(struct linux_binprm *bprm,struct pt_regs *regs)
  {
! 	char *cp, *i_name, *i_arg;
  	struct file *file;
  	char interp[BINPRM_BUF_SIZE];
  	int retval;
  
  	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!') || (bprm->sh_bang)) 
  		return -ENOEXEC;
--- 16,96 ----
  #include <linux/file.h>
  #include <linux/smp_lock.h>
  
+ #define MAX_SCRIPT_ARGS 16
+ 
+ /*
+  * Split line into arguments separated by white space.
+  * Line terminates at first of NUL, NL or '#' character.
+  *
+  * Caller must supply suitable array to hold pointers.
+  * Input string is modified to separate argument strings with NUL.
+  * *nargs contains max args allowed on entry, actual number found on exit.
+  */
+ static void split_line(char *p, char **argsout, int *nargs)
+ {
+ 	int maxn;
+ 	int in_arg;
+ 	char *argstart;
+ 	char c;
+ 
+ 	maxn = *nargs;
+ 	*nargs = 0;
+ 
+ 	if( maxn < 1 )
+ 		return;
+ 
+ 	in_arg = 0;
+ 	argstart = 0;
+ 	c = *p;
+ 
+ 	for (;;) {
+ 		int finished = 0;
+ 
+ 		switch (c) {
+ 		  case '#':
+ 		  case '\n':
+ 		  case '\0':
+ 			finished = 1;
+ 			/*FALLTHROUGH*/
+ 
+ 		  case ' ':
+ 		  case '\t':
+ 			if (in_arg) {
+ 				/* finished an actual argument */
+ 				int n = *nargs;
+ 				*p = '\0';
+ 				argsout[n++] = argstart;
+ 				*nargs = n;
+ 				in_arg = 0;
+ 				argstart = 0;
+ 				if (n == maxn)
+ 					finished = 1;
+ 			}
+ 			if (finished)
+ 				return;
+ 			break;
+ 
+ 		  default:
+ 			if (!in_arg) {
+ 				/* start new argument */
+ 				in_arg = 1;
+ 				argstart = p;
+ 			}
+ 			break;
+ 		}
+ 		c = * ++p;
+ 	}
+ }
+ 
  static int load_script(struct linux_binprm *bprm,struct pt_regs *regs)
  {
! 	char *i_name;
  	struct file *file;
  	char interp[BINPRM_BUF_SIZE];
  	int retval;
+ 	char *args[1+MAX_SCRIPT_ARGS];	/* includes interpreter name */
+ 	int nargs = 1+MAX_SCRIPT_ARGS;	/* max on i/p to split, actual on o/p */
+ 	char **pp = &args[0];
  
  	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!') || (bprm->sh_bang)) 
  		return -ENOEXEC;
***************
*** 34,83 ****
  	bprm->file = NULL;
  
  	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
! 	if ((cp = strchr(bprm->buf, '\n')) == NULL)
! 		cp = bprm->buf+BINPRM_BUF_SIZE-1;
! 	*cp = '\0';
! 	while (cp > bprm->buf) {
! 		cp--;
! 		if ((*cp == ' ') || (*cp == '\t'))
! 			*cp = '\0';
! 		else
! 			break;
! 	}
! 	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
! 	if (*cp == '\0') 
! 		return -ENOEXEC; /* No interpreter name found */
! 	i_name = cp;
! 	i_arg = 0;
! 	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
! 		/* nothing */ ;
! 	while ((*cp == ' ') || (*cp == '\t'))
! 		*cp++ = '\0';
! 	if (*cp)
! 		i_arg = cp;
! 	strcpy (interp, i_name);
  	/*
! 	 * OK, we've parsed out the interpreter name and
! 	 * (optional) argument.
  	 * Splice in (1) the interpreter's name for argv[0]
! 	 *           (2) (optional) argument to interpreter
  	 *           (3) filename of shell script (replace argv[0])
  	 *
  	 * This is done in reverse order, because of how the
  	 * user environment and arguments are stored.
  	 */
  	remove_arg_zero(bprm);
! 	retval = copy_strings_kernel(1, &bprm->filename, bprm);
! 	if (retval < 0) return retval; 
  	bprm->argc++;
! 	if (i_arg) {
! 		retval = copy_strings_kernel(1, &i_arg, bprm);
! 		if (retval < 0) return retval; 
! 		bprm->argc++;
  	}
  	retval = copy_strings_kernel(1, &i_name, bprm);
! 	if (retval) return retval; 
  	bprm->argc++;
  	/*
  	 * OK, now restart the process with the interpreter's dentry.
  	 */
--- 105,144 ----
  	bprm->file = NULL;
  
  	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
! 
! 	split_line(bprm->buf + 2,args,&nargs);
! 
! 	if( nargs == 0 )
! 		return -ENOEXEC;
! 
  	/*
! 	 * We now have the line tokenized, excluding the leading "#!".
  	 * Splice in (1) the interpreter's name for argv[0]
! 	 *           (2) (optional) arguments to interpreter
  	 *           (3) filename of shell script (replace argv[0])
  	 *
  	 * This is done in reverse order, because of how the
  	 * user environment and arguments are stored.
  	 */
+ 	i_name = *pp++;
+ 	--nargs;
+ 	strcpy(interp,i_name);
+ 
  	remove_arg_zero(bprm);
! 	retval = copy_strings_kernel(1,&bprm->filename,bprm);
! 	if (retval) return retval;
  	bprm->argc++;
! 
! 	if( nargs > 0 ) {
! 		retval = copy_strings_kernel(nargs,pp,bprm);
! 		if (retval) return retval;
! 		bprm->argc += nargs;
  	}
+ 
  	retval = copy_strings_kernel(1, &i_name, bprm);
! 	if (retval) return retval;
  	bprm->argc++;
+ 
  	/*
  	 * OK, now restart the process with the interpreter's dentry.
  	 */

> 
> >Anyway - it's bash, not the bin_fmt.
> 
> Bash is (correctly) complaining that it's been passed an invalid
> argument, but the reason for the different behaviour between it and
> FreeBSD is because of binfmt_script. There's no clearly defined standard
> for how this should behave.

Arguably, whatever the original BSD did.  The linux version is clearly
bogus.  (I fell over the perl thing too, since at work I have a common
home dir for multiple architectures where I therefore multiple binaries
of an up-to-date perl.)

-Malcolm

